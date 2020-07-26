/obj/item/gun/ballistic/automatic/pistol/wzzzz/luger
	name = "Luger P08"
	desc = "German 9mm pistol."
	icon = 'white/Wzzzz/icons/Weea.dmi'
	icon_state = "luger"
	w_class = WEIGHT_CLASS_SMALL
	fire_sound = 'white/Wzzzz/Gunshot_light.ogg'
	mag_type = /obj/item/ammo_box/magazine/wzzzz/luger/battle
	can_suppress = FALSE
	slot_flags = ITEM_SLOT_BELT


/obj/item/ammo_box/magazine/wzzzz/luger
	name = "Luger magazine"
	desc = "A luger magazine."
	icon = 'white/Wzzzz/icons/ammo.dmi'
	icon_state = "lugermag"
	inhand_icon_state = "lugermag"
	caliber = "9mm"
	ammo_type = /obj/item/ammo_casing/wzzzz/luger
	max_ammo = 8
	multiple_sprites = TRUE

/obj/item/ammo_box/magazine/wzzzz/luger/battle
	name = "Luger magazine (9mm battle)"
	ammo_type = /obj/item/ammo_casing/wzzzz/lugerb

/obj/item/ammo_box/magazine/wzzzz/luger/rubber
	name = "Luger magazine (9mm rubber)"
	ammo_type = /obj/item/ammo_casing/wzzzz/luger

/obj/projectile/bullet/pistol/wzzzz/rubber
	name = "rubber bullet"
	damage = 5
	stamina = 25

/obj/projectile/bullet/pistol/wzzzz/battle
	name = "9mm bullet"
	damage = 20

/obj/item/ammo_casing/wzzzz/luger
	desc = "A 9mm bullet casing."
	caliber = "9mm"
	projectile_type = /obj/projectile/bullet/pistol/wzzzz/rubber

/obj/item/ammo_casing/wzzzz/lugerb
	desc = "A 9mm bullet casing."
	caliber = "9mm"
	projectile_type = /obj/projectile/bullet/pistol/wzzzz/battle
