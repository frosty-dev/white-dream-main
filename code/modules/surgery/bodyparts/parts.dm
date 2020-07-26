
/obj/item/bodypart/chest
	name = "грудь"
	desc = "Неправильно смотреть на чью-то грудь."
	icon_state = "default_human_chest"
	max_damage = 200
	body_zone = BODY_ZONE_CHEST
	body_part = CHEST
	px_x = 0
	px_y = 0
	stam_damage_coeff = 1
	max_stamina_damage = 120
	var/obj/item/cavity_item
	specific_locations = list("груди", "животе", "тазе", "ключице", "нижней части спины")
	wound_resistance = 10

/obj/item/bodypart/chest/can_dismember(obj/item/I)
	if(!((owner.stat == DEAD) || owner.InFullCritical()))
		return FALSE
	return ..()

/obj/item/bodypart/chest/Destroy()
	QDEL_NULL(cavity_item)
	return ..()

/obj/item/bodypart/chest/drop_organs(mob/user, violent_removal)
	if(cavity_item)
		cavity_item.forceMove(drop_location())
		cavity_item = null
	..()

/obj/item/bodypart/chest/monkey
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "default_monkey_chest"
	animal_origin = MONKEY_BODYPART
	wound_resistance = -10

/obj/item/bodypart/chest/alien
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "alien_chest"
	dismemberable = 0
	max_damage = 500
	animal_origin = ALIEN_BODYPART

/obj/item/bodypart/chest/devil
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART

/obj/item/bodypart/chest/larva
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "larva_chest"
	dismemberable = 0
	max_damage = 50
	animal_origin = LARVA_BODYPART

/obj/item/bodypart/l_arm
	name = "левая рука"
	desc = "Этой штукой можно пощекотать свою жопу."
	icon_state = "default_human_l_arm"
	attack_verb = list("slapped", "punched")
	max_damage = 50
	max_stamina_damage = 50
	body_zone = BODY_ZONE_L_ARM
	body_part = ARM_LEFT
	aux_zone = BODY_ZONE_PRECISE_L_HAND
	aux_layer = HANDS_PART_LAYER
	body_damage_coeff = 0.75
	held_index = 1
	px_x = -6
	px_y = 0
	specific_locations = list("левом предплечье", "левом запястье", "левом локте", "левом бицепсе", "левом плече")

/obj/item/bodypart/l_arm/is_disabled()
	if(HAS_TRAIT(owner, TRAIT_PARALYSIS_L_ARM))
		return BODYPART_DISABLED_PARALYSIS
	return ..()

/obj/item/bodypart/l_arm/set_disabled(new_disabled)
	. = ..()
	if(!.)
		return
	if(disabled == BODYPART_DISABLED_DAMAGE)
		if(owner.stat < UNCONSCIOUS)
			owner.emote("scream")
		if(owner.stat < DEAD)
			to_chat(owner, "<span class='userdanger'>Моя [name] сильно повреждена для работы!</span>")
		if(held_index)
			owner.dropItemToGround(owner.get_item_for_held_index(held_index))
	else if(disabled == BODYPART_DISABLED_PARALYSIS)
		if(owner.stat < DEAD)
			to_chat(owner, "<span class='userdanger'>Я не чувствую свою [sklonenie(name, VINITELNI, FEMALE)]!</span>")
			if(held_index)
				owner.dropItemToGround(owner.get_item_for_held_index(held_index))
	if(owner.hud_used)
		var/obj/screen/inventory/hand/L = owner.hud_used.hand_slots["[held_index]"]
		if(L)
			L.update_icon()

/obj/item/bodypart/l_arm/monkey
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "default_monkey_l_arm"
	animal_origin = MONKEY_BODYPART
	wound_resistance = -10
	px_x = -5
	px_y = -3

/obj/item/bodypart/l_arm/alien
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "alien_l_arm"
	px_x = 0
	px_y = 0
	dismemberable = 0
	max_damage = 100
	animal_origin = ALIEN_BODYPART

/obj/item/bodypart/l_arm/devil
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART

/obj/item/bodypart/r_arm
	name = "правая рука"
	desc = "А вот этой вот дрочу."
	icon_state = "default_human_r_arm"
	attack_verb = list("slapped", "punched")
	max_damage = 50
	body_zone = BODY_ZONE_R_ARM
	body_part = ARM_RIGHT
	aux_zone = BODY_ZONE_PRECISE_R_HAND
	aux_layer = HANDS_PART_LAYER
	body_damage_coeff = 0.75
	held_index = 2
	px_x = 6
	px_y = 0
	max_stamina_damage = 50
	specific_locations = list("правом предплечье", "правом запястье", "правом локоте", "правом бицепсе", "правом плече")

/obj/item/bodypart/r_arm/is_disabled()
	if(HAS_TRAIT(owner, TRAIT_PARALYSIS_R_ARM))
		return BODYPART_DISABLED_PARALYSIS
	return ..()

/obj/item/bodypart/r_arm/set_disabled(new_disabled)
	. = ..()
	if(!.)
		return
	if(disabled == BODYPART_DISABLED_DAMAGE)
		if(owner.stat < UNCONSCIOUS)
			owner.emote("scream")
		if(owner.stat < DEAD)
			to_chat(owner, "<span class='userdanger'>Моя [name] сильно повреждена для работы!</span>")
		if(held_index)
			owner.dropItemToGround(owner.get_item_for_held_index(held_index))
	else if(disabled == BODYPART_DISABLED_PARALYSIS)
		if(owner.stat < DEAD)
			to_chat(owner, "<span class='userdanger'>Я не чувствую свою [sklonenie(name, VINITELNI, FEMALE)]!</span>")
			if(held_index)
				owner.dropItemToGround(owner.get_item_for_held_index(held_index))
	if(owner.hud_used)
		var/obj/screen/inventory/hand/R = owner.hud_used.hand_slots["[held_index]"]
		if(R)
			R.update_icon()

/obj/item/bodypart/r_arm/monkey
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "default_monkey_r_arm"
	animal_origin = MONKEY_BODYPART
	wound_resistance = -10
	px_x = 5
	px_y = -3

/obj/item/bodypart/r_arm/alien
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "alien_r_arm"
	px_x = 0
	px_y = 0
	dismemberable = 0
	max_damage = 100
	animal_origin = ALIEN_BODYPART

/obj/item/bodypart/r_arm/devil
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART

/obj/item/bodypart/l_leg
	name = "левая нога"
	desc = "Вставать с этой ноги не круто."
	icon_state = "default_human_l_leg"
	attack_verb = list("kicked", "stomped")
	max_damage = 50
	body_zone = BODY_ZONE_L_LEG
	body_part = LEG_LEFT
	body_damage_coeff = 0.75
	px_x = -2
	px_y = 12
	max_stamina_damage = 50
	specific_locations = list("левом бедре", "внешней левой голени", "верхней левой голени", " левой коленной чашечке", "нижней левой голени")

/obj/item/bodypart/l_leg/is_disabled()
	if(HAS_TRAIT(owner, TRAIT_PARALYSIS_L_LEG))
		return BODYPART_DISABLED_PARALYSIS
	return ..()

/obj/item/bodypart/l_leg/set_disabled(new_disabled)
	. = ..()
	if(!.)
		return
	if(disabled == BODYPART_DISABLED_DAMAGE)
		if(owner.stat < UNCONSCIOUS)
			owner.emote("scream")
		if(owner.stat < DEAD)
			to_chat(owner, "<span class='userdanger'>Моя [name] сильно повреждена для работы!</span>")
	else if(disabled == BODYPART_DISABLED_PARALYSIS)
		if(owner.stat < DEAD)
			to_chat(owner, "<span class='userdanger'>Я не чувствую свою [sklonenie(name, VINITELNI, FEMALE)]!</span>")

/obj/item/bodypart/l_leg/digitigrade
	name = "левая искусственная нога"
	use_digitigrade = FULL_DIGITIGRADE

/obj/item/bodypart/l_leg/monkey
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "default_monkey_l_leg"
	animal_origin = MONKEY_BODYPART
	wound_resistance = -10
	px_y = 4

/obj/item/bodypart/l_leg/alien
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "alien_l_leg"
	px_x = 0
	px_y = 0
	dismemberable = 0
	max_damage = 100
	animal_origin = ALIEN_BODYPART

/obj/item/bodypart/l_leg/devil
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART

/obj/item/bodypart/r_leg
	name = "правая нога"
	desc = "А вот с этой ноги стоит вставать."
	// alternative spellings of 'pokey' are availible
	icon_state = "default_human_r_leg"
	attack_verb = list("kicked", "stomped")
	max_damage = 50
	body_zone = BODY_ZONE_R_LEG
	body_part = LEG_RIGHT
	body_damage_coeff = 0.75
	px_x = 2
	px_y = 12
	max_stamina_damage = 50
	specific_locations = list("правом бедре", "внешней правой голени", "верхней правой голени", " правой коленной чашечке", "нижней правой голени")

/obj/item/bodypart/r_leg/is_disabled()
	if(HAS_TRAIT(owner, TRAIT_PARALYSIS_R_LEG))
		return BODYPART_DISABLED_PARALYSIS
	return ..()

/obj/item/bodypart/r_leg/set_disabled(new_disabled)
	. = ..()
	if(!.)
		return
	if(disabled == BODYPART_DISABLED_DAMAGE)
		if(owner.stat < UNCONSCIOUS)
			owner.emote("scream")
		if(owner.stat < DEAD)
			to_chat(owner, "<span class='userdanger'>Моя [name] сильно повреждена для работы!</span>")
	else if(disabled == BODYPART_DISABLED_PARALYSIS)
		if(owner.stat < DEAD)
			to_chat(owner, "<span class='userdanger'>Я не чувствую свою [sklonenie(name, VINITELNI, FEMALE)]!</span>")

/obj/item/bodypart/r_leg/digitigrade
	name = "правая искусственная нога"
	use_digitigrade = FULL_DIGITIGRADE

/obj/item/bodypart/r_leg/monkey
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "default_monkey_r_leg"
	animal_origin = MONKEY_BODYPART
	wound_resistance = -10
	px_y = 4

/obj/item/bodypart/r_leg/alien
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "alien_r_leg"
	px_x = 0
	px_y = 0
	dismemberable = 0
	max_damage = 100
	animal_origin = ALIEN_BODYPART

/obj/item/bodypart/r_leg/devil
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART
