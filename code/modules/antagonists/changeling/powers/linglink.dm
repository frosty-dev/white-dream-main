/datum/action/changeling/linglink
	name = "Привязка к рою"
	desc = "Мы связываем ум нашей жертвы с роем для личного допроса."
	helptext = "Если мы найдем человека достаточно безумным, чтобы поддержать наше дело, это может быть полезным инструментом, чтобы оставаться на связи."
	button_icon_state = "hivemind_link"
	chemical_cost = 0
	dna_cost = 0
	req_human = 1

/datum/action/changeling/linglink/can_sting(mob/living/carbon/user)
	if(!..())
		return
	var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling)
	if(changeling.islinking)
		to_chat(user, "<span class='warning'>Мы уже сформировали связь с жертвой!</span>")
		return
	if(!user.pulling)
		to_chat(user, "<span class='warning'>Мы должны крепко схватить существо, чтобы связаться с ними!</span>")
		return
	if(!iscarbon(user.pulling))
		to_chat(user, "<span class='warning'>Мы не можем связаться с этим существом!</span>")
		return
	var/mob/living/carbon/target = user.pulling

	if(!target.mind)
		to_chat(user, "<span class='warning'>У жертвы отсутствует разум!</span>")
		return
	if(target.stat == DEAD)
		to_chat(user, "<span class='warning'>Жертва мертва, мы не можем связаться с мертвым разумом!</span>")
		return
	if(target.mind.has_antag_datum(/datum/antagonist/changeling))
		to_chat(user, "<span class='warning'>Жертва уже является частью роя!</span>")
		return
	if(user.grab_state <= GRAB_AGGRESSIVE)
		to_chat(user, "<span class='warning'>Мы должны держать это существо крепче!</span>")
		return
	return changeling.can_absorb_dna(target)

/datum/action/changeling/linglink/sting_action(mob/user)
	var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling)
	var/mob/living/carbon/human/target = user.pulling
	changeling.islinking = 1
	for(var/i in 1 to 3)
		switch(i)
			if(1)
				to_chat(user, "<span class='notice'>Существо подходит. Нам нужно не двигаться...</span>")
			if(2)
				to_chat(user, "<span class='notice'>Мы незаметно протыкаем <b>[target]</b> нашим малым хоботком...</span>")
				to_chat(target, "<span class='userdanger'>Испытваю какое-то острое ощущение и в ушах начинает звенеть...</span>")
			if(3)
				to_chat(user, "<span class='notice'>Мы формируем разум <b>[target]</b>, давая жертве способность общаться с роем!</span>")
				to_chat(target, "<span class='userdanger'>Мигрень пульсирует перед глазами, слышу, как я кричу, но рот мой закрыт!</span>")
				for(var/mi in GLOB.mob_list)
					var/mob/M = mi
					if(M.lingcheck() == LINGHIVE_LING)
						to_chat(M, "<span class='changeling'>Мы ощущаем чужое присутствие в рое...</span>")
				target.mind.linglink = 1
				target.say("[MODE_TOKEN_CHANGELING] БЛЯЯЯЯЯЯЯЯЯЯЯЯТЬ!!")
				to_chat(target, "<span class='changeling bold'> > Теперь ты можешь общаться с генокрадами, используй \"[MODE_TOKEN_CHANGELING] сообщение\" для связи!</span>")
		SSblackbox.record_feedback("nested tally", "changeling_powers", 1, list("[name]", "[i]"))
		if(!do_mob(user, target, 20))
			to_chat(user, "<span class='warning'>Наша связь с <b>[target]</b> завершена!</span>")
			changeling.islinking = 0
			target.mind.linglink = 0
			return

	to_chat(user, "<span class='notice'>Мы должны удерживать <b>[target]</b> для поддержания связи. </span>")
	while(user.pulling && user.grab_state >= GRAB_NECK)
		target.reagents.add_reagent(/datum/reagent/medicine/salbutamol, 0.5) // So they don't choke to death while you interrogate them
		do_mob(user, target, 100, TRUE)

	changeling.islinking = 0
	target.mind.linglink = 0
	to_chat(user, "<span class='notice'>Мы не можем больше поддерживать связь, наша жертва исчезает из роя!</span>")
	to_chat(target, "<span class='userdanger'>Связь больше не поддерживается, моё соединение с роем разорвано!</span>")
