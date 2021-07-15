/obj/machinery/power/generator
	name = "термоэлектрический генератор"
	desc = "Высокоэффективный термоэлектрический генератор."
	icon = 'white/valtos/icons/teg.dmi'
	icon_state = "teg-unassembled"
	density = TRUE
	use_power = NO_POWER_USE
	integrity_failure = 0.75

	var/obj/machinery/atmospherics/components/binary/circulator/cold_circ
	var/obj/machinery/atmospherics/components/binary/circulator/hot_circ

	var/lastgen = 0
	var/lastgenlev = -1

/obj/machinery/power/generator/Initialize(mapload)
	. = ..()
	find_circs()
	connect_to_network()
	SSair.atmos_machinery += src
	update_icon()
	component_parts = list(new /obj/item/circuitboard/machine/generator)

/obj/machinery/power/generator/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/simple_rotation,ROTATION_ALTCLICK | ROTATION_CLOCKWISE | ROTATION_COUNTERCLOCKWISE | ROTATION_VERBS )

/obj/machinery/power/generator/Destroy()
	kill_circs()
	SSair.atmos_machinery -= src
	return ..()

/obj/machinery/power/generator/update_icon()
	cut_overlays()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)

	if(machine_stat & (BROKEN))
		icon_state = "teg-broken"
		return
	if(hot_circ && cold_circ)
		icon_state = "teg-assembled"
	else
		icon_state = "teg-unassembled"
		if(panel_open)
			add_overlay("teg-panel")
		return

	if(machine_stat & (NOPOWER))
		return
	else
		var/L = min(round(lastgenlev/100000),11)
		if(L != 0)
			SSvis_overlays.add_vis_overlay(src, icon, "teg-op[L]", ABOVE_LIGHTING_LAYER, ABOVE_LIGHTING_PLANE, dir)

#define GENRATE 800		// generator output coefficient from Q

/obj/machinery/power/generator/process_atmos()

	if(!cold_circ || !hot_circ)
		return

	if(powernet)
		var/datum/gas_mixture/cold_air = cold_circ.return_transfer_air()
		var/datum/gas_mixture/hot_air = hot_circ.return_transfer_air()

		if(cold_air && hot_air)

			var/cold_air_heat_capacity = cold_air.heat_capacity()
			var/hot_air_heat_capacity = hot_air.heat_capacity()

			var/delta_temperature = hot_air.return_temperature() - cold_air.return_temperature()


			if(delta_temperature > 0 && cold_air_heat_capacity > 0 && hot_air_heat_capacity > 0)
				var/efficiency = 0.65

				var/energy_transfer = delta_temperature*hot_air_heat_capacity*cold_air_heat_capacity/(hot_air_heat_capacity+cold_air_heat_capacity)

				var/heat = energy_transfer*(1-efficiency)
				lastgen += energy_transfer*efficiency

				hot_air.set_temperature(hot_air.return_temperature() - energy_transfer/hot_air_heat_capacity)
				cold_air.set_temperature(cold_air.return_temperature() + heat/cold_air_heat_capacity)

				//add_avail(lastgen) This is done in process now
		// update icon overlays only if displayed level has changed

		if(hot_air)
			var/datum/gas_mixture/hot_circ_air1 = hot_circ.airs[1]
			hot_circ_air1.merge(hot_air)

		if(cold_air)
			var/datum/gas_mixture/cold_circ_air1 = cold_circ.airs[1]
			cold_circ_air1.merge(cold_air)

		update_icon()

	src.updateDialog()

/obj/machinery/power/generator/process()
	//Setting this number higher just makes the change in power output slower, it doesnt actualy reduce power output cause **math**
	var/power_output = round(lastgen / 10)
	add_avail(power_output/100)
	lastgenlev = power_output
	lastgen -= power_output
	..()

/obj/machinery/power/generator/proc/get_menu(include_link = TRUE)
	var/t = ""
	if(!powernet)
		t += "<span class='bad'>Нет соединения с энергосетью!</span>"
	else if(cold_circ && hot_circ)
		var/datum/gas_mixture/cold_circ_air1 = cold_circ.airs[1]
		var/datum/gas_mixture/cold_circ_air2 = cold_circ.airs[2]
		var/datum/gas_mixture/hot_circ_air1 = hot_circ.airs[1]
		var/datum/gas_mixture/hot_circ_air2 = hot_circ.airs[2]

		t += "<div class='statusDisplay'>"

		t += "Выход: [DisplayPower(lastgenlev/100)]"

		t += "<BR>"

		t += "<B><font color='blue'>Холодная петля</font></B><BR>"
		t += "Температура: [round(cold_circ_air2.return_temperature(), 0.1)] K / Выход: [round(cold_circ_air1.return_temperature(), 0.1)] K<BR>"
		t += "Давление: [round(cold_circ_air2.return_pressure(), 0.1)] кПа /  Выход: [round(cold_circ_air1.return_pressure(), 0.1)] кПа<BR>"

		t += "<B><font color='red'>Горячая петля</font></B><BR>"
		t += "Температура: [round(hot_circ_air2.return_temperature(), 0.1)] K / Выход: [round(hot_circ_air1.return_temperature(), 0.1)] K<BR>"
		t += "Давление: [round(hot_circ_air2.return_pressure(), 0.1)] кПа / Выход: [round(hot_circ_air1.return_pressure(), 0.1)] кПа<BR>"

		t += "</div>"
	else if(!hot_circ && cold_circ)
		t += "<span class='bad'>Не найден циркулятор!</span>"
	else if(hot_circ && !cold_circ)
		t += "<span class='bad'>Не найден холодный циркулятор!</span>"
	else
		t += "<span class='bad'>Не найдены части!</span>"
	if(include_link)
		t += "<BR><A href='?src=[REF(src)];close=1'>Закрыть</A>"

	return t

