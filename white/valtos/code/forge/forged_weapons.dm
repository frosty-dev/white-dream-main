/obj/item/forged
	icon = 'white/valtos/icons/forge/forged_weapons.dmi'
	lefthand_file = 'white/valtos/icons/forge/lefthand.dmi'
	righthand_file = 'white/valtos/icons/forge/righthand.dmi'
	var/datum/reagent/reagent_type
	var/weapon_type
	var/identifier = FORGED_MELEE_SINGLEHANDED
	var/stabby = 0
	var/speed = CLICK_CD_MELEE
	var/list/special_traits
	var/radioactive = FALSE
	var/fire = FALSE


/obj/item/forged/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()


/obj/item/forged/process()
	if(prob(50) && radioactive)
		radiation_pulse(src, 200, 0.5)
	if(fire)
		open_flame()


/obj/item/forged/proc/assign_properties()
	if(reagent_type && weapon_type)
		special_traits = list()
		name = name += " ([reagent_type.name])"
		color = reagent_type.color
		force = max(0.1, (reagent_type.density * weapon_type))
		throwforce = force
		speed = max(CLICK_CD_RAPID, (reagent_type.density * weapon_type))
		for(var/I in reagent_type.special_traits)
			var/datum/special_trait/S = new I
			LAZYADD(special_traits, S)
			S.on_apply(src, identifier)
		armour_penetration += force * 0.2

/obj/item/forged/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	user.changeNext_move(speed)
	if(iscarbon(target) && reagent_type && proximity_flag)
		var/mob/living/carbon/C = target
		var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
		var/armour_block = C.getarmor(affecting, "melee") * 0.01
		if(!armour_block)
			armour_block = 1
		C.reagents.add_reagent(reagent_type.type, max(0, (0.2 * stabby) * max(1, armour_block - armour_penetration)))
		if(stabby < 1 && stabby > 0)
			reagent_type.expose_mob(C, TOUCH, max(0, 1 / stabby))
	if(proximity_flag && reagent_type)
		for(var/I in special_traits)
			var/datum/special_trait/A = I
			if(prob(A.effectiveness))
				A.on_hit(target, user, src, FORGED_MELEE_SINGLEHANDED)
	..()

/obj/item/forged/melee/dagger
	name = "forged dagger"
	desc = "A custom dagger forged from solid ingots"
	icon_state = "forged_knife"
	inhand_icon_state = "forged_dagger"
	hitsound = 'white/valtos/sounds/forge/knife.ogg'
	weapon_type = MELEE_TYPE_DAGGER
	stabby = TRANSFER_SHARP
	w_class = WEIGHT_CLASS_SMALL
	sharpness = IS_SHARP_ACCURATE
	attack_verb = list("тычет", "протыкает", "втыкает", "нанизывает", "гопстопает", "пробивает")


/obj/item/forged/melee/sword
	name = "forged sword"
	desc = "A custom sword forged from solid ingots"
	icon_state = "forged_sword"
	inhand_icon_state = "forged_sword"
	worn_icon = 'white/valtos/icons/forge/belt.dmi'
	slot_flags = ITEM_SLOT_BELT
	hitsound = 'sound/weapons/rapierhit.ogg'
	weapon_type = MELEE_TYPE_SWORD
	stabby = TRANSFER_SHARPER
	w_class = WEIGHT_CLASS_BULKY
	sharpness = IS_SHARP
	attack_verb = list("рубит", "режет", "втыкает", "нарезает", "нарезает", "пробивает")


/obj/item/forged/melee/mace
	name = "forged mace"
	desc = "A custom mace forged from solid ingots"
	icon_state = "forged_mace"
	inhand_icon_state = "forged_mace"
	worn_icon = 'white/valtos/icons/forge/belt.dmi'
	slot_flags = ITEM_SLOT_BELT
	hitsound = 'white/valtos/sounds/forge/crunch.ogg'
	weapon_type = MELEE_TYPE_MACE
	stabby = TRANSFER_PARTIALLY_BLUNT
	w_class = WEIGHT_CLASS_BULKY
	sharpness = IS_BLUNT
	attack_verb = list("бьёт", "ударяет")
	armour_penetration = 5

/obj/item/forged/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()


/obj/item/forged/process()
	if(prob(50) && radioactive)
		radiation_pulse(src, 200, 0.5)
	if(fire)
		open_flame()

/obj/item/forged/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	user.changeNext_move(speed)
	if(iscarbon(target) && reagent_type && proximity_flag)
		var/mob/living/carbon/C = target
		var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
		var/armour_block = C.getarmor(affecting, "melee") * 0.01
		if(!armour_block)
			armour_block = 1
		C.reagents.add_reagent(reagent_type.type, max(0, (0.2 * stabby) * max(1, armour_block - armour_penetration)))
		if(stabby < 1 && stabby > 0)
			reagent_type.expose_mob(C, TOUCH, max(0, 1 / stabby))
	if(proximity_flag && reagent_type)
		for(var/I in special_traits)
			var/datum/special_trait/A = I
			if(prob(A.effectiveness))
				A.on_hit(target, user, src, FORGED_MELEE_TWOHANDED)
	..()

