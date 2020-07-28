#define SOLAR_GEN_RATE 1500
#define OCCLUSION_DISTANCE 20

/obj/machinery/power/solar
	name = "Солнечная панель"
	desc = "Солнечная панель. Генерирует энергию при контакте со светом"
	icon = 'goon/icons/obj/power.dmi'
	icon_state = "sp_base"
	density = TRUE
	use_power = NO_POWER_USE
	idle_power_usage = 0
	active_power_usage = 0
	max_integrity = 150
	integrity_failure = 0.33

	var/id
	var/obscured = FALSE
	var/sunfrac = 0 //[0-1] measure of obscuration -- multipllier against power generation
	var/azimuth_current = 0 //[0-360) degrees, which direction are we facing?
	var/azimuth_target = 0 //same but what way we're going to face next time we turn
	var/obj/machinery/power/solar_control/control
	var/needs_to_turn = TRUE //do we need to turn next tick?
	var/needs_to_update_solar_exposure = TRUE //do we need to call update_solar_exposure() next tick?
	var/obj/effect/overlay/panel

/obj/machinery/power/solar/Initialize(mapload, obj/item/solar_assembly/S)
	. = ..()
	panel = new()
	panel.vis_flags = VIS_INHERIT_ID|VIS_INHERIT_ICON|VIS_INHERIT_PLANE
	vis_contents += panel
	panel.icon = icon
	panel.icon_state = "solar_panel"
	panel.layer = FLY_LAYER
	Make(S)
	connect_to_network()
	RegisterSignal(SSsun, COMSIG_SUN_MOVED, .proc/queue_update_solar_exposure)

/obj/machinery/power/solar/Destroy()
	unset_control() //remove from control computer
	return ..()

/obj/machinery/power/solar/should_have_node()
	return TRUE

//set the control of the panel to a given computer
/obj/machinery/power/solar/proc/set_control(obj/machinery/power/solar_control/SC)
	unset_control()
	control = SC
	SC.connected_panels += src
	queue_turn(SC.azimuth_target)

//set the control of the panel to null and removes it from the control list of the previous control computer if needed
/obj/machinery/power/solar/proc/unset_control()
	if(control)
		control.connected_panels -= src
		control = null

/obj/machinery/power/solar/proc/Make(obj/item/solar_assembly/S)
	if(!S)
		S = new /obj/item/solar_assembly(src)
		S.glass_type = /obj/item/stack/sheet/glass
		S.set_anchored(TRUE)
	else
		S.forceMove(src)
	if(S.glass_type == /obj/item/stack/sheet/rglass) //if the panel is in reinforced glass
		max_integrity *= 2 								 //this need to be placed here, because panels already on the map don't have an assembly linked to
		obj_integrity = max_integrity

/obj/machinery/power/solar/crowbar_act(mob/user, obj/item/I)
	playsound(src.loc, 'sound/machines/click.ogg', 50, TRUE)
	user.visible_message("<span class='notice'>[user] начинает снимать стекло с [src].</span>", "<span class='notice'>Вы начинаете снимать стекло с [src]...</span>")
	if(I.use_tool(src, user, 50))
		playsound(src.loc, 'sound/items/deconstruct.ogg', 50, TRUE)
		user.visible_message("<span class='notice'>[user] снимает стекло с [src].</span>", "<span class='notice'>Вы снимаете стекло с [src].</span>")
		deconstruct(TRUE)
	return TRUE

/obj/machinery/power/solar/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(machine_stat & BROKEN)
				playsound(loc, 'sound/effects/hit_on_shattered_glass.ogg', 60, TRUE)
			else
				playsound(loc, 'sound/effects/glasshit.ogg', 90, TRUE)
		if(BURN)
			playsound(loc, 'sound/items/welder.ogg', 100, TRUE)


/obj/machinery/power/solar/obj_break(damage_flag)
	. = ..()
	if(.)
		playsound(loc, 'sound/effects/glassbr3.ogg', 100, TRUE)
		unset_control()

