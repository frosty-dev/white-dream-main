//fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck
//
//FUCK
//
//fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck fuck

/turf/open/lifeweb

/turf/closed/lifeweb

/turf/closed/lifeweb/rock
	name = "rock"
	icon = 'icons/turf/mining.dmi'
	var/smooth_icon = 'white/valtos/icons/lifeweb/caves_fuck.dmi'
	icon_state = "rock"
	smooth = SMOOTH_MORE|SMOOTH_BORDER
	canSmoothWith = null
	baseturfs = /turf/open/floor/plating/asteroid/airless
	initial_gas_mix = AIRLESS_ATMOS
	opacity = 1
	density = TRUE
	layer = EDGED_TURF_LAYER
	temperature = TCMB
	var/obj/item/stack/ore/mineralType = null
	var/mineralAmt = 3
	var/spread = 0
	var/spreadChance = 0
	var/last_act = 0
	var/scan_state = ""
	var/defer_change = 0


/turf/closed/lifeweb/rock/Initialize()
	if (!canSmoothWith)
		canSmoothWith = list(/turf/closed/lifeweb/rock)
	var/matrix/M = new
	M.Translate(-4, -4)
	transform = M
	icon = smooth_icon
	. = ..()
