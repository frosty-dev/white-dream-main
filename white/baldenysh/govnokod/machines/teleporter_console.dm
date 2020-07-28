/obj/machinery/computer/bs_emitter
	name = "прикольная консоль телепортера"
	desc = "Необходима для телепортации всяких штук."
	icon_screen = "teleport"
	icon_keyboard = "teleport_key"
	//circuit = /obj/item/circuitboard/computer/turbine_computer
	var/obj/machinery/power/bs_emitter/BSE

/obj/machinery/computer/bs_emitter/Initialize()
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/computer/bs_emitter/LateInitialize()
	locate_machinery()

/obj/machinery/computer/bs_emitter/locate_machinery()
		BSE = locate(/obj/machinery/power/bs_emitter) in range(7, src)

/obj/machinery/computer/bs_emitter/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BSEmitter", name)
		ui.open()

/obj/machinery/computer/bs_emitter/ui_data(mob/user)
	var/list/data = list()

	data["connected"] = BSE ? TRUE : FALSE

	if(BSE)
		data["active"] = BSE.active
		data["expanding"] = BSE.expanding
		data["powernet"] = BSE.powernet ? TRUE : FALSE
		data["surplusKW"] = BSE.surplus()/1000
		data["loadKW"] = BSE.cur_load/1000

		data["radius"] = BSE.max_range
		data["t_x"] = BSE.target_x
		data["t_y"] = BSE.target_y
		data["t_z"] = BSE.target_z

	return data

/obj/machinery/computer/bs_emitter/ui_act(action, params)
	if(..())
		return
	. = TRUE
	switch(action)
		if("toggle")
			if(BSE)
				if(BSE.active)
					BSE.turn_off()
				else
					BSE.turn_on()

		if("reconnect")
			locate_machinery()

		if("setCoords")
			var/tx = text2num(params["newx"])
			var/ty = text2num(params["newy"])
			var/tz = text2num(params["newz"])
			if(BSE)
				if(BSE.expanding)
					return
				BSE.set_coords(tx, ty, tz)

		if("setRadius")
			var/radius = text2num(params["radius"])
			if(BSE)
				if(BSE.expanding)
					return
				BSE.max_range = radius