/obj/machinery/power/solar/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(disassembled)
			var/obj/item/solar_assembly/S = locate() in src
			if(S)
				S.forceMove(loc)
				S.give_glass(machine_stat & BROKEN)
		else
			playsound(src, "shatter", 70, TRUE)
			new /obj/item/shard(src.loc)
			new /obj/item/shard(src.loc)
	qdel(src)

/obj/machinery/power/solar/update_overlays()
	. = ..()
	var/matrix/turner = matrix()
	turner.Turn(azimuth_current)
	panel.transform = turner
	if(machine_stat & BROKEN)
		panel.icon_state = "solar_panel-b"
	else
		panel.icon_state = "solar_panel"

/obj/machinery/power/solar/proc/queue_turn(azimuth)
	needs_to_turn = TRUE
	azimuth_target = azimuth

/obj/machinery/power/solar/proc/queue_update_solar_exposure()
	needs_to_update_solar_exposure = TRUE //updating right away would be wasteful if we're also turning later

/obj/machinery/power/solar/proc/update_turn()
	needs_to_turn = FALSE
	if(azimuth_current != azimuth_target)
		azimuth_current = azimuth_target
		occlusion_setup()
		update_icon()
		needs_to_update_solar_exposure = TRUE

///trace towards sun to see if we're in shadow
/obj/machinery/power/solar/proc/occlusion_setup()
	obscured = TRUE

	var/distance = OCCLUSION_DISTANCE
	var/target_x = round(sin(SSsun.azimuth), 0.01)
	var/target_y = round(cos(SSsun.azimuth), 0.01)
	var/x_hit = x
	var/y_hit = y
	var/turf/hit

	for(var/run in 1 to distance)
		x_hit += target_x
		y_hit += target_y
		hit = locate(round(x_hit, 1), round(y_hit, 1), z)
		if(hit.opacity)
			return
		if(hit.x == 1 || hit.x == world.maxx || hit.y == 1 || hit.y == world.maxy) //edge of the map
			break
	obscured = FALSE

///calculates the fraction of the sunlight that the panel receives
/obj/machinery/power/solar/proc/update_solar_exposure()
	needs_to_update_solar_exposure = FALSE
	sunfrac = 0
	if(obscured)
		return 0

	var/sun_azimuth = SSsun.azimuth
	if(azimuth_current == sun_azimuth) //just a quick optimization for the most frequent case
		. = 1
	else
		//dot product of sun and panel -- Lambert's Cosine Law
		. = cos(azimuth_current - sun_azimuth)
		. = clamp(round(., 0.01), 0, 1)
	sunfrac = .

/obj/machinery/power/solar/process()
	if(machine_stat & BROKEN)
		return
	if(control && (!powernet || control.powernet != powernet))
		unset_control()
	if(needs_to_turn)
		update_turn()
	if(needs_to_update_solar_exposure)
		update_solar_exposure()
	if(sunfrac <= 0)
		return

	var/sgen = SOLAR_GEN_RATE * sunfrac
	add_avail(sgen)
	if(control)
		control.gen += sgen

//Bit of a hack but this whole type is a hack
/obj/machinery/power/solar/fake/Initialize(turf/loc, obj/item/solar_assembly/S)
	. = ..()
	UnregisterSignal(SSsun, COMSIG_SUN_MOVED)

/obj/machinery/power/solar/fake/process()
	return PROCESS_KILL

//
// Solar Assembly - For construction of solar arrays.
//

/obj/item/solar_assembly
	name = "Основание солнечной панели"
	desc = "Основание солнечной панели, даёт возможность создания солнечной панели, или с помощью платы отслеживания a солнечный отслеживатель." // отслеживатель? Как по мне круче трекер, но кого это интересует...
	icon = 'goon/icons/obj/power.dmi'
	icon_state = "sp_base"
	inhand_icon_state = "electropack"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY // Pretty big!
	anchored = FALSE
	var/tracker = 0
	var/glass_type = null
	var/random_offset = 6 //amount in pixels an unanchored assembly may be offset by

