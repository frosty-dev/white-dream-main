/obj/item/bodypart/head
	name = "голова"
	desc = "Круглая. Можно в футбик погонять."
	icon = 'icons/mob/human_parts.dmi'
	icon_state = "default_human_head"
	max_damage = 200
	body_zone = BODY_ZONE_HEAD
	body_part = HEAD
	w_class = WEIGHT_CLASS_BULKY //Quite a hefty load
	slowdown = 1 //Balancing measure
	throw_range = 2 //No head bowling
	px_x = 0
	px_y = -8
	stam_damage_coeff = 1
	max_stamina_damage = 100
	wound_resistance = 10
	scars_covered_by_clothes = FALSE

	var/mob/living/brain/brainmob = null //The current occupant.
	var/obj/item/organ/brain/brain = null //The brain organ
	var/obj/item/organ/eyes/eyes
	var/obj/item/organ/ears/ears
	var/obj/item/organ/tongue/tongue

	//Limb appearance info:
	var/real_name = "" //Replacement name
	//Hair colour and style
	var/hair_color = "000"
	var/hairstyle = "Bald"
	var/hair_alpha = 255
	//Facial hair colour and style
	var/facial_hair_color = "000"
	var/facial_hairstyle = "Shaved"
	//Eye Colouring

	var/lip_style = null
	var/lip_color = "white"


/obj/item/bodypart/head/Destroy()
	QDEL_NULL(brainmob) //order is sensitive, see warning in handle_atom_del() below
	QDEL_NULL(brain)
	QDEL_NULL(eyes)
	QDEL_NULL(ears)
	QDEL_NULL(tongue)
	return ..()

/obj/item/bodypart/head/handle_atom_del(atom/A)
	if(A == brain)
		brain = null
		update_icon_dropped()
		if(!QDELETED(brainmob)) //this shouldn't happen without badminnery.
			message_admins("Brainmob: ([ADMIN_LOOKUPFLW(brainmob)]) was left stranded in [src] at [ADMIN_VERBOSEJMP(src)] without a brain!")
			log_game("Brainmob: ([key_name(brainmob)]) was left stranded in [src] at [AREACOORD(src)] without a brain!")
	if(A == brainmob)
		brainmob = null
	if(A == eyes)
		eyes = null
		update_icon_dropped()
	if(A == ears)
		ears = null
	if(A == tongue)
		tongue = null
	return ..()

/obj/item/bodypart/head/examine(mob/user)
	. = ..()
	if(status == BODYPART_ORGANIC)
		if(!brain)
			. += "<span class='info'>Здесь нет мозга.</span>"
		else if(brain.suicided || brainmob?.suiciding)
			. += "<span class='info'>Странная гримасса на лице [real_name]; похоже эта голова и правда не любила свою жизнь. Это можно выбросить.</span>"
		else if(brainmob?.health <= HEALTH_THRESHOLD_DEAD)
			. += "<span class='info'>Из этой штуки что-то... вытекает? Похоже мозгу внутри придали неестественную форму.</span>"
		else if(brainmob)
			if(brainmob.get_ghost(FALSE, TRUE))
				. += "<span class='info'>Эта штука немного шевелится... Похоже внутрии неё что-то очень хочет жить.</span>"
			else
				. += "<span class='info'>Эта штука неподвижна. Возможно есть шанс сделать из этого что-то полезное.</span>"
		else if(brain?.decoy_override)
			. += "<span class='info'>Эта штука неподвижна. Возможно есть шанс сделать из этого что-то полезное.</span>"
		else
			. += "<span class='info'>Эта штука неподвижна.</span>"

		if(!eyes)
			. += "<span class='info'>Глаза [real_name] отсутствуют.</span>"

		if(!ears)
			. += "<span class='info'>Уши [real_name] отсутствуют.</span>"

		if(!tongue)
			. += "<span class='info'>Язык [real_name] отсутствует.</span>"


/obj/item/bodypart/head/can_dismember(obj/item/I)
	if(owner && !((owner.stat == DEAD) || owner.InFullCritical()))
		return FALSE
	return ..()

/obj/item/bodypart/head/drop_organs(mob/user, violent_removal)
	var/turf/T = get_turf(src)
	if(status != BODYPART_ROBOTIC)
		playsound(T, 'sound/misc/splort.ogg', 50, TRUE, -1)
	for(var/obj/item/I in src)
		if(I == brain)
			if(user)
				user.visible_message("<span class='warning'>[user] распиливает [src] и вырывает мозг!</span>", "<span class='notice'>Распиливаю [src] и вырываю оттуда мозг.</span>")
			if(brainmob)
				brainmob.container = null
				brainmob.forceMove(brain)
				brain.brainmob = brainmob
				brainmob = null
			if(violent_removal && prob(rand(80, 100))) //ghetto surgery can damage the brain.
				to_chat(user, "<span class='warning'>[brain] был повреждён в процессе!</span>")
				brain.setOrganDamage(brain.maxHealth)
			brain.forceMove(T)
			brain = null
			update_icon_dropped()
		else
			if(istype(I, /obj/item/reagent_containers/pill))
				for(var/datum/action/item_action/hands_free/activate_pill/AP in I.actions)
					qdel(AP)
			I.forceMove(T)
	eyes = null
	ears = null
	tongue = null

