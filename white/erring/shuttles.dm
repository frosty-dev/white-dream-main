/obj/machinery/computer/camera_advanced/shuttle_docker/adv/corvette
	name = "SBC corvette navigation console"
	desc = "Used to designate a precise transit location for the SBC corvette."
	shuttleId = "corvette"
	shuttlePortId = "corvette_custom"
	jumpto_ports = list()
	//view_range = 20
	x_offset = 15
	y_offset = 0

/obj/machinery/computer/shuttle/corvette
	name = "SBC corvette console"
	shuttleId = "corvette"
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	light_color = LIGHT_COLOR_RED
	possible_destinations = "corvette_home;corvette_custom"


/obj/docking_port/mobile/corvette
	name = "SBC corvette"
	id = "corvette"
	dir = 4
	port_direction = 2
	width = 13
	height = 24
	dwidth = 6
	dheight = 23

/obj/docking_port/stationary/corvette
	name = "SBC corvette home"
	id = "corvette_home"
	dir = 4
	width = 13
	height = 24
	dwidth = 6
	dheight = 23
