/datum/map_template/shuttle/atmosia
	name = "KSV Atmosia"
	prefix = "white/hule/prikol_atmos/"
	port_id = "ksv_atmosia"
	suffix = "b"

///////////////////////////////////////////////////////

/area/shuttle/atmosia
	name = "KSV Atmosia Bridge"
	ambientsounds = ENGINEERING
	requires_power = TRUE
	valid_territory = FALSE
	flags_1 = NONE

/area/shuttle/atmosia/atmos
	name = "KSV Atmosia Atmospherics"
	icon_state = "atmos"

/area/shuttle/atmosia/engine
	name = "KSV Atmosia Engine"
	icon_state = "atmos_engine"

//////////////////////////////////////////////////////

/obj/item/circuitboard/computer/atmosia
	name = "Atmosia Navigation (Computer Board)"
	icon_state = "generic"
	build_path = /obj/machinery/computer/camera_advanced/shuttle_docker/adv/atmosia

/obj/machinery/computer/camera_advanced/shuttle_docker/adv/atmosia
	name = "KSV Atmosia navigation computer"
	desc = "Used to designate a precise transit location for the ship."
	shuttleId = "ksv_atmosia"
	shuttlePortId = "ksv_atmosia_custom"
	shuttlePortName = "custom location"
	req_access = list(ACCESS_SYNDICATE)
	view_range = 20
	y_offset = -14
	z_lock = list(3,4,7,8,9,10,12)

/obj/machinery/computer/shuttle/atmosia
	name = "KSV Atmosia console"
	shuttleId = "ksv_atmosia"
	possible_destinations = "ksv_atmosia_custom;ksv_atmosia_home"

/obj/docking_port/mobile/atmosia
	name = "KSV Atmosia"
	id = "ksv_atmosia"
	dir = 2
	port_direction = 1
	width = 19
	dwidth = 9
	height = 28
	dheight = 1
	movement_force = list("KNOCKDOWN" = 0, "THROW" = 0)
	engine_coeff = 6
	rechargeTime = 10 MINUTES

/obj/docking_port/stationary/atmosia
	name = "KSV Atmosia Home"
	id = "ksv_atmosia_home"
	roundstart_template = /datum/map_template/shuttle/atmosia
	dir = 2
	width = 19
	dwidth = 9
	height = 28
	dheight = 1

/obj/docking_port/stationary/atmosia/hohlostan
	name = "KSV Atmosia Hohlostan"
	id = "ksv_atmosia_hohlostan"
	roundstart_template = null
	dir = 2
	width = 19
	dwidth = 9
	height = 28
	dheight = 1
