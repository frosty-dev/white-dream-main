/obj/item/stack/sheet/palputinum
	name = "лист палпутинума"
	desc = "Вскрытие туза в комплект не входит"
	singular_name = "лист палпутинума"
	icon = 'white/baldenysh/icons/obj/stack.dmi'
	icon_state = "sheet-pyramid"
	material_flags = MATERIAL_COLOR
	custom_materials = list(/datum/material/palputinum = MINERAL_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/palputinum
	material_type = /datum/material/palputinum
	material_modifier = 1

/obj/item/stack/sheet/palputinum/ten
	amount = 10

/datum/material/palputinum
	name = "палпутинум"
	desc = "Туз"
	color = rgb(239, 151, 68)
	categories = list(MAT_CATEGORY_RIGID = TRUE, MAT_CATEGORY_BASE_RECIPES = TRUE)
	sheet_type = /obj/item/stack/sheet/palputinum
	value_per_unit = 0.05
	beauty_modifier = 0.3
	strength_modifier = 0.9
	armor_modifiers = list("melee" = 0.3, "bullet" = 0.3, "laser" = 1.2, "energy" = 1.2, "bomb" = 0.3, "bio" = 0, "rad" = 0.7, "fire" = 1, "acid" = 1)
	item_sound_override = 'sound/effects/meatslap.ogg'
	turf_sound_override = FOOTSTEP_MEAT
	texture_layer_icon_state = "palputinum"
