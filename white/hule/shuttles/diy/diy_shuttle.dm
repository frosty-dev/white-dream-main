GLOBAL_VAR_INIT(diy_shuttle_count, 0)

/area/shuttle/diy
	name = "Do-It-Yourself shuttle"
	requires_power = TRUE
	valid_territory = FALSE

//////////////////////////////////////////////////

/obj/machinery/computer/camera_advanced/shuttle_docker/adv/diy
	name = "Do-It-Yourself shuttle navigation console"
	desc = "Used to designate a precise transit location."
	shuttleId = "diy_autism"
	shuttlePortId = "diy_autism_custom"
	jumpto_ports = list()
	dir = 2
	x_offset = 0
	y_offset = 0
	z_lock = list(2,3,4,7,8,9,10,12)

/obj/machinery/computer/camera_advanced/shuttle_docker/adv/diy/Initialize()
	shuttleId += "[GLOB.diy_shuttle_count]"
	shuttlePortId = "diy_autism[GLOB.diy_shuttle_count]_custom"
	. = ..()

/obj/machinery/computer/shuttle/diy
	name = "Do-It-Yourself shuttle movement console"
	shuttleId = "diy_autism"
	possible_destinations = ""
	dir = 2

/obj/machinery/computer/shuttle/diy/Initialize()
	shuttleId += "[GLOB.diy_shuttle_count]"
	possible_destinations += "diy_autism[GLOB.diy_shuttle_count]_home;"
	possible_destinations += "diy_autism[GLOB.diy_shuttle_count]_custom"
	. = ..()

//////////////////////////////////////////////////////

/obj/docking_port/mobile/diy
	name = "DIY"
	id = "diy_autism"
	port_direction = 2
	width = 9
	height = 13
	dwidth = 4
	dheight = 14

/obj/docking_port/mobile/diy/Initialize()
	id += "[GLOB.diy_shuttle_count]"
	. = ..()
	register()

/obj/docking_port/stationary/diy
	name = "DIY stationary"
	id = "diy_autism_home"
	dir = 2
	width = 9
	height = 13
	dwidth = 4
	dheight = 14

/obj/docking_port/stationary/diy/Initialize()
	id = "diy_autism[GLOB.diy_shuttle_count]_home"
	. = ..()

///////////////////////////////////////////////////////////////////////

/datum/map_template/shuttle/capsule/diyshuttle
	name = "Autism Shuttle"
	description = "Priv"

	port_id = "diy_autism"
	suffix = "normal"
	prefix = "white/hule/shuttles/diy/"


/obj/item/shuttlespawner/diyshuttle
	name = "bluespace shuttle capsule"
	desc = "Priva."
	template = new /datum/map_template/shuttle/capsule/diyshuttle


/obj/item/shuttlespawner/diyshuttle/attack_self()
	. = ..()
	if(used)
		GLOB.diy_shuttle_count++

///////////////////////////////////////

/obj/docking_port/mobile/diy/big
	dir = 2
	width = 13
	height = 20
	dwidth = 6
	dheight = 19

/obj/docking_port/stationary/diy/big
	width = 13
	height = 20
	dwidth = 6
	dheight = 19

/datum/map_template/shuttle/capsule/diyshuttle/big
	name = "Big Autism Shuttle"
	description = "Priv"
	suffix = "big"

/obj/item/shuttlespawner/diyshuttle/big
	template = new /datum/map_template/shuttle/capsule/diyshuttle/big

/datum/supply_pack/misc/diyshuttle
	name = "Bluespace shuttle capsule crate"
	cost = 20000
	contains = list(/obj/item/shuttlespawner/diyshuttle/big)
	crate_name = "shuttle capsule crate"
