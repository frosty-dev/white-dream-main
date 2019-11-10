/obj/item/gun/ballistic/automatic/wzzzz/stg
	name = "STG-44"
	desc = "German submachinegun chambered in 9x19 Parabellum, with a 32 magazine magazine layout. Standard issue amongst most troops."
	icon = 'code/shitcode/Wzzzz/icons/Weea.dmi'
	lefthand_file = 'code/shitcode/Wzzzz/icons/clothing/mob/lefthand_guns.dmi'
	righthand_file = 'code/shitcode/Wzzzz/icons/clothing/mob/righthand_guns.dmi'
	icon_state = "stg"
	item_state = "stg"
	slot_flags = ITEM_SLOT_BACK
	resistance_flags = FIRE_PROOF
	fire_sound = 'code/shitcode/Wzzzz/stg.ogg'
	mag_type = /obj/item/ammo_box/magazine/wzzzz/stg
	w_class = WEIGHT_CLASS_HUGE
	fire_delay = 2
	can_suppress = FALSE
	burst_size = 3
	can_bayonet = FALSE

/obj/item/ammo_box/magazine/wzzzz/stg
	name = "stg-44 (7.92x33mm) magazine"
	desc = "A Stg-44 magazine."
	icon = 'code/shitcode/Wzzzz/icons/ammo.dmi'
	icon_state = "stgmag"
	item_state = "stgmag"
	caliber = "a792x33"
	ammo_type = /obj/item/ammo_casing/wzzzz/a792x33
	max_ammo = 30
	multiple_sprites = FALSE


/obj/projectile/bullet/wzzzz/stg
	name = "a792x33 bullet"
	damage = 35
	armour_penetration = 45

/obj/item/ammo_casing/wzzzz/a792x33
	name = "a792x33 bullet casing"
	desc = "A a792x33 bullet casing."
	caliber = "a792x33"
	projectile_type = /obj/projectile/bullet/wzzzz/stg
