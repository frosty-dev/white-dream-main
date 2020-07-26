/datum/action/changeling/mimicvoice
	name = "Подражание голосу"
	desc = "Мы формируем наши голосовые железы так, чтобы они звучали как желаемый голос. Поддержание этой силы замедляет регенерацию химикатов."
	button_icon_state = "mimic_voice"
	helptext = "Превратит наш голос в имя, которое мы хотим. Мы должны постоянно расходовать химические вещества, чтобы поддерживать наш голос."
	chemical_cost = 0//constant chemical drain hardcoded
	dna_cost = 1
	req_human = 1

// Fake Voice
/datum/action/changeling/mimicvoice/sting_action(mob/user)
	var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling)
	if(changeling.mimicing)
		changeling.mimicing = ""
		changeling.chem_recharge_slowdown -= 0.5
		to_chat(user, "<span class='notice'>Мы возвращаем наши голосовые железы в исходное положение.</span>")
		return

	var/mimic_voice = sanitize_name(stripped_input(user, "Ввести бы имя для подражания.", "Подражание голосу", null, MAX_NAME_LEN))
	if(!mimic_voice)
		return
	..()
	changeling.mimicing = mimic_voice
	changeling.chem_recharge_slowdown += 0.5
	to_chat(user, "<span class='notice'>Мы формируем наши железы, чтобы принять голос <b>[mimic_voice]</b>, это замедлит регенерацию химических веществ, пока оно активно.</span>")
	to_chat(user, "<span class='notice'>Использовав эту силу снова, мы вернёмся к нашему первоначальному голосу и вернём химическую регенерацию к нормальному уровню.</span>")
	return TRUE
