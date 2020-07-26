/datum/action/changeling/sting//parent path, not meant for users afaik
	name = "Tiny Prick"
	desc = "Stabby stabby"

/datum/action/changeling/sting/Trigger()
	var/mob/user = owner
	if(!user || !user.mind)
		return
	var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling)
	if(!changeling)
		return
	if(!changeling.chosen_sting)
		set_sting(user)
	else
		unset_sting(user)
	return

/datum/action/changeling/sting/proc/set_sting(mob/user)
	to_chat(user, "<span class='notice'>Мы готовим наше жало. Alt + клик или щелчок средней кнопкой мыши на цели, чтобы жалить их.</span>")
	var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling)
	changeling.chosen_sting = src

	user.hud_used.lingstingdisplay.icon_state = button_icon_state
	user.hud_used.lingstingdisplay.invisibility = 0

/datum/action/changeling/sting/proc/unset_sting(mob/user)
	to_chat(user, "<span class='warning'>Мы убираем наше жало, пока мы не можем никого жалить.</span>")
	var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling)
	changeling.chosen_sting = null

	user.hud_used.lingstingdisplay.icon_state = null
	user.hud_used.lingstingdisplay.invisibility = INVISIBILITY_ABSTRACT

/mob/living/carbon/proc/unset_sting()
	if(mind)
		var/datum/antagonist/changeling/changeling = mind.has_antag_datum(/datum/antagonist/changeling)
		if(changeling && changeling.chosen_sting)
			changeling.chosen_sting.unset_sting(src)

/datum/action/changeling/sting/can_sting(mob/user, mob/target)
	if(!..())
		return
	var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling)
	if(!changeling.chosen_sting)
		to_chat(user, "Мы еще не подготовили наше жало!")
	if(!iscarbon(target))
		return
	if(!isturf(user.loc))
		return
	if(!AStar(user, target.loc, /turf/proc/Distance, changeling.sting_range, simulated_only = FALSE))
		return
	if(target.mind && target.mind.has_antag_datum(/datum/antagonist/changeling))
		sting_feedback(user, target)
		changeling.chem_charges -= chemical_cost
	return 1

/datum/action/changeling/sting/sting_feedback(mob/user, mob/target)
	if(!target)
		return
	to_chat(user, "<span class='notice'>Мы незаметно жалим <b>[target.name]</b>.</span>")
	if(target.mind && target.mind.has_antag_datum(/datum/antagonist/changeling))
		to_chat(target, "<span class='warning'>Чувствую небольшое покалывание.</span>")
	return 1


/datum/action/changeling/sting/transformation
	name = "Трансформирующее жало"
	desc = "Мы незаметно жалим человека, вводя ретровирус, который заставляет их трансформироваться. Стоит 50 химикатов."
	helptext = "Жертва превратится так же, как генокрад. Не дает предупреждение другим. Мутации не будут переданы, и обезьяны станут людьми."
	button_icon_state = "sting_transform"
	chemical_cost = 50
	dna_cost = 3
	var/datum/changelingprofile/selected_dna = null

/datum/action/changeling/sting/transformation/Trigger()
	var/mob/user = usr
	var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling)
	if(changeling.chosen_sting)
		unset_sting(user)
		return
	selected_dna = changeling.select_dna("Выберем же ДНК: ", "Целевое ДНК")
	if(!selected_dna)
		return
	if(NOTRANSSTING in selected_dna.dna.species.species_traits)
		to_chat(user, "<span class='notice'>Эта ДНК не совместима с трансформирующим ретровирусом!</span>")
		return
	..()

/datum/action/changeling/sting/transformation/can_sting(mob/user, mob/living/carbon/target)
	if(!..())
		return
	if((HAS_TRAIT(target, TRAIT_HUSK)) || !iscarbon(target) || (NOTRANSSTING in target.dna.species.species_traits))
		to_chat(user, "<span class='warning'>Наш укус кажется неэффективным против его ДНК.</span>")
		return 0
	return 1

/datum/action/changeling/sting/transformation/sting_action(mob/user, mob/target)
	log_combat(user, target, "stung", "transformation sting", " new identity is '[selected_dna.dna.real_name]'")
	var/datum/dna/NewDNA = selected_dna.dna
	if(ismonkey(target))
		to_chat(user, "<span class='notice'>Наши гены кричат, когда мы жалим <b>[target.name]</b>!</span>")

	var/mob/living/carbon/C = target
	. = TRUE
	if(istype(C))
		C.real_name = NewDNA.real_name
		NewDNA.transfer_identity(C)
		if(ismonkey(C))
			C.humanize(TR_KEEPITEMS | TR_KEEPIMPLANTS | TR_KEEPORGANS | TR_KEEPDAMAGE | TR_KEEPVIRUS | TR_KEEPSTUNS | TR_KEEPREAGENTS | TR_DEFAULTMSG)
		C.updateappearance(mutcolor_update=1)


/datum/action/changeling/sting/false_armblade
	name = "Жало ложной руки-лезвия"
	desc = "Мы незаметно жалим человека, вводя ретровирус, который временно трансформирует его руку в клинок. Стоит 20 химикатов."
	helptext = "Жертва сформирует руку-лезвие так же, как генокрад, за исключением того, что клинок тупой и бесполезный."
	button_icon_state = "sting_armblade"
	chemical_cost = 20
	dna_cost = 1

/obj/item/melee/arm_blade/false
	desc = "Гротескная масса плоти, которая была моей рукой. Хотя поначалу это выглядит опасно, я могу сказать, что на самом деле оно довольно тупое и бесполезное."
	force = 5 //Basically as strong as a punch
	fake = TRUE

/datum/action/changeling/sting/false_armblade/can_sting(mob/user, mob/target)
	if(!..())
		return
	if(isliving(target))
		var/mob/living/L = target
		if((HAS_TRAIT(L, TRAIT_HUSK)) || !L.has_dna())
			to_chat(user, "<span class='warning'>Наше жало похоже неэффективно против его ДНК.</span>")
			return 0
	return 1

/datum/action/changeling/sting/false_armblade/sting_action(mob/user, mob/target)
	log_combat(user, target, "stung", object="false armblade sting")

	var/obj/item/held = target.get_active_held_item()
	if(held && !target.dropItemToGround(held))
		to_chat(user, "<span class='warning'><b>[capitalize(held)]</b> застрял в руке жертвы, у нас не получится сформировать клинок поверх этой штуки!</span>")
		return
	..()
	if(ismonkey(target))
		to_chat(user, "<span class='notice'>Наши гены кричат, когда мы жалим <b>[target.name]</b>!</span>")

	var/obj/item/melee/arm_blade/false/blade = new(target,1)
	target.put_in_hands(blade)
	target.visible_message("<span class='warning'>Гротескный клинок формируется из руки <b>[target.name]</b>!</span>", "<span class='userdanger'>Наша рука крутится и мутирует, превращаясь в ужасающее чудовище!</span>", "<span class='hear'>Слышу как что-то органическое разрывается!</span>")
	playsound(target, 'sound/effects/blobattack.ogg', 30, TRUE)

	addtimer(CALLBACK(src, .proc/remove_fake, target, blade), 600)
	return TRUE

/datum/action/changeling/sting/false_armblade/proc/remove_fake(mob/target, obj/item/melee/arm_blade/false/blade)
	playsound(target, 'sound/effects/blobattack.ogg', 30, TRUE)
	target.visible_message("<span class='warning'>С отвратительным хрустом, <b>[target]</b> формирует [blade.name] обратно в руку!</span>",
	"<span class='warning'>[capitalize(blade)] трансформируется в нормальную руку.</span>",
	"<span class='italics>Слышу как что-то органическое разрывается!</span>")

	qdel(blade)
	target.update_inv_hands()

/datum/action/changeling/sting/extract_dna
	name = "Извлекающее ДНК жало"
	desc = "Мы незаметно жалим цель и извлекаем её ДНК. Стоит 25 химикатов."
	helptext = "Даст вам ДНК вашей цели, что позволит вам превратиться в них."
	button_icon_state = "sting_extract"
	chemical_cost = 25
	dna_cost = 0

/datum/action/changeling/sting/extract_dna/can_sting(mob/user, mob/target)
	if(..())
		var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling)
		return changeling.can_absorb_dna(target)

/datum/action/changeling/sting/extract_dna/sting_action(mob/user, mob/living/carbon/human/target)
	log_combat(user, target, "stung", "extraction sting")
	var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling)
	if(!(changeling.has_dna(target.dna)))
		changeling.add_new_profile(target)
	return TRUE

/datum/action/changeling/sting/mute
	name = "Жало безмолвия"
	desc = "Мы незаметно жалим человека, на короткое время полностью делая его немым. Стоит 20 химикатов."
	helptext = "Не предупреждает жертву о том, что ее ужалили, пока она не попытается заговорить и поймёт, что не может."
	button_icon_state = "sting_mute"
	chemical_cost = 20
	dna_cost = 2

/datum/action/changeling/sting/mute/sting_action(mob/user, mob/living/carbon/target)
	log_combat(user, target, "stung", "mute sting")
	target.silent += 30
	return TRUE

/datum/action/changeling/sting/blind
	name = "Ослепляющее жало"
	desc = "Мы временно ослепляем нашу жертву. Стоит 25 химикатов."
	helptext = "Это жало на короткое время полностью ослепляет цель и на долгое время оставляет её с нечетким зрением."
	button_icon_state = "sting_blind"
	chemical_cost = 25
	dna_cost = 1

/datum/action/changeling/sting/blind/sting_action(mob/user, mob/living/carbon/target)
	log_combat(user, target, "stung", "blind sting")
	to_chat(target, "<span class='danger'>Глаза горят ужасно!</span>")
	target.become_nearsighted(EYE_DAMAGE)
	target.blind_eyes(20)
	target.blur_eyes(40)
	return TRUE

/datum/action/changeling/sting/lsd
	name = "Галлюн-жало"
	desc = "Мы причиняем муки и страдания нашей жертве."
	helptext = "Мы развиваем способность поражать цель мощным галлюциногенным химическим веществом. Цель не замечает, что её ужалили, и эффект наступает через 30-60 секунд."
	button_icon_state = "sting_lsd"
	chemical_cost = 10
	dna_cost = 1

/datum/action/changeling/sting/lsd/sting_action(mob/user, mob/living/carbon/target)
	log_combat(user, target, "stung", "LSD sting")
	addtimer(CALLBACK(src, .proc/hallucination_time, target), rand(300,600))
	return TRUE

/datum/action/changeling/sting/lsd/proc/hallucination_time(mob/living/carbon/target)
	if(target)
		target.hallucination = max(90, target.hallucination)

/datum/action/changeling/sting/cryo
	name = "Замораживающее жало"
	desc = "Мы незаметно жалим нашу жертву коктейлем из химикатов, который замораживает её изнутри. Стоит 15 химикатов."
	helptext = "Не дает предупреждение жертве, хотя она, вероятно, поймёт, что она внезапно начнёт замерзать."
	button_icon_state = "sting_cryo"
	chemical_cost = 15
	dna_cost = 2

/datum/action/changeling/sting/cryo/sting_action(mob/user, mob/target)
	log_combat(user, target, "stung", "cryo sting")
	if(target.reagents)
		target.reagents.add_reagent(/datum/reagent/consumable/frostoil, 30)
	return TRUE
