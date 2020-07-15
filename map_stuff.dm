// Негр в Чили.
// Источник вдохновения - https://www.youtube.com/watch?v=oHg5SJYRHA0

/* AREAS */


/area/awaymission/chilly
	name = "Surface"
	icon = 'rebolution228/map_sprites.dmi' // изменить путь при переброске в папку shitcode, потому что мне лень
	icon_state = "coutdoor"
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	requires_power = FALSE
	has_gravity = STANDARD_GRAVITY
	noteleport = TRUE
	valid_territory = FALSE

/area/awaymission/chilly/facility
	name = "Base"
	icon_state = "base"
	dynamic_lighting = DYNAMIC_LIGHTING_ENABLED
	requires_power = TRUE
	ambientsounds = MAINTENANCE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	poweralm = FALSE

/area/awaymission/chilly/facility2
	name = "Base 2"
	icon_state = "base2"
	dynamic_lighting = DYNAMIC_LIGHTING_ENABLED
	requires_power = TRUE
	ambientsounds = MAINTENANCE
	poweralm = FALSE
	always_unpowered = TRUE

/area/awaymission/chilly/facility3
	name = "Base 3"
	icon_state = "base3"
	dynamic_lighting = DYNAMIC_LIGHTING_ENABLED
	requires_power = TRUE
	poweralm = FALSE

/area/awaymission/chilly/facility4
	name = "Base 4"
	icon_state = "base4"
	dynamic_lighting = DYNAMIC_LIGHTING_ENABLED
	requires_power = TRUE
	poweralm = FALSE

/area/awaymission/chilly/cave
	name = "Cavern"
	icon_state = "caverns"
	dynamic_lighting = DYNAMIC_LIGHTING_ENABLED
	requires_power = TRUE
	ambientsounds = SPOOKY
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	poweralm = FALSE


/* TURFS */

/turf/open/floor/plasteel/stairs/old/zalupa
	name = "stairs"
	icon = 'rebolution228/map_sprites.dmi'
	icon_state = "stairs"

/turf/open/floor/plasteel/stairs/old/zalupa_left
	name = "stairs"
	icon = 'rebolution228/map_sprites.dmi'
	icon_state = "stairs_left"

/turf/open/floor/plasteel/stairs/old/zalupa_med
	name = "stairs"
	icon = 'rebolution228/map_sprites.dmi'
	icon_state = "stairs_med"

/turf/open/floor/plasteel/stairs/old/zalupa_right
	name = "stairs"
	icon = 'rebolution228/map_sprites.dmi'
	icon_state = "stairs_right"




/* MISC */

/obj/effect/weather_effects
	name = "weather"
	icon = null
	icon_state = null
	density = 0
	anchored = 1
	mouse_opacity = 0
	layer = FLY_LAYER

/obj/effect/weather_effects/snow
	name = "snow"
	icon = 'rebolution228/map_sprites.dmi'
	icon_state = "snowflakes"
	mouse_opacity = 0

/obj/effect/turf_decal/weather/side
	name = "side"
	icon = 'rebolution228/map_sprites.dmi'
	icon_state = "side"
	mouse_opacity = 0

/obj/effect/turf_decal/weather/side/corner
	icon_state = "sidecorn"



/*
TODO:
1. Нижняя часть карты.
2. снежинки переработать нахуй
3. Рабочее электричество на базе I
5. Переработать мобов/их спавн в путепроводе
6. Добавить окружение вокруг базы.
7. В озеро добавить строение/домик
8. В затемненные части карты добавить освещение на turf (восток запад)
*/





























































































// ты хуй