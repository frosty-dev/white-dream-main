
/*
	Bones
*/
// TODO: well, a lot really, but i'd kill to get overlays and a bonebreaking effect like Blitz: The League, similar to electric shock skeletons

/*
	Base definition
*/
/datum/wound/brute/bone
	sound_effect = 'sound/effects/crack1.ogg'
	wound_type = WOUND_LIST_BONE

	/// The item we're currently splinted with, if there is one
	var/obj/item/stack/splinted

	/// Have we been taped?
	var/taped
	/// Have we been bone gel'd?
	var/gelled
	/// If we did the gel + surgical tape healing method for fractures, how many regen points we need
	var/regen_points_needed
	/// Our current counter for gel + surgical tape regeneration
	var/regen_points_current
	/// If we suffer severe head booboos, we can get brain traumas tied to them
	var/datum/brain_trauma/active_trauma
	/// What brain trauma group, if any, we can draw from for head wounds
	var/brain_trauma_group
	/// If we deal brain traumas, when is the next one due?
	var/next_trauma_cycle
	/// How long do we wait +/- 20% for the next trauma?
	var/trauma_cycle_cooldown
	/// If this is a chest wound and this is set, we have this chance to cough up blood when hit in the chest
	var/chance_internal_bleeding = 0

/*
	Overwriting of base procs
*/
/datum/wound/brute/bone/wound_injury(datum/wound/old_wound = null)
	if(limb.body_zone == BODY_ZONE_HEAD && brain_trauma_group)
		processes = TRUE
		active_trauma = victim.gain_trauma_type(brain_trauma_group, TRAUMA_RESILIENCE_WOUND)
		next_trauma_cycle = world.time + (rand(100-WOUND_BONE_HEAD_TIME_VARIANCE, 100+WOUND_BONE_HEAD_TIME_VARIANCE) * 0.01 * trauma_cycle_cooldown)

	RegisterSignal(victim, COMSIG_HUMAN_EARLY_UNARMED_ATTACK, .proc/attack_with_hurt_hand)
	if(limb.held_index && victim.get_item_for_held_index(limb.held_index) && (disabling || prob(30 * severity)))
		var/obj/item/I = victim.get_item_for_held_index(limb.held_index)
		if(istype(I, /obj/item/offhand))
			I = victim.get_inactive_held_item()

		if(I && victim.dropItemToGround(I))
			victim.visible_message("<span class='danger'><b>[victim]</b> бросает <b>[I]</b> в приступе боли!</span>", "<span class='warning'>Боль в моей <b>[ru_gde_zone(limb.name)]</b> заставляет меня бросить <b>[I]</b>!</span>", vision_distance=COMBAT_MESSAGE_RANGE)

	update_inefficiencies()

/datum/wound/brute/bone/remove_wound(ignore_limb, replaced)
	limp_slowdown = 0
	QDEL_NULL(active_trauma)
	if(victim)
		UnregisterSignal(victim, COMSIG_HUMAN_EARLY_UNARMED_ATTACK)
	return ..()

/datum/wound/brute/bone/handle_process()
	. = ..()
	if(limb.body_zone == BODY_ZONE_HEAD && brain_trauma_group && world.time > next_trauma_cycle)
		if(active_trauma)
			QDEL_NULL(active_trauma)
		else
			active_trauma = victim.gain_trauma_type(brain_trauma_group, TRAUMA_RESILIENCE_WOUND)
		next_trauma_cycle = world.time + (rand(100-WOUND_BONE_HEAD_TIME_VARIANCE, 100+WOUND_BONE_HEAD_TIME_VARIANCE) * 0.01 * trauma_cycle_cooldown)

	if(!regen_points_needed)
		return

	regen_points_current++
	if(prob(severity * 2))
		victim.take_bodypart_damage(rand(2, severity * 2), stamina=rand(2, severity * 2.5), wound_bonus=CANT_WOUND)
		if(prob(33))
			to_chat(victim, "<span class='danger'>Ощущаю острую боль в теле, ведь мои кости преобразуются!</span>")

	if(regen_points_current > regen_points_needed)
		if(!victim || !limb)
			qdel(src)
			return
		to_chat(victim, "<span class='green'>Моя [limb.name] больше не страдает от переломов!</span>")
		remove_wound()

