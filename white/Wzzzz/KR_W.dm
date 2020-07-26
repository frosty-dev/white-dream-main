/obj/item/gun/ballistic/automatic/mg34
	name = "MG-34"
	desc = "German light machinegun chambered in 7.92x57mm Mauser ammunition. An utterly devastating support weapon."
	icon_state = "mg34"
	inhand_icon_state = "mg34"
	w_class = WEIGHT_CLASS_HUGE
	force = 10
	slot_flags = SLOT_BACK
	magazine_type = /obj/item/ammo_magazine/a762
	allowed_magazines = /obj/item/ammo_magazine/a762
	unload_sound 	= 'sound/weapons/guns/interact/lmg_magout.ogg'
	reload_sound 	= 'sound/weapons/guns/interact/lmg_magin.ogg'
	fire_sound = 'sound/weapons/guns/fire/lmg_fire.ogg'

	firemodes = list(
		list(mode_name="short bursts",	burst=5, move_delay=6, dispersion = list(0.6, 1.0, 1.0, 1.0, 1.2)),
		list(mode_name="long bursts",	burst=8, move_delay=8, dispersion = list(1.0, 1.0, 1.0, 1.0, 1.2)),
		)

	var/cover_open = FALSE

/obj/item/gun/ballistic/automatic/mg34/special_check(mob/user)
	if(cover_open)
		to_chat(user, "<span class='warning'>[src]'s cover is open! Close it before firing!</span>")
		return FALSE
	return ..()

/obj/item/gun/ballistic/automatic/mg34/proc/toggle_cover(mob/user)
	cover_open = !cover_open
	to_chat(user, "<span class='notice'>You [cover_open ? "open" : "close"] [src]'s cover.</span>")
	update_icon()

/obj/item/gun/ballistic/automatic/mg34/attack_self(mob/user as mob)
	if(cover_open)
		toggle_cover(user) //close the cover
		playsound(loc, 'sound/weapons/guns/interact/lmg_close.ogg', 100, TRUE)
	else
		return ..() //once closed, behave like normal

/obj/item/gun/ballistic/automatic/mg34/attack_hand(mob/user as mob)
	if(!cover_open && user.get_inactive_hand() == src)
		toggle_cover(user) //open the cover
		playsound(loc, 'sound/weapons/guns/interact/lmg_open.ogg', 100, TRUE)
	else
		return ..() //once open, behave like normal

/obj/item/gun/ballistic/automatic/mg34/load_ammo(var/obj/item/A, mob/user)
	if(!cover_open)
		to_chat(user, "<span class='warning'>You need to open the cover to load [src].</span>")
		return
	..()

/obj/item/gun/ballistic/automatic/mg34/unload_ammo(mob/user, var/allow_dump=1)
	if(!cover_open)
		to_chat(user, "<span class='warning'>You need to open the cover to unload [src].</span>")
		return
	..()


/obj/item/ammo_magazine/luger
	name = "Luger magazine"
	icon_state = "lugermag"
	origin_tech = "combat=2"
	mag_type = MAGAZINE
	matter = list(DEFAULT_WALL_MATERIAL = 600)
	ammo_type = /obj/item/ammo_casing/c9mm
	max_ammo = 8
	multiple_sprites = TRUE

/obj/item/ammo_magazine/luger/flash
	name = "Luger magazine (9mm flash)"
	ammo_type = /obj/item/ammo_casing/c9mm/flash

/obj/item/ammo_magazine/luger/rubber
	name = "Luger magazine (9mm rubber)"
	ammo_type = /obj/item/ammo_casing/c9mm/rubber

/obj/item/ammo_magazine/luger/practice
	name = "Luger magazine (9mm practice)"
	ammo_type = /obj/item/ammo_casing/c9mm/practice

/obj/item/ammo_magazine/mauser
	name = "C96 magazine"
	icon_state = "7.63x25m"
	origin_tech = "combat=2"
	mag_type = MAGAZINE
	matter = list(DEFAULT_WALL_MATERIAL = 600)
	ammo_type = /obj/item/ammo_casing/c9mm
	max_ammo = 8
	multiple_sprites = TRUE

/obj/item/ammo_magazine/mauser/flash
	name = "C96 magazine (9mm flash)"
	ammo_type = /obj/item/ammo_casing/c9mm/flash

/obj/item/ammo_magazine/mauser/rubber
	name = "C96 magazine (9mm rubber)"
	ammo_type = /obj/item/ammo_casing/c9mm/rubber

/obj/item/ammo_magazine/mauser/practice
	name = "C96 magazine (9mm practice)"
	ammo_type = /obj/item/ammo_casing/c9mm/practice
