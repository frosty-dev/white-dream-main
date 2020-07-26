/turf/closed
	layer = CLOSED_TURF_LAYER
	opacity = 1
	density = TRUE
	blocks_air = TRUE
	flags_1 = RAD_PROTECT_CONTENTS_1 | RAD_NO_CONTAMINATE_1
	rad_insulation = RAD_MEDIUM_INSULATION

/turf/closed/Initialize()
	. = ..()
	update_air_ref()

/turf/closed/AfterChange()
	. = ..()
	SSair.high_pressure_delta -= src
	update_air_ref()

/turf/closed/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	return FALSE

/turf/closed/CanAllowThrough(atom/movable/mover, turf/target)
	. = ..()
	if(istype(mover) && (mover.pass_flags & PASSCLOSEDTURF))
		return TRUE

/turf/closed/indestructible
	name = "стена"
	icon = 'icons/turf/walls.dmi'
	explosion_block = 50

/turf/closed/indestructible/rust_heretic_act()
	return

/turf/closed/indestructible/TerraformTurf(path, new_baseturf, flags, defer_change = FALSE, ignore_air = FALSE)
	return

/turf/closed/indestructible/acid_act(acidpwr, acid_volume, acid_id)
	return 0

/turf/closed/indestructible/Melt()
	to_be_destroyed = FALSE
	return src

/turf/closed/indestructible/singularity_act()
	return

/turf/closed/indestructible/oldshuttle
	name = "странная челночная стена"
	icon = 'icons/turf/shuttleold.dmi'
	icon_state = "block"

/turf/closed/indestructible/sandstone
	name = "песчаниковая стена"
	desc = "A wall with sandstone plating. Rough."
	icon = 'icons/turf/walls/sandstone_wall.dmi'
	icon_state = "sandstone"
	baseturfs = /turf/closed/indestructible/sandstone
	smooth = SMOOTH_TRUE

/turf/closed/indestructible/oldshuttle/corner
	icon_state = "corner"

/turf/closed/indestructible/splashscreen
	name = "White Dream"
	desc = "Истерическая утопия."
	icon = 'icons/protocol_c.dmi'
	icon_state = "blank"
	layer = SPLASHSCREEN_LAYER
	plane = SPLASHSCREEN_PLANE
	bullet_bounce_sound = null
	maptext_height = 480
	maptext_width = 608
	maptext_x = 4
	maptext_y = 8

/turf/closed/indestructible/splashscreen/proc/do_cring()
	filters += filter(type = "displace", icon = 'white/valtos/icons/cfas.png', size = 0)
	animate(filters[1], size = 4, time = 300, loop = -1, easing = SINE_EASING)
	animate(size = 0, y = -4, time = 300)

/turf/closed/indestructible/splashscreen/New()
	SStitle.splash_turf = src
	..()

/turf/closed/indestructible/splashscreen/vv_edit_var(var_name, var_value)
	. = ..()
	if(.)
		switch(var_name)
			if("icon")
				SStitle.icon = icon

/turf/closed/indestructible/riveted
	icon = 'icons/turf/walls/riveted.dmi'
	icon_state = "riveted"
	smooth = SMOOTH_TRUE

/turf/closed/indestructible/syndicate
	name = "пластитановая стена"
	desc = "Зловещая стена со пластитановым покрытием."
	icon = 'icons/turf/walls/plastitanium_wall.dmi'
	icon_state = "map-shuttle"
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/closed/indestructible/syndicate, /turf/closed/wall/mineral/plastitanium/interior)

/turf/closed/indestructible/riveted/uranium
	icon = 'icons/turf/walls/uranium_wall.dmi'
	icon_state = "uranium"

/turf/closed/indestructible/riveted/plastinum
	name = "plastinum wall"
	desc = "A luxurious wall made out of a plasma-platinum alloy. Effectively impervious to conventional methods of destruction."
	icon = 'icons/turf/walls/plastinum_wall.dmi'
	icon_state = "shuttle"

/turf/closed/indestructible/abductor
	icon_state = "alien1"

/turf/closed/indestructible/opshuttle
	icon_state = "wall3"

