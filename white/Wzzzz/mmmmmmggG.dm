/obj/item/gun/ballistic/automatic/l6_saw/unrestricted/wzzzz/mg34
	name = "MG-34"
	desc = "German machinegun chambered in 7.92x57mm Mauser ammunition. An utterly devastating support weapon."
	icon = 'white/Wzzzz/icons/Weea.dmi'
	lefthand_file = 'white/Wzzzz/icons/clothing/mob/lefthand_guns.dmi'
	righthand_file = 'white/Wzzzz/icons/clothing/mob/righthand_guns.dmi'
	icon_state = "mg34"
	inhand_icon_state = "mg34"
	slot_flags = ITEM_SLOT_BACK
	resistance_flags = FIRE_PROOF
	fire_sound = 'white/Wzzzz/lmg_fire.ogg'
	mag_type = /obj/item/ammo_box/magazine/wzzzz/a762d
	w_class = WEIGHT_CLASS_HUGE
	fire_delay = 1
	spread = 9
	can_suppress = FALSE
	burst_size = 5
	can_bayonet = FALSE
	force = 10

/obj/item/ammo_box/magazine/wzzzz/a762d
	name = "Mg34 drum magazine (7.92x57mm)"
	desc = "A MG-34 magazine."
	icon = 'white/Wzzzz/icons/3434.dmi'
	icon_state = "mg34_drum"
	inhand_icon_state = "mg34_drum"
	caliber = "a792x33"
	ammo_type = /obj/item/ammo_casing/wzzzz/a792x33
	max_ammo = 100
	multiple_sprites = TRUE


/obj/projectile/bullet/wzzzz/a792x33
	name = "a792x33 bullet"
	damage = 25
	armour_penetration = 5

/obj/item/ammo_casing/wzzzz/a792x33
	name = "a792x33 bullet casing"
	desc = "A a792x33 bullet casing."
	caliber = "a792x33"
	projectile_type = /obj/projectile/bullet/wzzzz/a792x33