/obj/item/forged/greatsword
	name = "forged greatsword"
	desc = "A custom greatsword forged from solid ingots"
	icon_state = "forged_greatsword"
	lefthand_file = 'white/valtos/icons/forge/64x64_lefthand.dmi'
	righthand_file = 'white/valtos/icons/forge/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	hitsound = 'sound/weapons/slash.ogg'
	weapon_type = MELEE_TYPE_GREATSWORD
	stabby = TRANSFER_SHARPEST
	w_class = WEIGHT_CLASS_HUGE
	sharpness = IS_SHARP
	attack_verb = list("нанизывает", "пробивает", "втыкает", "рубит", "кромсает", "протыкает")


/obj/item/forged/greatsword/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	..()
	if(iscarbon(user) && proximity_flag)
		var/mob/living/carbon/CU = user
		CU.adjustStaminaLoss(10)


/obj/item/forged/warhammer
	name = "forged warhammer"
	desc = "A custom warhammer forged from solid ingots"
	icon_state = "forged_hammer0"
	worn_icon = 'white/valtos/icons/forge/back.dmi'
	slot_flags = ITEM_SLOT_BACK
	hitsound = 'white/valtos/sounds/forge/crunch.ogg'
	weapon_type = MELEE_TYPE_WARHAMMER
	stabby = TRANSFER_BLUNT
	w_class = WEIGHT_CLASS_HUGE
	sharpness = IS_BLUNT
	attack_verb = list("уничтожает", "молотит", "ударяет", "долбит", "разбивает")
	armour_penetration = 10

/obj/item/forged/warhammer/update_icon()
	icon_state = "forged_hammer_1"
	return

/obj/item/forged/warhammer/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	..()
	if(iscarbon(user) && proximity_flag && target)
		var/mob/living/carbon/CU = user
		CU.adjustStaminaLoss(15)

	if(iswallturf(target) && proximity_flag)
		var/turf/closed/wall/W = target
		var/chance = (W.hardness * 0.5)//>lower hardness = stronger wall
		if(chance < 10)
			return FALSE

		if(prob(chance))
			playsound(src, 'sound/effects/meteorimpact.ogg', 100, 1)
			W.dismantle_wall(TRUE)

		else
			playsound(src, 'sound/effects/bang.ogg', 50, 1)
			W.add_dent(WALL_DENT_HIT)
			visible_message("<span class='danger'>[user] has smashed [W] with [src]!</span>", null, COMBAT_MESSAGE_RANGE)
	return TRUE


/obj/projectile/bullet/forged
	damage = 0
	hitsound_wall = "ricochet"
	impact_effect_type = /obj/effect/temp_visual/impact_effect
	var/datum/reagent/reagent_type
	var/identifier = FORGED_BULLET_CASING
	speed = 0.8
	var/list/special_traits
	var/radioactive = FALSE
	var/fire = FALSE


/obj/projectile/bullet/forged/proc/assign_properties(datum/reagent/reagent_type, caliber_multiplier)
	if(reagent_type)
		special_traits = list()
		name = name += " ([reagent_type.name])"
		color = reagent_type.color
		damage = max(0.1, (reagent_type.density * 0.8 * caliber_multiplier))
		speed = max(0, reagent_type.density / 2.5)
		for(var/I in reagent_type.special_traits)
			var/datum/special_trait/S = new I
			LAZYADD(special_traits, S)
			S.on_apply(src, identifier)


/obj/projectile/bullet/forged/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(reagent_type)
		for(var/I in special_traits)
			var/datum/special_trait/A = I
			if(prob(A.effectiveness))
				A.on_hit(target, I = src, type = identifier)
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		var/limb_hit =  C.check_limb_hit(def_zone)
		var/armour_block = C.getarmor(limb_hit, "bullet") * 0.01
		if(!armour_block)
			armour_block = 1
		C.reagents.add_reagent(reagent_type.type, max(0, 1 * max(1, armour_block - armour_penetration)))
		reagent_type.expose_mob(C, TOUCH, 1)



/obj/projectile/bullet/forged/Move()
	. = ..()
	if(!QDELETED(src))
		for(var/I in special_traits)
			var/datum/special_trait/A = I
			if(prob(A.effectiveness))
				A.on_hit(I = src, type = identifier)

		if(radioactive)
			radiation_pulse(src, 300)

		var/turf/location = get_turf(src)
		if(location && reagent_type)
			reagent_type.expose_turf(location, 1)


/obj/item/ammo_casing/forged
	name = "forged bullet casing"
	desc = "A custom bullet casing designed to be quickly changeable to any caliber"
	projectile_type = /obj/projectile/bullet/forged
	var/datum/reagent/reagent_type
	var/static/list/calibers = list("357" = 4.5, "a762" = 5, "n762" = 5, ".50" = 6, "38" = 1.5, "10mm" = 3, "9mm" = 2, "4.6x30mm" = 2, ".45" = 2.5, "a556" = 3.5, "mm195129" = 4.5)


/obj/item/ammo_casing/forged/proc/assign_properties()//placeholder proc to prevent runtimes, this SHOULD be the only exception to the rule
	if(reagent_type)
		name = "([reagent_type.name]-[caliber] bullet casing)"
	return


/obj/item/ammo_casing/forged/attack_self(mob/user)
	..()
	if(!caliber)
		caliber = input("Shape the bullet to which caliber? (You may only do this once!)", "Transform", caliber) as null|anything in calibers
		if(BB)
			var/obj/projectile/bullet/forged/FF = BB
			FF.reagent_type = reagent_type
			FF.assign_properties(reagent_type, calibers[caliber])
			desc = "A custom [caliber] bullet casing"
