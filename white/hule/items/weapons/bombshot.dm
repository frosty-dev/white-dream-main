/obj/item/ammo_casing/shotgun/bombslug
	name = "FRAGZ-5-10-15 slug"
	desc = "A highly explosive round for a 12 gauge shotgun."
	icon = 'white/hule/icons/obj/weapons.dmi'
	icon_state = "bombslug"
	projectile_type = /obj/projectile/bullet/shotgun_bombslug

/obj/projectile/bullet/shotgun_bombslug
	name ="FRAGZ-5-10-15 slug"
	icon_state = "missile"
	damage = 25
	knockdown = 50

/obj/projectile/bullet/shotgun_bombslug/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, 5, 10, 15)
	return TRUE
