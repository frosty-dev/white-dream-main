//////////////////////////
//
//stealware
//
//////////////////////////

//clothing

/obj/item/clothing/under/m35jacket
	name = "m35 jacket"
	desc = "Ммм. Хайль Вайт."
	worn_icon = 'white/valtos/icons/clothing/mob/uniform.dmi'
	icon = 'white/valtos/icons/clothing/uniforms.dmi'
	icon_state = "m35_jacket"
	inhand_icon_state = "m35_jacket"

	//armor = list("melee" = 20, "bullet" = 20, "laser" = 20,"energy" = 20, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 30)
	can_adjust = FALSE

/obj/item/clothing/under/m35jacket/officer
	icon_state = "m35_jacket_officer"
	inhand_icon_state = "m35_jacket_officer"
	//armor = list("melee" = 30, "bullet" = 30, "laser" = 30,"energy" = 30, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)

/obj/item/clothing/under/m35jacket/elite
	icon_state = "m35_elite_jacket"
	inhand_icon_state = "m35_elite_jacket"
	//armor = list("melee" = 60, "bullet" = 60, "laser" = 60,"energy" = 60, "bomb" = 60, "bio" = 0, "rad" = 0, "fire" = 60, "acid" = 60)

/obj/item/clothing/under/m35jacket/elite/super
	icon_state = "m35_super_elite_jacket"
	inhand_icon_state = "m35_super_elite_jacket"
	//armor = list("melee" = 90, "bullet" = 90, "laser" = 90,"energy" = 90, "bomb" = 90, "bio" = 0, "rad" = 0, "fire" = 90, "acid" = 90)

/obj/item/clothing/under/magistrate
	name = "magistrate uniform"
	desc = "Ммм. Хайль Вайт."
	worn_icon = 'white/valtos/icons/clothing/mob/uniform.dmi'
	icon = 'white/valtos/icons/clothing/uniforms.dmi'
	icon_state = "magistrate"
	inhand_icon_state = "magistrate"

	//armor = list("melee" = 100, "bullet" = 100, "laser" = 100,"energy" = 100, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	can_adjust = FALSE

/obj/item/clothing/under/arbiter
	name = "arbiter uniform"
	desc = "Ммм. Хайль Вайт."
	worn_icon = 'white/valtos/icons/clothing/mob/uniform.dmi'
	icon = 'white/valtos/icons/clothing/uniforms.dmi'
	icon_state = "arbiter"
	inhand_icon_state = "arbiter"

	//armor = list("melee" = 100, "bullet" = 100, "laser" = 100,"energy" = 100, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	can_adjust = FALSE

//suits

/obj/item/clothing/suit/armor/vest/izan
	name = "bulletproof vest"
	desc = "Спасёт твою грудь от пуль. Пахнет китайским пластиком."
	worn_icon = 'white/valtos/icons/clothing/mob/suit.dmi'
	icon = 'white/valtos/icons/clothing/suits.dmi'
	icon_state = "opvest"

	//armor = list("melee" = 35, "bullet" = 90, "laser" = 20,"energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)

/obj/item/clothing/suit/armor/vest/izan/arbiter
	icon_state = "arbiter"

/obj/item/clothing/suit/armor/vest/izan/army_coat
	icon_state = "army_coat"
	//armor = list("melee" = 45, "bullet" = 90, "laser" = 10,"energy" = 20, "bomb" = 5, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)

/obj/item/clothing/suit/armor/vest/izan/elite_army_coat
	icon_state = "elite_army_coat"
	//armor = list("melee" = 55, "bullet" = 95, "laser" = 20,"energy" = 30, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)

/obj/item/clothing/suit/armor/vest/izan/super_elite_army_coat
	icon_state = "super_elite_army_coat"
	//armor = list("melee" = 75, "bullet" = 100, "laser" = 60,"energy" = 50, "bomb" = 70, "bio" = 0, "rad" = 0, "fire" = 90, "acid" = 30)

/obj/item/clothing/suit/cowl
	name = "cowl"
	desc = "Красивое покрывало."
	worn_icon = 'white/valtos/icons/clothing/mob/suit.dmi'
	icon = 'white/valtos/icons/clothing/suits.dmi'
	icon_state = "cowl"
	slot_flags = ITEM_SLOT_NECK

/obj/item/clothing/suit/cowl/robe
	name = "robe"
	desc = "Модное покрывало."
	icon_state = "robes"

//gloves

/obj/item/clothing/gloves/arbiter
	name = "arbiter gloves"
	worn_icon = 'white/valtos/icons/clothing/mob/glove.dmi'
	icon = 'white/valtos/icons/clothing/gloves.dmi'
	icon_state = "arbiter"

/obj/item/clothing/gloves/arbiter/undertaker
	name = "undertaker gloves"
	icon_state = "undertaker"

//hats

/obj/item/clothing/head/helmet/arbiter
	name = "arbiter helmet"
	desc = "Ммм. Хайль Вайт."
	worn_icon = 'white/valtos/icons/clothing/mob/hat.dmi'
	icon = 'white/valtos/icons/clothing/hats.dmi'
	icon_state = "arbiter"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR
	//armor = list("melee" = 100, "bullet" = 100, "laser" = 100,"energy" = 100, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)

