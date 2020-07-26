// stats

/client/var/wpp = 0

/mob/living/carbon/human
	var/list/dstats = list(MOB_STR = 10, MOB_STM = 10, MOB_INT = 10, MOB_DEX = 10)
	var/list/bstats = list(MOB_STR = 10, MOB_STM = 10, MOB_INT = 10, MOB_DEX = 10)
	var/list/bmods = list()
	var/isstatee = FALSE

// do this shit

/mob/living/carbon/human/proc/StatsInit()
	// рандомизируем стартовые статы

	if(!isstatee)
		return

	dstats[MOB_STR] = rand(7, 12)
	dstats[MOB_STM] = rand(5, 10)
	dstats[MOB_INT] = rand(7, 12)
	dstats[MOB_DEX] = rand(5, 10)

	// запоминаем базовые значения

	bmods["maxHealth"]			= maxHealth
	bmods["armor"]				= dna.species.armor
	bmods["punchdamagelow"]	    = dna.species.punchdamagelow
	bmods["punchdamagehigh"]    = dna.species.punchdamagehigh
	bmods["punchstunthreshold"] = dna.species.punchstunthreshold
	bmods["brutemod"]			= dna.species.brutemod
	bmods["burnmod"]			= dna.species.burnmod
	bmods["coldmod"]			= dna.species.coldmod
	bmods["heatmod"]			= dna.species.heatmod
	bmods["stunmod"]			= dna.species.stunmod
	bmods["speedmod"]			= dna.species.speedmod
	bmods["next_move_modifier"] = next_move_modifier

	// аугментируем статы согласно ролям

	spawn(50)
		if(mind)
			switch(mind.assigned_role)
				if("Captain")
					dstats[MOB_STR] += rand(-2, 4)
					dstats[MOB_STM] += rand(-3, 3)
					dstats[MOB_INT] += rand( 0, 5)
					dstats[MOB_DEX] += rand(-1, 6)

				if("Head of Security")
					dstats[MOB_STR] += rand(5, 9)
					dstats[MOB_STM] += rand(6, 9)
					dstats[MOB_INT] += rand(1, 6)
					dstats[MOB_DEX] += rand(3, 6)

				if("Veteran")
					dstats[MOB_STR] += rand(3, 7)
					dstats[MOB_STM] += rand(4, 7)
					dstats[MOB_INT] += rand(4, 7)
					dstats[MOB_DEX] += rand(3, 4)

				if("Warden")
					dstats[MOB_STR] += rand(-2, 3)
					dstats[MOB_STM] += rand( 1, 4)
					dstats[MOB_INT] += rand( 3, 6)
					dstats[MOB_DEX] += rand(-2, 3)

				if("Detective")
					dstats[MOB_STR] += rand(-3, 1)
					dstats[MOB_STM] += rand(4, 6)
					dstats[MOB_INT] += rand(1, 4)
					dstats[MOB_DEX] += rand(4, 10)

				if("Russian Officer")
					dstats[MOB_STR] += rand( 1, 5)
					dstats[MOB_STM] += rand( 3, 6)
					dstats[MOB_INT] += rand(-1, 2)
					dstats[MOB_DEX] += rand( 2, 4)

				if("International Officer")
					dstats[MOB_STR] += rand(1, 3)
					dstats[MOB_STM] += rand(3, 4)
					dstats[MOB_INT] += rand(0, 4)
					dstats[MOB_DEX] += rand(3, 6)

				if("Lawyer")
					dstats[MOB_STR] += rand(-4, 0)
					dstats[MOB_STM] += rand(-5, 1)
					dstats[MOB_INT] += rand( 1, 6)
					dstats[MOB_DEX] += rand(-2, 3)

				if("Head of Personnel")
					dstats[MOB_STR] += rand(-3, 1)
					dstats[MOB_STM] += rand(-4, 2)
					dstats[MOB_INT] += rand( 2, 6)
					dstats[MOB_DEX] += rand(-3, 1)

				if("Quartermaster")
					dstats[MOB_STR] += rand( 1, 3)
					dstats[MOB_STM] += rand(-1, 2)
					dstats[MOB_INT] += rand( 4, 5)
					dstats[MOB_DEX] += rand( 4, 12)

				if("Cargo Technician")
					dstats[MOB_STR] += rand( 3, 6)
					dstats[MOB_STM] += rand( 2, 4)
					dstats[MOB_INT] += rand(-4, 1)
					dstats[MOB_DEX] += rand( 10, 15)

				if("Shaft Miner")
					dstats[MOB_STR] += rand(5, 8)
					dstats[MOB_STM] += rand(4, 9)
					dstats[MOB_INT] += rand(2, 3)
					dstats[MOB_DEX] += rand(6, 9)

				if("Clown") // HONK
					dstats[MOB_STR] += rand(-5, 7)
					dstats[MOB_STM] += rand(-5, 7)
					dstats[MOB_INT] += rand(-5, 7)
					dstats[MOB_DEX] += rand(-5, 7)

				if("Mime")
					dstats[MOB_STR] += rand(-2, 2)
					dstats[MOB_STM] += rand(-2, 2)
					dstats[MOB_INT] += rand( 4, 9)
					dstats[MOB_DEX] += rand( 5, 9)

				if("Janitor")
					dstats[MOB_STR] += rand(-3, 1)
					dstats[MOB_STM] += rand(-2, 1)
					dstats[MOB_INT] += rand(-4, 0)
					dstats[MOB_DEX] += rand( 2, 4)

				if("Cook")
					dstats[MOB_STR] += rand( 5, 9)
					dstats[MOB_STM] += rand( 1, 4)
					dstats[MOB_INT] += rand(-1, 2)
					dstats[MOB_DEX] += rand( 2, 6)

				if("Botanist")
					dstats[MOB_STR] += rand( 2, 4)
					dstats[MOB_STM] += rand(-2, 2)
					dstats[MOB_INT] += rand( 4, 6)
					dstats[MOB_DEX] += rand( 1, 3)

				if("Bartender")
					dstats[MOB_STR] += rand( 2, 3)
					dstats[MOB_STM] += rand(-3, 4)
					dstats[MOB_INT] += rand( 1, 3)
					dstats[MOB_DEX] += rand( 7, 12)

				if("Curator")
					dstats[MOB_STR] += rand(-2, 6)
					dstats[MOB_STM] += rand(-5, 2)
					dstats[MOB_INT] += rand( 6, 9)
					dstats[MOB_DEX] += rand( 2, 6)

				if("Chaplain")
					dstats[MOB_STR] += rand( 2, 5)
					dstats[MOB_STM] += rand( 2, 4)
					dstats[MOB_INT] += rand(-6, 2)
					dstats[MOB_DEX] += rand( 2, 2)

				if("Assistant") // никому не нужный (tm)
					dstats[MOB_STR] += rand(-3, 3)
					dstats[MOB_STM] += rand(-3, 3)
					dstats[MOB_INT] += rand(-6, 3)
					dstats[MOB_DEX] += rand(-3, 3)

				if("Prisoner") // same
					dstats[MOB_STR] += rand(-3, 3)
					dstats[MOB_STM] += rand(-3, 3)
					dstats[MOB_INT] += rand(-6, 3)
					dstats[MOB_DEX] += rand(-3, 3)

				if("Chief Medical Officer")
					dstats[MOB_STR] += rand(1, 4)
					dstats[MOB_STM] += rand(-1, 4)
					dstats[MOB_INT] += rand(5, 7)
					dstats[MOB_DEX] += rand(3, 7)

				if("Medical Doctor")
					dstats[MOB_STR] += rand(-1, 2)
					dstats[MOB_STM] += rand(-2, 3)
					dstats[MOB_INT] += rand(2, 5)
					dstats[MOB_DEX] += rand(2, 3)

				if("Chemist") // сторчался
					dstats[MOB_STR] += rand(-4, 4)
					dstats[MOB_STM] += rand(-4, 4)
					dstats[MOB_INT] += rand(-4, 4)
					dstats[MOB_DEX] += rand(-4, 4)

				if("Virologist")
					dstats[MOB_STR] += rand( 1, 2)
					dstats[MOB_STM] += rand(-2, 3)
					dstats[MOB_INT] += rand( 1, 5)
					dstats[MOB_DEX] += rand(-3, 1)

				if("Geneticist")
					dstats[MOB_STR] += rand( 3, 7)
					dstats[MOB_STM] += rand( 1, 5)
					dstats[MOB_INT] += rand( 6, 10)
					dstats[MOB_DEX] += rand(-3, 1)

				if("Chief Engineer")
					dstats[MOB_STR] += rand(1, 5)
					dstats[MOB_STM] += rand(2, 3)
					dstats[MOB_INT] += rand(2, 7)
					dstats[MOB_DEX] += rand(2, 5)

				if("Station Engineer")
					dstats[MOB_STR] += rand(3, 6)
					dstats[MOB_STM] += rand(1, 3)
					dstats[MOB_INT] += rand(-1, 4)
					dstats[MOB_DEX] += rand(4, 9)

				if("Atmospheric Technician")
					dstats[MOB_STR] += rand(2, 4)
					dstats[MOB_STM] += rand(-1, 2)
					dstats[MOB_INT] += rand(4, 8)
					dstats[MOB_DEX] += rand(5, 10)

				if("Research Director")
					dstats[MOB_STR] += rand(-5, 3)
					dstats[MOB_STM] += rand(-6, 2)
					dstats[MOB_INT] += rand(12, 15)
					dstats[MOB_DEX] += rand(-4, 2)

				if("Scientist")
					dstats[MOB_STR] += rand(-1, 4)
					dstats[MOB_STM] += rand(-1, 3)
					dstats[MOB_INT] += rand(9, 12)
					dstats[MOB_DEX] += rand(-2, 3)

				if("Roboticist")
					dstats[MOB_STR] += rand(2, 3)
					dstats[MOB_STM] += rand(-3, 1)
					dstats[MOB_INT] += rand(7, 10)
					dstats[MOB_DEX] += rand(-4, 1)

				if("Trader")
					dstats[MOB_STR] += rand(-2, 1)
					dstats[MOB_STM] += rand(-4, -1)
					dstats[MOB_INT] += rand(2, 7)
					dstats[MOB_DEX] += rand(-4, 0)

				if("Paramedic")
					dstats[MOB_STR] += rand(2, 5)
					dstats[MOB_STM] += rand(1, 4)
					dstats[MOB_INT] += rand(2, 7)
					dstats[MOB_DEX] += rand(4, 12)

			// если антаг, то
			if(mind.special_role) // пока бустаем статы всем антагам
				dstats[MOB_STR] += rand(1, 2)
				dstats[MOB_STM] += rand(1, 2)
				dstats[MOB_INT] += rand(1, 2)
				dstats[MOB_DEX] += rand(1, 2)

		// сохраняем базовые статы

		bstats[MOB_STR] = dstats[MOB_STR]
		bstats[MOB_STM] = dstats[MOB_STM]
		bstats[MOB_INT] = dstats[MOB_INT]
		bstats[MOB_DEX] = dstats[MOB_DEX]

		recalculate_stats()

