/obj/item/ammo_casing/caseless/laser
	name = "laser casing"
	desc = "You shouldn't be seeing this."
	caliber = "laser"
	icon_state = "s-casing-live"
	slot_flags = null
	projectile_type = /obj/projectile/beam
	fire_sound = 'sound/weapons/laser.ogg'
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect/energy

/obj/item/ammo_casing/caseless/laser/gatling
	projectile_type = /obj/projectile/beam/weak/penetrator
	variance = 0.8
	click_cooldown_override = 1

	// Harpoons (Ballistic Harpoon Gun)

/obj/item/ammo_casing/caseless/harpoon
	name = "harpoon"
	caliber = "harpoon"
	icon_state = "magspear"
	projectile_type = /obj/projectile/bullet/harpoon

/obj/item/ammo_casing/caseless/pissball
	name = "стансфера"
	desc = "Приятно щекочет пальцы!"
	caliber = "pissball"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "spark"
	fire_sound = 'sound/weapons/taser.ogg'
	w_class = WEIGHT_CLASS_BULKY
	projectile_type = /obj/projectile/energy/electrode
	custom_materials = null

/obj/item/ammo_casing/caseless/pissball/equipped(mob/living/carbon/user, slot)
	. = ..()
	if(!istype(user.gloves, /obj/item/clothing/gloves/color/yellow))
		user.Paralyze(100)
		playsound(user.loc, 'sound/weapons/taserhit.ogg', 50, TRUE)
		addtimer(CALLBACK(user, /mob/living/carbon.proc/do_jitter_animation, 20), 5)
		visible_message("<span class='warning'><b>[user.name]</b> ловит разряд тока от стансферы!</span>", \
						"<span class='userdanger'>Ай!!!</span>")

/obj/item/ammo_casing/caseless/pissball/examine(mob/user)
	. = ..()
	. -= "<hr><span class='smallnoticeital'>Это [weightclass2text(w_class)] размера предмет.</span>"
