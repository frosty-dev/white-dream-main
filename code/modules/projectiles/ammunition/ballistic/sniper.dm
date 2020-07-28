// .50 (Sniper)

/obj/item/ammo_casing/p50
	name = ".50 гильза"
	desc = "Патрон .50"
	caliber = ".50"
	projectile_type = /obj/projectile/bullet/p50
	icon_state = ".50"

/obj/item/ammo_casing/p50/soporific
	name = ".50 усыпляющая гильза"
	desc = "Патрон .50 специализирующийся на отправке цели в сон, а не в ад."
	projectile_type = /obj/projectile/bullet/p50/soporific
	icon_state = "sleeper"
	harmful = FALSE

/obj/item/ammo_casing/p50/penetrator
	name = ".50 бронебойная гильза"
	desc = "Патрон .50 бронебойный."
	projectile_type = /obj/projectile/bullet/p50/penetrator
