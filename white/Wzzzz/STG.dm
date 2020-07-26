/obj/item/gun/ballistic/automatic/wzzzz/stg
	name = "STG-44"
	desc = "German submachinegun chambered in 9x19 Parabellum, with a 32 magazine magazine layout. Standard issue amongst most troops."
	icon = 'white/Wzzzz/icons/Weea.dmi'
	lefthand_file = 'white/Wzzzz/icons/clothing/mob/lefthand_guns.dmi'
	righthand_file = 'white/Wzzzz/icons/clothing/mob/righthand_guns.dmi'
	icon_state = "stg"
	inhand_icon_state = "stg"
	slot_flags = ITEM_SLOT_BACK
	resistance_flags = FIRE_PROOF
	fire_sound = 'white/Wzzzz/stg.ogg'
	mag_type = /obj/item/ammo_box/magazine/wzzzz/stg
	w_class = WEIGHT_CLASS_HUGE
	fire_delay = 2
	can_suppress = FALSE
	burst_size = 3
	can_bayonet = FALSE

/obj/item/ammo_box/magazine/wzzzz/stg
	name = "stg-44 (7.92x33mm) magazine"
	desc = "A Stg-44 magazine."
	icon = 'white/Wzzzz/icons/ammo.dmi'
	icon_state = "stgmag"
	inhand_icon_state = "stgmag"
	caliber = "a792x33"
	ammo_type = /obj/item/ammo_casing/wzzzz/a792x33
	max_ammo = 30
	multiple_sprites = FALSE



/obj/projectile/bullet/wzzzz/stg
	name = "a792x33 bullet"
	damage = 35
	armour_penetration = 30

/obj/item/ammo_casing/wzzzz/a792x33
	name = "a792x33 bullet casing"
	desc = "A a792x33 bullet casing."
	caliber = "a792x33"
	projectile_type = /obj/projectile/bullet/wzzzz/stg

/obj/item/gun/ballistic/automatic/ar/wzzzz/fg42
	name = "FG-42"
	desc = "Automatic sniper weapon."
	icon_state = "fg42"
	lefthand_file = 'white/Wzzzz/icons/clothing/mob/lefthand_guns.dmi'
	righthand_file = 'white/Wzzzz/icons/clothing/mob/righthand_guns.dmi'
	inhand_icon_state = "fg42"
	mag_type = /obj/item/ammo_box/magazine/wzzzz/fg42
	fire_sound = 'white/Wzzzz/sfrifle_fire.ogg'
	can_suppress = FALSE
	icon = 'white/Wzzzz/icons/Weea.dmi'
	burst_size = 3
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 10
	fire_delay = 1.75

/obj/item/ammo_box/magazine/wzzzz/fg42
	name = "fg42 magazine (5.56mm)"
	ammo_type = /obj/item/ammo_casing/a762/wzzzz/fg42
	caliber = "7.92"
	max_ammo = 20
	icon_state = "5.56"
	icon = 'white/Wzzzz/icons/ammo.dmi'
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_casing/a762/wzzzz/fg42
	name = "7.92mm bullet casing"
	desc = "A 7.92mm bullet casing."
	caliber = "7.92"
	projectile_type = /obj/projectile/bullet/wzzzz/fg42

/obj/projectile/bullet/wzzzz/fg42
	damage = 35
	armour_penetration = 20
	speed = 0.35

/obj/item/gun/ballistic/automatic/m90/unrestricted/wzzzz/z8
	name = "bullpup assault rifle"
	desc = "The Z8 Bulldog is an older model bullpup carbine, made by the now defunct Zendai Foundries. Uses armor piercing 5.56mm rounds. Makes you feel like a space marine when you hold it."
	icon_state = "carbine"
	inhand_icon_state = "carbine"
	w_class = WEIGHT_CLASS_HUGE
	force = 10
	fire_sound = 'white/Wzzzz/gunshot3.ogg'
	slot_flags = ITEM_SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/wzzzz/a556carbine
	fire_delay = 2
	can_suppress = FALSE
	burst_size = 3
	can_bayonet = FALSE
	icon = 'white/Wzzzz/icons/Weea.dmi'
	lefthand_file = 'white/Wzzzz/icons/clothing/mob/lefthand_guns.dmi'
	righthand_file = 'white/Wzzzz/icons/clothing/mob/righthand_guns.dmi'

/obj/item/ammo_box/magazine/wzzzz/a556carbine
	name = "magazine (6.8mm)"
	icon_state = "5.56"
	caliber = "229"
	ammo_type = /obj/item/ammo_casing/wzzzz/a556carbine
	max_ammo = 15
	icon = 'white/Wzzzz/icons/ammo.dmi'
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_casing/wzzzz/a556carbine
	desc = "A 6.8mm bullet casing."
	caliber = "229"
	projectile_type = /obj/projectile/bullet/wzzzz/a556

/obj/projectile/bullet/wzzzz/a556
	damage = 50
	armour_penetration = 25

/obj/item/gun/ballistic/automatic/wzzzz/carbine
	name = "assault carbine"
	desc = "The assault rifle is new standart automatic weapon"
	icon_state = "carbinex"
	inhand_icon_state = "carbinex"
	w_class = 4
	force = 10
	fire_sound = 'white/Wzzzz/batrifle_fire.ogg'
	slot_flags = ITEM_SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/wzzzz/carbine
	fire_delay = 2
	can_suppress = FALSE
	burst_size = 3
	can_bayonet = FALSE
	icon = 'white/Wzzzz/icons/Weea.dmi'
	lefthand_file = 'white/Wzzzz/icons/clothing/mob/lefthand_guns.dmi'
	righthand_file = 'white/Wzzzz/icons/clothing/mob/righthand_guns.dmi'

/obj/item/ammo_box/magazine/wzzzz/carbine
	name = "magazine (5.56mm)"
	icon_state = "carb"
	caliber = "carab"
	ammo_type = /obj/item/ammo_casing/wzzzz/carbine
	max_ammo = 30
	icon = 'white/Wzzzz/icons/ammo.dmi'
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_casing/wzzzz/carbine
	desc = "A 5.56mm bullet casing."
	caliber = "carab"
	projectile_type = /obj/projectile/bullet/wzzzz/carab

/obj/projectile/bullet/wzzzz/carab
	damage = 30
	armour_penetration = 7.5

