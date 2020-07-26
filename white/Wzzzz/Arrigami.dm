/obj/item/gun/ballistic/automatic/ar/wzzzz
	name = "\improper NT-ARG 'Boarder'"
	desc = "Assault rile with special amp."
	icon_state = "arg"
	inhand_icon_state = "arg"
	slot_flags = 0
	mag_type = /obj/item/ammo_box/magazine/m556/arg/wzzzz
	fire_sound = 'white/Wzzzz/gunshot_smg.ogg'
	can_suppress = FALSE
	icon = 'white/Wzzzz/icons/Weea.dmi'
	burst_size = 3
	zoomable = TRUE
	zoom_amt = 8
	zoom_out_amt = 8
	fire_delay = 2

/obj/item/ammo_box/magazine/m556/arg/wzzzz
	name = "arg magazine (5.56mm)"
	icon_state = "arg"
	ammo_type = /obj/item/ammo_casing/m556
	caliber = "m556"
	max_ammo = 30
	icon = 'white/Wzzzz/icons/Ora/ne_sharu_v_etom_vse_eshe.dmi'
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_casing/m556
	name = "5.56mm bullet casing"
	desc = "A 5.56mm bullet casing."
	caliber = "m556"
	projectile_type = /obj/projectile/bullet/m556/wzzzz

/obj/projectile/bullet/m556/wzzzz
	damage = 35
	armour_penetration = 10
	speed = 0.25
	stamina = 15
