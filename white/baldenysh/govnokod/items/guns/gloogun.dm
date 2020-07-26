/obj/item/gun/gloogun
	name = "нитропеническое ружье"
	desc = "Невольно вспоминаешь своего деда глядя на такое."
	fire_sound = 'sound/items/syringeproj.ogg'
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "chemsprayer"
	inhand_icon_state = "chemsprayer"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	automatic = TRUE
	spread = 15
	fire_delay = 0

	var/obj/item/tank/bolon
	var/moles_drawn = 10
	var/debug = TRUE

/obj/item/gun/gloogun/Initialize()
	. = ..()
	chambered = new /obj/item/ammo_casing/gloo(src)

/obj/item/gun/gloogun/can_shoot()
	return bolon

/obj/item/gun/gloogun/process_chamber()
	if(chambered && !chambered.BB && bolon)
		var/datum/gas_mixture/removed = bolon.air_contents.remove(moles_drawn)

		var/co_amount = removed.get_moles(/datum/gas/carbon_dioxide)
		var/o_amount = removed.get_moles(/datum/gas/oxygen)
		var/n_amount = removed.get_moles(/datum/gas/nitrogen)

		var/amount_mul = 0

		if(debug)
			amount_mul = round(min(n_amount/2, o_amount))
			removed.adjust_moles(/datum/gas/nitrogen, -amount_mul*2)
			removed.adjust_moles(/datum/gas/oxygen, -amount_mul)
		else
			amount_mul = round(min(n_amount, o_amount, co_amount/3))
			removed.adjust_moles(/datum/gas/nitrogen, -amount_mul)
			removed.adjust_moles(/datum/gas/oxygen, -amount_mul)
			removed.adjust_moles(/datum/gas/carbon_dioxide, -amount_mul*3)

		bolon.air_contents.merge(removed)

		if(amount_mul)
			chambered.newshot()

			var/obj/projectile/bullet/gloo/GL = chambered.BB
			GL.foam_str = amount_mul

/obj/item/gun/gloogun/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/tank) && !bolon)
		bolon = I
		I.forceMove(src)
		process_chamber()
	..()

/obj/item/gun/gloogun/attack_self(mob/user)
	if(bolon)
		if(user)
			user.put_in_hands(bolon)
		else
			bolon.forceMove(get_turf(src))
		bolon = null
	..()

/*
/obj/item/gun/gloogun/examine(mob/user)
	. = ..()
	if(bolon && get_shot_count())
		. += "<span class=notice>Похоже, синтез пены можно произвести еще [get_shot_count()] раз.</span>"
*/

/obj/item/ammo_casing/gloo
	name = "нитропенический рекомбинатор"
	desc = "прив я умноые слово ааааааааааааааа"
	projectile_type = /obj/projectile/bullet/gloo
	caliber = "gloo"
	icon = 'icons/effects/effects.dmi'
	icon_state = "frozen_smoke_capsule"
	firing_effect_type = null

/obj/projectile/bullet/gloo
	name = "сгусток нитропены"
	damage = 3
	damage_type = STAMINA
	icon = 'icons/effects/effects.dmi'
	icon_state = "frozen_smoke_capsule"

	var/foam_str = 1

/obj/projectile/bullet/gloo/on_hit(atom/target)
	. = ..()

	if(iscarbon(target) || isitem(target))
		var/datum/component/glooed/G = target.GetComponent(/datum/component/glooed)
		if(!G)
			G = target.AddComponent(/datum/component/glooed)
		G.get_glooed(foam_str)

		if(iscarbon(target))
			G.get_glooed_carbon(def_zone)

	else if(isturf(target))
		return //aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa где спрайты
