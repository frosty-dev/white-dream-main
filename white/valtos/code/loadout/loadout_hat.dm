/datum/gear/hat
	subtype_path = /datum/gear/hat
	slot = ITEM_SLOT_HEAD
	sort_category = "Голова"
	species_blacklist = list("plasmaman") //Their helmet takes up the head slot
	cost = 8

/datum/gear/hat/hhat_yellow
	display_name = "Каска, жёлтая"
	path = /obj/item/clothing/head/hardhat
	allowed_roles = list("Chief Engineer", "Station Engineer")
	cost = 9

/datum/gear/hat/hhat_orange
	display_name = "Каска, оранжевая"
	path = /obj/item/clothing/head/hardhat/orange
	allowed_roles = list("Chief Engineer", "Station Engineer")

/datum/gear/hat/hhat_blue
	display_name = "Каска, синяя"
	path = /obj/item/clothing/head/hardhat/dblue
	allowed_roles = list("Chief Engineer", "Station Engineer")

/datum/gear/hat/that
	display_name = "Цилиндр"
	path = /obj/item/clothing/head/that
	cost = 10

/datum/gear/hat/red_beret
	display_name = "Берет, красный"
	path = /obj/item/clothing/head/beret
	cost = 20
