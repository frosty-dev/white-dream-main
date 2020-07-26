/datum/action/changeling/absorb_dna
	name = "Поглотить ДНК"
	desc = "Поглощает ДНК нашей жертвы. Необходимо её душить при этом."
	button_icon_state = "absorb_dna"
	chemical_cost = 0
	dna_cost = 0
	req_human = 1

/datum/action/changeling/absorb_dna/can_sting(mob/living/carbon/user)
	if(!..())
		return

	var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling)
	if(changeling.isabsorbing)
		to_chat(user, "<span class='warning'>Мы уже поглощаем!</span>")
		return

	if(!user.pulling || !iscarbon(user.pulling))
		to_chat(user, "<span class='warning'>Мы должны держать существо для поглощения!</span>")
		return
	if(user.grab_state <= GRAB_NECK)
		to_chat(user, "<span class='warning'>Нам нужно держать существо крепче для поглощения!</span>")
		return

	var/mob/living/carbon/target = user.pulling
	return changeling.can_absorb_dna(target)



/datum/action/changeling/absorb_dna/sting_action(mob/user)
	var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling)
	var/mob/living/carbon/human/target = user.pulling
	changeling.isabsorbing = 1
	for(var/i in 1 to 3)
		switch(i)
			if(1)
				to_chat(user, "<span class='notice'>Это существо подходит. Нужно постараться не двигаться...</span>")
			if(2)
				user.visible_message("<span class='warning'><b>[user]</b> выпускает хоботок!</span>", "<span class='notice'>Выпускаем хоботок.</span>")
			if(3)
				user.visible_message("<span class='danger'><b>[user]</b> протыкает <b>[target]</b> своим хоботком!</span>", "<span class='notice'>Протыкаем <b>[target]</b> своим хоботком.</span>")
				to_chat(target, "<span class='userdanger'>Что-то острое проникает в меня!</span>")
				target.take_overall_damage(40)

		SSblackbox.record_feedback("nested tally", "changeling_powers", 1, list("Absorb DNA", "[i]"))
		if(!do_mob(user, target, 150))
			to_chat(user, "<span class='warning'>Наше поглощение <b>[target]</b> нарушено!</span>")
			changeling.isabsorbing = 0
			return

	SSblackbox.record_feedback("nested tally", "changeling_powers", 1, list("Absorb DNA", "4"))
	user.visible_message("<span class='danger'><b>[user]</b> высасывает жидкости из <b>[target]</b>!</span>", "<span class='notice'>Поглощаем <b>[target]</b>.</span>")
	to_chat(target, "<span class='userdanger'>Похоже меня сожрал генокрад!</span>")

	if(!changeling.has_dna(target.dna))
		changeling.add_new_profile(target)
		changeling.trueabsorbs++

	if(user.nutrition < NUTRITION_LEVEL_WELL_FED)
		user.set_nutrition(min((user.nutrition + target.nutrition), NUTRITION_LEVEL_WELL_FED))

	// Absorb a lizard, speak Draconic.
	owner.copy_languages(target, LANGUAGE_ABSORB)

	if(target.mind && user.mind)//if the victim and user have minds
		var/datum/mind/suckedbrain = target.mind
		user.mind.memory += "<BR><b>Мы также поглотили воспоминания <b>[target]</b>...</b><BR>[suckedbrain.memory]<BR>"
		for(var/A in suckedbrain.antag_datums)
			var/datum/antagonist/antag_types = A
			var/list/all_objectives = antag_types.objectives.Copy()
			if(antag_types.antag_memory)
				user.mind.memory += "[antag_types.antag_memory]<BR>"
			if(LAZYLEN(all_objectives))
				user.mind.memory += "<B>Цели:</B>"
				var/obj_count = 1
				for(var/O in all_objectives)
					var/datum/objective/objective = O
					user.mind.memory += "<br><B>Цель #[obj_count++]</B>: [objective.explanation_text]"
					var/list/datum/mind/other_owners = objective.get_owners() - suckedbrain
					if(other_owners.len)
						user.mind.memory += "<ul>"
						for(var/mind in other_owners)
							var/datum/mind/M = mind
							user.mind.memory += "<li>Сообщник: [M.name]</li>"
						user.mind.memory += "</ul>"
		user.mind.memory += "<b>Это всё, что [target] знает.</b><BR>"
		user.memory() //I can read your mind, kekeke. Output all their notes.

		//Some of target's recent speech, so the changeling can attempt to imitate them better.
		//Recent as opposed to all because rounds tend to have a LOT of text.

		var/list/recent_speech = list()
		var/list/say_log = list()
		var/log_source = target.logging
		for(var/log_type in log_source)
			var/nlog_type = text2num(log_type)
			if(nlog_type & LOG_SAY)
				var/list/reversed = log_source[log_type]
				if(islist(reversed))
					say_log = reverseRange(reversed.Copy())
					break

		if(LAZYLEN(say_log) > LING_ABSORB_RECENT_SPEECH)
			recent_speech = say_log.Copy(say_log.len-LING_ABSORB_RECENT_SPEECH+1,0) //0 so len-LING_ARS+1 to end of list
		else
			for(var/spoken_memory in say_log)
				if(recent_speech.len >= LING_ABSORB_RECENT_SPEECH)
					break
				recent_speech[spoken_memory] = say_log[spoken_memory]

		if(recent_speech.len)
			changeling.antag_memory += "<B>Некоторые фразы сказанные [target] можно использовать их в наших целях!</B><br>"
			to_chat(user, "<span class='boldnotice'>Некоторые фразы сказанные [target] можно использовать их в наших целях!</span>")
			for(var/spoken_memory in recent_speech)
				changeling.antag_memory += "\"[recent_speech[spoken_memory]]\"<br>"
				to_chat(user, "<span class='notice'>\"[recent_speech[spoken_memory]]\"</span>")
			changeling.antag_memory += "<B>У нас больше нет знаний о речевых шаблонах [target].</B><br>"
			to_chat(user, "<span class='boldnotice'>У нас больше нет знаний о речевых шаблонах [target].</span>")


		var/datum/antagonist/changeling/target_ling = target.mind.has_antag_datum(/datum/antagonist/changeling)
		if(target_ling)//If the target was a changeling, suck out their extra juice and objective points!
			to_chat(user, "<span class='boldnotice'>[target] один из нас. Мы поглотили его силы также.</span>")
			target_ling.remove_changeling_powers()
			changeling.geneticpoints += round(target_ling.geneticpoints/2)
			changeling.total_geneticspoints = changeling.geneticpoints //updates the total sum of genetic points when you absorb another ling
			target_ling.geneticpoints = 0
			target_ling.canrespec = 0
			changeling.chem_storage += round(target_ling.chem_storage/2)
			changeling.total_chem_storage = changeling.chem_storage //updates the total sum of chemicals stored for when you absorb another ling
			changeling.chem_charges += min(target_ling.chem_charges, changeling.chem_storage)
			target_ling.chem_charges = 0
			target_ling.chem_storage = 0
			changeling.absorbedcount += (target_ling.absorbedcount)
			target_ling.stored_profiles.len = 1
			target_ling.absorbedcount = 0
			target_ling.was_absorbed = TRUE


	changeling.chem_charges=min(changeling.chem_charges+10, changeling.chem_storage)

	changeling.isabsorbing = 0
	changeling.canrespec = 1

	target.death(0)
	target.Drain()
	return TRUE
