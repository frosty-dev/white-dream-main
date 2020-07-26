/obj/item/gun/ballistic/automatic/pistol/wzzzz/mauser
	name = "Mauser C96"
	desc = "German 10mm pistol. Still da, ihr Redner! Du hast das Wort, rede, Genosse Mauser!"
	icon = 'white/Wzzzz/icons/Weea.dmi'
	icon_state = "mauser"
	w_class = WEIGHT_CLASS_SMALL
	fire_sound = 'white/Wzzzz/Gunshot_light.ogg'
	mag_type = /obj/item/ammo_box/magazine/wzzzz/mauser/battle
	can_suppress = FALSE
	slot_flags = ITEM_SLOT_BELT


/obj/item/ammo_box/magazine/wzzzz/mauser
	name = "Mauser magazine"
	desc = "A mauser magazine."
	icon = 'white/Wzzzz/icons/ammo.dmi'
	icon_state = "meow"
	inhand_icon_state = "meow"
	caliber = "10mm"
	ammo_type = /obj/item/ammo_casing/wzzzz/mauser
	max_ammo = 10

/obj/item/ammo_box/magazine/wzzzz/mauser/battle
	name = "Mauser magazine (10mm battle)"
	ammo_type = /obj/item/ammo_casing/wzzzz/mauserb


/obj/item/ammo_box/magazine/wzzzz/mauser/rubber
	name = "Mauser magazine (10mm rubber)"
	ammo_type = /obj/item/ammo_casing/wzzzz/mauser

/obj/projectile/bullet/pistol/wzzzz/rubberma
	name = "rubber bullet"
	damage = 7
	stamina = 30

/obj/projectile/bullet/pistol/wzzzz/battle
	name = "10mm bullet"
	damage = 23
	armour_penetration = 15

/obj/item/ammo_casing/wzzzz/mauser
	name = "10mm bullet casing."
	desc = "A 10mm bullet casing."
	caliber = "10mm"
	projectile_type = /obj/projectile/bullet/pistol/wzzzz/rubberma

/obj/item/ammo_casing/wzzzz/mauserb
	name = "10mm bullet casing."
	desc = "A 10mm bullet casing."
	caliber = "10mm"
	projectile_type = /obj/projectile/bullet/pistol/wzzzz/battle
