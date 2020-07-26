
/*
	Cuts
*/

/datum/wound/brute/cut
	sound_effect = 'sound/weapons/slice.ogg'
	processes = TRUE
	wound_type = WOUND_LIST_CUT
	treatable_by = list(/obj/item/stack/medical/suture, /obj/item/stack/medical/gauze)
	treatable_by_grabbed = list(/obj/item/gun/energy/laser)
	treatable_tool = TOOL_CAUTERY
	treat_priority = TRUE
	base_treat_time = 3 SECONDS

	/// How much blood we start losing when this wound is first applied
	var/initial_flow
	/// When we have less than this amount of flow, either from treatment or clotting, we demote to a lower cut or are healed of the wound
	var/minimum_flow
	/// How fast our blood flow will naturally decrease per tick, not only do larger cuts bleed more faster, they clot slower
	var/clot_rate

	/// Once the blood flow drops below minimum_flow, we demote it to this type of wound. If there's none, we're all better
	var/demotes_to

	/// How much staunching per type (cautery, suturing, bandaging) you can have before that type is no longer effective for this cut NOT IMPLEMENTED
	var/max_per_type
	/// The maximum flow we've had so far
	var/highest_flow
	/// How much flow we've already cauterized
	var/cauterized
	/// How much flow we've already sutured
	var/sutured

	/// The current bandage we have for this wound (maybe move bandages to the limb?)
	var/obj/item/stack/current_bandage
	/// A bad system I'm using to track the worst scar we earned (since we can demote, we want the biggest our wound has been, not what it was when it was cured (probably moderate))
	var/datum/scar/highest_scar

/datum/wound/brute/cut/wound_injury(datum/wound/brute/cut/old_wound = null)
	blood_flow = initial_flow
	if(old_wound)
		blood_flow = max(old_wound.blood_flow, initial_flow)
		if(old_wound.severity > severity && old_wound.highest_scar)
			highest_scar = old_wound.highest_scar
			old_wound.highest_scar = null
		if(old_wound.current_bandage)
			current_bandage = old_wound.current_bandage
			old_wound.current_bandage = null

	if(!highest_scar)
		highest_scar = new
		highest_scar.generate(limb, src, add_to_scars=FALSE)

/datum/wound/brute/cut/remove_wound(ignore_limb, replaced)
	if(!replaced && highest_scar)
		already_scarred = TRUE
		highest_scar.lazy_attach(limb)
	return ..()

/datum/wound/brute/cut/get_examine_description(mob/user)
	if(!current_bandage)
		return ..()

	var/bandage_condition = ""
	// how much life we have left in these bandages
	switch(current_bandage.absorption_capacity)
		if(0 to 1.25)
			bandage_condition = "почти разрушенным "
		if(1.25 to 2.75)
			bandage_condition = "сильно изношенным "
		if(2.75 to 4)
			bandage_condition = "слегка окровавленным "
		if(4 to INFINITY)
			bandage_condition = "чиста "
	return "<B>Порезы на [ru_parse_zone(limb.name)] перемотаны [bandage_condition] [current_bandage.name]!</B>"

/datum/wound/brute/cut/receive_damage(wounding_type, wounding_dmg, wound_bonus)
	if(victim.stat != DEAD && wounding_type == WOUND_SHARP) // can't stab dead bodies to make it bleed faster this way
		blood_flow += 0.05 * wounding_dmg

/datum/wound/brute/cut/handle_process()
	blood_flow = min(blood_flow, WOUND_CUT_MAX_BLOODFLOW)

	if(victim.reagents && victim.reagents.has_reagent(/datum/reagent/toxin/heparin))
		blood_flow += 0.5 // old herapin used to just add +2 bleed stacks per tick, this adds 0.5 bleed flow to all open cuts which is probably even stronger as long as you can cut them first
	else if(victim.reagents && victim.reagents.has_reagent(/datum/reagent/medicine/coagulant))
		blood_flow -= 0.25

	if(current_bandage)
		if(clot_rate > 0)
			blood_flow -= clot_rate
		blood_flow -= current_bandage.absorption_rate
		current_bandage.absorption_capacity -= current_bandage.absorption_rate
		if(current_bandage.absorption_capacity < 0)
			victim.visible_message("<span class='danger'>Кровь проникает сквозь [current_bandage] на [ru_parse_zone(limb.name)] [victim].</span>", "<span class='warning'>Кровь проникает сквозь [current_bandage] на моей [ru_parse_zone(limb.name)].</span>", vision_distance=COMBAT_MESSAGE_RANGE)
			QDEL_NULL(current_bandage)
			treat_priority = TRUE
	else
		blood_flow -= clot_rate

	if(blood_flow > highest_flow)
		highest_flow = blood_flow

	if(blood_flow < minimum_flow)
		if(demotes_to)
			replace_wound(demotes_to)
		else
			to_chat(victim, "<span class='green'>Порез на моей [ru_parse_zone(limb.name)] перестаёт кровоточить!</span>")
			qdel(src)

