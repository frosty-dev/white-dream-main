/mob/living/carbon/human
	var/list/current_fate = list(MOB_STR = 0, MOB_STM = 0, MOB_INT = 0, MOB_DEX = 0)
	var/list/base_fate    = list(MOB_STR = 0, MOB_STM = 0, MOB_INT = 0, MOB_DEX = 0)
	var/fate_luck = 1
	var/isstatee = FALSE

/mob/living/carbon/human/proc/StatsInit()
	if(!isstatee) return
	// аугментируем статы согласно ролям
	spawn(50)
		if(mind)
			switch(mind.assigned_role)
				if("Captain", "Head of Security", "Head of Personnel", "Chief Medical Officer", "Chief Engineer", "Research Director", "Veteran", "Warden", "Detective", "Russian Officer", "International Officer", "Hacker")
					fate_luck = 4

				if("Quartermaster", "Shaft Miner", "Curator", "Chaplain", "Medical Doctor", "Station Engineer", "Atmospheric Technician", "Scientist", "Paramedic")
					fate_luck = 3

				if("Lawyer", "Cargo Technician", "Clown", "Mime", "Janitor", "Cook", "Botanist", "Bartender", "Chemist", "Virologist", "Geneticist", "Roboticist", "Trader")
					fate_luck = 2

				if("Assistant", "Prisoner")
					fate_luck = 1

			// если антаг, то
			if(mind.special_role)
				fate_luck += 1

		if(prob(50)) // если просто повезло
			fate_luck += 1

		current_fate[MOB_STR] = roll_stat_dice(fate_luck)
		current_fate[MOB_STM] = roll_stat_dice(fate_luck)
		current_fate[MOB_INT] = roll_stat_dice(fate_luck)
		current_fate[MOB_DEX] = roll_stat_dice(fate_luck)

		base_fate[MOB_STR]    = current_fate[MOB_STR]
		base_fate[MOB_STM]    = current_fate[MOB_STM]
		base_fate[MOB_INT]    = current_fate[MOB_INT]
		base_fate[MOB_DEX]    = current_fate[MOB_DEX]

		recalculate_stats()

/mob/living/carbon/human/proc/recalculate_stats()
	// калькулируем модификаторы
	if(!isstatee) return
	if(!dna || !dna.species) return

/mob/living/carbon/human/proc/get_stats()
	return list(MOB_STR = current_fate[MOB_STR], MOB_STM = current_fate[MOB_STM], MOB_INT = current_fate[MOB_INT], MOB_DEX = current_fate[MOB_DEX])

/mob/living/carbon/human/proc/set_stats(str = current_fate[MOB_STR], stm = current_fate[MOB_STM], int = current_fate[MOB_INT], dex = current_fate[MOB_DEX])
	current_fate[MOB_STR] = str
	current_fate[MOB_STM] = stm
	current_fate[MOB_INT] = int
	current_fate[MOB_DEX] = dex

	recalculate_stats()

	return

/mob/living/carbon/human/Stat()
	..()
	if(statpanel("Игра"))
		stat(null, null)
		if(isstatee)
			stat("Сила:",			fateize_stat(current_fate[MOB_STR]))
			stat("Выносливость:",   fateize_stat(current_fate[MOB_STM]))
			stat("Интеллект:",      fateize_stat(current_fate[MOB_INT]))
			stat("Ловкость:",       fateize_stat(current_fate[MOB_DEX]))
		stat("Метакэш:",      	client.mc_cached)

/proc/fateize_stat(stat, humanize = FALSE)
	if(humanize)
		switch(stat)
			if(-4)
				return "ничтожно низкий"
			if(-3)
				return "очень низкий"
			if(-2)
				return "низкий"
			if(-1)
				return "пониженный"
			if(0)
				return "средний"
			if(1)
				return "повышенный"
			if(2)
				return "высокий"
			if(3)
				return "очень высокий"
			if(4)
				return "невероятно высокий"
	else
		switch(stat)
			if(-4)
				return "<<<<"
			if(-3)
				return "<<<"
			if(-2)
				return "<<"
			if(-1)
				return "<"
			if(0)
				return "="
			if(1)
				return ">"
			if(2)
				return ">>"
			if(3)
				return ">>>"
			if(4)
				return ">>>>"

/proc/return_damage_string(luck)
	switch(luck)
		if(-4)
			return " невероятно слабо"
		if(-3)
			return " слабо"
		if(-2)
			return " несильно"
		if(-1)
			return " слегка слабо"
		if(0)
			return ""
		if(1)
			return " немного сильно"
		if(2)
			return " сильно"
		if(3)
			return " очень сильно"
		if(4)
			return " невероятно сильно"

/proc/return_miss_string(luck)
	switch(luck)
		if(-4)
			return " глупо"
		if(-3)
			return " тупо"
		if(-2)
			return " странно"
		if(-1)
			return " неправильно"
		if(0)
			return " как обычно"
		if(1)
			return " невезуче"
		if(2)
			return " удивительно"
		if(3)
			return " подозрительно"
		if(4)
			return " невозможно странно"

/proc/roll_damage_dice(force, luck)
	var/bb = 0
	if(luck < -4)
		luck = 1
	switch(roll(luck, 20))
		if(1)
			bb = force / 0.5
		if(2 to 3)
			bb = force / 0.6
		if(4 to 9)
			bb = force / 0.8
		if(10 to 15)
			bb = force * 0.9
		if(16 to 25)
			bb = force
		if(26 to 30)
			bb = force * 1.1
		if(31 to 47)
			bb = force * 1.2
		if(48 to 65)
			bb = force * 1.3
		if(66 to INFINITY)
			bb = force * 1.5
	return bb

/proc/roll_miss_dice(luck)
	var/bb = 0
	if(luck < -4)
		luck = 1
	switch(roll(luck, 20))
		if(1)
			bb = 60
		if(2 to 3)
			bb = 50
		if(4 to 9)
			bb = 40
		if(10 to 15)
			bb = 30
		if(16 to 25)
			bb = 20
		if(26 to 30)
			bb = 15
		if(31 to 47)
			bb = 10
		if(48 to 65)
			bb = 5
		if(66 to INFINITY)
			bb = 0
	return bb

/proc/roll_stat_dice(luck)
	var/bb = 0
	if(luck < -4)
		luck = 1
	switch(roll(luck, 20))
		if(1)
			bb = -4
		if(2 to 3)
			bb = -3
		if(4 to 9)
			bb = -2
		if(10 to 15)
			bb = -1
		if(16 to 25)
			bb = 0
		if(26 to 30)
			bb = 1
		if(31 to 47)
			bb = 2
		if(48 to 65)
			bb = 3
		if(66 to INFINITY)
			bb = 4
	return bb