/mob/living/carbon/human/proc/recalculate_stats()

	if(!isstatee)
		return

	// калькулируем модификаторы

	if(dstats[MOB_INT] <= 0)
		visible_message("<span class='suicide'><b>[name]</b> падает на пол закатив свои глаза!</span>")
		setOrganLoss(ORGAN_SLOT_BRAIN, 200)
		return

	if(!dna || !dna.species)
		return

	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		BP.max_damage = FLOOR(initial(BP.max_damage)*((dstats[MOB_STR] + dstats[MOB_STM]))/20, 1)
		BP.max_stamina_damage = FLOOR(initial(BP.max_stamina_damage)*((dstats[MOB_STR] + dstats[MOB_STM]))/20, 1)

	maxHealth 					   = FLOOR((bmods["maxHealth"]           * (dstats[MOB_STR] + dstats[MOB_STM]										  ))  / 20, 1)
	dna.species.armor 			   = FLOOR((bmods["armor"]         	  	 * (dstats[MOB_STR] + dstats[MOB_STM]									 	  ))  / 20, 1)
	dna.species.punchdamagelow 	   = FLOOR((bmods["punchdamagelow"]    	 * (dstats[MOB_STR] + dstats[MOB_STM] + ((dstats[MOB_INT] + dstats[MOB_DEX])/2))) / 30, 1)
	dna.species.punchdamagehigh    = FLOOR((bmods["punchdamagehigh"]   	 * (dstats[MOB_STR] + dstats[MOB_STM] + ((dstats[MOB_INT] + dstats[MOB_DEX])/2))) / 30, 1)
	dna.species.punchstunthreshold = CEILING((bmods["punchstunthreshold"]* (dstats[MOB_STR] + dstats[MOB_STM] + ((dstats[MOB_INT] + dstats[MOB_DEX])/2))) / 30, 20)
	dna.species.brutemod 		   = bmods["brutemod"]			  		 / ((dstats[MOB_STR] + dstats[MOB_STM]) / 30)
	dna.species.burnmod 		   = bmods["burnmod"]			  		 / ((dstats[MOB_STR] + dstats[MOB_STM]) / 30)
	dna.species.coldmod 		   = bmods["coldmod"]			  		 / ((dstats[MOB_STR] + dstats[MOB_STM]) / 30)
	dna.species.heatmod 		   = bmods["heatmod"]			  		 / ((dstats[MOB_STR] + dstats[MOB_STM]) / 30)
	dna.species.stunmod 		   = bmods["stunmod"]   		  		 / ((dstats[MOB_STR] + dstats[MOB_STM] + dstats[MOB_DEX]) / 30)
	dna.species.speedmod 		   = bmods["speedmod"]  		  		 / (dstats[MOB_DEX] / 15)
	next_move_modifier			   = bmods["next_move_modifier"] 		 / (dstats[MOB_DEX] / 15)