/* BEWARE, THE BELOW NONSENSE IS MADNESS. bones.dm looks more like what I have in mind and is sufficiently clean, don't pay attention to this messiness */

/datum/wound/brute/cut/check_grab_treatments(obj/item/I, mob/user)
	if(istype(I, /obj/item/gun/energy/laser))
		return TRUE

/datum/wound/brute/cut/treat(obj/item/I, mob/user)
	if(istype(I, /obj/item/gun/energy/laser))
		las_cauterize(I, user)
	else if(I.tool_behaviour == TOOL_CAUTERY || I.get_temperature() > 300)
		tool_cauterize(I, user)
	else if(istype(I, /obj/item/stack/medical/gauze))
		bandage(I, user)
	else if(istype(I, /obj/item/stack/medical/suture))
		suture(I, user)

/datum/wound/brute/cut/try_handling(mob/living/carbon/human/user)
	if(user.pulling != victim || user.zone_selected != limb.body_zone || user.a_intent == INTENT_GRAB)
		return FALSE

	if(!isfelinid(user))
		return FALSE

	lick_wounds(user)
	return TRUE

/// if a felinid is licking this cut to reduce bleeding
/datum/wound/brute/cut/proc/lick_wounds(mob/living/carbon/human/user)
	if(INTERACTING_WITH(user, victim))
		to_chat(user, "<span class='warning'>Я уже взаимодействую с [victim]!</span>")
		return

	user.visible_message("<span class='notice'><b>[user]</b> начинает зализывать рану на [ru_gde_zone(limb.name)] <b>[victim]</b>.</span>", "<span class='notice'>Начинаю заливать рану на [ru_gde_zone(limb.name)] <b>[victim]</b>...</span>", ignored_mobs=victim)
	to_chat(victim, "<span class='notice'><b>[user]</b> начинает зализывать рану на моей [ru_gde_zone(limb.name)].</span")
	if(!do_after(user, base_treat_time, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return

	user.visible_message("<span class='notice'><b>[user]</b> зализывает рану на [ru_gde_zone(limb.name)] <b>[victim]</b>.</span>", "<span class='notice'>Зализываю рану на [ru_gde_zone(limb.name)] <b>[victim]</b>.</span>", ignored_mobs=victim)
	to_chat(victim, "<span class='green'><b>[user]</b> зализывает рану на моей [ru_gde_zone(limb.name)]!</span")
	blood_flow -= 0.5

	if(blood_flow > minimum_flow)
		try_handling(user)
	else if(demotes_to)
		to_chat(user, "<span class='green'>Успешно понижаю силу кровотечения порезов [victim].</span>")

/datum/wound/brute/cut/on_xadone(power)
	. = ..()
	blood_flow -= 0.03 * power // i think it's like a minimum of 3 power, so .09 blood_flow reduction per tick is pretty good for 0 effort

/// If someone's putting a laser gun up to our cut to cauterize it
/datum/wound/brute/cut/proc/las_cauterize(obj/item/gun/energy/laser/lasgun, mob/user)
	var/self_penalty_mult = (user == victim ? 1.25 : 1)
	user.visible_message("<span class='warning'><b>[user]</b> начинает наводить [lasgun] прямо на [ru_gde_zone(limb.name)] <b>[victim]</b>...</span>", "<span class='userdanger'>Начинаю наводить [lasgun] прямо на [user == victim ? "свою " : " "][ru_parse_zone(limb.name)][user == victim ? "" : " <b>[victim]</b>"]...</span>")
	if(!do_after(user, base_treat_time  * self_penalty_mult, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return
	var/damage = lasgun.chambered.BB.damage
	lasgun.chambered.BB.wound_bonus -= 30
	lasgun.chambered.BB.damage *= self_penalty_mult
	if(!lasgun.process_fire(victim, victim, TRUE, null, limb.body_zone))
		return
	victim.emote("scream")
	blood_flow -= damage / (5 * self_penalty_mult) // 20 / 5 = 4 bloodflow removed, p good
	cauterized += damage / (5 * self_penalty_mult)
	victim.visible_message("<span class='warning'>Порезы на [ru_gde_zone(limb.name)] <b>[victim]</b> превращаются в ужасные шрамы!</span>")

/// If someone is using either a cautery tool or something with heat to cauterize this cut
/datum/wound/brute/cut/proc/tool_cauterize(obj/item/I, mob/user)
	var/self_penalty_mult = (user == victim ? 1.5 : 1)
	user.visible_message("<span class='danger'><b>[user]</b> начинает прижигать порезы на [ru_gde_zone(limb.name)] <b>[victim]</b> используя [I]...</span>", "<span class='danger'>Начинаю прижигать порезы на [user == victim ? "своей" : " "][ru_gde_zone(limb.name)][user == victim ? "" : " <b>[victim]</b>"] используя [I]...</span>")
	if(!do_after(user, base_treat_time * self_penalty_mult, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return

	user.visible_message("<span class='green'><b>[user]</b> прижигает некоторые порезы <b>[victim]</b>.</span>", "<span class='green'>Прижигаю некоторые порезы <b>[victim]</b>.</span>")
	limb.receive_damage(burn = 2 + severity, wound_bonus = CANT_WOUND)
	if(prob(30))
		victim.emote("scream")
	var/blood_cauterized = (0.6 / self_penalty_mult)
	blood_flow -= blood_cauterized
	cauterized += blood_cauterized

	if(blood_flow > minimum_flow)
		try_treating(I, user)
	else if(demotes_to)
		to_chat(user, "<span class='green'>Успешно уменьшаю кровотечение от [user == victim ? "моих порезов" : "порезов [victim]"].</span>")

/// If someone is using a suture to close this cut
/datum/wound/brute/cut/proc/suture(obj/item/stack/medical/suture/I, mob/user)
	var/self_penalty_mult = (user == victim ? 1.4 : 1)
	user.visible_message("<span class='notice'><b>[user]</b> начинает зашивать порезы на [ru_gde_zone(limb.name)] <b>[victim]</b> используя [I]...</span>", "<span class='notice'>Начинаю зашивать порезы на [user == victim ? "моей" : " "][ru_gde_zone(limb.name)][user == victim ? "" : " <b>[victim]</b>"] используя [I]...</span>")
	if(!do_after(user, base_treat_time * self_penalty_mult, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return
	user.visible_message("<span class='green'><b>[user]</b> зашивает некоторые порезы <b>[victim]</b>.</span>", "<span class='green'>Зашиваю некоторые порезы [user == victim ? "успешно" : "<b>[victim]</b>"].</span>")
	var/blood_sutured = I.stop_bleeding / self_penalty_mult
	blood_flow -= blood_sutured
	sutured += blood_sutured
	limb.heal_damage(I.heal_brute, I.heal_burn)

	if(blood_flow > minimum_flow)
		try_treating(I, user)
	else if(demotes_to)
		to_chat(user, "<span class='green'>Успешно уменьшаю кровотечение от [user == victim ? "моих порезов" : "порезов [victim]"].</span>")

/// If someone is using gauze on this cut
/datum/wound/brute/cut/proc/bandage(obj/item/stack/I, mob/user)
	if(current_bandage)
		if(current_bandage.absorption_capacity > I.absorption_capacity + 1)
			to_chat(user, "<span class='warning'>Текущий [current_bandage] на [ru_gde_zone(limb.name)] [victim] всё ещё лучше моего [I.name]!</span>")
			return
		else
			user.visible_message("<span class='warning'><b>[user]</b> начинает перевязку [ru_parse_zone(limb.name)] <b>[victim]</b> используя [I]...</span>", "<span class='warning'>Начинаю перевязку [user == victim ? "моей" : " "][ru_parse_zone(limb.name)][user == victim ? "" : " <b>[victim]</b>"] используя [I]...</span>")
	else
		user.visible_message("<span class='warning'><b>[user]</b> начинает обматывать порезы на [ru_gde_zone(limb.name)] <b>[victim]</b> используя [I]...</span>", "<span class='warning'>Начинаю обматывание [user == victim ? "моей" : " "][ru_parse_zone(limb.name)][user == victim ? "" : " <b>[victim]</b>"] используя [I]...</span>")
	if(!do_after(user, base_treat_time, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return

	user.visible_message("<span class='green'><b>[user]</b> обматывает [I] на [ru_gde_zone(limb.name)] <b>[victim]</b>.</span>", "<span class='green'>Обматываю [user == victim ? "свои порезы" : "порезы <b>[victim]</b>"].</span>")
	QDEL_NULL(current_bandage)
	current_bandage = new I.type(limb)
	current_bandage.amount = 1
	treat_priority = FALSE
	I.use(1)


/datum/wound/brute/cut/moderate
	name = "Глубокие Порезы"
	skloname = "глубоких порезов"
	desc = "Кожа пациента была сильно соскоблена, что привело к умеренной кровопотере."
	treat_text = "Наложение чистых повязок или швов для оказания первой медицинской помощи, затем еда и отдых."
	examine_desc = "имеет открытый порез"
	occur_text = "вскрыта, медленно источая кровь"
	sound_effect = 'sound/effects/blood1.ogg'
	severity = WOUND_SEVERITY_MODERATE
	initial_flow = 2
	minimum_flow = 0.5
	max_per_type = 3
	clot_rate = 0.15
	threshold_minimum = 20
	threshold_penalty = 10
	status_effect_type = /datum/status_effect/wound/cut/moderate
	scarring_descriptions = list("лёгкие, блеклые линии", "незначительные шрамы", "маленькая выцветшая щель", "группа маленьких шрамов")

/datum/wound/brute/cut/severe
	name = "Открытая Рана"
	skloname = "открытой раны"
	desc = "Кожа пациента разорвана, что приводит к значительной потере крови."
	treat_text = "Быстрое наложение швов первой помощи и чистых повязок с последующим мониторингом жизненно важных функций для обеспечения восстановления."
	examine_desc = "имеет серьёзный порез"
	occur_text = "вскрыта, вены брызгают кровью"
	sound_effect = 'sound/effects/blood2.ogg'
	severity = WOUND_SEVERITY_SEVERE
	initial_flow = 3.25
	minimum_flow = 2.75
	clot_rate = 0.07
	max_per_type = 4
	threshold_minimum = 50
	threshold_penalty = 25
	demotes_to = /datum/wound/brute/cut/moderate
	status_effect_type = /datum/status_effect/wound/cut/severe
	scarring_descriptions = list("витая линия затухших налетов", "корявый серповидный ломтик шрама", "давно выцветшая колотая рана")

/datum/wound/brute/cut/critical
	name = "Открытая Артерия"
	skloname = "открытой артерии"
	desc = "Кожа пациента полностью разорвана, что сопровождается значительным повреждением тканей. Чрезвычайная потеря крови приведет к быстрой смерти без вмешательства."
	treat_text = "Немедленная перевязка и либо ушивание, либо прижигание, а затем повторная регенерация."
	examine_desc = "брызгает кровью с угрожающей скоростью"
	occur_text = "разрывается, дико брызгая кровью"
	sound_effect = 'sound/effects/blood3.ogg'
	severity = WOUND_SEVERITY_CRITICAL
	initial_flow = 4.25
	minimum_flow = 4
	clot_rate = -0.05 // critical cuts actively get worse instead of better
	max_per_type = 5
	threshold_minimum = 80
	threshold_penalty = 40
	demotes_to = /datum/wound/brute/cut/severe
	status_effect_type = /datum/status_effect/wound/cut/critical
	scarring_descriptions = list("извилистая дорожка очень плохо зажившей рубцовой кожи", "ряд пиков и долин вдоль ужасной линии разреза рубцовой кожи", "гротескная змея из вмятин и швов")

// TODO: see about moving dismemberment over to this, i'll have to add judging dismembering power/wound potential wrt item size i guess
/datum/wound/brute/cut/loss
	name = "Расчленение"
	skloname = "расчленения"
	desc = "больно!!"
	occur_text = "отлетает испуская тонкие струйки крови!"
	sound_effect = 'sound/effects/dismember.ogg'
	viable_zones = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	severity = WOUND_SEVERITY_LOSS
	threshold_minimum = 180
	status_effect_type = null

/datum/wound/brute/cut/loss/apply_wound(obj/item/bodypart/L, silent, datum/wound/brute/cut/old_wound, smited = FALSE)
	if(!L.dismemberable)
		qdel(src)
		return

	L.dismember()
	qdel(src)
