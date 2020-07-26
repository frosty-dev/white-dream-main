/obj/machinery/power/bs_emitter
	name = "списанный военный блюспейс эмиттер"
	desc = "Остался еще от распила космосовка."
	icon = 'white/baldenysh/icons/obj/teleporter.dmi'
	icon_state = "teleporter"

	anchored = TRUE
	density = TRUE

	use_power = NO_POWER_USE
	idle_power_usage = 10
	active_power_usage = 15000
	var/cur_load = 0
	var/optimization_mod = 1

	var/active = FALSE

	var/turf/pointer = null
	var/list/active_tiles = list()

	var/expanding = FALSE
	var/expansion_time = 5
	var/max_range = 6

	var/target_x = 100
	var/target_y = 100
	var/target_z = 2

	var/icon_state_on = "teleporter_active"
	var/icon_state_underpowered = "teleporter_underpowered"
	var/icon_state_expanding = "teleporter_active"

/obj/machinery/power/bs_emitter/Initialize()
	. = ..()
	if(anchored)
		connect_to_network()

/obj/machinery/power/bs_emitter/Destroy()
	disconnect_from_network()
	start_collapse()
	return ..()

/obj/machinery/power/bs_emitter/examine(mob/user)
	. = ..()
	if(machine_stat & (BROKEN))
		. += "<span class='info'>Похоже, какая-то важная научная блюспейс штуковина была сломана. Данный агрегат теперь абсолютно бесполезен.</span>"

/obj/machinery/power/bs_emitter/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/simple_rotation, ROTATION_ALTCLICK | ROTATION_CLOCKWISE | ROTATION_COUNTERCLOCKWISE | ROTATION_VERBS, null, CALLBACK(src, .proc/can_be_rotated))

/obj/machinery/power/bs_emitter/proc/can_be_rotated(mob/user,rotation_type)
	if(anchored)
		to_chat(user, "<span class='warning'>Он прикручен к полу!</span>")
		return FALSE
	return TRUE

/obj/machinery/power/bs_emitter/can_be_unfasten_wrench(mob/user, silent)
	if(active)
		if(!silent)
			to_chat(user, "<span class='warning'>Надо бы выключить <b>[src]</b> сначала!</span>")
		return FAILED_UNFASTEN
	return ..()

/obj/machinery/power/bs_emitter/wrench_act(mob/living/user, obj/item/I)
	..()
	if(default_unfasten_wrench(user, I))
		if(anchored)
			connect_to_network()
		else
			disconnect_from_network()
	return TRUE

/obj/machinery/power/bs_emitter/should_have_node()
	return anchored

/obj/machinery/power/bs_emitter/update_icon_state()
	if(expanding)
		icon_state = icon_state_expanding
	if(active && powernet)
		icon_state = avail(cur_load*optimization_mod) ? icon_state_on : icon_state_underpowered
	else
		icon_state = initial(icon_state)

/obj/machinery/power/bs_emitter/process()
	if(machine_stat & (BROKEN))
		if(active)
			turn_off()
		return

	if(active)
		if(avail(cur_load*optimization_mod))
			add_load(cur_load*optimization_mod)
		else
			turn_off()
	else if(avail(idle_power_usage))
		add_load(idle_power_usage)

	update_icon()

////////////////////////////////////////////////////////////

/obj/machinery/power/bs_emitter/proc/get_pointer()
	if(!pointer)
		pointer_reset()
	return pointer

/obj/machinery/power/bs_emitter/proc/pointer_reset()
	pointer = get_step(src, dir)

/obj/machinery/power/bs_emitter/proc/pointer_step()

	var/turf/cur = get_step(get_pointer(), dir)

	if(!istype(cur, /turf/open))
		return FALSE
	if(get_dist_euclidian(src, cur) > max_range)
		return	FALSE
	pointer = cur
	return TRUE

/obj/machinery/power/bs_emitter/proc/start_collapse()
	for(var/turf/open/transparent/openspace/bluespace/BT in active_tiles)
		BT.start_collapse()

	active_tiles = list()

/obj/machinery/power/bs_emitter/proc/recursive_meksumportools()
	if(!active)
		turn_off()
		return FALSE

	var/currange = get_dist_euclidian(get_step(src, dir), get_pointer())
	var/list/radius = circleviewturfs(pointer, currange)

	for(var/turf/open/T in radius)
		if(T in active_tiles)
			continue
		var/turf/open/transparent/openspace/bluespace/BS
		if(istype(T, /turf/open/transparent/openspace/bluespace))
			BS = T
			BS.stop_collapse()
		else
			BS = T.PlaceOnTop(/turf/open/transparent/openspace/bluespace, flags = CHANGETURF_INHERIT_AIR)

		if(!BS)
			stop_exp()
			return

		if(istype(BS, /turf/open/transparent/openspace/bluespace))
			active_tiles += BS

		var/tx = target_x + BS.x - x
		var/ty = target_y + BS.y - y

		if(tx < 0 || ty < 0)
			BS.start_collapse()
			stop_exp()
			return

		BS.rift(locate(tx, ty, target_z))

	if(!pointer_step())
		stop_exp()
		return

	cur_load += active_power_usage*currange

	spawn(expansion_time)
		recursive_meksumportools()

/obj/machinery/power/bs_emitter/proc/start_exp()
	recursive_meksumportools()
	expanding = TRUE

/obj/machinery/power/bs_emitter/proc/stop_exp()
	expanding = FALSE

/obj/machinery/power/bs_emitter/proc/set_coords(cx,cy,cz)
	if(cx > 0 && cx < 257)
		target_x = cx
	if(cy > 0 && cy < 257)
		target_y = cy
	if(cz > 0 && cz < 257)
		target_z = cz

/obj/machinery/power/bs_emitter/proc/turn_on()
	if(!avail(50000))
		return
	pointer_reset()
	active = TRUE
	start_exp()

/obj/machinery/power/bs_emitter/proc/turn_off()
	if(expanding)
		stop_exp()
	start_collapse()
	cur_load = 0
	active = FALSE

/////////////////////////////////////////////////////////////////


