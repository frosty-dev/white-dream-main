///////////////////////////////////////////////

/area/boxplanet
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	flora_allowed = TRUE
	blob_allowed = FALSE

/area/boxplanet/surface
	name = "Поверхность"
	outdoors = TRUE
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	icon_state = "explored"
	always_unpowered = TRUE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambientsounds = MINING

/area/boxplanet/underground
	name = "Пещеры"
	outdoors = TRUE
	always_unpowered = TRUE
	requires_power = TRUE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	ambientsounds = MINING
	mob_spawn_allowed = FALSE
	megafauna_spawn_allowed = FALSE

/area/boxplanet/underground/unexplored
	icon_state = "unexplored"
	tunnel_allowed = TRUE

/area/boxplanet/underground/explored
	name = "Подземелье"
	flora_allowed = FALSE

///////////////////////////////////////////////

/obj/structure/flora/tree/boxplanet
	name = "что-то"
	desc = "АААААААААААААААААААААААААААА"
	icon = 'code/shitcode/valtos/icons/mineflora.dmi'
	icon_state = null
	pixel_x = 0

/obj/structure/flora/tree/boxplanet/kartoshmel
	name = "картошмель"
	desc = "Удивительное растение, которое... Будем честны - какая-то непонятная херобора торчащая из земли и убивающая своим присутствием всех вокруг."
	icon_state = "kartoshmel"
	var/mob_type
	var/spawned_mobs = 0
	var/max_spawn = 3
	var/cooldown = 0

/obj/structure/flora/tree/boxplanet/kartoshmel/Initialize()
	mob_type = rand(1, 5)
	. = ..()

/obj/structure/flora/tree/boxplanet/kartoshmel/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/flora/tree/boxplanet/kartoshmel/process()
	if(cooldown < world.time - 480)
		cooldown = world.time
		if(max_spawn > spawned_mobs)
			spawned_mobs++
			var/turf/T = get_turf(src)
			switch(mob_type)
				if(1)
					new /mob/living/simple_animal/hostile/skeleton/vanya(T)
				if(2)
					new /mob/living/simple_animal/hostile/vanya/killermeat(T)
				if(3)
					new /mob/living/simple_animal/hostile/vanya/leech(T)
				if(4)
					new /mob/living/simple_animal/hostile/faithless/vanya/chort(T)
				if(5)
					new /mob/living/simple_animal/hostile/faithless/vanya/drown(T)
		else
			STOP_PROCESSING(SSobj, src)

/obj/structure/flora/tree/boxplanet/glikodil
	name = "гликодил"
	desc = "Целебный куст."
	icon_state = "glikodil"
	var/has_cure = TRUE

/obj/structure/flora/tree/boxplanet/glikodil/attack_hand(mob/user)
	. = ..()
	if(has_cure)
		has_cure = FALSE
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.adjustBruteLoss(-25)
			H.adjustFireLoss(-25)
			H.remove_CC()
			H.bodytemperature = H.get_body_temp_normal()
			visible_message("<span class='notice'>[H] прикасается рукой к растению и его раны начинают затягиваться.</span>")
		else
			visible_message("<span class='warning'>Похоже, что эта штука помогает только людям, но не животным. <b>[capitalize(user)]</b> поедает гликодил.</span>")
			qdel(src)
		spawn(rand(600, 3600))
			has_cure = TRUE
	else
		to_chat(user, "<span class='notice'>Не могу найти лечебных листочков на этом растении. Видимо ещё не время.</span>")

/obj/structure/flora/tree/boxplanet/svetosvin
	name = "светосвин"
	desc = "Эта штука светится. Надеешься, что это растение не радиоактивное."
	icon_state = "svetosvin"
	light_color = "#00aaff"
	light_power = 1
	light_range = 5
	var/cooldown = 0

/obj/structure/flora/tree/boxplanet/svetosvin/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/flora/tree/boxplanet/svetosvin/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/flora/tree/boxplanet/svetosvin/process()
	if(cooldown < world.time - 60)
		cooldown = world.time
		radiation_pulse(src, 25, 2)

