/datum/techweb/specialized/autounlocking/reagent_forge
	design_autounlock_buildtypes = REAGENT_FORGE
	allowed_buildtypes = REAGENT_FORGE

/datum/techweb_node/refinery
	id = "refinery"
	display_name = "Prikol Refinery Consturction"
	description = "Allows for a new ways of matter manipulation."
	prereq_ids = list("adv_datatheory")
	design_ids = list("reagent_sheet")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/design/board/reagent_sheet
	name = "Reagent Refinery (Machine Board)"
	desc = "Allows for the construction of circuit boards used to build a reagent refinery."
	id = "reagent_sheet"
	build_path = /obj/item/circuitboard/machine/reagent_sheet
	category = list("Engineering Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE
