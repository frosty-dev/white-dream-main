#define DUALWIELD_PENALTY_EXTRA_MULTIPLIER 1.
/obj/item/ammo_box/magazine/m10mm/i_dont_know_how_the_fuck_i_can_do_that_in_another_way // just ignore this, for god's sake
	max_ammo = 4000 //this too
// you would ask me - "what the fuck is this shit". it's just a fix for a bug with non-existing bullet after shot
// please, just ignore it. think it about something that just should exist and not should be changed


/obj/item/gun/ballistic/duck_game
	icon = 'white/ClickerOfThings/duckgame_weapon/dg_weapons_icons.dmi'
	icon_state = "duel"
	inhand_icon_state = "duel"
	var/deletable = FALSE
	var/bullets = 0
	mag_type = /obj/item/ammo_box/magazine/m10mm/i_dont_know_how_the_fuck_i_can_do_that_in_another_way

/obj/item/gun/ballistic/duck_game/proc/CheckDestroy()
	if (deletable)
		qdel(src)


// get rid of useless shit that breaks weapon

/obj/item/gun/ballistic/duck_game/attackby(obj/item/A, mob/user, params)
	return

/obj/item/gun/ballistic/duck_game/attack_self(mob/living/user)
	return

// end of "// get rid of useless shit that breaks weapon"


/obj/item/gun/ballistic/duck_game/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	CheckDestroy()
	..()

/obj/item/gun/ballistic/duck_game/shoot_with_empty_chamber(mob/living/user as mob|obj)
	to_chat(user, "<span class='danger'>*click*<br>Shit, it's empty.</span>")
	playsound(src, dry_fire_sound, 30, TRUE)

/obj/item/gun/ballistic/duck_game/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	add_fingerprint(user)
	if(semicd)
		return
	var/sprd = 0
	var/randomized_gun_spread = 0
	var/rand_spr = rand()
	if(spread)
		randomized_gun_spread =	rand(0,spread)
	if(HAS_TRAIT(user, TRAIT_POOR_AIM)) //nice shootin' tex
		bonus_spread += 25
	var/randomized_bonus_spread = rand(0, bonus_spread)
	if(burst_size > 1)
		firing_burst = TRUE
		for(var/i = 1 to burst_size)
			addtimer(CALLBACK(src, .proc/process_burst, user, target, message, params, zone_override, sprd, randomized_gun_spread, randomized_bonus_spread, rand_spr, i), fire_delay * (i - 1))
	else
		if(chambered)
			if(HAS_TRAIT(user, TRAIT_PACIFISM)) // If the user has the pacifist trait, then they won't be able to fire [src] if the round chambered inside of [src] is lethal.
				if(chambered.harmful) // Is the bullet chambered harmful?
					to_chat(user, "<span class='notice'> [src] is lethally chambered! You don't want to risk harming anyone...</span>")
					return
			sprd = round((rand() - 0.5) * DUALWIELD_PENALTY_EXTRA_MULTIPLIER * (randomized_gun_spread + randomized_bonus_spread))
			if(!chambered.fire_casing(target, user, params, , suppressed, zone_override, sprd))
				shoot_with_empty_chamber(user)
				return
			else
				if(get_dist(user, target) <= 1) //Making sure whether the target is in vicinity for the pointblank shot
					shoot_live_shot(user, 1, target, message)
				else
					shoot_live_shot(user, 0, target, message)
		else
			shoot_with_empty_chamber(user)
			return
		process_chamber()
		update_icon()
		bullets-=1 // it was all copy-pasted just for this
		semicd = TRUE
		addtimer(CALLBACK(src, .proc/reset_semicd), fire_delay)
	if(user)
		user.update_inv_hands()
	SSblackbox.record_feedback("tally", "gun_fired", 1, type)
	return TRUE

/obj/item/gun/ballistic/duck_game/afterattack(atom/target, mob/living/user, flag, params)
	if (bullets == 0)
		deletable = TRUE
		shoot_with_empty_chamber(user)
		return
	else
		..()

// ---------------------------------------------

// TODO: make more weapons

/obj/item/gun/ballistic/duck_game/dueling
	bullets = 1
	name = "dueling pistol"
	desc = "Small shitty dueling pistol with one bullet."
	icon = 'white/ClickerOfThings/duckgame_weapon/dg_weapons_icons.dmi'
	icon_state = "duel"
	inhand_icon_state = "duel"

/obj/item/gun/ballistic/duck_game/test_weapon
	bullets = 5
	name = "dueling pistol"
	desc = "Test weapon. 5 bullets."
	icon = 'white/ClickerOfThings/duckgame_weapon/dg_weapons_icons.dmi'
	icon_state = "duel"
	inhand_icon_state = "duel"


#undef DUALWIELD_PENALTY_EXTRA_MULTIPLIER
