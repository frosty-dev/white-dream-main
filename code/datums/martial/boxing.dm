/datum/martial_art/boxing
	name = "Boxing"
	id = MARTIALART_BOXING

/datum/martial_art/boxing/disarm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	to_chat(A, "<span class='warning'>Can't disarm while boxing!</span>")
	return 1

/datum/martial_art/boxing/grab_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	to_chat(A, "<span class='warning'>Can't grab while boxing!</span>")
	return 1

/datum/martial_art/boxing/harm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)

	A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)

	var/atk_verb = pick("левым хуком","правым хуком","прямым ударом")

	var/damage = rand(5, 8) + A.dna.species.punchdamagelow
	if(!damage)
		playsound(D.loc, A.dna.species.miss_sound, 25, TRUE, -1)
		D.visible_message("<span class='warning'>[A] [atk_verb] мимо [D]!</span>", \
			"<span class='userdanger'>[A] [atk_verb] мимо меня!</span>", "<span class='hear'>Слышу взмах!</span>", COMBAT_MESSAGE_RANGE, A)
		to_chat(A, "<span class='warning'>Промахиваюсь [atk_verb], пытаясь ударить [D]!</span>")
		log_combat(A, D, "attempted to hit", atk_verb)
		return 0


	var/obj/item/bodypart/affecting = D.get_bodypart(ran_zone(A.zone_selected))
	var/armor_block = D.run_armor_check(affecting, "melee")

	playsound(D.loc, A.dna.species.attack_sound, 25, TRUE, -1)

	D.visible_message("<span class='danger'>[A] [atk_verb] [D]!</span>", \
			"<span class='userdanger'>[A] [atk_verb] меня!</span>", "<span class='hear'>Слышу как что-то сильно бьёт по плоти!</span>", COMBAT_MESSAGE_RANGE, A)
	to_chat(A, "<span class='danger'>Бью [atk_verb] [D]!</span>")

	D.apply_damage(damage, STAMINA, affecting, armor_block)
	log_combat(A, D, "punched (boxing) ")
	if(D.getStaminaLoss() > 50 && istype(D.mind?.martial_art, /datum/martial_art/boxing))
		var/knockout_prob = D.getStaminaLoss() + rand(-15,15)
		if((D.stat != DEAD) && prob(knockout_prob))
			D.visible_message("<span class='danger'>[A] валит [D] одним сильным ударом!</span>", \
								"<span class='userdanger'>[A] валит меня сильным ударом!</span>", "<span class='hear'>Слышу как что-то сильно бьёт по плоти!</span>", COMBAT_MESSAGE_RANGE, A)
			to_chat(A, "<span class='danger'>Укладываю [D] одним сильным ударом!</span>")
			D.apply_effect(200,EFFECT_KNOCKDOWN,armor_block)
			D.SetSleeping(100)
			log_combat(A, D, "knocked out (boxing) ")
	return 1

/obj/item/clothing/gloves/boxing
	var/datum/martial_art/boxing/style = new

/obj/item/clothing/gloves/boxing/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	if(slot == ITEM_SLOT_GLOVES)
		var/mob/living/carbon/human/H = user
		style.teach(H,1)
	return

/obj/item/clothing/gloves/boxing/dropped(mob/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.get_item_by_slot(ITEM_SLOT_GLOVES) == src)
		style.remove(H)
	return
