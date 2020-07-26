/obj/item/melee/sabre/wzzzz/marine
	name = "marine sword"
	desc = "A curved sword issued to german marines"
	icon = 'white/Wzzzz/icons/Weea.dmi'
	icon_state = "marinesword"
	inhand_icon_state = "marinesword"
	lefthand_file = 'white/Wzzzz/icons/Weeal.dmi'
	righthand_file = 'white/Wzzzz/icons/Weear.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/belt.dmi'
	slot_flags = ITEM_SLOT_BELT
	flags_1 = CONDUCT_1
	force = 20
	throwforce = 7
	w_class = WEIGHT_CLASS_BULKY
	block_chance = 30
	armour_penetration = 25
	sharpness = IS_SHARP
	hitsound = 'sound/weapons/rapierhit.ogg'
	custom_materials = list(/datum/material/iron = 500)

/obj/item/melee/sabre/wzzzz/officer
	name = "officer sword"
	desc = "A curved sword issued to german officers"
	icon = 'white/Wzzzz/icons/Weea.dmi'
	icon_state = "officersword"
	inhand_icon_state = "officersword"
	lefthand_file = 'white/Wzzzz/icons/Weeal.dmi'
	righthand_file = 'white/Wzzzz/icons/Weear.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/belt.dmi'
	slot_flags = ITEM_SLOT_BELT
	flags_1 = CONDUCT_1
	force = 20
	throwforce = 7
	w_class = WEIGHT_CLASS_BULKY
	block_chance = 30
	armour_penetration = 20
	sharpness = IS_SHARP
	hitsound = 'sound/weapons/rapierhit.ogg'
	custom_materials = list(/datum/material/iron = 500)

/obj/item/melee/sabre/wzzzz/marineofficer
	name = "marine officer sword"
	desc = "A curved sword issued to german marine officers"
	icon = 'white/Wzzzz/icons/Weea.dmi'
	icon_state = "marineofficersword"
	inhand_icon_state = "marineofficersword"
	lefthand_file = 'white/Wzzzz/icons/Weeal.dmi'
	righthand_file = 'white/Wzzzz/icons/Weear.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/belt.dmi'
	slot_flags = ITEM_SLOT_BELT
	flags_1 = CONDUCT_1
	force = 28
	throwforce = 7
	w_class = WEIGHT_CLASS_BULKY
	block_chance = 45
	armour_penetration = 15
	sharpness = IS_SHARP
	hitsound = 'sound/weapons/rapierhit.ogg'
	custom_materials = list(/datum/material/iron = 500)

/obj/item/melee/sabre/wzzzz/pettyofficer
	name = "pettyofficer sword"
	desc = "A curved sword issued to german petty officers"
	icon = 'white/Wzzzz/icons/Weea.dmi'
	icon_state = "pettyofficersword"
	inhand_icon_state = "pettyofficersword"
	lefthand_file = 'white/Wzzzz/icons/Weeal.dmi'
	righthand_file = 'white/Wzzzz/icons/Weear.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/belt.dmi'
	slot_flags = ITEM_SLOT_BELT
	flags_1 = CONDUCT_1
	force = 25
	throwforce = 7
	w_class = WEIGHT_CLASS_BULKY
	block_chance = 50
	armour_penetration = 20
	sharpness = IS_SHARP
	hitsound = 'sound/weapons/rapierhit.ogg'
	custom_materials = list(/datum/material/iron = 500)

/obj/item/melee/sabre/wzzzz/german
	name = "german sabre"
	desc = "A good weapon in melee battle"
	icon = 'white/Wzzzz/icons/Weea.dmi'
	icon_state = "sabre"
	inhand_icon_state = "sabre"
	lefthand_file = 'white/Wzzzz/icons/Weeal.dmi'
	righthand_file = 'white/Wzzzz/icons/Weear.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/belt.dmi'
	slot_flags = ITEM_SLOT_BELT
	flags_1 = CONDUCT_1
	force = 30
	throwforce = 5
	w_class = WEIGHT_CLASS_BULKY
	block_chance = 65
	armour_penetration = 35
	sharpness = IS_SHARP
	hitsound = 'sound/weapons/rapierhit.ogg'
	custom_materials = list(/datum/material/iron = 500)

/obj/item/melee/classic_baton/wzzzz/german
	name = "baton"
	desc = "A compact yet robust personal defense weapon. Can be concealed when folded."
	icon = 'white/Wzzzz/icons/Weea.dmi'
	icon_state = "baton"
	cooldown = 20
	inhand_icon_state = "baton"
	lefthand_file = 'white/Wzzzz/icons/Weeal.dmi'
	righthand_file = 'white/Wzzzz/icons/Weear.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/belt.dmi'
	slot_flags = ITEM_SLOT_BELT

/obj/item/melee/wzzzz/club
	icon_state = "club"
	inhand_icon_state = "club"
	icon = 'white/Wzzzz/icons/Weea.dmi'
	lefthand_file = 'white/Wzzzz/icons/Weeal.dmi'
	righthand_file = 'white/Wzzzz/icons/Weear.dmi'
	name = "club"
	desc = "Heavy strong club from somewhere"
	w_class = WEIGHT_CLASS_BULKY
	force = 25
	throwforce = 3
	throw_speed = 2
	armour_penetration = 30
	custom_materials = list(/datum/material/iron=2000)

/obj/item/kitchen/knife/wzzzz/german
	name = "combat knife"
	desc = "A german military combat knife."
	embedding = list("embedded_pain_multiplier" = 2, "embed_chance" = 50, "embedded_fall_chance" = 5, "embedded_ignore_throwspeed_threshold" = TRUE)
	force = 20
	icon_state = "knife"
	inhand_icon_state = "knife"
	icon = 'white/Wzzzz/icons/Weea.dmi'
	lefthand_file = 'white/Wzzzz/icons/Weeal.dmi'
	righthand_file = 'white/Wzzzz/icons/Weear.dmi'
	throwforce = 15
	bayonet = TRUE
	custom_price = 0

/obj/item/melee/baton/loaded/german
	desc = "A german stun baton."
	icon = 'white/Wzzzz/icons/Uebermarginal/weapons.dmi'
	lefthand_file = 'white/Wzzzz/icons/Weeal.dmi'
	righthand_file = 'white/Wzzzz/icons/Weear.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/belt.dmi'

/obj/item/kitchen/knife/butcher/wzzzz/machete
	name = "machete"
	icon = 'white/Wzzzz/icons/Weea.dmi'
	icon_state = "machete"
	inhand_icon_state = "machete"
	lefthand_file = 'white/Wzzzz/icons/Weeal.dmi'
	righthand_file = 'white/Wzzzz/icons/Weear.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/belt.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 23
	throwforce = 10
	block_chance = 30
	armour_penetration = 15
	sharpness = 5
	custom_materials = list(/datum/material/iron = 550)
