
/* AREAS */

/area/awaymission/chilly
	name = "Surface"
	icon = 'white/rebolution228/map_sprites.dmi'
	icon_state = "coutdoor"
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	requires_power = FALSE
	has_gravity = STANDARD_GRAVITY
	area_flags = VALID_TERRITORY | UNIQUE_AREA | NOTELEPORT
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	poweralm = FALSE

/area/awaymission/chilly/facility
	name = "Base"
	icon_state = "base"
	dynamic_lighting = DYNAMIC_LIGHTING_ENABLED
	requires_power = TRUE
	ambientsounds = MAINTENANCE
	always_unpowered = TRUE

/area/awaymission/chilly/facility2
	name = "Base 2"
	icon_state = "base2"
	dynamic_lighting = DYNAMIC_LIGHTING_ENABLED
	requires_power = TRUE
	ambientsounds = MAINTENANCE
	always_unpowered = TRUE

/area/awaymission/chilly/facility3
	name = "Base 3"
	icon_state = "base3"
	dynamic_lighting = DYNAMIC_LIGHTING_ENABLED
	requires_power = TRUE
	always_unpowered = TRUE

/area/awaymission/chilly/facility4
	name = "Base 4"
	icon_state = "base4"
	dynamic_lighting = DYNAMIC_LIGHTING_ENABLED
	requires_power = TRUE
	always_unpowered = TRUE

/area/awaymission/chilly/gatewaystart
	name = "Gateway"
	icon_state = "base4"
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	requires_power = FALSE
	always_unpowered = FALSE

/area/awaymission/chilly/cave
	name = "Cavern"
	icon_state = "caverns"
	dynamic_lighting = DYNAMIC_LIGHTING_ENABLED
	requires_power = TRUE
	ambientsounds = SPOOKY
	always_unpowered = TRUE

/area/awaymission/chilly/mountain
	name = "Mountain"
	icon_state = "mountain"
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	always_unpowered = TRUE

/* TURFS */


/turf/open/floor/plasteel/stairs/old/chilly
	name = "stairs"
	icon = 'white/rebolution228/map_sprites.dmi'
	icon_state = "stairs"

/turf/open/floor/plasteel/stairs/old/chilly/right
	name = "stairs"
	icon = 'white/rebolution228/map_sprites.dmi'
	icon_state = "stairs_right"

/turf/open/floor/plasteel/stairs/old/chilly/left
	name = "stairs"
	icon = 'white/rebolution228/map_sprites.dmi'
	icon_state = "stairs_left"

/turf/open/floor/plasteel/stairs/old/chilly/single
	name = "stairs"
	icon = 'white/rebolution228/map_sprites.dmi'
	icon_state = "stairs_single"

/* MISC */


/obj/effect/turf_decal/weather/side
	name = "side"
	icon = 'white/rebolution228/map_sprites.dmi'
	icon_state = "side"
	mouse_opacity = 0

/obj/effect/turf_decal/weather/side/corner
	icon_state = "sidecorn"

/obj/effect/turf_decal/dust
	name = "dust"
	icon = 'white/rebolution228/map_sprites.dmi'
	icon_state = "dirty"
	mouse_opacity = 0

/turf/open/floor/grass/snow/safe/oxy
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/floor/plating/snowed/oxy
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = FALSE

/turf/open/floor/plating/asteroid/snow/ice/oxy
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = FALSE

/turf/open/floor/plating/snowed/smoothed/temperatre
	temperature = 255.37
	planetary_atmos = FALSE
	
/turf/open/floor/engine/hull/oxy
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	temperature = 255.37
	
/turf/open/floor/plating/ice/smooth/oxy
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = FALSE
	temperature = 250
	baseturfs = /turf/open/floor/grass/snow/safe/oxy
	
/turf/closed/mineral/snowmountain/cavern/oxy
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/oxy
	environment_type = null
	turf_type = /turf/open/floor/plating/asteroid/snow/ice/oxy
