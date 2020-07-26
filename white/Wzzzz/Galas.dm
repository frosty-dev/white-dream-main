//clothing
/obj/item/clothing/glasses/wzzzz/leforge
	name = "Le forge"
	desc = "Аля форж"
	icon = 'white/Wzzzz/icons/clothing/glasses.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/eyes.dmi'
	icon_state = "leforge"
	inhand_icon_state = "leforge"

/obj/item/clothing/glasses/wzzzz/denight
	name = "denight vision goggles"
	desc = "Not night, just denight"
	icon = 'white/Wzzzz/icons/clothing/glasses.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/eyes.dmi'
	icon_state = "denight"
	inhand_icon_state = "denight"
	flash_protect = 1
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	darkness_view = 10

/obj/item/clothing/glasses/wzzzz/jensenshades
	name = "Jensenshades"
	desc = "Дженсен Стэтхем"
	icon = 'white/Wzzzz/icons/clothing/glasses.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/eyes.dmi'
	icon_state = "jensenshades"
	inhand_icon_state = "jensenshades"
	flash_protect = 5
	tint = 1

/obj/item/clothing/glasses/wzzzz/goggless
	name = "Dark gogles"
	desc = "Something familiar, but dark"
	icon = 'white/Wzzzz/icons/clothing/glasses.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/eyes.dmi'
	icon_state = "goggless"
	inhand_icon_state = "goggless"
	tint = 1
	flash_protect = 3
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	darkness_view = 8

/obj/item/clothing/glasses/wzzzz/sec_flash
	name = "Security glasses"
	desc = "New style, maybe"
	icon = 'white/Wzzzz/icons/clothing/glasses.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/eyes.dmi'
	icon_state = "sec_flash"
	inhand_icon_state = "sec_flash"
	flash_protect = 1
	tint = 1

/obj/item/clothing/glasses/welding/wzzzz/r
	name = "New welding goggles"
	desc = "Protects the eyes from bright flashes; approved by the mad scientist association."
	icon = 'white/Wzzzz/icons/clothing/glasses.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/eyes.dmi'
	icon_state = "rwelding-g"
	inhand_icon_state = "rwelding-g"
	actions_types = list(/datum/action/item_action/toggle)
	custom_materials = list(/datum/material/iron = 250)
	flash_protect = 2
	tint = 2
	visor_vars_to_toggle = VISOR_FLASHPROTECT | VISOR_TINT
	flags_cover = GLASSESCOVERSEYES
	glass_colour_type = /datum/client_colour/glass_colour/green