/obj/machinery/power/generator/ui_interact(mob/user)
	. = ..()
	var/datum/browser/popup = new(user, "teg", "Термо-Электрический Генератор", 460, 300)
	popup.set_content(get_menu())
	popup.open()

/obj/machinery/power/generator/Topic(href, href_list)
	if(..())
		return
	if( href_list["close"] )
		usr << browse(null, "window=teg")
		usr.unset_machine()
		return FALSE
	return TRUE

/obj/machinery/power/generator/proc/find_circs()
	kill_circs()
	var/list/circs = list()
	var/obj/machinery/atmospherics/components/binary/circulator/C
	var/circpath = /obj/machinery/atmospherics/components/binary/circulator
	if(dir == NORTH || dir == SOUTH)
		C = locate(circpath) in get_step(src, EAST)
		if(C && C.dir == WEST && C.anchored && !(C.machine_stat &(BROKEN)) && !C.panel_open)
			circs += C

		C = locate(circpath) in get_step(src, WEST)
		if(C && C.dir == EAST && C.anchored && !(C.machine_stat &(BROKEN)) && !C.panel_open)
			circs += C

	else
		C = locate(circpath) in get_step(src, NORTH)
		if(C && C.dir == SOUTH && C.anchored && !(C.machine_stat &(BROKEN)) && !C.panel_open)
			circs += C

		C = locate(circpath) in get_step(src, SOUTH)
		if(C && C.dir == NORTH && C.anchored && !(C.machine_stat &(BROKEN)) && !C.panel_open)
			circs += C

	if(circs.len == 2)
		for(C in circs)
			if(C.mode == CIRCULATOR_COLD && !cold_circ)
				cold_circ = C
				C.generator = src
			else if(C.mode == CIRCULATOR_HOT && !hot_circ)
				hot_circ = C
				C.generator = src
		if(!hot_circ || !cold_circ)
			kill_circs()
			return 3
	return circs.len

/obj/machinery/power/generator/wrench_act(mob/living/user, obj/item/I)
	if(user.a_intent == INTENT_HARM)
		return

	if(!panel_open) //connect/disconnect circulators
		if(!anchored)
			to_chat(user, "<span class='warning'>Нужно прикрутить [src] перед подключением циркуляторов!</span>")
			return TRUE
		else
			if(hot_circ && cold_circ)
				to_chat(user, "<span class='notice'>Начинаю отсоединять циркуляторы...</span>")
				if(I.use_tool(src, user, 30, volume=50))
					kill_circs()
					update_icon()
					to_chat(user, "<span class='notice'>Отсоединяю циркуляторы от [src].</span>")
					playsound(src, 'sound/misc/box_deploy.ogg', 50)
				return TRUE

			to_chat(user, "<span class='notice'>Пытаюсь присоединить циркуляторы...</span>")
			if(I.use_tool(src, user, 30, volume=50))
				switch(find_circs())
					if(0)
						to_chat(user, "<span class='warning'>Не обнаружено циркуляторов!</span>")
					if(1)
						to_chat(user, "<span class='warning'>Найден только один циркулятор!</span>")
					if(2)
						to_chat(user, "<span class='notice'>Присоединяю циркуляторы к [src].</span>")
						playsound(src, 'sound/misc/box_deploy.ogg', 50)
						return TRUE
					if(3)
						to_chat(user, "<span class='warning'>Оба циркулятора в одинаковом режиме!</span>")
				return TRUE

	anchored = !anchored
	I.play_tool_sound(src)
	if(!anchored)
		kill_circs()
	connect_to_network()
	to_chat(user, "<span class='notice'>[anchored?"Прикручиваю":"Откручиваю"] [src].</span>")
	update_icon()
	return TRUE

/obj/machinery/power/generator/screwdriver_act(mob/user, obj/item/I)
	if(..())
		return TRUE
	if(user.a_intent == INTENT_HARM)
		return

	if(hot_circ && cold_circ)
		to_chat(user, "<span class='warning'>Нужно отсоединить циркуляторы сначала!</span>")
		return TRUE
	panel_open = !panel_open
	I.play_tool_sound(src)
	to_chat(user, "<span class='notice'>[panel_open?"Открываю":"Закрываю"] панель [src].</span>")
	update_icon()
	return TRUE

/obj/machinery/power/generator/crowbar_act(mob/user, obj/item/I)
	if(user.a_intent == INTENT_HARM)
		return

	if(anchored)
		to_chat(user, "<span class='warning'>[capitalize(src.name)] прикручен!</span>")
		return TRUE
	else if(!panel_open)
		to_chat(user, "<span class='warning'>Стоит открыть панель сначала!</span>")
		return TRUE
	else
		default_deconstruction_crowbar(I)
		return TRUE

/obj/machinery/power/generator/on_deconstruction()
	kill_circs()

/obj/machinery/power/generator/proc/kill_circs()
	if(hot_circ)
		hot_circ.generator = null
		hot_circ.update_icon()
		hot_circ = null
	if(cold_circ)
		cold_circ.generator = null
		cold_circ.update_icon()
		cold_circ = null

/obj/machinery/power/generator/obj_break(damage_flag)
	kill_circs()
	..()
