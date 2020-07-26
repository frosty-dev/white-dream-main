/obj/item/melee/vanya
	name = "eldritch sword"
	desc = "Looks like life of this weapon is located in tentacle, what gets out from broken crystal."
	icon = 'white/Wzzzz/Knife.dmi'
	lefthand_file = 'white/Wzzzz/Knifel.dmi'
	righthand_file = 'white/Wzzzz/Knifer.dmi'
	icon_state = "old_sword"
	inhand_icon_state = "old_sword"
	force = 23
	sharpness = 2
	resistance_flags = LAVA_PROOF|FIRE_PROOF|ACID_PROOF|INDESTRUCTIBLE|FREEZE_PROOF
	block_chance = 25
	damtype = "sharp"
	sharpness = 3

/obj/item/ammo_casing/rod/skel
    projectile_type = /obj/projectile/rod/skel

/obj/projectile/rod/skel
	charge = 2
	damage = 15
	stutter = 1
	jitter = 1

/obj/projectile/rod/skel/on_hit(atom/target, blocked = FALSE)
	..()
	var/volume = vol_by_damage()
	if (istype(target, /mob))
		playsound(target, impale_sound, volume, 1, -1)
		if (ishuman(target)) // Only fully charged shots can impale
			var/mob/living/carbon/human/H = target
			Impale(H)
	else
		playsound(target, hitsound_override, volume, 1, -1)
	qdel(src)

/mob/living/simple_animal/hostile/skeleton/vanya
	name = "skeleton archer"
	icon = 'white/Wzzzz/e.dmi'
	faction = list("mining")
	weather_immunities = list("ash")
	icon_state = "bownner"
	icon_living = "bownner"
	icon_dead = "bownner"
	projectiletype = /obj/projectile/rod/skel
	projectilesound = 'white/valtos/sounds/rodgun_fire.ogg'
	ranged = 1
	ranged_message = "stares"
	ranged_cooldown_time = 40
	vision_range = 7
	loot = list(/obj/effect/decal/remains/human, /obj/item/stack/rods)

/mob/living/simple_animal/hostile/skeleton/vanya/Initialize(mapload)
	. = ..()
	apply_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)

/mob/living/simple_animal/hostile/vanya
	icon = 'white/Wzzzz/e.dmi'

/mob/living/simple_animal/hostile/vanya/killermeat
	name = "Killer Meat"
	desc = "It's a horrifyingly enormous pile of meat. It looks wild."
	icon_state = "nicemeal"
	icon_living = "nicemeal"
	icon_dead = "nicemeals"
	gender = NEUTER
	speak_chance = 0
	weather_immunities = list("ash")
	turns_per_move = 1
	maxHealth = 300
	health = 300
	see_in_dark = 0
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 4, /obj/item/stack/sheet/bone = 2)
	response_help_continuous = "prods"
	response_help_simple = "prod"
	response_disarm_continuous = "pushes aside"
	response_disarm_simple = "push aside"
	response_harm_continuous = "smacks"
	response_harm_simple = "smack"
	melee_damage_lower = 10
	melee_damage_upper = 17
	attack_verb_continuous = "slams"
	attack_verb_simple = "slam"
	attack_sound = 'sound/effects/blobattack.ogg'
	ventcrawler = VENTCRAWLER_ALWAYS
	faction = list("plants","mining")
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 150
	maxbodytemp = 800
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/vanya/killermeat/Moved(atom/OldLoc, Dir, Forced = FALSE)
	if(Dir)
		new /obj/effect/decal/cleanable/blood/splatter(src.loc)
	return ..()

/mob/living/simple_animal/hostile/vanya/killermeat/Initialize(mapload)
	. = ..()
	apply_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)

/mob/living/simple_animal/hostile/vanya/leech
	name = "Leechs"
	desc = "It's a horrifyingly big leechs. It looks scary and hungry."
	icon_state = "chervebaloyed"
	icon_living = "chervebaloyed"
	icon_dead = "chervebaloyeds"
	gender = NEUTER
	speak_chance = 0
	turns_per_move = 2
	maxHealth = 50
	health = 50
	faction = list("mining")
	weather_immunities = list("ash")
	see_in_dark = 1
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/fly = 1)
	response_help_continuous = "prods"
	response_help_simple = "prod"
	response_disarm_continuous = "pushes aside"
	response_disarm_simple = "push aside"
	response_harm_continuous = "smacks"
	response_harm_simple = "smack"
	melee_damage_lower = 3
	melee_damage_upper = 5
	attack_verb_continuous = "eats"
	attack_verb_simple = "eat"
	attack_sound = null
	ventcrawler = VENTCRAWLER_ALWAYS
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 10, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 150
	maxbodytemp = 800
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/vanya/leech/Initialize(mapload)
	. = ..()
	apply_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)

/mob/living/simple_animal/hostile/faithless/vanya/chort
	name = "Imp"
	desc = "Imp?"
	icon = 'white/Wzzzz/e.dmi'
	icon_state = "chort"
	icon_living = "chort"
	icon_dead = "chorts"
	gender = MALE
	speak_chance = 0
	turns_per_move = 2
	maxHealth = 150
	faction = list("mining")
	weather_immunities = list("lava","ash")
	health = 150
	see_in_dark = 3
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/human = 3)
	response_help_continuous = "prods"
	response_help_simple = "prod"
	response_disarm_continuous = "pushes aside"
	response_disarm_simple = "push aside"
	response_harm_continuous = "smacks"
	response_harm_simple = "smack"
	melee_damage_lower = 9
	melee_damage_upper = 14
	attack_verb_continuous = "kicks"
	attack_sound = 'sound/weapons/punch1.ogg'
	attack_verb_simple = "kick"
	ventcrawler = VENTCRAWLER_ALWAYS
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 60, "min_co2" = 0, "max_co2" = 100, "min_n2" = 0, "max_n2" = 80)
	minbodytemp = 150
	maxbodytemp = 800
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/faithless/vanya/chort/Initialize(mapload)
	. = ..()
	apply_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)

/mob/living/simple_animal/hostile/faithless/vanya/drown
	name = "Drowned"
	desc = "Blue skin, yellow eyes...that's undead?"
	icon = 'white/Wzzzz/e.dmi'
	icon_state = "blyadina"
	icon_living = "blyadina"
	icon_dead = "blyadinas"
	faction = list("mining")
	weather_immunities = list("ash")
	gender = MALE
	speak_chance = 0
	turns_per_move = 1
	maxHealth = 200
	health = 200
	see_in_dark = 100
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/fly = 2)
	response_help_continuous = "prods"
	response_help_simple = "prod"
	response_disarm_continuous = "pushes aside"
	response_disarm_simple = "push aside"
	response_harm_continuous = "smacks"
	response_harm_simple = "smack"
	melee_damage_lower = 10
	melee_damage_upper = 13
	attack_verb_continuous = "chokes"
	attack_sound = 'white/Wzzzz/drown.ogg'
	attack_verb_simple = "choke"
	ventcrawler = VENTCRAWLER_ALWAYS
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 00, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 50
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/faithless/vanya/drown/Initialize(mapload)
	. = ..()
	apply_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)

