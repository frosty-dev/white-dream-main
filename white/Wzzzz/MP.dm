/obj/item/gun/ballistic/automatic/wzzzz/mp40
	name = "MP40"
	desc = "German submachinegun chambered in 9x19 Parabellum, with a 32 magazine magazine layout. Standard issue amongst most troops."
	icon = 'white/Wzzzz/icons/Weea.dmi'
	lefthand_file = 'white/Wzzzz/icons/clothing/mob/lefthand_guns.dmi'
	righthand_file = 'white/Wzzzz/icons/clothing/mob/righthand_guns.dmi'
	icon_state = "mp40"
	inhand_icon_state = "mp40"
	slot_flags = ITEM_SLOT_BELT
	resistance_flags = FIRE_PROOF
	fire_sound = 'white/Wzzzz/Gunshot_light.ogg'
	mag_type = /obj/item/ammo_box/magazine/wzzzz/mp40
	w_class = 4
	fire_delay = 2
	can_suppress = FALSE
	burst_size = 3
	can_bayonet = FALSE
	fire_sound = 'white/Wzzzz/smg_fire.ogg'

/obj/item/ammo_box/magazine/wzzzz/mp40
	name = "MP-40 magazine (c9mm)"
	desc = "A mp40 magazine."
	icon = 'white/Wzzzz/ne_sharu_v_etom.dmi'
	icon_state = "mp40mag"
	inhand_icon_state = "mp40mag"
	caliber = "crgmm"
	ammo_type = /obj/item/ammo_casing/wzzzz/crgmm
	max_ammo = 32
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/projectile/bullet/mp40
	name = "9mm bullet"
	damage = 25
	armour_penetration = 13.5

/obj/item/ammo_casing/wzzzz/crgmm
	name = "9mm bullet casing"
	desc = "A 9mm bullet casing."
	caliber = "crgmm"
	projectile_type = /obj/projectile/bullet/mp40
