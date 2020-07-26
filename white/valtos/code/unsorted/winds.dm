/obj/effect/temp_visual/dir_setting/space_wind
	icon = 'white/valtos/icons/wind.dmi'
	icon_state = "space_wind"
	layer = FLY_LAYER
	duration = 20
	mouse_opacity = 0

/obj/effect/temp_visual/dir_setting/space_wind/Initialize(mapload, set_dir, set_alpha = 255)
	. = ..()
	alpha = set_alpha
