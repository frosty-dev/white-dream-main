//////////////////The Man Behind The Slaughter

/mob/living/simple_animal/hostile/imp/slaughter
	name = "демон бойни"
	real_name = "slaughter demon"
	unique_name = FALSE
	speak_emote = list("gurgles")
	emote_hear = list("wails","screeches")
	icon_state = "daemon"
	icon_living = "daemon"
	minbodytemp = 0
	obj_damage = 50
	melee_damage_lower = 15 // reduced from 30 to 15 with wounds since they get big buffs to slicing wounds
	melee_damage_upper = 15
	wound_bonus = -10
	bare_wound_bonus = 0
	sharpness = SHARP_EDGED
	playstyle_string = "<span class='big bold'>Ты демон бойни,</span><B> ужасное создание из другого измерения. У тебя есть единственное желание — убивать. \
							Ты можешь использовать способность \"Ползанье в крови\" неподалеку от луж крови для того чтобы перемещаться между ними, появляясь и исчезая по собственному желанию. \
							Если ты тащишь труп или бессознательного моба входя в лужу, то это переместит его с вами, позволяя сожрать его и восстановить здоровье. \
							Ты ускоряешься выходя из кровавой лужи, однако материальный мир со временем истощит твои силы и ты скоро станешь довольно медлительным. \
							Ты набираешь силу с каждой атакой, нанесенной по живым гуманоидам, однако, эта сила оставит тебя, когда ты вернешься в кровь. Ты также можешь \
							провести сокрушительную отбрасывающую атаку, нажав ctrl+shift+ЛКМ, которая способна переломать кости за один удар.</B>"

	loot = list(/obj/effect/decal/cleanable/blood, \
				/obj/effect/decal/cleanable/blood/innards, \
				/obj/item/organ/heart/demon)
	del_on_death = 1
	///Sound played when consuming a body
	var/feast_sound = 'sound/magic/demon_consume.ogg'
	/// How long it takes for the alt-click slam attack to come off cooldown
	var/slam_cooldown_time = 45 SECONDS
	/// The actual instance var for the cooldown
	var/slam_cooldown = 0
	/// How many times we have hit humanoid targets since we last bloodcrawled, scaling wounding power
	var/current_hitstreak = 0
	/// How much both our wound_bonus and bare_wound_bonus go up per hitstreak hit
	var/wound_bonus_per_hit = 5
	/// How much our wound_bonus hitstreak bonus caps at (peak demonry)
	var/wound_bonus_hitstreak_max = 12
	discovery_points = 3000

/mob/living/simple_animal/hostile/imp/slaughter/Initialize(mapload, obj/effect/dummy/phased_mob/bloodpool)//Bloodpool is the blood pool we spawn in
	..()
	ADD_TRAIT(src, TRAIT_BLOODCRAWL_EAT, "innate")
	var/obj/effect/proc_holder/spell/bloodcrawl/bloodspell = new
	AddSpell(bloodspell)
	if(istype(loc, /obj/effect/dummy/phased_mob))
		bloodspell.phased = TRUE
	if(bloodpool)
		bloodpool.RegisterSignal(src, list(COMSIG_LIVING_AFTERPHASEIN,COMSIG_PARENT_QDELETING), /obj/effect/dummy/phased_mob/.proc/deleteself)

/mob/living/simple_animal/hostile/imp/slaughter/CtrlShiftClickOn(atom/A)
	if(!isliving(A))
		return ..()
	if(slam_cooldown + slam_cooldown_time > world.time)
		to_chat(src, "<span class='warning'>Отбрасывающая атака всё еще восстанавливается!</span>")
		return
	if(istype(loc, /obj/effect/dummy/phased_mob))
		to_chat(src, "<span class='warning'>Не могу бить, пока я нахожусь в крови!</span>")
		return

	face_atom(A)
	var/mob/living/victim = A
	victim.take_bodypart_damage(brute=20, wound_bonus=wound_bonus) // don't worry, there's more punishment when they hit something
	visible_message("<span class='danger'>[capitalize(src.name)] отбрасывает [victim] с монструозной силой!</span>", "<span class='danger'>Отбрасываю [victim] с монструозной силой!</span>", ignored_mobs=victim)
	to_chat(victim, "<span class='userdanger'>[capitalize(src.name)] отбрасывает меня с монструозной силой, как обычную тряпичную куклу!</span>")
	var/turf/yeet_target = get_edge_target_turf(victim, dir)
	victim.throw_at(yeet_target, 10, 5, src)
	slam_cooldown = world.time
	log_combat(src, victim, "slaughter slammed")

