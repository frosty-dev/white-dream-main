//=========limbs
/obj/item/bodypart/chest/loly
	icon = 'lol_parts.dmi'
	icon_state = "chest"
	skin_tone = "caucasian1"
	var/id = "loly_chest"
	name = "loly`s chest"
	desc = "Mmm..."
/obj/item/bodypart/head/loly
	icon = 'lol_parts.dmi'
	icon_state = "head"
	var/id = "loly_head"
	skin_tone = "caucasian1"
	name = "loly`s head"
	desc = "Mmm..."
/obj/item/bodypart/l_arm/loly
	icon = 'lol_parts.dmi'
	icon_state = "l_arm"
	skin_tone = "caucasian1"
	var/id = "loly_l_arm"
	name = "loly`s left arm"
	desc = "Mmm..."
/obj/item/bodypart/r_arm/loly
	icon = 'lol_parts.dmi'
	icon_state = "r_arm"
	skin_tone = "caucasian1"
	var/id = "loly_r_arm"
	name = "loly`s right arm"
	desc = "Mmm..."
/obj/item/bodypart/r_leg/loly
	icon = 'lol_parts.dmi'
	icon_state = "r_leg"
	skin_tone = "caucasian1"
	var/id = "loly_r_leg"
	name = "loly`s right leg"
	desc = "Mmm..."
/obj/item/bodypart/l_leg/loly
	icon = 'lol_parts.dmi'
	icon_state = "l_leg"
	skin_tone = "caucasian1"
	var/id = "loly_l_leg"
	name = "loly`s left leg"
	desc = "Mmm..."
//===============

/mob/living/carbon/human/species/loly
	race = /datum/species/loly

/mob/living/carbon/human/species/loly/Life()
	listclearnulls(hand_bodyparts)
	..()
	listclearnulls(hand_bodyparts)

/proc/pisk()
	set name = "squeak"
	set category = "IC"
	playsound(get_turf(usr), 'pisk.ogg', 50, 10)

/datum/species/loly
	name = "Loly"
	id = "loly"
	limbs_id = "loly"

	changesource_flags = MIRROR_BADMIN

	mutant_bodyparts = list(/obj/item/bodypart/chest/loly, /obj/item/bodypart/head/loly, /obj/item/bodypart/l_arm/loly, /obj/item/bodypart/r_arm/loly, /obj/item/bodypart/r_leg/loly, /obj/item/bodypart/l_leg/loly)

	var/list/hand_mutaparts = list(/obj/item/bodypart/l_arm/loly, /obj/item/bodypart/r_arm/loly)

/mob/living/carbon/human/species/loly/proc/on_species_gain(mob/living/carbon/human/C, datum/species/old_species, replace_current = TRUE)
	for(var/obj/item/bodypart/i in C.bodyparts)
		QDEL_NULL(i)

	//C.bodyparts = mutant_bodyparts
	//C.hand_bodyparts = hand_mutaparts

	C.icon = 'human_3.dmi'//'loly.dmi'
	C.icon_state = "loly1"
	C.real_name = "Loly"
	C.name = "Loly"
	C.icon_render_key = null
	C.underwear = "Nude"
	C.undershirt = "Nude"
	C.socks = "Nude"
	C.verbs += /proc/pisk

	C.create_bodyparts()
	C.create_internal_organs()
	C.update_body()

	//listclearnulls(hand_bodyparts)
