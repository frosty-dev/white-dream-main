	//armor = list("melee" = 60, "bullet" = 60, "laser" = 50,"energy" = 40, "bomb" = 50, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	//flags_inv = HIDEEARS
	//flags_cover = HEADCOVERSEYES
	//flags_inv = HIDEHAIR


	//armor = list("melee" = 60, "bullet" = 60, "laser" = 50,"energy" = 40, "bomb" = 50, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	//flags_inv = HIDEEARS
	//flags_cover = HEADCOVERSEYES
	//flags_inv = HIDEHAIR


	//armor = list("melee" = 50, "bullet" = 50, "laser" = 40,"energy" = 30, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 40, "acid" = 40)
	//flags_inv = HIDEEARS
	//flags_cover = HEADCOVERSEYES
	//flags_inv = HIDEHAIR

	[bolt_locked ? "_locked" : ""]
	
	obj/item/gun/ballistic/kar98k/update_icon()
	..()
	add_overlay("[icon_state]_open")
	
	mp40,mauser,luger - 9mm
	mg34 - a792x57
	stg - a792x33
	
	
		firemodes = list(
		list(mode_name="single shot",	burst=1, burst_delay=1.5, move_delay=2, dispersion = list(0.6, 1.0, 1.0, 1.0, 1.2)),
		list(mode_name="short bursts",	burst=3, burst_delay=1.5, move_delay=4, dispersion = list(0.6, 1.0, 1.0, 1.0, 1.2)),
		list(mode_name="long bursts",	burst=5, burst_delay=1.5, move_delay=6, dispersion = list(1.0, 1.0, 1.0, 1.0, 1.2)),
		)


/obj/item/gun/ballistic/automatic/mp40/update_icon()
	icon_state = (ammo_magazine)? "mp40" : "mp400"
	wielded_inhand_icon_state = (ammo_magazine)? "mp40-w" : "mp400"
	..()
	
	
	
	var/obj/item/clothing/head/helmet/space/hardsuit/wzzzz/breacher_cheap = null
	
	
	
	
	
	
	
	
	/obj/item/storage/belt/mining/wzzzz/large/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 10
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.max_combined_w_class = 20
	STR.set_holdable(list(
		/obj/item/crowbar,
		/obj/item/screwdriver,
		/obj/item/weldingtool,
		/obj/item/wirecutters,
		/obj/item/wrench,
		/obj/item/multitool,
		/obj/item/flashlight,
		/obj/item/stack/cable_coil,
		/obj/item/analyzer,
		/obj/item/extinguisher/mini,
		/obj/item/radio,
		/obj/item/clothing/gloves,
		/obj/item/resonator,
		/obj/item/mining_scanner,
		/obj/item/pickaxe,
		/obj/item/shovel,
		/obj/item/stack/sheet/animalhide,
		/obj/item/stack/sheet/sinew,
		/obj/item/stack/sheet/bone,
		/obj/item/lighter,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/reagent_containers/food/drinks/bottle,
		/obj/item/stack/medical,
		/obj/item/kitchen/knife,
		/obj/item/reagent_containers/hypospray,
		/obj/item/gps,
		/obj/item/storage/bag/ore,
		/obj/item/survivalcapsule,
		/obj/item/t_scanner/adv_mining_scanner,
		/obj/item/reagent_containers/pill,
		/obj/item/storage/pill_bottle,
		/obj/item/stack/ore,
		/obj/item/reagent_containers/food/drinks,
		/obj/item/organ/regenerative_core,
		/obj/item/wormhole_jaunter,
		/obj/item/storage/bag/plants,
		/obj/item/stack/marker_beacon
		))

	
	
	
	
	
	
	
	
/obj/item/melee/marines/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 30, 95, 5) //fast and effective, but as a sword, it might damage the results.

/obj/item/melee/marines/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(attack_type == PROJECTILE_ATTACK)
		final_block_chance = 0 //Don't bring a sword to a gunfight
	return ..()

/obj/item/melee/marines/on_exit_storage(datum/component/storage/concrete/S)
	var/obj/item/storage/belt/sabre/B = S.real_location()
	if(istype(B))
		playsound(B, 'sound/items/unsheath.ogg', 25, TRUE)

/obj/item/melee/marines/on_enter_storage(datum/component/storage/concrete/S)
	var/obj/item/storage/belt/sabre/B = S.real_location()
	if(istype(B))
		playsound(B, 'sound/items/sheath.ogg', 25, TRUE)

/obj/item/melee/marines/suicide_act(mob/living/user)
	user.visible_message("<span class='suicide'>[user] is trying to cut off all [user.p_their()] limbs with [src]! it looks like [user.p_theyre()] trying to commit suicide!</span>")
	var/i = 0
	ADD_TRAIT(src, TRAIT_NODROP, SABRE_SUICIDE_TRAIT)
	if(iscarbon(user))
		var/mob/living/carbon/Cuser = user
		var/obj/item/bodypart/holding_bodypart = Cuser.get_holding_bodypart_of_item(src)
		var/list/limbs_to_dismember
		var/list/arms = list()
		var/list/legs = list()
		var/obj/item/bodypart/bodypart

		for(bodypart in Cuser.bodyparts)
			if(bodypart == holding_bodypart)
				continue
			if(bodypart.body_part & ARMS)
				arms += bodypart
			else if (bodypart.body_part & LEGS)
				legs += bodypart

		limbs_to_dismember = arms + legs
		if(holding_bodypart)
			limbs_to_dismember += holding_bodypart

		var/speedbase = abs((4 SECONDS) / limbs_to_dismember.len)
		for(bodypart in limbs_to_dismember)
			i++
			addtimer(CALLBACK(src, .proc/suicide_dismember, user, bodypart), speedbase * i)
	addtimer(CALLBACK(src, .proc/manual_suicide, user), (5 SECONDS) * i)
	return MANUAL_SUICIDE

/obj/item/melee/marines/proc/suicide_dismember(mob/living/user, obj/item/bodypart/affecting)
	if(!QDELETED(affecting) && affecting.dismemberable && affecting.owner == user && !QDELETED(user))
		playsound(user, hitsound, 25, TRUE)
		affecting.dismember(BRUTE)
		user.adjustBruteLoss(20)

/obj/item/melee/marines/proc/manual_suicide(mob/living/user, originally_nodropped)
	if(!QDELETED(user))
		user.adjustBruteLoss(200)
		user.death(FALSE)
	REMOVE_TRAIT(src, TRAIT_NODROP, SABRE_SUICIDE_TRAIT)
	
pocket_storage_component_path = /datum/component/storage/concrete/pockets/helmet
	
	
	
desc = "To cut everything."
	
	
	
	
	
	
	
	
	
	
	

	
	
	
	

	
	
	
	