/// If we're a human who's punching something with a broken arm, we might hurt ourselves doing so
/datum/wound/brute/bone/proc/attack_with_hurt_hand(mob/M, atom/target, proximity)
	if(victim.get_active_hand() != limb || victim.a_intent == INTENT_HELP || !ismob(target) || severity <= WOUND_SEVERITY_MODERATE)
		return

	// With a severe or critical wound, you have a 15% or 30% chance to proc pain on hit
	if(prob((severity - 1) * 15))
		// And you have a 70% or 50% chance to actually land the blow, respectively
		if(prob(70 - 20 * (severity - 1)))
			to_chat(victim, "<span class='userdanger'>Перелом в моей [ru_gde_zone(limb.name)] стреляет от боли при ударе <b>[target]</b>!</span>")
			limb.receive_damage(brute=rand(1,5))
		else
			victim.visible_message("<span class='danger'><b>[victim]</b> слабо бьёт <b>[target]</b> своей сломаной рукой, отскакивая в приступе боли!</span>", \
			"<span class='userdanger'>У меня не вышло ударить <b>[target]</b> так как перелом в моей [ru_gde_zone(limb.name)] загорается от невыносимой боли!</span>", vision_distance=COMBAT_MESSAGE_RANGE)
			victim.emote("scream")
			victim.Stun(0.5 SECONDS)
			limb.receive_damage(brute=rand(3,7))
			return COMPONENT_NO_ATTACK_HAND

/datum/wound/brute/bone/receive_damage(wounding_type, wounding_dmg, wound_bonus)
	if(!victim)
		return

	if(limb.body_zone == BODY_ZONE_CHEST && victim.blood_volume && prob(chance_internal_bleeding + wounding_dmg))
		var/blood_bled = rand(1, wounding_dmg * (severity == WOUND_SEVERITY_CRITICAL ? 2 : 1.5)) // 12 brute toolbox can cause up to 18/24 bleeding with a severe/critical chest wound
		switch(blood_bled)
			if(1 to 6)
				victim.bleed(blood_bled, TRUE)
			if(7 to 13)
				victim.visible_message("<span class='danger'><b>[victim]</b> кашляет кровью от удара в грудь.</span>", "<span class='danger'>Выплёвываю немного крови от удара в грудь.</span>")
				victim.bleed(blood_bled, TRUE)
			if(14 to 19)
				victim.visible_message("<span class='danger'><b>[victim]</b> выплевывает струю крови от удара в грудь!</span>", "<span class='danger'>Выплёвываю струю крови от удара в грудь!</span>")
				new /obj/effect/temp_visual/dir_setting/bloodsplatter(victim.loc, victim.dir)
				victim.bleed(blood_bled)
			if(20 to INFINITY)
				victim.visible_message("<span class='danger'><b>[victim]</b> заблёвывает всё кровью от удара в грудь!</span>", "<span class='danger'><b>Заблёвываю всё кровью от удара в грудь!</b></span>")
				victim.bleed(blood_bled)
				new /obj/effect/temp_visual/dir_setting/bloodsplatter(victim.loc, victim.dir)
				victim.add_splatter_floor(get_step(victim.loc, victim.dir))

	if(!(wounding_type in list(WOUND_SHARP, WOUND_BURN)) || !splinted || wound_bonus == CANT_WOUND)
		return

	splinted.take_damage(wounding_dmg, damage_type = (wounding_type == WOUND_SHARP ? BRUTE : BURN), sound_effect = FALSE)
	if(QDELETED(splinted))
		var/destroyed_verb = (wounding_type == WOUND_SHARP ? "разрывается в клочья" : "превращается в пепел")
		victim.visible_message("<span class='danger'>Шина, которая удерживала [ru_parse_zone(limb.name)] <b>[victim]</b> [destroyed_verb]!</span>", "<span class='danger'><b>Шина на моей [limb.name] [destroyed_verb]!</b></span>", vision_distance=COMBAT_MESSAGE_RANGE)
		splinted = null
		treat_priority = TRUE
		update_inefficiencies()


