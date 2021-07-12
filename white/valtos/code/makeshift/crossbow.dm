/obj/item/gun/ballistic/crossbow
	name = "арбалет"
	desc = "Мощный арбалет, который умеет стрелять металлическими стержнями. Очень полезен в целях охоты."
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

					user.visible_message("<span class='notice'>[user] аккуратно устанавливает [chambered.BB] в [src].</span>", \
                                         "<span class='notice'>Аккуратно устанавливаю [chambered.BB] в [src].</span>")
		else
			to_chat(user, "<span class='warning'>Стоит натянуть тетиву перед установкой снаряда!</span>")
	else
		to_chat(user, "<span class='warning'>Здесь уже есть [chambered.BB] внутри!<span>")

	update_icon()
	return

/obj/item/gun/ballistic/crossbow/process_chamber(empty_chamber = 0)
	chambered = null
	charge = 0
	update_icon()
	return

/obj/item/gun/ballistic/crossbow/chamber_round(replace_new_round = FALSE)
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

			if (do_after(user, charge_time, 0, timed_action_flags = IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE) && charging)
				charge = charge + 1
				charging = FALSE
				var/draw = "немножечко"

				if (charge > 2)
					draw = "на максимум"
				else if (charge > 1)
					draw = "дальше"
				user.visible_message("<span class='notice'>[user] натягивает тетиву [draw].</span>", \
	                                     "<span class='notice'>Натягиваю тетиву [draw].</span>")
			else
				charging = FALSE
		else
			to_chat(user, "<span class='warning'>Тетива натянута, милорд!</span>")
	else
		user.visible_message("<span class='notice'>[user] достаёт [chambered.BB] из [src].</span>", \
							"<span class='notice'>Достаю [chambered.BB] из [src].</span>")
		user.put_in_hands(new /obj/item/stack/rods)
		chambered = null
		playsound(user, insert_sound, 50, 1)
	update_icon()
	charging = FALSE
	return

/obj/item/gun/ballistic/crossbow/examine(mob/user)
	..()
	var/bowstring = "Тетива "
	if (charge > 2)
		bowstring = bowstring + "в полной боевой готовности"
	else if (charge > 1)
		bowstring = bowstring + "натянута на половину"
	else if (charge > 0)
		bowstring = bowstring + "слабо натянута"
	else
		bowstring = bowstring + "в покое"
	to_chat(user, "[bowstring][charge > 2 ? "!" : "."]")

	if (chambered?.BB)
		to_chat(user, "[capitalize(chambered.BB)] установлен.")

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
	name = "импровизированный арбалет"
	desc = "Арбалет собранный из хлама, вероятнее всего не сможет навредить кому-то."
	icon_state = "crossbow_body_improv"
	inhand_icon_state = "crossbow_body_improv"
	charge_time = 20

/datum/crafting_recipe/crossbow_improv
	name = "Импровизированный арбалет"
	result = /obj/item/gun/ballistic/crossbow/improv
	reqs = list(/obj/item/stack/rods = 3,
		        /obj/item/stack/cable_coil = 10,
		        /obj/item/weaponcrafting/stock = 1)
	tool_paths = list(/obj/item/weldingtool,
		         /obj/item/screwdriver)
	time = 150
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/obj/projectile/rod
	name = "металлический стержень"
	icon = 'white/valtos/icons/crossbow.dmi'
	icon_state = "rod_proj"
	suppressed = TRUE
	damage = 15 // multiply by how drawn the bow string is
	range = 10 // also multiply by the bow string
	damage_type = BRUTE
	flag = "bullet"
	hitsound = null // We use our own for different circumstances
	var/impale_sound = 'white/valtos/sounds/rodgun_pierce.ogg'
	var/hitsound_override = 'sound/weapons/pierce.ogg'
	var/charge = 0 // How much power is in the bolt, transferred from the crossbow

/obj/projectile/rod/on_range()
	// we didn't hit anything, place a rod here
	new /obj/item/bent_rod(get_turf(src))
	..()

/obj/projectile/rod/proc/Impale(mob/living/carbon/human/H)
	if (H)
		var/hit_zone = H.check_limb_hit(def_zone)
		var/obj/item/bodypart/BP = H.get_bodypart(hit_zone)
		var/obj/item/bent_rod/R = new(H.loc, 1, FALSE)

		if (istype(BP))
			R.add_blood_DNA(H.return_blood_DNA())
			R.forceMove(H)
			BP.embedded_objects += R
			H.update_damage_overlays()
			visible_message("<span class='warning'><b>[capitalize(R.name)]</b> проникает в [ru_parse_zone(BP)] <b>[H]</b>!</span>",
							"<span class='userdanger'>Ох! <b>[capitalize(R.name)]</b> проникает в <b>[ru_parse_zone(BP)]</b>!</span>")
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
			new /obj/item/bent_rod(get_turf(src))
	else
		playsound(target, hitsound_override, volume, 1, -1)
		new /obj/item/bent_rod(get_turf(src))
	qdel(src)

/obj/item/ammo_casing/rod
	projectile_type = /obj/projectile/rod

/obj/item/bent_rod
	name = "погнутый металлический стержень"
	desc = "Надо-бы выгнуть."
	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "rods-1"
	custom_materials = list(/datum/material/iron = 1000)

/obj/item/bent_rod/attack_self(mob/user)
	. = ..()
	new /obj/item/stack/rods(get_turf(user))
	qdel(src)