/obj/effect/flora_spawner
	invisibility = SEE_INVISIBLE_OBSERVER
	icon = 'code/shitcode/valtos/icons/mineflora.dmi'
	icon_state = "kartoshmel"
	maptext = "GENERATOR"
	var/generating_type = /obj/structure/flora/tree/boxplanet/kartoshmel
	var/planted_things = 0
	var/cooldown = 0

/obj/effect/flora_spawner/process()
	if(cooldown < world.time - 120)
		cooldown = world.time
		if(prob(100 - (planted_things * 10)))
			var/list/possible_turfs = list()
			for(var/turf/T in RANGE_TURFS(7, src))
				if(istype(T, /turf/open/floor/plating/asteroid/boxplanet/caves))
					possible_turfs += T
			new generating_type(pick(possible_turfs))
			planted_things++
			return
	if(planted_things >= 10)
		STOP_PROCESSING(SSobj, src)
		qdel(src)

/obj/effect/flora_spawner/Initialize()
	. = ..()
	generating_type = pick(/obj/structure/flora/tree/boxplanet/kartoshmel, /obj/structure/flora/tree/boxplanet/glikodil, /obj/structure/flora/tree/boxplanet/svetosvin)
	START_PROCESSING(SSobj, src)

/obj/effect/flora_spawner/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/effect/step_trigger/ambush
	mobs_only = TRUE
	var/amb_chance = 90

/obj/effect/step_trigger/ambush/Trigger(atom/A)
	if(!ishuman(A))
		return
	if(prob(amb_chance))
		amb_chance = 0
		var/msg = pick("ЗАСАДА!", "ЗДЕСЬ КТО-ТО ЕСТЬ!", "МОНСТРЫ!")
		var/turf/T = get_turf(A)
		T.visible_message("<span class='userdanger'>[msg]</span>")
		playsound(A.loc, 'code/shitcode/valtos/sounds/ambush.ogg', 50)
		for(var/obj/structure/flora/tree/boxplanet/kartoshmel/K in orange(7, src))
			K.spawned_mobs = 0
			START_PROCESSING(SSobj, K)
	else
		amb_chance += 10

///////////////////////////////////////////////

/turf/open/floor/plating/asteroid/boxplanet/caves
	name = "затвердевшая грязь"
	desc = "Неприятная."
	icon_state = "caves1"
	baseturfs = /turf/open/openspace/boxplanet/caves
	icon = 'code/shitcode/valtos/icons/caves_floor.dmi'
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	dug = TRUE

/turf/open/floor/plating/asteroid/boxplanet/caves/Initialize()
	. = ..()
	icon_state = "caves[rand(1,6)]"

