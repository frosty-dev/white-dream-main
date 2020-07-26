/obj/item/clothing/suit/space/pilot
	name = "pilot suit"
	desc = "A universal space suit for pilots"
	icon_state = "pilot"
	inhand_icon_state = "pilot"
	allowed = list(/obj/item)
	armor = list("melee" = 20, "bullet" = 30, "laser" = 15, "energy" = 30, "bomb" = 50, "bio" = 90, "rad" = 100, "fire" = 100, "acid" = 100)
	strip_delay = 120
	worn_icon = 'white/Wzzzz/pilot1.dmi'
	icon = 'white/Wzzzz/pilot.dmi'
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF

/obj/item/clothing/head/helmet/space/pilot
	name = "pilot helmet"
	desc = "A universal space helmet for pilots"
	icon_state = "pilot_helmet"
	inhand_icon_state = "pilot_helmet"
	armor = list("melee" = 20, "bullet" = 30, "laser" = 15, "energy" = 30, "bomb" = 50, "bio" = 90, "rad" = 100, "fire" = 100, "acid" = 100)
	strip_delay = 130
	worn_icon = 'white/Wzzzz/pilot1.dmi'
	icon = 'white/Wzzzz/pilot.dmi'
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF
