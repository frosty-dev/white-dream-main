//Augmented Eyesight: Gives you X-ray vision or protection from flashes. Also, high DNA cost because of how powerful it is.
//Possible todo: make a custom message for directing a penlight/flashlight at the eyes - not sure what would display though.

/datum/action/changeling/augmented_eyesight
	name = "Расширенное зрение"
	desc = "Создает больше светочувствительных стержней в наших глазах, позволяя нашему зрению проникать через большинство твёрдых объектов. Защищает наше зрение от вспышек, когда неактивен."
	helptext = "Дает нам рентгеновское зрение или защиту от вспышек. Мы станем намного более уязвимыми для устройств на основе вспышки, когда рентгеновское зрение активно."
	button_icon_state = "augmented_eyesight"
	chemical_cost = 0
	dna_cost = 2 //Would be 1 without thermal vision
	active = FALSE

/datum/action/changeling/augmented_eyesight/on_purchase(mob/user) //The ability starts inactive, so we should be protected from flashes.
	..()
	var/obj/item/organ/eyes/E = user.getorganslot(ORGAN_SLOT_EYES)
	if (E)
		E.flash_protect = FLASH_PROTECTION_WELDER //Adjust the user's eyes' flash protection
		to_chat(user, "Мы настраиваем наши глаза, чтобы защитить их от яркого света.")
	else
		to_chat(user, "Мы не можем настроить наши глаза, если у нас их нет!")

/datum/action/changeling/augmented_eyesight/sting_action(mob/living/carbon/user)
	if(!istype(user))
		return
	..()
	var/obj/item/organ/eyes/E = user.getorganslot(ORGAN_SLOT_EYES)
	if(E)
		if(!active)
			E.sight_flags |= SEE_MOBS | SEE_OBJS | SEE_TURFS //Add sight flags to the user's eyes
			E.flash_protect = FLASH_PROTECTION_SENSITIVE //Adjust the user's eyes' flash protection
			to_chat(user, "Мы настраиваем наши глаза, чтобы чувствовать добычу сквозь стены.")
			active = TRUE //Defined in code/modules/spells/spell.dm
		else
			E.sight_flags ^= SEE_MOBS | SEE_OBJS | SEE_TURFS //Remove sight flags from the user's eyes
			E.flash_protect = FLASH_PROTECTION_WELDER //Adjust the user's eyes' flash protection
			to_chat(user, "Мы настраиваем наши глаза, чтобы защитить их от яркого света.")
			active = FALSE
		user.update_sight()
	else
		to_chat(user, "Мы не можем настроить наши глаза, если у нас их нет!")
	return 1


/datum/action/changeling/augmented_eyesight/Remove(mob/user) //Get rid of x-ray vision and flash protection when the user refunds this ability
	var/obj/item/organ/eyes/E = user.getorganslot(ORGAN_SLOT_EYES)
	if(E)
		if (active)
			E.sight_flags ^= SEE_MOBS | SEE_OBJS | SEE_TURFS
		else
			E.flash_protect = FLASH_PROTECTION_NONE
		user.update_sight()
	..()
