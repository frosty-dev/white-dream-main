/obj/item/gun/energy/kinetic_accelerator/super_kinetic_accelerator
	name = "super proto-kinetic accelerator"
	desc = "A self recharging, ranged mining tool that does increased damage in low pressure, now with more mod capacity! But without damage..."
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/decreased_damage)
	max_mod_capacity = 250

	// add here mods that CAN be attached
	var/accept_mods = list(/obj/item/borg/upgrade/modkit/aoe/turfs,
	/obj/item/borg/upgrade/modkit/cooldown,
	/obj/item/borg/upgrade/modkit/range,
	/obj/item/borg/upgrade/modkit/minebot_passthrough,
	/obj/item/borg/upgrade/modkit/trigger_guard,
	/obj/item/borg/upgrade/modkit/chassis_mod,
	/obj/item/borg/upgrade/modkit/chassis_mod/orange,
	/obj/item/borg/upgrade/modkit/tracer,
	/obj/item/borg/upgrade/modkit/tracer/adjustable)

/obj/item/gun/energy/kinetic_accelerator/super_kinetic_accelerator/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/borg/upgrade/modkit))
		var/list/mods_can_be_added = src.accept_mods
		for(var/counter = 1; counter <= mods_can_be_added.len; counter++)
			if(istype(I, mods_can_be_added[counter]) && ispath(mods_can_be_added[counter], I))
				var/obj/item/borg/upgrade/modkit/MK = I
				MK.install(src, user)
				return
		to_chat(user, "<span class='warning'>You can't install that mod!</span>")
		return
	else
		..()

/obj/projectile/kinetic/decreased_damage
	damage = 5

/obj/item/ammo_casing/energy/kinetic/decreased_damage
	projectile_type = /obj/projectile/kinetic
