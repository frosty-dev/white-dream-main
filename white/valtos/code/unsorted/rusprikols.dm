/obj/mecha/working/ripley/buran
	desc = "Гарантия тоталитарной власти. Держится на духовных скрепах."
	name = "\improper APLU MK-IV \"Buran\""
	icon = 'white/valtos/icons/mecha.dmi'
	icon_state = "buran"
	max_temperature = 65000
	max_integrity = 150
	deflect_chance = 25
	fast_pressure_step_in = 2 //step_in while in low pressure conditions
	slow_pressure_step_in = 4 //step_in while in normal pressure conditions
	step_in = 4
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	lights_power = 7
	armor = list("melee" = 80, "bullet" = 60, "laser" = 60, "energy" = 60, "bomb" = 90, "bio" = 0, "rad" = 90, "fire" = 100, "acid" = 100)
	max_equip = 3
	wreckage = /obj/structure/mecha_wreckage/ripley/buran
	enclosed = TRUE
	enter_delay = 40
	silicon_icon_state = null
	opacity = TRUE

/obj/mecha/working/ripley/buran/Initialize()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/flashbang
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/tesla_energy_relay
	ME.attach(src)

/obj/structure/mecha_wreckage/ripley/buran
	name = "\improper Buran wreckage"
	icon_state = "buran-broken"

/obj/machinery/porta_turret/armory
	name = "armory defense turret"
	desc = "An energy blaster auto-turret."
	installation = null
	stun_projectile = /obj/projectile/energy/electrode
	stun_projectile_sound = 'sound/weapons/taser.ogg'
	lethal_projectile = /obj/projectile/beam/laser/heavylaser/penetrator
	lethal_projectile_sound = 'sound/weapons/lasercannonfire.ogg'
	mode = TURRET_LETHAL
	turret_flags = TURRET_FLAG_SHOOT_UNSHIELDED | TURRET_FLAG_SHOOT_CRIMINALS | TURRET_FLAG_AUTH_WEAPONS
	//stun_all = 1
	always_up = 1
	scan_range = 9
	use_power = NO_POWER_USE
	faction = list("silicon","turret")

/obj/machinery/porta_turret/armory/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/empprotection, EMP_PROTECT_SELF | EMP_PROTECT_WIRES)

/obj/machinery/porta_turret/armory/setup()
	return

/obj/machinery/porta_turret/armory/interact(mob/user)
	return

/obj/projectile/beam/laser/heavylaser/penetrator
	movement_type = FLYING | UNSTOPPABLE
	range = 12

/obj/item/melee/classic_baton/dildon
	name = "dildo"
	desc = "При неправильном обращении окажется у меня в жопе."
	icon = 'white/valtos/icons/melee.dmi'
	icon_state = "dildo"
	inhand_icon_state = "dildo"
	lefthand_file = 'white/valtos/icons/lefthand.dmi'
	righthand_file = 'white/valtos/icons/righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 10
	w_class = WEIGHT_CLASS_NORMAL
	cooldown = 40

/mob/living
	var/headstamp //надпись на башне

/obj/item/stock_parts/capacitor/noneuclid
	name = "noneuclid capacitor"
	desc = "An capacity capacitor used in the construction of a variety of devices."
	icon_state = "quadratic_capacitor"
	rating = 8
	custom_materials = list(/datum/material/iron=1, /datum/material/glass=1)
	color = "#ff3333"

/obj/item/stock_parts/scanning_module/noneuclid
	name = "noneuclid scanning module"
	desc = "A compact, ultra resolution noneuclid scanning module used in the construction of certain devices."
	icon_state = "triphasic_scan_module"
	rating = 8
	custom_materials = list(/datum/material/iron=1, /datum/material/glass=1)
	color = "#ff3333"

/obj/item/stock_parts/manipulator/noneuclid
	name = "noneuclid-manipulator"
	desc = "A tiny little manipulator used in the construction of certain devices."
	icon_state = "femto_mani"
	rating = 8
	custom_materials = list(/datum/material/iron=1)
	color = "#ff3333"

/obj/item/stock_parts/micro_laser/noneuclid
	name = "noneuclid micro-laser"
	icon_state = "quadultra_micro_laser"
	desc = "A tiny laser used in certain devices."
	rating = 8
	custom_materials = list(/datum/material/iron=1, /datum/material/glass=1)
	color = "#ff3333"

/obj/item/stock_parts/matter_bin/noneuclid
	name = "noneuclid matter bin"
	desc = "A container designed to hold noneuclid matter awaiting reconstruction."
	icon_state = "bluespace_matter_bin"
	rating = 8
	custom_materials = list(/datum/material/iron=1)
	color = "#ff3333"

/obj/item/storage/part_replacer/bluespace/tier8
	color = "#ff3333"
	w_class = WEIGHT_CLASS_TINY

/obj/item/storage/part_replacer/bluespace/tier8/PopulateContents()
	for(var/i in 1 to 50)
		new /obj/item/stock_parts/capacitor/noneuclid(src)
		new /obj/item/stock_parts/scanning_module/noneuclid(src)
		new /obj/item/stock_parts/manipulator/noneuclid(src)
		new /obj/item/stock_parts/micro_laser/noneuclid(src)
		new /obj/item/stock_parts/matter_bin/noneuclid(src)

/datum/techweb_node/noneuclidic
	id = "noneuclidic"
	display_name = "Non-Euclid Research"
	description = "Experiments in the field of bluespace technologies led to the discovery of non-Euclidean spaces."
	prereq_ids = list("bluespace_travel", "practical_bluespace", "bluespace_storage")
	design_ids = list("noneuclid_matter_bin", "noneuclid_mani", "noneuclid_scanning", "noneuclid_capacitor", "noneuclid_micro_laser")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000000)
	export_price = 100000

/datum/design/noneuclid_matter_bin
	name = "Noneuclid Matter Bin"
	desc = "A stock part used in the construction of various devices."
	id = "noneuclid_matter_bin"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2500, /datum/material/diamond = 1000, /datum/material/bluespace = 1000)
	build_path = /obj/item/stock_parts/matter_bin/noneuclid
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/noneuclid_mani
	name = "Noneuclid Manipulator"
	desc = "A stock part used in the construction of various devices."
	id = "noneuclid_mani"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2000, /datum/material/diamond = 300, /datum/material/titanium = 300)
	build_path = /obj/item/stock_parts/manipulator/noneuclid
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/noneuclid_scanning
	name = "Noneuclid Scanning Module"
	desc = "A stock part used in the construction of various devices."
	id = "noneuclid_scanning"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2000, /datum/material/glass = 2000, /datum/material/diamond = 300, /datum/material/bluespace = 300)
	build_path = /obj/item/stock_parts/scanning_module/noneuclid
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/noneuclid_capacitor
	name = "Noneuclid Capacitor"
	desc = "A stock part used in the construction of various devices."
	id = "noneuclid_capacitor"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2000, /datum/material/glass = 2000, /datum/material/gold = 1000, /datum/material/diamond = 100)
	build_path = /obj/item/stock_parts/capacitor/noneuclid
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/noneuclid_micro_laser
	name = "Noneuclid Micro-Laser"
	desc = "A stock part used in the construction of various devices."
	id = "noneuclid_micro_laser"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2000, /datum/material/glass = 2000, /datum/material/uranium = 1000, /datum/material/diamond = 600)
	build_path = /obj/item/stock_parts/micro_laser/noneuclid
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE
