/turf/open/floor/partyhard
	name = "floor"
	icon = 'white/valtos/icons/turfs.dmi'
	baseturfs = /turf/open/openspace
	icon_state = "b-1"
	floor_tile = null

/turf/open/floor/partyhard/steel
	icon_state = "g-4"
	footstep = FOOTSTEP_PLATING
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/partyhard/wood
	icon_state = "w-1"
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/partyhard/break_tile()
	return //unbreakable

/turf/open/floor/partyhard/burn_tile()
	return //unburnable

/turf/open/floor/partyhard/make_plating(force = 0)
	if(force)
		..()
	return //unplateable

/turf/open/floor/partyhard/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/turf/open/floor/partyhard/crowbar_act(mob/living/user, obj/item/I)
	return

/turf/closed/wall/partyhard
	name = "durawall"
	desc = "Durable metal wall."
	icon = 'white/valtos/icons/walls.dmi'
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/closed/wall/partyhard, /turf/closed/wall/r_wall/partyhard, /obj/machinery/door/airlock/, /obj/structure/window/fulltile, /obj/structure/window/reinforced/fulltile)

/turf/closed/wall/r_wall/partyhard
	name = "durable reinforced wall"
	desc = "A huge chunk of durable reinforced metal."
	icon = 'white/valtos/icons/r_walls.dmi'
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/closed/wall/r_wall/partyhard, /turf/closed/wall/partyhard, /obj/machinery/door/airlock/, /obj/structure/window/fulltile, /obj/structure/window/reinforced/fulltile)

/obj/structure/window/reinforced/fulltile/partyhard
	icon = 'white/valtos/icons/windows.dmi'
	icon_state = "smooth"
	max_integrity = 200
	canSmoothWith = list(/obj/structure/window/fulltile, /obj/structure/window/reinforced/fulltile, /obj/structure/window/reinforced/tinted/fulltile, /obj/structure/window/plasma/fulltile, /obj/structure/window/plasma/reinforced/fulltile, /turf/closed/wall/r_wall/partyhard, /turf/closed/wall/partyhard, /obj/structure/window/reinforced/fulltile/partyhard)

/obj/effect/spawner/structure/window/reinforced/partyhard
	icon = 'white/valtos/icons/windows.dmi'
	icon_state = "smooth"
	spawn_list = list(/obj/structure/grille, /obj/structure/window/reinforced/fulltile/partyhard)

/turf/closed/mineral/partyhard
	name = "rock"
	icon = 'icons/turf/mining.dmi'
	smooth_icon = 'icons/turf/walls/rock_wall.dmi'
	icon_state = "rock2"
	smooth = SMOOTH_MORE|SMOOTH_BORDER
	canSmoothWith = list (/turf/closed)
	baseturfs = /turf/open/floor/plating/ashplanet/rocky
	environment_type = "waste"
	turf_type = /turf/open/floor/plating/ashplanet/rocky
	defer_change = 1

/turf/closed/indestructible/black
	name = "nothing"
	icon = 'white/valtos/icons/area.dmi'
	icon_state = "black"
	layer = FLY_LAYER
	bullet_bounce_sound = null

/area/partyhard
	icon = 'white/valtos/icons/area.dmi'
	icon_state = "1f"
	name = "partyhard"
	has_gravity = STANDARD_GRAVITY

/area/partyhard/outdoors
	icon_state = "1f"
	name = "outdoors"
	always_unpowered = TRUE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambientsounds = MINING
	outdoors = TRUE

/area/partyhard/outdoors/unexplored
	icon_state = "2f"
	name = "far away"
	always_unpowered = TRUE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambientsounds = MINING
	outdoors = TRUE

/area/partyhard/odin
	icon_state = "1f"
	name = "1st floor"

/area/partyhard/dva
	icon_state = "2f"
	name = "2nd floor"

/area/partyhard/tri
	icon_state = "3f"
	name = "3rd floor"

/area/partyhard/chetyre
	icon_state = "4f"
	name = "4th floor"

/area/partyhard/pyat
	icon_state = "5f"
	name = "5th floor"

/area/partyhard/surface
	icon_state = "4f"
	name = "surface"
	always_unpowered = TRUE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambientsounds = RUINS
	outdoors = TRUE
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED

/area/shuttle/partyhard
	name = "Station Elevator"

/obj/machinery/computer/shuttle/partyhard
	name = "elevator console"
	desc = "A elevator control computer."
	icon_screen = "shuttle"
	icon_keyboard = "tech_key"
	light_color = LIGHT_COLOR_CYAN
	shuttleId = "partyhard_elevator"
	possible_destinations = "ph_station_bottom;ph_station_top"

/obj/effect/turf_decal/partyhard/lines
	icon = 'white/valtos/icons/decals.dmi'
	icon_state = "s-1"

/turf/open/floor/plating/partyhard
	icon = 'icons/turf/mining.dmi'
	gender = PLURAL
	name = "ash"
	icon_state = "ash"
	smooth = SMOOTH_MORE|SMOOTH_BORDER
	var/smooth_icon = 'icons/turf/floors/ash.dmi'
	desc = "The ground is covered in volcanic ash."
	baseturfs = /turf/open/floor/plating/partyhard
	initial_gas_mix = KITCHEN_COLDROOM_ATMOS
	planetary_atmos = TRUE
	attachment_holes = FALSE
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE

/turf/open/floor/plating/partyhard/Initialize()
	if(smooth)
		var/matrix/M = new
		M.Translate(-4, -4)
		transform = M
		icon = smooth_icon
	. = ..()


/obj/structure/pillar
	name = "pillar"
	desc = "Заборчик. Круто."
	icon = 'white/valtos/icons/objects.dmi'
	icon_state = "b-1"
	density = FALSE
	layer = BYOND_LIGHTING_LAYER
	plane = BYOND_LIGHTING_PLANE
	pressure_resistance = 4*ONE_ATMOSPHERE
	anchored = TRUE
	flags_1 = ON_BORDER_1
	max_integrity = 250
	can_be_unanchored = FALSE
	resistance_flags = ACID_PROOF
	armor = list("melee" = 90, "bullet" = 90, "laser" = 100, "energy" = 100, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 80, "acid" = 100)
	CanAtmosPass = ATMOS_PASS_YES
	rad_insulation = RAD_NO_INSULATION
	var/real_explosion_block	//ignore this, just use explosion_block

/obj/structure/pillar/CanPass(atom/movable/mover, turf/target)
	. = ..()
	if(istype(mover) && (mover.pass_flags & PASSTABLE))
		return TRUE
	return TRUE

/obj/structure/pillar/CheckExit(atom/movable/O, turf/target)
	if(istype(O) && (O.pass_flags & PASSTABLE))
		return TRUE
	if(get_dir(O.loc, target) == dir)
		return FALSE
	return TRUE

/obj/structure/pillar/CanAtmosPass(turf/T)
	return TRUE

/********************** New mining areas **************************/

/area/thetaMining
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE

/area/thetaMining/surface
	name = "Mining Theta"
	icon_state = "purple"
	always_unpowered = TRUE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = TRUE
	requires_power = TRUE
	ambientsounds = MINING
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	outdoors = TRUE

/area/thetaMining/underground
	name = "Caves"
	icon_state = "red"
	always_unpowered = TRUE
	requires_power = TRUE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	ambientsounds = MINING
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
