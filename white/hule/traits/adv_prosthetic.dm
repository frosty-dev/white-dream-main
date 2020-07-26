/datum/quirk/augmented
	name = "Аугментированный"
	desc = "Вы заменили одну из своих рук на новейший протез!"
	value = 2
	var/slot_string = "limb"
	medical_record_text = "Во время физического обследования у пациента был обнаружен протез."

/datum/quirk/augmented/on_spawn()
	var/limb_slot = pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/bodypart/old_part = H.get_bodypart(limb_slot)
	var/obj/item/bodypart/prosthetic
	switch(limb_slot)
		if(BODY_ZONE_L_ARM)
			prosthetic = new/obj/item/bodypart/l_arm/robot(quirk_holder)
			slot_string = "левая рука"
		if(BODY_ZONE_R_ARM)
			prosthetic = new/obj/item/bodypart/r_arm/robot(quirk_holder)
			slot_string = "правая рука"
	prosthetic.replace_limb(H)
	qdel(old_part)
	H.regenerate_icons()