/mob/living/simple_animal/hostile/imp/slaughter/UnarmedAttack(atom/A, proximity)
	if(HAS_TRAIT(src, TRAIT_HANDS_BLOCKED))
		return
	if(iscarbon(A))
		var/mob/living/carbon/target = A
		if(target.stat != DEAD && target.mind && current_hitstreak < wound_bonus_hitstreak_max)
			current_hitstreak++
			wound_bonus += wound_bonus_per_hit
			bare_wound_bonus += wound_bonus_per_hit

	return ..()

/obj/effect/decal/cleanable/blood/innards
	name = "куча внутренностей"
	desc = "Отвратительная куча из кишок и крови."
	gender = NEUTER
	icon = 'icons/obj/surgery.dmi'
	icon_state = "innards"
	random_icon_states = null

/mob/living/simple_animal/hostile/imp/slaughter/phasein()
	. = ..()
	add_movespeed_modifier(/datum/movespeed_modifier/slaughter)
	addtimer(CALLBACK(src, .proc/remove_movespeed_modifier, /datum/movespeed_modifier/slaughter), 6 SECONDS, TIMER_UNIQUE | TIMER_OVERRIDE)

//The loot from killing a slaughter demon - can be consumed to allow the user to blood crawl
/obj/item/organ/heart/demon
	name = "демоническое сердце"
	desc = "Всё еще яростно бьется, излучая ауру абсолютной ненависти."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "demon_heart-on"
	decay_factor = 0

/obj/item/organ/heart/demon/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_blocker)

/obj/item/organ/heart/demon/attack(mob/M, mob/living/carbon/user, obj/target)
	if(M != user)
		return ..()
	user.visible_message("<span class='warning'>[user] поднимает [src] к [user.ru_ego()] рту и вгрызается в него при помощи [user.ru_ego()] зубов!</span>", \
		"<span class='danger'>Неестественный голод поглощает меня. Я поднимаю [src] к своему рту и пожираю!</span>")
	playsound(user, 'sound/magic/demon_consume.ogg', 50, TRUE)
	for(var/obj/effect/proc_holder/spell/knownspell in user.mind.spell_list)
		if(knownspell.type == /obj/effect/proc_holder/spell/bloodcrawl)
			to_chat(user, "<span class='warning'>...и не ощущаю никакой разницы.</span>")
			qdel(src)
			return
	user.visible_message("<span class='warning'>Глаза [user] вспыхивают темно-красным!</span>", \
		"<span class='userdanger'>Чувствую как странная сила растекается по моему телу... я поглотил способность демона путешествовать по крови!</span>")
	user.temporarilyRemoveItemFromInventory(src, TRUE)
	src.Insert(user) //Consuming the heart literally replaces your heart with a demon heart. H A R D C O R E

/obj/item/organ/heart/demon/Insert(mob/living/carbon/M, special = 0)
	..()
	if(M.mind)
		M.mind.AddSpell(new /obj/effect/proc_holder/spell/bloodcrawl(null))

/obj/item/organ/heart/demon/Remove(mob/living/carbon/M, special = 0)
	..()
	if(M.mind)
		M.mind.RemoveSpell(/obj/effect/proc_holder/spell/bloodcrawl)

/obj/item/organ/heart/demon/Stop()
	return 0 // Always beating.

/mob/living/simple_animal/hostile/imp/slaughter/laughter
	// The laughter demon! It's everyone's best friend! It just wants to hug
	// them so much, it wants to hug everyone at once!
	name = "демон смеха"
	real_name = "laughter demon"
	desc = "Большое, милое существо, облаченное в доспехи с розовыми бантиками."
	speak_emote = list("giggles","titters","chuckles")
	emote_hear = list("guffaws","laughs")
	response_help_continuous = "hugs"
	attack_verb_continuous = "яростно зажимает"
	attack_verb_simple = "яростно зажимает"

	attack_sound = 'sound/items/bikehorn.ogg'
	attack_vis_effect = null
	feast_sound = 'sound/spookoween/scary_horn2.ogg'
	deathsound = 'sound/misc/sadtrombone.ogg'

	icon_state = "bowmon"
	icon_living = "bowmon"
	deathmessage = "исчезает, так как все его друзья освободились из его \
		тюрьмы объятий."
	loot = list(/mob/living/simple_animal/pet/cat/kitten{name = "Laughter"})

	// Keep the people we hug!
	var/list/consumed_mobs = list()

	playstyle_string = "<span class='big bold'>Ты демон \
	смеха,</span><B> замечательное существо из другого измерения. У тебя лишь одно \
	желание: <span class='clown'>Обнимать и щекотать.</span><BR>\
	Ты можешь использовать способность \"Ползанье в крови\" неподалеку от кровавых луж для того чтобы перемещаться \
	между ними, появляясь и исчезая по собственному желанию. \
	Если ты тащишь труп или бессознательного моба входя в лужу, то это переместит \
	его с вами, позволяя обнять их и восстановить здоровье.<BR> \
	Ты ускоряешься выходя из кровавой лужи, однако материальный мир \
	со временем истощит твои силы и ты станешь довольно медлительным.<BR>\
	Тебя немного огорчает то, что, видимо, люди умирают от того как ты их \
	щекочешь, но не переживай! Когда ты умрешь, то все кого ты обнял будут \
	освобождены и полностью исцелены, ведь, в конце концов, это всего лишь шутка, \
	братан!</B>"

/mob/living/simple_animal/hostile/imp/slaughter/laughter/Initialize()
	. = ..()
	if(SSevents.holidays && SSevents.holidays[APRIL_FOOLS])
		icon_state = "honkmon"

/mob/living/simple_animal/hostile/imp/slaughter/laughter/Destroy()
	release_friends()
	. = ..()

/mob/living/simple_animal/hostile/imp/slaughter/laughter/ex_act(severity)
	switch(severity)
		if(1)
			death()
		if(2)
			adjustBruteLoss(60)
		if(3)
			adjustBruteLoss(30)

/mob/living/simple_animal/hostile/imp/slaughter/laughter/proc/release_friends()
	if(!consumed_mobs)
		return

	var/turf/T = get_turf(src)

	for(var/mob/living/M in consumed_mobs)
		if(!M)
			continue

		// Unregister the signal first, otherwise it'll trigger the "ling revived inside us" code
		UnregisterSignal(M, COMSIG_MOB_STATCHANGE)

		M.forceMove(T)
		if(M.revive(full_heal = TRUE, admin_revive = TRUE))
			M.grab_ghost(force = TRUE)
			playsound(T, feast_sound, 50, TRUE, -1)
			to_chat(M, "<span class='clown'>Оставляю [src] теплые объятия,	 и чувствую силу покорять мир.</span>")

/mob/living/simple_animal/hostile/imp/slaughter/laughter/bloodcrawl_swallow(mob/living/victim)
	// Keep their corpse so rescue is possible
	consumed_mobs += victim
	RegisterSignal(victim, COMSIG_MOB_STATCHANGE, .proc/on_victim_statchange)

/* Handle signal from a consumed mob changing stat.
 *
 * A signal handler for if one of the laughter demon's consumed mobs has
 * changed stat. If they're no longer dead (because they were dead when
 * swallowed), eject them so they can't rip their way out from the inside.
 */
/mob/living/simple_animal/hostile/imp/slaughter/laughter/proc/on_victim_statchange(mob/living/victim, new_stat)
	SIGNAL_HANDLER

	if(new_stat == DEAD)
		return
	// Someone we've eaten has spontaneously revived; maybe nanites, maybe a changeling
	victim.forceMove(get_turf(src))
	victim.exit_blood_effect()
	victim.visible_message("<span class='warning'>Покрытый кровью [victim] возникает из воздуха, с озадаченным выражением лица.</span>")
	consumed_mobs -= victim
	UnregisterSignal(victim, COMSIG_MOB_STATCHANGE)

/mob/living/simple_animal/hostile/imp/slaughter/engine_demon
	name = "демон двигателя"
	faction = list("hell", "neutral")