/obj/item/solar_assembly/Initialize(mapload)
	. = ..()
	if(!anchored && !pixel_x && !pixel_y)
		randomise_offset(random_offset)

/obj/item/solar_assembly/proc/randomise_offset(amount)
	pixel_x = rand(-amount,amount)
	pixel_y = rand(-amount,amount)

// Give back the glass type we were supplied with
/obj/item/solar_assembly/proc/give_glass(device_broken)
	var/atom/Tsec = drop_location()[1]
	if(device_broken)
		new /obj/item/shard(Tsec)
		new /obj/item/shard(Tsec)
	else if(glass_type)
		new glass_type(Tsec, 2)
	glass_type = null

/obj/item/solar_assembly/set_anchored(anchorvalue)
	. = ..()
	if(isnull(.))
		return
	randomise_offset(anchored ? 0 : random_offset)

/obj/item/solar_assembly/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_WRENCH && isturf(loc))
		if(isinspace())
			to_chat(user, "<span class='warning'>Вы не можете прикрутить [src] тут.</span>")
			return
		set_anchored(!anchored)
		user.visible_message("<span class='notice'>[user] [anchored ? "при" : "от"]кручивает основание солнечной панели.</span>", "<span class='notice'>[anchored ? "При" : "от"]кручиваю основание солнечной панели.</span>")
		W.play_tool_sound(src, 75)
		return TRUE

	if(istype(W, /obj/item/stack/sheet/glass) || istype(W, /obj/item/stack/sheet/rglass))
		if(!anchored)
			to_chat(user, "<span class='warning'>Вы должны прикрутить основание прежде чем добавлять туда стекло.</span>")
			return
		var/obj/item/stack/sheet/S = W
		if(S.use(2))
			glass_type = W.type
			playsound(src.loc, 'sound/machines/click.ogg', 50, TRUE)
			user.visible_message("<span class='notice'>[user] вставляет стекло в основание солнечной панели.</span>", "<span class='notice'>Вы вставляете стекло в основание солнейчной панели.</span>")
			if(tracker)
				new /obj/machinery/power/tracker(get_turf(src), src)
			else
				new /obj/machinery/power/solar(get_turf(src), src)
		else
			to_chat(user, "<span class='warning'>Вы должны иметь два листа стекла прежде чем вставлять их в основание!</span>")
			return
		return TRUE

	if(!tracker)
		if(istype(W, /obj/item/electronics/tracker))
			if(!user.temporarilyRemoveItemFromInventory(W))
				return
			tracker = TRUE
			qdel(W)
			user.visible_message("<span class='notice'>[user] вставляет электронику в основание солнечной панели.</span>", "<span class='notice'>Вставляю электронику в основание солнечной панели.</span>")
			return TRUE
	else
		if(W.tool_behaviour == TOOL_CROWBAR)
			new /obj/item/electronics/tracker(src.loc)
			tracker = FALSE
			user.visible_message("<span class='notice'>[user] вынимает электронику из основания солнечной панели.</span>", "<span class='notice'>Вынимаю электронику из основания солнечной панели.</span>")
			return TRUE
	return ..()

//
// Solar Control Computer
//

/obj/machinery/power/solar_control
	name = "Консоль управления солнечными панелями"
	desc = "Консоль управления солнечными панелями."
	icon = 'icons/obj/computer.dmi'
	icon_state = "computer"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 250
	max_integrity = 200
	integrity_failure = 0.5
	var/icon_screen = "solar"
	var/icon_keyboard = "power_key"
	var/id = 0
	var/gen = 0
	var/lastgen = 0
	var/azimuth_target = 0
	var/azimuth_rate = 1 ///degree change per minute

	var/track = SOLAR_TRACK_OFF ///SOLAR_TRACK_OFF, SOLAR_TRACK_TIMED, SOLAR_TRACK_AUTO

	var/obj/machinery/power/tracker/connected_tracker = null
	var/list/connected_panels = list()

