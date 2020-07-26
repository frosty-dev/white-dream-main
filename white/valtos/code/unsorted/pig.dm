/mob/living/simple_animal/pig
	name = "свинья"
	desc = "Хрюкает."
	icon = 'white/valtos/icons/animal.dmi'
	icon_state = "pig"
	icon_living = "pig"
	icon_dead = "pig_dead"
	speak = list("ХРЮ!","УИИИИ!","ХРЮ?")
	speak_emote = list("хрюкает")
	emote_hear = list("хрюкает.")
	emote_see = list("хрюкает.")
	speak_chance = 5
	turns_per_move = 1
	see_in_dark = 3
	maxHealth = 50
	health = 50
	attacked_sound = 'white/valtos/sounds/pig/oink.ogg'
	deathsound = 'white/valtos/sounds/pig/death.ogg'
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/pig = 3)
	response_help_continuous = "гладит"
	response_help_simple = "гладит"
	response_disarm_continuous = "отталкивает"
	response_disarm_simple = "отталкивает"
	response_harm_continuous = "пинает"
	response_harm_simple = "пинает"
	density = TRUE
	mob_size = MOB_SIZE_LARGE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	gold_core_spawnable = FRIENDLY_SPAWN
	can_be_held = FALSE
	held_state = "pig"
	faction = list("neutral")

/mob/living/simple_animal/pig/Life()
	..()
	if(stat)
		return
	if(prob(10))
		var/chosen_sound = pick('white/valtos/sounds/pig/hru.ogg', 'white/valtos/sounds/pig/oink.ogg', 'white/valtos/sounds/pig/squeak.ogg')
		playsound(src, chosen_sound, 50, TRUE)

/obj/item/reagent_containers/food/snacks/meat/slab/pig
	name = "сало"
	icon = 'white/valtos/icons/items.dmi'
	icon_state = "salo"
	slice_path = /obj/item/reagent_containers/food/snacks/meat/rawcutlet/plain/salo
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/meat/rawcutlet/plain/salo
	name = "сало"
	icon = 'white/valtos/icons/items.dmi'
	icon_state = "salo_slice"
