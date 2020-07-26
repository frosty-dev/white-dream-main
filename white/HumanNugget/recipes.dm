
/datum/crafting_recipe/am_jar
	name = "Antimatter Containment Jar"
	result = /obj/item/am_containment
	reqs = list(/obj/item/stock_parts/matter_bin/bluespace = 2,
				/obj/item/stack/ore/bluespace_crystal = 1)
	tools = list(TOOL_WELDER, TOOL_WRENCH)
	time = 40
	category = CAT_MISC
