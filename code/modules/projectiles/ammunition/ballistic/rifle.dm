// 7.62 (Nagant Rifle)

/obj/item/ammo_casing/a762
	name = "7.62 гильза"
	desc = "Патрон 7.62."
	icon_state = "762-casing"
	caliber = "a762"
	projectile_type = /obj/projectile/bullet/a762

/obj/item/ammo_casing/a762/enchanted
	projectile_type = /obj/projectile/bullet/a762_enchanted

// 5.56mm (M-90gl Carbine)

/obj/item/ammo_casing/a556
	name = "5.56mm гильза"
	desc = "Патрон 5.56mm."
	caliber = "a556"
	projectile_type = /obj/projectile/bullet/a556

/obj/item/ammo_casing/a556/phasic
	name = "5.56mm фазовая гильза"
	desc = "Патрон 5.56mm фазовый."
	projectile_type = /obj/projectile/bullet/a556/phasic

// 40mm (Grenade Launcher)

/obj/item/ammo_casing/a40mm
	name = "40mm HE гильза"
	desc = "Боевая взрывная граната, которая может быть активирована только после выстрела из гранатомета."
	caliber = "40mm"
	icon_state = "40mmHE"
	projectile_type = /obj/projectile/bullet/a40mm