/turf/closed/indestructible/fakeglass
	name = "окно"
	icon_state = "fake_window"
	opacity = 0
	smooth = SMOOTH_TRUE
	icon = 'icons/obj/smooth_structures/reinforced_window.dmi'

/turf/closed/indestructible/fakeglass/Initialize()
	. = ..()
	icon_state = null //set the icon state to null, so our base state isn't visible
	underlays += mutable_appearance('icons/obj/structures.dmi', "grille") //add a grille underlay
	underlays += mutable_appearance('icons/turf/floors.dmi', "plating") //add the plating underlay, below the grille

/turf/closed/indestructible/opsglass
	name = "окно"
	icon_state = "plastitanium_window"
	opacity = 0
	smooth = SMOOTH_TRUE
	icon = 'icons/obj/smooth_structures/plastitanium_window.dmi'

/turf/closed/indestructible/opsglass/Initialize()
	. = ..()
	icon_state = null
	underlays += mutable_appearance('icons/obj/structures.dmi', "grille")
	underlays += mutable_appearance('icons/turf/floors.dmi', "plating")

/turf/closed/indestructible/fakedoor
	name = "CentCom Access"
	icon = 'icons/obj/doors/airlocks/centcom/centcom.dmi'
	icon_state = "fake_door"

/turf/closed/indestructible/rock
	name = "плотная скала"
	desc = "Чрезвычайно плотная порода, большинство горнодобывающих орудий и взрывчатых веществ никогда не пройдет сквозь нее."
	icon = 'icons/turf/mining.dmi'
	icon_state = "rock"

/turf/closed/indestructible/rock/snow
	name = "склон горы"
	desc = "Чрезвычайно плотная скала, покрытая льдом и снегом на протяжении столетий."
	icon = 'icons/turf/walls.dmi'
	icon_state = "snowrock"
	bullet_sizzle = TRUE
	bullet_bounce_sound = null

/turf/closed/indestructible/rock/snow/ice
	name = "ледяной камень"
	desc = "Чрезвычайно плотно заполненные ледяные и скальные покровы, выкованные за годы сильного холода."
	icon = 'icons/turf/walls.dmi'
	icon_state = "icerock"

/turf/closed/indestructible/rock/snow/ice/ore
	icon = 'icons/turf/walls/icerock_wall.dmi'
	icon_state = "icerock"
	smooth = SMOOTH_MORE|SMOOTH_BORDER
	canSmoothWith = list (/turf/closed)
	pixel_x = -4
	pixel_y = -4


/turf/closed/indestructible/paper
	name = "толстая бумажная стена"
	desc = "Стена, покрытая непроницаемыми листами бумаги."
	icon = 'icons/turf/walls.dmi'
	icon_state = "paperwall"

/turf/closed/indestructible/necropolis
	name = "стена некрополя"
	desc = "Казалось бы, непробиваемая стена."
	icon = 'icons/turf/walls.dmi'
	icon_state = "necro"
	explosion_block = 50
	baseturfs = /turf/closed/indestructible/necropolis

/turf/closed/indestructible/necropolis/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	underlay_appearance.icon = 'icons/turf/floors.dmi'
	underlay_appearance.icon_state = "necro1"
	return TRUE

/turf/closed/indestructible/riveted/boss
	name = "стена некрополя"
	desc = "Толстая, казалось бы, неразрушимая каменная стена."
	icon = 'icons/turf/walls/boss_wall.dmi'
	icon_state = "wall"
	canSmoothWith = list(/turf/closed/indestructible/riveted/boss, /turf/closed/indestructible/riveted/boss/see_through)
	explosion_block = 50
	baseturfs = /turf/closed/indestructible/riveted/boss

/turf/closed/indestructible/riveted/boss/see_through
	opacity = FALSE

/turf/closed/indestructible/riveted/boss/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	underlay_appearance.icon = 'icons/turf/floors.dmi'
	underlay_appearance.icon_state = "basalt"
	return TRUE

/turf/closed/indestructible/riveted/hierophant
	name = "стена"
	desc = "Стена, сделанная из странного металла. Квадраты на нем пульсируют предсказуемым образом."
	icon = 'icons/turf/walls/hierophant_wall.dmi'
	icon_state = "wall"