/obj/machinery/power/solar_control/Initialize()
	. = ..()
	azimuth_rate = SSsun.base_rotation
	RegisterSignal(SSsun, COMSIG_SUN_MOVED, .proc/timed_track)
	connect_to_network()
	if(powernet)
		set_panels(azimuth_target)

/obj/machinery/power/solar_control/Destroy()
	for(var/obj/machinery/power/solar/M in connected_panels)
		M.unset_control()
	if(connected_tracker)
		connected_tracker.unset_control()
	return ..()

//search for unconnected panels and trackers in the computer powernet and connect them
/obj/machinery/power/solar_control/proc/search_for_connected()
	if(powernet)
		for(var/obj/machinery/power/M in powernet.nodes)
			if(istype(M, /obj/machinery/power/solar))
				var/obj/machinery/power/solar/S = M
				if(!S.control) //i.e unconnected
					S.set_control(src)
			else if(istype(M, /obj/machinery/power/tracker))
				if(!connected_tracker) //if there's already a tracker connected to the computer don't add another
					var/obj/machinery/power/tracker/T = M
					if(!T.control) //i.e unconnected
						T.set_control(src)

/obj/machinery/power/solar_control/update_overlays()
	. = ..()
	if(machine_stat & NOPOWER)
		. += mutable_appearance(icon, "[icon_keyboard]_off")
		return
	. += mutable_appearance(icon, icon_keyboard)
	if(machine_stat & BROKEN)
		. += mutable_appearance(icon, "[icon_state]_broken")
	else
		. += mutable_appearance(icon, icon_screen)

/obj/machinery/power/solar_control/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SolarControl", name)
		ui.open()

/obj/machinery/power/solar_control/ui_data()
	var/data = list()
	data["generated"] = round(lastgen)
	data["generated_ratio"] = data["generated"] / round(max(connected_panels.len, 1) * SOLAR_GEN_RATE)
	data["azimuth_current"] = azimuth_target
	data["azimuth_rate"] = azimuth_rate
	data["max_rotation_rate"] = SSsun.base_rotation * 2
	data["tracking_state"] = track
	data["connected_panels"] = connected_panels.len
	data["connected_tracker"] = (connected_tracker ? TRUE : FALSE)
	return data

/obj/machinery/power/solar_control/ui_act(action, params)
	if(..())
		return
	if(action == "azimuth")
		var/adjust = text2num(params["adjust"])
		var/value = text2num(params["value"])
		if(adjust)
			value = azimuth_target + adjust
		if(value != null)
			set_panels(value)
			return TRUE
		return FALSE
	if(action == "azimuth_rate")
		var/adjust = text2num(params["adjust"])
		var/value = text2num(params["value"])
		if(adjust)
			value = azimuth_rate + adjust
		if(value != null)
			azimuth_rate = round(clamp(value, -2 * SSsun.base_rotation, 2 * SSsun.base_rotation), 0.01)
			return TRUE
		return FALSE
	if(action == "tracking")
		var/mode = text2num(params["mode"])
		track = mode
		if(mode == SOLAR_TRACK_AUTO)
			if(connected_tracker)
				connected_tracker.sun_update(SSsun, SSsun.azimuth)
			else
				track = SOLAR_TRACK_OFF
		return TRUE
	if(action == "refresh")
		search_for_connected()
		return TRUE
	return FALSE

/obj/machinery/power/solar_control/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_SCREWDRIVER)
		if(I.use_tool(src, user, 20, volume=50))
			if (src.machine_stat & BROKEN)
				to_chat(user, "<span class='notice'>Сломанное стекло выпадает.</span>")
				var/obj/structure/frame/computer/A = new /obj/structure/frame/computer( src.loc )
				new /obj/item/shard( src.loc )
				var/obj/item/circuitboard/computer/solar_control/M = new /obj/item/circuitboard/computer/solar_control( A )
				for (var/obj/C in src)
					C.forceMove(drop_location())
				A.circuit = M
				A.state = 3
				A.icon_state = "3"
				A.set_anchored(TRUE)
				qdel(src)
			else
				to_chat(user, "<span class='notice'>Вы отсоединяете монитор.</span>")
				var/obj/structure/frame/computer/A = new /obj/structure/frame/computer( src.loc )
				var/obj/item/circuitboard/computer/solar_control/M = new /obj/item/circuitboard/computer/solar_control( A )
				for (var/obj/C in src)
					C.forceMove(drop_location())
				A.circuit = M
				A.state = 4
				A.icon_state = "4"
				A.set_anchored(TRUE)
				qdel(src)
	else if(user.a_intent != INTENT_HARM && !(I.item_flags & NOBLUDGEON))
		attack_hand(user)
	else
		return ..()

