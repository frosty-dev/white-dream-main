/turf/closed/wall/mineral/cult
	name = "стена с рунами"
	desc = "Стена с непонятными рунами на ней, которые вызывают боли в голове если долго смотреть на них. Холодная на ощупь."
	icon = 'icons/turf/walls/cult_wall.dmi'
	icon_state = "cult"
	canSmoothWith = null
	smooth = SMOOTH_MORE
	sheet_type = /obj/item/stack/sheet/runed_metal
	sheet_amount = 1
	girder_type = /obj/structure/girder/cult

/turf/closed/wall/mineral/cult/Initialize()
	new /obj/effect/temp_visual/cult/turf(src)
	. = ..()

/turf/closed/wall/mineral/cult/devastate_wall()
	new sheet_type(get_turf(src), sheet_amount)

/turf/closed/wall/mineral/cult/Exited(atom/movable/AM, atom/newloc)
	. = ..()
	if(istype(AM, /mob/living/simple_animal/hostile/construct/harvester)) //harvesters can go through cult walls, dragging something with
		var/mob/living/simple_animal/hostile/construct/harvester/H = AM
		var/atom/movable/stored_pulling = H.pulling
		if(stored_pulling)
			stored_pulling.setDir(get_dir(stored_pulling.loc, newloc))
			stored_pulling.forceMove(src)
			H.start_pulling(stored_pulling, supress_message = TRUE)

/turf/closed/wall/mineral/cult/artificer
	name = "стена с рунами"
	desc = "Стена с непонятными рунами на ней, которые вызывают боли в голове если долго смотреть на них. Холодная на ощупь."

/turf/closed/wall/mineral/cult/artificer/break_wall()
	new /obj/effect/temp_visual/cult/turf(get_turf(src))
	return null //excuse me we want no runed metal here

/turf/closed/wall/mineral/cult/artificer/devastate_wall()
	new /obj/effect/temp_visual/cult/turf(get_turf(src))

/turf/closed/wall/vault
	icon = 'icons/turf/walls.dmi'
	icon_state = "rockvault"

/turf/closed/wall/ice
	icon = 'icons/turf/walls/icedmetal_wall.dmi'
	icon_state = "iced"
	desc = "Стена покрытая льдом."
	canSmoothWith = null
	hardness = 35
	slicing_duration = 150 //welding through the ice+metal
	bullet_sizzle = TRUE

/turf/closed/wall/rust
	name = "ржавая стена"
	desc = "Старая ржавая стена."
	icon = 'icons/turf/walls/rusty_wall.dmi'
	hardness = 45

/turf/closed/wall/rust/rust_heretic_act()
	ScrapeAway()

/turf/closed/wall/r_wall/rust
	name = "ржавая укреплённая стена"
	desc = "Старая укреплённая ржавая стена."
	icon = 'icons/turf/walls/rusty_reinforced_wall.dmi'
	hardness = 15

/turf/closed/wall/r_wall/rust/rust_heretic_act()
	if(prob(50))
		return
	ScrapeAway()

/turf/closed/wall/mineral/bronze
	name = "бронзовая стена"
	desc = "Крупная бронзовая стена. Её украшивают также и бронзовые шестерни."
	icon = 'icons/turf/walls/clockwork_wall.dmi'
	icon_state = "clockwork_wall"
	sheet_type = /obj/item/stack/tile/bronze
	sheet_amount = 2
	girder_type = /obj/structure/girder/bronze