/turf/open/floor/plating/asteroid/boxplanet/can_dig(mob/user)
	if(!dug)
		return TRUE
	else if(user)
		var/turf/T = below()
		var/dir_to_dig = get_dir(src, user.loc)

		if(do_after(user, 60, target = src))
			var/area/A = get_area(T)
			if(!istype(A, /area/boxplanet))
				ChangeTurf(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR)
				to_chat(user, "<span class='danger'><b>[capitalize(src)]</b> уже достаточно раскопан!</span>")
			if(istype(T, /turf/closed/mineral))
				ChangeTurf(/turf/open/openspace/boxplanet/caves, flags = CHANGETURF_INHERIT_AIR)
				T.ChangeTurf(/turf/open/floor/plating/asteroid/boxplanet/caves, flags = CHANGETURF_INHERIT_AIR)
				var/obj/L = new /obj/structure/stairs(T)
				L.dir = dir_to_dig
			if(istype(T, /turf/open))
				ChangeTurf(/turf/open/openspace/boxplanet/caves, flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/plating/asteroid/boxplanet/surface
	name = "снег"
	desc = "Выглядит холодным."
	icon = 'icons/turf/snow.dmi'
	baseturfs = /turf/open/openspace/boxplanet/surface
	icon_state = "snow"
	icon_plating = "snow"
	initial_gas_mix = FROZEN_ATMOS
	slowdown = 2
	environment_type = "snow"
	flags_1 = NONE
	planetary_atmos = TRUE
	broken_states = list("snow_dug")
	burnt_states = list("snow_dug")
	bullet_sizzle = TRUE
	bullet_bounce_sound = null
	digResult = /obj/item/stack/sheet/mineral/snow

/turf/open/floor/plating/asteroid/boxplanet/surface/burn_tile()
	if(!burnt)
		visible_message("<span class='danger'>[src] тает!.</span>")
		slowdown = 0
		burnt = TRUE
		icon_state = "snow_dug"
		return TRUE
	return FALSE

/turf/open/floor/plating/asteroid/airless/cave/boxplanet
	name = "затвердевшая грязь"
	desc = "Неприятная."
	icon = 'code/shitcode/valtos/icons/caves_floor.dmi'
	baseturfs = /turf/open/floor/plating/asteroid/boxplanet/caves
	icon_state = "caves1"
	icon_plating = "caves1"
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	slowdown = 0
	flags_1 = NONE
	planetary_atmos = TRUE
	burnt_states = list("snow_dug")
	bullet_sizzle = TRUE
	bullet_bounce_sound = null
	digResult = /obj/item/stack/sheet/mineral/snow
	mob_spawn_list = list(/mob/living/simple_animal/hostile/asteroid/wolf = 1)
	flora_spawn_list = list(/obj/structure/flora/tree/boxplanet/kartoshmel = 2, /obj/structure/flora/tree/boxplanet/glikodil = 2, /obj/structure/flora/tree/boxplanet/svetosvin = 2)
	terrain_spawn_list = list(/obj/effect/step_trigger/ambush = 2, /obj/effect/flora_spawner = 1)
	data_having_type = /turf/open/floor/plating/asteroid/airless/cave/boxplanet/has_data
	turf_type = /turf/open/floor/plating/asteroid/boxplanet/caves

/turf/open/floor/plating/asteroid/airless/cave/boxplanet/has_data //subtype for producing a tunnel with given data
	has_data = TRUE

/turf/open/floor/plating/asteroid/airless/cave/boxplanet/make_tunnel(dir, pick_tunnel_width)
	pick_tunnel_width = list("1" = 4, "2" = 5, "3" = 3, "4" = 3, "5" = 2)
	..()

/turf/open/floor/plating/asteroid/boxplanet/ex_act(severity, target, prikolist)
	..()
	if(severity == 1)
		var/turf/T = below()
		T.ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

///////////////////////////////////////////////

/turf/open/openspace/boxplanet
	name = "открытое пространство"
	baseturfs = /turf/open/openspace/boxplanet

/turf/open/openspace/boxplanet/surface
	initial_gas_mix = FROZEN_ATMOS

/turf/open/openspace/boxplanet/caves
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

///////////////////////////////////////////////

/obj/machinery/power_restarter
	name = "большой ржавый рубильник"
	desc = "Если приглядеться, то за толстым слоем ржавчины и крови можно разглядеть надпись \"ПЕРЕЗАГРУЗКА ЭНЕРГОСЕТИ\". К чему бы это?"
	icon = 'code/shitcode/valtos/icons/switch.dmi'
	icon_state = "switch-off"
	var/is_turned = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/power_restarter/attackby(obj/item/W, mob/user, params)
	electrocute_mob(user, get_area(src), src, 1.7, TRUE)
	return

/obj/machinery/power_restarter/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	add_fingerprint(user)
	if(is_turned)
		to_chat(user, "<span class='danger'>Рубильник не поддаётся!</span>")
		return
	user.visible_message("<span class='warning'><b>[user]</b> дёргает рубильник!</span>")
	is_turned = TRUE
	icon_state = "switch-on"
	SSmachines.makepowernets()
	log_admin("[key_name(user)] has remade the powernet. Рубильник called.")
	message_admins("[key_name_admin(user)] has remade the powernets. Рубильник called.")
	use_power(5)
	playsound(src.loc, 'code/shitcode/valtos/sounds/leveron.ogg', 50, TRUE)
	spawn(3000)
		icon_state = "switch-off"
		is_turned = FALSE
		playsound(src.loc, 'code/shitcode/valtos/sounds/leveroff.ogg', 90, TRUE)
		var/turf/T = get_turf(src)
		T.visible_message("<span class='notice'><b>[src]</b> возвращается на место!</span>")