/obj/machinery/power/solar_control/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(machine_stat & BROKEN)
				playsound(src.loc, 'sound/effects/hit_on_shattered_glass.ogg', 70, TRUE)
			else
				playsound(src.loc, 'sound/effects/glasshit.ogg', 75, TRUE)
		if(BURN)
			playsound(src.loc, 'sound/items/welder.ogg', 100, TRUE)

/obj/machinery/power/solar_control/obj_break(damage_flag)
	. = ..()
	if(.)
		playsound(loc, 'sound/effects/glassbr3.ogg', 100, TRUE)

/obj/machinery/power/solar_control/process()
	lastgen = gen
	gen = 0

	if(connected_tracker && (!powernet || connected_tracker.powernet != powernet))
		connected_tracker.unset_control()

///Ran every time the sun updates.
/obj/machinery/power/solar_control/proc/timed_track()
	if(track == SOLAR_TRACK_TIMED)
		azimuth_target += azimuth_rate
		set_panels(azimuth_target)

///Rotates the panel to the passed angles
/obj/machinery/power/solar_control/proc/set_panels(azimuth)
	azimuth = clamp(round(azimuth, 0.01), -360, 719.99)
	if(azimuth >= 360)
		azimuth -= 360
	if(azimuth < 0)
		azimuth += 360
	azimuth_target = azimuth

	for(var/obj/machinery/power/solar/S in connected_panels)
		S.queue_turn(azimuth)

//
// MISC
//

/obj/item/paper/guides/jobs/engi/solars
	name = "paper- 'Создания солнечных панелей'"
	info = "<h1> Добро пожаловать </ h1> <p> В Зелёных Корпорациях мы любим окружающую среду и пространство. С помощью этого ящика вы можете помочь матери-природе и производить энергию без использования ископаемого топлива или плазмы! Энергия сингулярности опасна, а солнечная энергия безопасна, поэтому она лучше. Теперь вот как вы настраиваете свою собственную солнечную батарею. </ P> <p> Вы можете сделать солнечную панель, прикрутив солнечную батарею к кабельному узлу. Добавление стеклянной панели, армированного или обычного стекла завершит строительство вашей солнечной панели. Это так просто! </ P> <p> Теперь, после установки еще 19 таких солнечных панелей, вы захотите создать солнечный остлеживатель для отслеживания дара нашей матери-природы - солнца. Это те же шаги, что и ранее, за исключением того, что вы вставляете схему оборудования трекера в сборку перед выполнением последнего шага добавления стекла. Теперь у вас есть Остлеживатель! Теперь последний шаг - добавить компьютер для расчета движений солнца и посылать команды на солнечные панели для изменения направления движения с солнцем. Настройка солнечного компьютера аналогична настройке любого компьютера, поэтому у вас не должно возникнуть никаких проблем. Вам необходимо поместить проводной узел под компьютер, а провод должен быть подключен к трекеру. </ P> <p> Поздравляем, у вас должна быть работающая солнечная батарея. Если у вас возникли проблемы, вот несколько советов. Убедитесь, что все солнечное оборудование находится на кабельном узле, даже компьютер. Вы всегда можете деконструировать свои творения, если допустите ошибку. </ P> <p> Вот и все, будьте в безопасности, будьте зелеными! </ P> "

#undef SOLAR_GEN_RATE
#undef OCCLUSION_DISTANCE