/obj/item/clothing/head/helmet/arbiter/inquisitor
	name = "inquisitor helmet"
	icon_state = "inquisitor"

/obj/item/clothing/head/helmet/izanhelm
	name = "m35 cap"
	desc = "Ммм. Хайль Вайт."
	worn_icon = 'white/valtos/icons/clothing/mob/hat.dmi'
	icon = 'white/valtos/icons/clothing/hats.dmi'
	icon_state = "officer_cap"
	//armor = list("melee" = 55, "bullet" = 90, "laser" = 20,"energy" = 30, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)

/obj/item/clothing/head/helmet/izanhelm/elite
	name = "m35 elite cap"
	icon_state = "m35_elite_cap"
	//armor = list("melee" = 75, "bullet" = 100, "laser" = 60,"energy" = 50, "bomb" = 70, "bio" = 0, "rad" = 0, "fire" = 90, "acid" = 30)

/obj/item/clothing/head/helmet/izanhelm/helmet
	name = "m35 helmet"
	icon_state = "m35_helmet"

/obj/item/clothing/head/helmet/izanhelm/helmet/elite
	name = "m35 elite helmet"
	icon_state = "m35_elite_helmet"
	//armor = list("melee" = 75, "bullet" = 100, "laser" = 60,"energy" = 50, "bomb" = 70, "bio" = 0, "rad" = 0, "fire" = 90, "acid" = 30)

/obj/item/clothing/head/helmet/izanhelm/helmet/pickelhelm
	name = "pickelhelm"
	icon_state = "pickelhelm"

/obj/item/clothing/head/helmet/richard
	name = "richard's head"
	desc = "Пахнет кровью."
	worn_icon = 'white/valtos/icons/clothing/mob/hat.dmi'
	icon = 'white/valtos/icons/clothing/hats.dmi'
	icon_state = "richard"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR
	//armor = list("melee" = 100, "bullet" = 100, "laser" = 100,"energy" = 100, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)

//masks

/obj/item/clothing/mask/gas/izan
	name = "old style gas mask"
	desc = "Ммм. Хайль Вайт."
	flags_inv = 256
	worn_icon = 'white/valtos/icons/clothing/mob/mask.dmi'
	icon = 'white/valtos/icons/clothing/masks.dmi'
	icon_state = "fullgas"

/obj/item/clothing/mask/gas/izan/german
	name = "german gas mask"
	flags_inv = 256
	icon_state = "german_gasmask"

/obj/item/clothing/mask/gas/izan/german/alt
	name = "gas mask"
	flags_inv = 256
	icon_state = "gas_alt"

/obj/item/clothing/mask/gas/izan/respirator
	name = "respirator mask"
	icon_state = "respirator"

/obj/item/clothing/mask/izanclava
	name = "balaclava"
	desc = "Ммм. Хайль Вайт."
	flags_inv = 256
	worn_icon = 'white/valtos/icons/clothing/mob/mask.dmi'
	icon = 'white/valtos/icons/clothing/masks.dmi'
	icon_state = "balaclava"

/obj/item/clothing/mask/izanclava/swat
	name = "swatclava"
	icon_state = "swatclava"

//shoes

/obj/item/clothing/shoes/jackboots/arbiter
	name = "arbiter boots"
	desc = "Ммм. Хайль Вайт."
	worn_icon = 'white/valtos/icons/clothing/mob/shoe.dmi'
	icon = 'white/valtos/icons/clothing/shoes.dmi'
	icon_state = "arbiter"

//guns

/obj/item/gun/ballistic/automatic/pistol/makarov
	name = "\improper Makarov"
	desc = "Ммм. Хайль Вайт."
	icon = 'white/valtos/icons/gun.dmi'
	icon_state = "makarov"
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/m9mm
	can_suppress = FALSE

/obj/item/gun/ballistic/automatic/ak47
	name = "AK-47"
	desc = "Отрывает ебальник с очереди. Использует противотанковый калибр 7.62."
	icon = 'white/valtos/icons/gun.dmi'
	lefthand_file = 'white/valtos/icons/lefthand.dmi'
	righthand_file = 'white/valtos/icons/righthand.dmi'
	worn_icon = 'white/valtos/icons/back.dmi'
	fire_sound = 'white/valtos/sounds/ak74_shot.ogg'
	icon_state = "ak47"
	inhand_icon_state = "ak47"
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	mag_type = /obj/item/ammo_box/magazine/ak47mag
	fire_delay = 2
	can_suppress = FALSE
	burst_size = 3
	can_bayonet = TRUE
	knife_x_offset = 28
	knife_y_offset = 12

/obj/item/ammo_box/magazine/ak47mag
	name = "AK-47 magazine (7.62)"
	icon = 'white/valtos/icons/ammo.dmi'
	icon_state = "akm"
	ammo_type = /obj/item/ammo_casing/a762
	caliber = "a762"
	max_ammo = 30

/obj/item/ammo_box/magazine/ak47mag/update_icon()
	..()
	icon_state = "akm-[ammo_count() ? "30" : "0"]"
