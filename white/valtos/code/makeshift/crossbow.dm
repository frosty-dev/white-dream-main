/obj/item/gun/ballistic/crossbow
	name = "crossbow"
	desc = "A powerful crossbow, capable of shooting metal rods. Very effective for hunting."
	icon = 'white/valtos/icons/crossbow.dmi'
	icon_state = "crossbow_body"
	inhand_icon_state = "crossbow_body"
	lefthand_file = 'white/valtos/icons/lefthand.dmi'
	righthand_file = 'white/valtos/icons/righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	force = 10
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	fire_sound = 'white/valtos/sounds/rodgun_fire.ogg'
	var/charge = 0
	var/max_charge = 3
	var/charging = FALSE
	var/charge_time = 10
	var/draw_sound = 'sound/weapons/draw_bow.ogg'
	var/insert_sound = 'sound/weapons/magin.ogg'
	weapon_weight = WEAPON_MEDIUM
	spawnwithmagazine = FALSE
	casing_ejector = FALSE

/obj/item/gun/ballistic/crossbow/attackby(obj/item/A, mob/living/user, params)
	if (!chambered)
		if (charge > 0)
			if (istype(A, /obj/item/stack/rods))
				var/obj/item/stack/rods/R = A
				if (R.use(1))
					chambered = new /obj/item/ammo_casing/rod
					var/obj/projectile/rod/PR = chambered.BB

					if (PR)
						PR.range = PR.range * charge
						PR.damage = PR.damage * charge
						PR.charge = charge

					playsound(user, insert_sound, 50, 1)

					user.visible_message("<span class='notice'>[user] carefully places the [chambered.BB] into the [src].</span>", \
                                         "<span class='notice'>You carefully place the [chambered.BB] into the [src].</span>")
		else
			to_chat(user, "<span class='warning'>You need to draw the bow string before loading a bolt!</span>")
	else
		to_chat(user, "<span class='warning'>There's already a [chambered.BB] loaded!<span>")

	update_icon()
	return

/obj/item/gun/ballistic/crossbow/process_chamber(empty_chamber = 0)
	chambered = null
	charge = 0
	update_icon()
	return

/obj/item/gun/ballistic/crossbow/chamber_round()
	return

/obj/item/gun/ballistic/crossbow/can_shoot()
	if (!chambered)
		return

	if (charge <= 0)
		return

	return (chambered.BB ? 1 : 0)

/obj/item/gun/ballistic/crossbow/attack_self(mob/living/user)
	if (!chambered)
		if (charge < 3)
			if (charging)
				return
			charging = TRUE
			playsound(user, draw_sound, 50, 1)

			if (do_after(user, charge_time, 0, user) && charging)
				charge = charge + 1
				charging = FALSE
				var/draw = "a little"

				if (charge > 2)
					draw = "fully"
				else if (charge > 1)
					draw = "further"
				user.visible_message("<span class='notice'>[user] pulls the drawstring back [draw].</span>", \
	                                     "<span class='notice'>You draw the bow string back [draw].</span>")
			else
				charging = FALSE
		else
			to_chat(user, "<span class='warning'>The bow string is fully drawn!</span>")
	else
		user.visible_message("<span class='notice'>[user] removes the [chambered.BB] from the [src].</span>", \
							"<span class='notice'>You remove the [chambered.BB] from the [src].</span>")
		user.put_in_hands(new /obj/item/stack/rods)
		chambered = null
		playsound(user, insert_sound, 50, 1)
	update_icon()
	charging = FALSE
	return

/obj/item/gun/ballistic/crossbow/examine(mob/user)
	..()
	var/bowstring = "The bow string is "
	if (charge > 2)
		bowstring = bowstring + "drawn back fully"
	else if (charge > 1)
		bowstring = bowstring + "drawn back most the way"
	else if (charge > 0)
		bowstring = bowstring + "drawn back a little"
	else
		bowstring = bowstring + "not drawn"
	to_chat(user, "[bowstring][charge > 2 ? "!" : "."]")

	if (chambered?.BB)
		to_chat(user, "A [chambered.BB] is loaded.")

/obj/item/gun/ballistic/crossbow/update_icon()
	..()
	cut_overlays()
	if (charge >= max_charge)
		add_overlay("charge_[max_charge]")
	else if (charge < 1)
		add_overlay("charge_0")
	else
		add_overlay("charge_[charge]")
	if (chambered && charge > 0)
		if (charge >= max_charge)
			add_overlay("rod_[max_charge]")
		else
			add_overlay("rod_[charge]")
	return

/obj/item/gun/ballistic/crossbow/improv
	name = "improvised crossbow"
	desc = "A poorly-built improvised crossbow, probably couldn't even hurt small game."
	icon_state = "crossbow_body_improv"
	inhand_icon_state = "crossbow_body_improv"
	charge_time = 20

/datum/crafting_recipe/crossbow_improv
	name = "Improvised Crossbow"
	result = /obj/item/gun/ballistic/crossbow/improv
	reqs = list(/obj/item/stack/rods = 3,
		        /obj/item/stack/cable_coil = 10,
		        /obj/item/weaponcrafting/stock = 1)
	tools = list(/obj/item/weldingtool,
		         /obj/item/screwdriver)
	time = 150
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/obj/projectile/rod
	name = "metal rod"
	icon = 'white/valtos/icons/crossbow.dmi'
	icon_state = "rod_proj"
	suppressed = TRUE
	damage = 10 // multiply by how drawn the bow string is
	range = 10 // also multiply by the bow string
	damage_type = BRUTE
	flag = "bullet"
	hitsound = null // We use our own for different circumstances
	var/impale_sound = 'white/valtos/sounds/rodgun_pierce.ogg'
	var/hitsound_override = 'sound/weapons/pierce.ogg'
	var/charge = 0 // How much power is in the bolt, transferred from the crossbow

/obj/projectile/rod/on_range()
	// we didn't hit anything, place a rod here
	new /obj/item/stack/rods(get_turf(src))
	..()

/obj/projectile/rod/proc/Impale(mob/living/carbon/human/H)
	if (H)
		var/hit_zone = H.check_limb_hit(def_zone)
		var/obj/item/bodypart/BP = H.get_bodypart(hit_zone)
		var/obj/item/stack/rods/R = new(H.loc, 1, FALSE) // Don't merge

		if (istype(BP))
			R.add_blood_DNA(H.return_blood_DNA())
			R.forceMove(H)
			BP.embedded_objects += R
			H.update_damage_overlays()
			visible_message("<span class='warning'>The [R] has embedded into [H]'s [BP]!</span>",
							"<span class='userdanger'>You feel [R] lodge into your [BP]!</span>")
			playsound(H, impale_sound, 50, 1)
			H.emote("scream")

/obj/projectile/rod/on_hit(atom/target, blocked = FALSE)
	..()
	var/volume = vol_by_damage()
	if (istype(target, /mob))
		playsound(target, impale_sound, volume, 1, -1)
		if (ishuman(target) && charge > 2) // Only fully charged shots can impale
			var/mob/living/carbon/human/H = target
			Impale(H)
		else
			new /obj/item/stack/rods(get_turf(src))
	else
		playsound(target, hitsound_override, volume, 1, -1)
		new /obj/item/stack/rods(get_turf(src))
	qdel(src)

/obj/item/ammo_casing/rod
	projectile_type = /obj/projectile/rod
