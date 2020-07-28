/datum/action/changeling/regenerate
	name = "Регенерация"
	desc = "Позволяет нам вырастить и восстановить недостающие внешние конечности и жизненно важные внутренние органы, а также удалить осколки и восстановить объем крови. Стоит 10 химикатов."
	helptext = "Оповестит ближайший экипаж, если какие-либо внешние конечности будут восстановлены. Может использоваться в бессознательном состоянии."
	button_icon_state = "regenerate"
	chemical_cost = 10
	dna_cost = 0
	req_stat = UNCONSCIOUS

/datum/action/changeling/regenerate/sting_action(mob/living/user)
	..()
	to_chat(user, "<span class='notice'>Чувствуем зуд, как внутри, так и снаружи, ведь наши ткани пересвязываются.</span>")
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		var/list/missing = C.get_missing_limbs()
		if(missing.len)
			playsound(user, 'sound/magic/demon_consume.ogg', 50, TRUE)
			C.visible_message("<span class='warning'><b>[user]</b> отращивает недостающие конечности, издавая громкие, гротескные звуки!</span>",
				"<span class='userdanger'>Наши конечности вырастают, издают громкие хрустящие звуки и причиняют нам сильную боль!</span>",
				"<span class='hear'>Слышу как что-то органическое разрывается!</span>")
			C.emote("scream")
			C.regenerate_limbs(1)
		if(!user.getorganslot(ORGAN_SLOT_BRAIN))
			var/obj/item/organ/brain/B
			if(C.has_dna() && C.dna.species.mutantbrain)
				B = new C.dna.species.mutantbrain()
			else
				B = new()
			B.organ_flags &= ~ORGAN_VITAL
			B.decoy_override = TRUE
			B.Insert(C)
		C.regenerate_organs()
		for(var/i in C.all_wounds)
			var/datum/wound/iter_wound = i
			iter_wound.remove_wound()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.restore_blood()
		H.remove_all_embedded_objects()
	return TRUE
