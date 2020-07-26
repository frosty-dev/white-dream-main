#define CRAB_POP_MAX 256

/mob/living/simple_animal/hostile/asteroid/mineral_crab
	name = "минеральный краб"
	desc = "Шестилапое и с клешнями. Не похоже на органическое существо, но тем не менее являющееся неплохим источником ресурсов \"живое ископаемое\"."
	icon = 'white/valtos/icons/gensokyo/crab.dmi'
	icon_state = "iron"
	icon_living = "iron"
	icon_aggro = "iron"
	icon_dead = "iron"
	icon_gib = "iron"
	mob_biotypes = MOB_MINERAL|MOB_BEAST
	mouse_opacity = MOUSE_OPACITY_ICON
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	move_to_delay = 20
	ranged = 1
	ranged_cooldown_time = 120
	friendly_verb_continuous = "тычет клешнёй"
	friendly_verb_simple = "тычет клешнёй"
	speak_emote = list("урчит")
	speed = 1
	maxHealth = 25
	health = 25
	harm_intent_damage = 0
	obj_damage = 75
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "прокусывает клешнёй"
	attack_verb_simple = "прокусывает клешнёй"
	attack_sound = 'white/valtos/sounds/gensokyo/crab_attack.ogg'
	throw_message = "пялится на"
	vision_range = 7
	aggro_vision_range = 9
	loot = list()
	var/ore = "iron"
	childtype = list(/mob/living/simple_animal/hostile/asteroid/mineral_crab)
	footstep_type = FOOTSTEP_MOB_HEAVY
	del_on_death = TRUE

/mob/living/simple_animal/hostile/asteroid/mineral_crab/Initialize()
	. = ..()
	pick_ore()

/mob/living/simple_animal/hostile/asteroid/mineral_crab/proc/pick_ore()
	ore = pick("iron", "glass", "gold", "silver", "plasma", "uranium", "titanium", "diamond")
	switch(ore)
		if("iron")
			loot = list(/obj/item/stack/ore/iron)
		if("glass")
			loot = list(/obj/item/stack/ore/glass)
		if("gold")
			loot = list(/obj/item/stack/ore/gold)
			melee_damage_lower = 25
			melee_damage_upper = 25
		if("silver")
			loot = list(/obj/item/stack/ore/silver)
			melee_damage_lower = 25
			melee_damage_upper = 25
		if("plasma")
			loot = list(/obj/item/stack/ore/plasma)
			melee_damage_lower = 20
			melee_damage_upper = 20
		if("uranium")
			loot = list(/obj/item/stack/ore/uranium)
			melee_damage_lower = 45
			melee_damage_upper = 45
		if("titanium")
			loot = list(/obj/item/stack/ore/titanium)
			melee_damage_lower = 50
			melee_damage_upper = 50
		if("diamond")
			loot = list(/obj/item/stack/ore/diamond)
			melee_damage_lower = 60
			melee_damage_upper = 60
	icon_state = ore
	icon_living = ore
	icon_aggro = ore
	icon_dead = ore
	icon_gib = ore
	SSmobs.crabstotal += src

/mob/living/simple_animal/hostile/asteroid/mineral_crab/Life()
	. = ..()
	make_babies()

/mob/living/simple_animal/hostile/asteroid/mineral_crab/Destroy()
	SSmobs.crabstotal -= src
	return ..()

/mob/living/simple_animal/hostile/asteroid/mineral_crab/drop_loot()
	if(loot.len)
		for(var/i in loot)
			new i(loc)
			if(prob(80))
				new i(loc)
			if(prob(55))
				new i(loc)
			if(prob(25))
				new i(loc)

/mob/living/simple_animal/hostile/asteroid/mineral_crab/make_babies()
	if(gender != FEMALE || stat || next_scan_time > world.time || !childtype || !animal_species || !SSticker.IsRoundInProgress())
		return
	next_scan_time = world.time + 400
	var/alone = TRUE
	var/mob/living/simple_animal/partner
	var/children = 0
	for(var/mob/living/simple_animal/hostile/asteroid/mineral_crab/M in view(5, src))
		if(M.stat != CONSCIOUS)
			continue
		else if(istype(M, childtype))
			children++
		else if(istype(M, animal_species))
			if(M.ckey)
				continue
			else if(!istype(M, childtype) && M.gender == MALE && !(M.flags_1 & HOLOGRAM_1) && ore == M.ore)
				partner = M

		else if(isliving(M) && !faction_check_mob(M))
			return

	if(alone && partner && children < 3 && LAZYLEN(SSmobs.crabstotal) < CRAB_POP_MAX)
		var/childspawn = pickweight(childtype)
		var/turf/target = get_turf(loc)
		if(target)
			return new childspawn(target)