/mob/living/carbon/human/UnarmedAttack(atom/A, proximity)
	. = ..()
	if(!isstatee)
		return
	if(dstats[MOB_STR] <= 29)
		return
	if(!proximity)
		return
	if(src.a_intent != INTENT_HARM)
		return
	if(ishuman(A))
		var/mob/living/carbon/human/T = A
		var/atom/throw_target = get_edge_target_turf(T, get_dir(T, get_step_away(T, src)))
		T.throw_at(throw_target, 200, (FLOOR(dna.species.punchdamagehigh/4, 1)), src)
		return
	if(A.attack_hulk(src))
		log_combat(src, A, "punched", "hulk powers")
		src.do_attack_animation(A, ATTACK_EFFECT_SMASH)
		src.changeNext_move(CLICK_CD_MELEE)
		return COMPONENT_NO_ATTACK_HAND

/mob/living/carbon/human/proc/get_stats()
	return list(MOB_STR = bstats[MOB_STR], MOB_STM = bstats[MOB_STM], MOB_INT = bstats[MOB_INT], MOB_DEX = bstats[MOB_DEX])

/mob/living/carbon/human/proc/set_stats(str = bstats[MOB_STR], stm = bstats[MOB_STM], int = bstats[MOB_INT], dex = bstats[MOB_DEX])
	bstats[MOB_STR] = str
	bstats[MOB_STM] = stm
	bstats[MOB_INT] = int
	bstats[MOB_DEX] = dex

	dstats[MOB_STR] = str
	dstats[MOB_STM] = stm
	dstats[MOB_INT] = int
	dstats[MOB_DEX] = dex

	recalculate_stats()

	return

/mob/living/carbon/human/Stat()
	..()
	if(statpanel("Игра") && isstatee)
		stat(null, null)
		stat("Сила: ",			FLOOR(dstats["strength"], 1))
		stat("Выносливость:",   FLOOR(dstats["stamina"], 1))
		stat("Интеллект:",      FLOOR(dstats["intelligence"], 1))
		stat("Ловкость:",       FLOOR(dstats["dexterity"], 1))
		stat("Метакэш:",      	client.mc_cached)