/datum/wound/brute/bone/get_examine_description(mob/user)
	if(!splinted && !gelled && !taped)
		return ..()

	var/msg = ""
	if(!splinted)
		msg = "[victim.ru_ego(TRUE)] [limb.name] [examine_desc]"
	else
		var/splint_condition = ""
		// how much life we have left in these bandages
		switch(splinted.obj_integrity / splinted.max_integrity * 100)
			if(0 to 25)
				splint_condition = "едва"
			if(25 to 50)
				splint_condition = "плохо"
			if(50 to 75)
				splint_condition = "слабовато"
			if(75 to INFINITY)
				splint_condition = "плотно"

		msg = "[capitalize(splinted.name)] на [victim.ru_ego()] [ru_gde_zone(limb.name)] [splint_condition] держится"

	if(taped)
		msg += ", и, кажется, реформируется под хирургической лентой!"
	else if(gelled)
		msg += ", с шипящими пятнами синего костного геля, искрящегося на костях!"
	else
		msg +=  "!"
	return "<span class='notice'><B>[msg]</B></span>"

/*
	New common procs for /datum/wound/brute/bone/
*/

/datum/wound/brute/bone/proc/update_inefficiencies()
	if(limb.body_zone in list(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
		if(splinted)
			limp_slowdown = initial(limp_slowdown) * splinted.splint_factor
		else
			limp_slowdown = initial(limp_slowdown)
		victim.apply_status_effect(STATUS_EFFECT_LIMP)
	else if(limb.body_zone in list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
		if(splinted)
			interaction_efficiency_penalty = 1 + ((interaction_efficiency_penalty - 1) * splinted.splint_factor)
		else
			interaction_efficiency_penalty = interaction_efficiency_penalty

	if(initial(disabling) && splinted)
		disabling = FALSE
	else if(initial(disabling))
		disabling = TRUE

	limb.update_wounds()

/*
	BEWARE OF REDUNDANCY AHEAD THAT I MUST PARE DOWN
*/

/datum/wound/brute/bone/proc/splint(obj/item/stack/I, mob/user)
	if(splinted && splinted.splint_factor >= I.splint_factor)
		to_chat(user, "<span class='warning'>Здесь уже есть шина на [ru_gde_zone(limb.name)] [user == victim ? "моей" : "<b>[victim]</b>"] и она лучше <b>[I]</b>.</span>")
		return

	user.visible_message("<span class='danger'><b>[user]</b> начинает накладывать шину на [ru_parse_zone(limb.name)] <b>[victim]</b> используя [I].</span>", "<span class='warning'>Начинаю накладывать шину на [ru_parse_zone(limb.name)] [user == victim ? " " : "<b>[victim]</b> "] используя [I]...</span>")

	if(!do_after(user, base_treat_time * (user == victim ? 1.5 : 1), target = victim, extra_checks=CALLBACK(src, .proc/still_exists)))
		return

	user.visible_message("<span class='green'><b>[user]</b> заканчивает накладывать шину на [ru_parse_zone(limb.name)] <b>[victim]</b>!</span>", "<span class='green'>Заканчиваю накладывать шину на [ru_parse_zone(limb.name)] [user == victim ? " " : "<b>[victim]</b> "]!</span>")
	treat_priority = FALSE
	splinted = new I.type(limb)
	splinted.amount = 1
	I.use(1)
	update_inefficiencies()

/*
	Moderate (Joint Dislocation)
*/

/datum/wound/brute/bone/moderate
	name = "Вывих"
	skloname = "вывиха"
	desc = "Кость пациента была выведена из нормального положения, вызывая боль и сниженную двигательную функцию."
	treat_text = "Рекомендуемое применение костоотвода на пораженную конечность, хотя ручного перемещения путем применения агрессивного захвата к пациенту и полезного взаимодействия с пораженной конечностью может быть достаточно."
	examine_desc = "неловко стоит не на своем месте"
	occur_text = "яростно дергается и перемещается в загадочное положение"
	severity = WOUND_SEVERITY_MODERATE
	viable_zones = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	interaction_efficiency_penalty = 1.5
	limp_slowdown = 3
	threshold_minimum = 35
	threshold_penalty = 15
	treatable_tool = TOOL_BONESET
	status_effect_type = /datum/status_effect/wound/bone/moderate
	scarring_descriptions = list("легкое обесцвечивание", "легкий синий оттенок")

/datum/wound/brute/bone/moderate/crush()
	if(prob(33))
		victim.visible_message("<span class='danger'><b>[victim]</b> выворачивает [ru_parse_zone(limb.name)] и ставит на место!</span>", "<span class='userdanger'>Выправляю [ru_parse_zone(limb.name)] на место! Ух!</span>")
		remove_wound()

/datum/wound/brute/bone/moderate/try_handling(mob/living/carbon/human/user)
	if(user.pulling != victim || user.zone_selected != limb.body_zone || user.a_intent == INTENT_GRAB)
		return FALSE

	if(user.grab_state == GRAB_PASSIVE)
		to_chat(user, "<span class='warning'>Мне стоит взять <b>[victim]</b> в более сильный захват для исправления [skloname]!</span>")
		return TRUE

	if(user.grab_state >= GRAB_AGGRESSIVE)
		user.visible_message("<span class='danger'><b>[user]</b> начинает скручивать и напрягать [ru_parse_zone(limb.name)] <b>[victim]</b>!</span>", "<span class='notice'>Начинаю скручивать и напрягать [ru_parse_zone(limb.name)] <b>[victim]</b>...</span>", ignored_mobs=victim)
		to_chat(victim, "<span class='userdanger'><b>[user]</b> начинает крутить и напрягать вывих на [ru_gde_zone(limb.name)]!</span>")
		if(user.a_intent == INTENT_HELP)
			chiropractice(user)
		else
			malpractice(user)
		return TRUE

/// If someone is snapping our dislocated joint back into place by hand with an aggro grab and help intent
/datum/wound/brute/bone/moderate/proc/chiropractice(mob/living/carbon/human/user)
	var/time = base_treat_time

	if(!do_after(user, time, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return

	if(prob(65))
		user.visible_message("<span class='danger'><b>[user]</b> вправляет [ru_parse_zone(limb.name)] <b>[victim]</b>!</span>", "<span class='notice'>Вправляю [ru_parse_zone(limb.name)] <b>[victim]</b> на место!</span>", ignored_mobs=victim)
		to_chat(victim, "<span class='userdanger'><b>[user]</b> вправляет мою [ru_parse_zone(limb.name)] на место!</span>")
		victim.emote("scream")
		limb.receive_damage(brute=20, wound_bonus=CANT_WOUND)
		qdel(src)
	else
		user.visible_message("<span class='danger'><b>[user]</b> крутит [ru_parse_zone(limb.name)] <b>[victim]</b> довольно неправильно!</span>", "<span class='danger'>Кручу [ru_parse_zone(limb.name)] <b>[victim]</b> неправильно!</span>", ignored_mobs=victim)
		to_chat(victim, "<span class='userdanger'><b>[user]</b> крутит мою [ru_parse_zone(limb.name)] неправильно!</span>")
		limb.receive_damage(brute=10, wound_bonus=CANT_WOUND)
		chiropractice(user)

/// If someone is snapping our dislocated joint into a fracture by hand with an aggro grab and harm or disarm intent
/datum/wound/brute/bone/moderate/proc/malpractice(mob/living/carbon/human/user)
	var/time = base_treat_time

	if(!do_after(user, time, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return

	if(prob(65))
		user.visible_message("<span class='danger'><b>[user]</b> вправляет [ru_parse_zone(limb.name)] <b>[victim]</b> с отвратительным хрустом!</span>", "<span class='danger'>Вправляю [ru_parse_zone(limb.name)] <b>[victim]</b> с отвратительным хрустом!</span>", ignored_mobs=victim)
		to_chat(victim, "<span class='userdanger'><b>[user]</b> вправляет [ru_parse_zone(limb.name)] с отвратительным хрустом!</span>")
		victim.emote("scream")
		limb.receive_damage(brute=25, wound_bonus=30)
	else
		user.visible_message("<span class='danger'><b>[user]</b> крутит [ru_parse_zone(limb.name)] <b>[victim]</b> неправильно!</span>", "<span class='danger'>Кручу [ru_parse_zone(limb.name)] <b>[victim]</b> неправильно!</span>", ignored_mobs=victim)
		to_chat(victim, "<span class='userdanger'><b>[user]</b> крутит мою [ru_parse_zone(limb.name)] неправильно!</span>")
		limb.receive_damage(brute=10, wound_bonus=CANT_WOUND)
		malpractice(user)


/datum/wound/brute/bone/moderate/treat(obj/item/I, mob/user)
	if(victim == user)
		victim.visible_message("<span class='danger'><b>[user]</b> начинает вправлять [victim.ru_ego()] [ru_parse_zone(limb.name)] используя [I].</span>", "<span class='warning'>Начинаю вправлять свою [ru_parse_zone(limb.name)] используя [I]...</span>")
	else
		user.visible_message("<span class='danger'><b>[user]</b> начинает вправлять [ru_parse_zone(limb.name)] <b>[victim]</b> используя [I].</span>", "<span class='notice'>Начинаю вправлять [ru_parse_zone(limb.name)] <b>[victim]</b> используя [I]...</span>")

	if(!do_after(user, base_treat_time * (user == victim ? 1.5 : 1), target = victim, extra_checks=CALLBACK(src, .proc/still_exists)))
		return

	if(victim == user)
		limb.receive_damage(brute=15, wound_bonus=CANT_WOUND)
		victim.visible_message("<span class='danger'><b>[user]</b> успешно вправляет [victim.ru_ego()] [ru_parse_zone(limb.name)]!</span>", "<span class='userdanger'>Вправляю свою [ru_parse_zone(limb.name)]!</span>")
	else
		limb.receive_damage(brute=10, wound_bonus=CANT_WOUND)
		user.visible_message("<span class='danger'><b>[user]</b> успешно вправляет [ru_parse_zone(limb.name)] <b>[victim]</b>!</span>", "<span class='nicegreen'>Вправляю [ru_parse_zone(limb.name)] <b>[victim]</b>!</span>", victim)
		to_chat(victim, "<span class='userdanger'><b>[user]</b> вправляет мою [ru_parse_zone(limb.name)]!</span>")

	victim.emote("scream")
	qdel(src)

/*
	Severe (Hairline Fracture)
*/

/datum/wound/brute/bone/severe
	name = "Трещина"
	skloname = "трещины"
	desc = "На кости пациента образовалась трещина в основании, вызывающая сильную боль и сниженную функциональность конечностей."
	treat_text = "Рекомендуется легкое хирургическое применение костного геля, хотя шинирование предотвратит ухудшение ситуации."
	examine_desc = "кажется ушибленной и сильно опухшей"

	occur_text = "разбрызгивает кусочки костей и развивает неприятный на вид синяк"
	severity = WOUND_SEVERITY_SEVERE
	interaction_efficiency_penalty = 2
	limp_slowdown = 6
	threshold_minimum = 60
	threshold_penalty = 30
	treatable_by = list(/obj/item/stack/sticky_tape/surgical, /obj/item/stack/medical/gauze, /obj/item/stack/medical/bone_gel)
	status_effect_type = /datum/status_effect/wound/bone/severe
	treat_priority = TRUE
	scarring_descriptions = list("выцветший синяк размером с кулак", "смутный треугольный шрам")
	brain_trauma_group = BRAIN_TRAUMA_MILD
	trauma_cycle_cooldown = 1.5 MINUTES
	chance_internal_bleeding = 40

/datum/wound/brute/bone/critical
	name = "Перелом"
	skloname = "перелома"
	desc = "Кости пациента перенесли множественные ужасные переломы, вызывая значительную боль и почти бесполезную конечность."
	treat_text = "Немедленное связывание пораженной конечности с последующим хирургическим вмешательством как можно скорее."
	examine_desc = "имеет торчащую из неё кость"
	occur_text = "трещины на части, открывая сломанные кости наружу"
	severity = WOUND_SEVERITY_CRITICAL
	interaction_efficiency_penalty = 4
	limp_slowdown = 9
	sound_effect = 'sound/effects/crack2.ogg'
	threshold_minimum = 115
	threshold_penalty = 50
	disabling = TRUE
	treatable_by = list(/obj/item/stack/sticky_tape/surgical, /obj/item/stack/medical/gauze, /obj/item/stack/medical/bone_gel)
	status_effect_type = /datum/status_effect/wound/bone/critical
	treat_priority = TRUE
	scarring_descriptions = list("участок шершавых линий кожи и плохо заживших шрамов", "большое пятно неровного тона кожи", "скопление мозолей")
	brain_trauma_group = BRAIN_TRAUMA_SEVERE
	trauma_cycle_cooldown = 2.5 MINUTES
	chance_internal_bleeding = 60

// doesn't make much sense for "a" bone to stick out of your head
/datum/wound/brute/bone/critical/apply_wound(obj/item/bodypart/L, silent, datum/wound/old_wound, smited)
	if(L.body_zone == BODY_ZONE_HEAD)
		occur_text = "хрустит, обнажая обнаженный треснувший череп сквозь плоть и кровь"
		examine_desc = "имеет тревожный отступ, с торчащими кусками черепа"
	. = ..()

/// if someone is using bone gel on our wound
/datum/wound/brute/bone/proc/gel(obj/item/stack/medical/bone_gel/I, mob/user)
	if(gelled)
		to_chat(user, "<span class='warning'>[capitalize(limb.name)] [user == victim ? " " : "<b>[victim]</b> "] уже покрыта костным гелем!</span>")
		return

	user.visible_message("<span class='danger'><b>[user]</b> начинает примеенять [I] на [ru_parse_zone(limb.name)] <b>[victim]</b>...</span>", "<span class='warning'>Начинаю применять [I] на [ru_parse_zone(limb.name)] [user == victim ? " " : "<b>[victim]</b> "], игнорируя предупреждение на этикетке...</span>")

	if(!do_after(user, base_treat_time * 1.5 * (user == victim ? 1.5 : 1), target = victim, extra_checks=CALLBACK(src, .proc/still_exists)))
		return

	I.use(1)
	victim.emote("scream")
	if(user != victim)
		user.visible_message("<span class='notice'><b>[user]</b> заканчивает применять [I] на [ru_parse_zone(limb.name)] <b>[victim]</b>, издавая шипящий звук!</span>", "<span class='notice'>Заканчиваю применять [I] на [ru_parse_zone(limb.name)] <b>[victim]</b>!</span>", ignored_mobs=victim)
		to_chat(victim, "<span class='userdanger'><b>[user]</b> заканчивает применять [I] на мою [ru_parse_zone(limb.name)] и я начинаю чувствовать, как мои кости взрываются от боли, когда они начинают таять и преобразовываться!</span>")
	else
		var/painkiller_bonus = 0
		if(victim.drunkenness)
			painkiller_bonus += 5
		if(victim.reagents && victim.reagents.has_reagent(/datum/reagent/medicine/morphine))
			painkiller_bonus += 10
		if(victim.reagents && victim.reagents.has_reagent(/datum/reagent/determination))
			painkiller_bonus += 5

		if(prob(25 + (20 * severity - 2) - painkiller_bonus)) // 25%/45% chance to fail self-applying with severe and critical wounds, modded by painkillers
			victim.visible_message("<span class='danger'><b>[victim]</b> проваливает попытку нанести [I] на [victim.ru_ego()] [ru_parse_zone(limb.name)], теряя сознание от боли!</span>", "<span class='notice'>Теряю сознание от боли пытаясь применить [I] на мою [ru_parse_zone(limb.name)] перед тем как закончить!</span>")
			victim.AdjustUnconscious(5 SECONDS)
			return
		victim.visible_message("<span class='notice'><b>[victim]</b> успешно применяет [I] на [victim.ru_ego()] [ru_parse_zone(limb.name)], скорчившись от боли!</span>", "<span class='notice'>Заканчиваю применять [I] на мою [ru_parse_zone(limb.name)], осталось перетерпеть адскую боль!</span>")

	limb.receive_damage(30, stamina=100, wound_bonus=CANT_WOUND)
	if(!gelled)
		gelled = TRUE

/// if someone is using surgical tape on our wound
/datum/wound/brute/bone/proc/tape(obj/item/stack/sticky_tape/surgical/I, mob/user)
	if(!gelled)
		to_chat(user, "<span class='warning'>[capitalize(limb.name)] [user == victim ? " " : "<b>[victim]</b> "] должна быть покрыт костным гелем для выполнения этой экстренной операции!</span>")
		return
	if(taped)
		to_chat(user, "<span class='warning'>[capitalize(limb.name)] [user == victim ? " " : "<b>[victim]</b> "] уже обёрнута в [I.name] и реформируется!</span>")
		return

	user.visible_message("<span class='danger'><b>[user]</b> начинает применять [I] на [ru_parse_zone(limb.name)] <b>[victim]</b>...</span>", "<span class='warning'>Начинаю применять [I] на [ru_parse_zone(limb.name)] [user == victim ? " " : "<b>[victim]</b> "]...</span>")

	if(!do_after(user, base_treat_time * (user == victim ? 1.5 : 1), target = victim, extra_checks=CALLBACK(src, .proc/still_exists)))
		return

	regen_points_current = 0
	regen_points_needed = 30 SECONDS * (user == victim ? 1.5 : 1) * (severity - 1)
	I.use(1)
	if(user != victim)
		user.visible_message("<span class='notice'><b>[user]</b> заканчивает применять [I] на [ru_parse_zone(limb.name)] <b>[victim]</b>, издавая шипящий звук!</span>", "<span class='notice'>Заканчиваю применять [I] на [ru_parse_zone(limb.name)] <b>[victim]</b>!</span>", ignored_mobs=victim)
		to_chat(victim, "<span class='green'><b>[user]</b> заканчивает применять [I] на мою [ru_parse_zone(limb.name)], сразу начинаю чувствовать как мои кости реформируются!</span>")
	else
		victim.visible_message("<span class='notice'><b>[victim]</b> заканчивает применять [I] на [victim.ru_ego()] [ru_parse_zone(limb.name)], !</span>", "<span class='green'>Заканчиваю применять [I] на мою [ru_parse_zone(limb.name)], сразу начинаю чувствовать как мои кости реформируются!</span>")

	taped = TRUE
	processes = TRUE

/datum/wound/brute/bone/treat(obj/item/I, mob/user)
	if(istype(I, /obj/item/stack/medical/bone_gel))
		gel(I, user)
	else if(istype(I, /obj/item/stack/sticky_tape/surgical))
		tape(I, user)
	else if(istype(I, /obj/item/stack/medical/gauze))
		splint(I, user)

/datum/wound/brute/bone/get_scanner_description(mob/user)
	. = ..()

	. += "<div class='ml-3'>"

	if(!gelled)
		. += "Альтернативное лечение: Нанесите костный гель непосредственно на поврежденную конечность, затем нанесите хирургическую ленту, чтобы начать регенерацию кости. Это мучительно больно и медленно, и рекомендуется только в тяжелых обстоятельствах.\n"
	else if(!taped)
		. += "<span class='notice'>Продолжить альтернативное лечение: Нанесите хирургическую ленту непосредственно на поврежденную конечность, чтобы начать регенерацию кости. Обратите внимание, это одновременно мучительно больно и медленно.</span>\n"
	else
		. += "<span class='notice'>Заметка: Регенерация костей в действии. Кость регенерировала на [round(regen_points_current/regen_points_needed)]%.</span>\n"

	if(limb.body_zone == BODY_ZONE_HEAD)
		. += "Обнаружена черепно-мозговая травма: Пациент будет страдать от случайных приступов [severity == WOUND_SEVERITY_SEVERE ? "незначительных" : "серьёзных"] травм головного мозга, пока кость не будет восстановлена."
	else if(limb.body_zone == BODY_ZONE_CHEST && victim.blood_volume)
		. += "Обнаружена травма грудной клетки: Дальнейшее повреждение груди может усилить внутреннее кровотечение, пока не будет восстановлена кость."
	. += "</div>"
