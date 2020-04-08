/turf/open/floor/dz
	icon = 'code/shitcode/valtos/icons/dz-031.dmi'

/turf/closed/dz
	icon = 'code/shitcode/valtos/icons/dz-031.dmi'

/turf/open/floor/dz/normal
	name = "киберпространство"
	icon_state = "open"
	plane = PLANE_SPACE
	layer = SPACE_LAYER
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	vis_flags = VIS_INHERIT_ID
	blocks_air = TRUE

/turf/open/floor/dz/normal/Initialize()
	SHOULD_CALL_PARENT(FALSE)
	vis_contents.Cut()
	visibilityChanged()

	if(flags_1 & INITIALIZED_1)
		stack_trace("Warning: [src]([type]) initialized multiple times!")
	flags_1 |= INITIALIZED_1

	ComponentInitialize()

	return INITIALIZE_HINT_NORMAL

/turf/open/floor/dz/pre_exit
	name = "зона выхода"
	icon_state = "pre_exit"

/turf/open/floor/dz/exit
	name = "выход"
	icon_state = "exit"

/turf/open/floor/dz/corruption
	name = "повреждение"
	icon_state = "corruption"

/turf/open/floor/dz/hot_plates
	name = "опасная зона"
	icon_state = "hot_plates"

/turf/closed/dz/normal
	name = "блок"
	icon_state = "closed"

/obj/structure/sign/dz
	name = "DZ-0031"
	desc = "Удивительно, что у тебя есть время на рассматривание этого."
	icon = 'code/shitcode/valtos/icons/dz-031.dmi'
	icon_state = "dz1"

/obj/structure/sign/dz/middle
	icon_state = "dz2"

/obj/structure/sign/dz/end
	icon_state = "dz3"

/area/cyberspace
	name = "Киберпространство"
	icon_state = "maint_bar"
	has_gravity = STANDARD_GRAVITY

/area/cyberspace/exit
	name = "Выход"
	icon_state = "maint_eva"

/area/cyberspace/border
	name = "Граница киберпространства"
	icon_state = "maint_sec"
