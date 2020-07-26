/datum/design/board/telepad
	name = "Machine Design (Telepad Board)"
	desc = "The circuit board for a telescience telepad."
	id = "telepad"
	build_path = /obj/item/circuitboard/machine/telesci_pad
	category = list ("Teleportation Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/obj/item/circuitboard/machine/telesci_pad
	name = "Telepad (Machine Board)"
	build_path = /obj/machinery/telepad
	req_components = list(
							/obj/item/stack/ore/bluespace_crystal = 2,
							/obj/item/stock_parts/capacitor = 1,
							/obj/item/stack/cable_coil = 1,
							/obj/item/stack/sheet/glass = 1)
	def_components = list(/obj/item/stack/ore/bluespace_crystal = /obj/item/stack/ore/bluespace_crystal/artificial)

//////////////////////////////////////////////////////////

/datum/design/board/telesci_console
	name = "Computer Design (Telepad Control Console Board)"
	desc = "Allows for the construction of circuit boards used to build a telescience console."
	id = "telesci_console"
	build_path = /obj/item/circuitboard/computer/telesci_console
	category = list("Teleportation Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/obj/item/circuitboard/computer/telesci_console
	name = "Telescience Console (Computer Board)"
	build_path = /obj/machinery/computer/telescience

//////////////////////////////////////////////////////////

/datum/techweb_node/telesci
	id = "telesci"
	display_name = "Prikol/Time Manipulation"
	description = "Allows for advanced prikol construction."
	prereq_ids = list("adv_datatheory")
	design_ids = list("telepad", "telesci_console")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000