/obj/item/bodypart/head/update_limb(dropping_limb, mob/living/carbon/source)
	var/mob/living/carbon/C
	if(source)
		C = source
	else
		C = owner

	real_name = C.real_name
	if(HAS_TRAIT(C, TRAIT_HUSK))
		real_name = "Unknown"
		hairstyle = "Bald"
		facial_hairstyle = "Shaved"
		lip_style = null

	else if(!animal_origin)
		var/mob/living/carbon/human/H = C
		var/datum/species/S = H.dna.species

		//Facial hair
		if(H.facial_hairstyle && (FACEHAIR in S.species_traits))
			facial_hairstyle = H.facial_hairstyle
			if(S.hair_color)
				if(S.hair_color == "mutcolor")
					facial_hair_color = H.dna.features["mcolor"]
				else if(hair_color == "fixedmutcolor")
					facial_hair_color = "#[S.fixed_mut_color]"
				else
					facial_hair_color = S.hair_color
			else
				facial_hair_color = H.facial_hair_color
			hair_alpha = S.hair_alpha
		else
			facial_hairstyle = "Shaved"
			facial_hair_color = "000"
			hair_alpha = 255
		//Hair
		if(H.hairstyle && (HAIR in S.species_traits))
			hairstyle = H.hairstyle
			if(S.hair_color)
				if(S.hair_color == "mutcolor")
					hair_color = H.dna.features["mcolor"]
				else if(hair_color == "fixedmutcolor")
					hair_color = "#[S.fixed_mut_color]"
				else
					hair_color = S.hair_color
			else
				hair_color = H.hair_color
			hair_alpha = S.hair_alpha
		else
			hairstyle = "Bald"
			hair_color = "000"
			hair_alpha = initial(hair_alpha)
		// lipstick
		if(H.lip_style && (LIPS in S.species_traits))
			lip_style = H.lip_style
			lip_color = H.lip_color
		else
			lip_style = null
			lip_color = "white"
	..()

/obj/item/bodypart/head/update_icon_dropped()
	var/list/standing = get_limb_icon(1)
	if(!standing.len)
		icon_state = initial(icon_state)//no overlays found, we default back to initial icon.
		return
	for(var/image/I in standing)
		I.pixel_x = px_x
		I.pixel_y = px_y
	add_overlay(standing)

/obj/item/bodypart/head/get_limb_icon(dropped)
	cut_overlays()
	. = ..()
	if(dropped) //certain overlays only appear when the limb is being detached from its owner.

		if(status != BODYPART_ROBOTIC) //having a robotic head hides certain features.
			//facial hair
			if(facial_hairstyle)
				var/datum/sprite_accessory/S = GLOB.facial_hairstyles_list[facial_hairstyle]
				if(S)
					var/image/facial_overlay = image(S.icon, "[S.icon_state]", -HAIR_LAYER, SOUTH)
					facial_overlay.color = "#" + facial_hair_color
					facial_overlay.alpha = hair_alpha
					. += facial_overlay

			//Applies the debrained overlay if there is no brain
			if(!brain)
				var/image/debrain_overlay = image(layer = -HAIR_LAYER, dir = SOUTH)
				if(animal_origin == ALIEN_BODYPART)
					debrain_overlay.icon = 'icons/mob/animal_parts.dmi'
					debrain_overlay.icon_state = "debrained_alien"
				else if(animal_origin == LARVA_BODYPART)
					debrain_overlay.icon = 'icons/mob/animal_parts.dmi'
					debrain_overlay.icon_state = "debrained_larva"
				else if(!(NOBLOOD in species_flags_list))
					debrain_overlay.icon = 'icons/mob/human_face.dmi'
					debrain_overlay.icon_state = "debrained"
				. += debrain_overlay
			else
				var/datum/sprite_accessory/S2 = GLOB.hairstyles_list[hairstyle]
				if(S2)
					var/image/hair_overlay = image(S2.icon, "[S2.icon_state]", -HAIR_LAYER, SOUTH)
					hair_overlay.color = "#" + hair_color
					hair_overlay.alpha = hair_alpha
					. += hair_overlay


		// lipstick
		if(lip_style)
			var/image/lips_overlay = image('icons/mob/human_face.dmi', "lips_[lip_style]", -BODY_LAYER, SOUTH)
			lips_overlay.color = lip_color
			. += lips_overlay

		// eyes
		var/image/eyes_overlay = image('icons/mob/human_face.dmi', "eyes_missing", -BODY_LAYER, SOUTH)
		. += eyes_overlay
		if(eyes)
			eyes_overlay.icon_state = eyes.eye_icon_state

			if(eyes.eye_color)
				eyes_overlay.color = "#" + eyes.eye_color

/obj/item/bodypart/head/monkey
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "default_monkey_head"
	animal_origin = MONKEY_BODYPART

/obj/item/bodypart/head/alien
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "alien_head"
	px_x = 0
	px_y = 0
	dismemberable = 0
	max_damage = 500
	animal_origin = ALIEN_BODYPART

/obj/item/bodypart/head/devil
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART

/obj/item/bodypart/head/larva
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "larva_head"
	px_x = 0
	px_y = 0
	dismemberable = 0
	max_damage = 50
	animal_origin = LARVA_BODYPART
