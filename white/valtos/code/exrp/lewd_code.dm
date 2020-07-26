/mob/var/lastmoan

/mob/proc/moan()

	if(!(prob(lust / lust_tolerance * 65)))
		return

	var/moan = rand(1, 7)
	if (moan == lastmoan)
		moan--
	lastmoan = moan

	visible_message("<span class='purple'> <b>[src]</b> [pick("стонет", "стонет в наслаждении",)].</span>")

	if (gender == FEMALE && prob(25))
		playsound(get_turf(src), "white/valtos/sounds/love/shot[rand(1, 8)].ogg", 90, 1, 0)
	else
		playsound(get_turf(src), "white/valtos/sounds/exrp/interactions/moan_[gender == FEMALE ? "f" : "m"][moan].ogg", 70, 1, 0)

/mob/proc/cum(var/mob/living/partner, var/target_orifice)

	var/message
	if(has_penis())

		if(!istype(partner))
			target_orifice = null

		switch(target_orifice)
			if(CUM_TARGET_MOUTH)
				if(partner.has_mouth() && partner.mouth_is_free())
					message = pick("сметанит прямо в рот [partner].","спустил на язычок [partner].","брызгает сметанкой в рот [partner].","заполняет рот [partner] сметанкой.","обильно сметанит в рот [partner], так, что стекает изо рта.","выпускает в ротик [partner] порцию густого молочка")
					partner.reagents.add_reagent("cum", 10)
				else
					message = "сметанит на лицо [partner]."
			if(CUM_TARGET_THROAT)
				if(partner.has_mouth() && partner.mouth_is_free())
					message = "засунул свой стан-батон как можно глубже в глотку [partner] и сметанит."
					partner.reagents.add_reagent("cum", 15)
				else
					message = "сметанит на лицо [partner]."
			if(CUM_TARGET_VAGINA)
				if(partner.is_nude() && partner.has_vagina())
					message = "сметанит в пельмешек [partner]."
				else
					message = "сметанит на животик[partner]."
			if(CUM_TARGET_ANUS)
				if(partner.is_nude() && partner.has_anus())
					message = "сметанит в шокоданицу [partner]."
				else
					message = "сметанит на спинку [partner]."
			if(CUM_TARGET_HAND)
				if(partner.has_hand())
					message = "сметанит в руку [partner]."
				else
					message = "сметанит на [partner]."
			if(CUM_TARGET_BREASTS)
				if(partner.is_nude() && partner.has_vagina())
					message = "сметанит на грудь [partner]."
				else
					message = "сметанит на шею и грудь [partner]."
			if(NUTS_TO_FACE)
				if(partner.has_mouth() && partner.mouth_is_free())
					message = "нещадно принуждает [partner] съесть яишницу с колбасой."
			if(THIGH_SMOTHERING)
				message = "удерживает [partner] в очень крепком захвате не давая выбраться попутно смазывая лицо майонезиком."
			else
				message = "спустил на пол сметанку!"

		lust = 5
		lust_tolerance += 50

	else
		message = pick("прикрывает глаза и мелко дрожит", "дёргается в удовлетворении.","замирает, закатив глаза","содрагается, а затем резко расслабляется","извивается в приступе сытости")
		lust -= pick(50, 55, 80, 125)

	if(gender == MALE)
		if (prob(75))
			playsound(loc, "white/valtos/sounds/exrp/interactions/final_m[rand(1, 3)].ogg", 90, 1, 0)
		else
			playsound(loc, "white/valtos/sounds/gachi/penetration_[rand(1, 2)].ogg", 90, 1, 0)
	else if(gender == FEMALE)
		if (prob(75))
			playsound(loc, "white/valtos/sounds/exrp/interactions/final_f[rand(1, 5)].ogg", 70, 1, 0)
		else
			playsound(loc, "white/valtos/sounds/love/shot9.ogg", 90, 1, 0)

	visible_message("<span class='purple'><b>[src]</b> [message]</span>")

	new /obj/effect/decal/cleanable/cum(src.loc)

	multiorgasms += 1
	if(multiorgasms == 1)
		log_combat(partner, src, "came on")

	if(multiorgasms > (sexual_potency/3))
		refactory_period = 100 //sex cooldown
		adjust_drugginess(35)
	else
		refactory_period = 100
		adjust_drugginess(12)

/mob/var/last_partner
/mob/var/last_orifice

/mob/proc/is_fucking(var/mob/living/partner, var/orifice)
	if(partner == last_partner && orifice == last_orifice)
		return 1
	return 0

/mob/proc/set_is_fucking(var/mob/living/partner, var/orifice)
	last_partner = partner
	last_orifice = orifice

/mob/living/proc/do_sex(var/mob/living/partner, var/action_to_do) // собак ебать будете в другом билде

	if(stat != CONSCIOUS) return

	var/message
	var/lust_increase = 0
	var/c_target = null
	var/stp

	switch(action_to_do)
		if ("do_oral")
			lust_increase = 10
			c_target = CUM_TARGET_MOUTH
			stp = "white/valtos/sounds/exrp/interactions/bj[rand(1, 11)].ogg"
			if(partner.is_fucking(src, CUM_TARGET_MOUTH))
				if(prob(partner.sexual_potency))
					message = "зарывается языком в пельмешек [partner]."
					lust_increase += 5
				else
					if(partner.has_vagina())
						message = "лижет пельмешек [partner]."
					else if(partner.has_penis())
						message = "посасывает стан-батон [partner]."
					else
						message = "лижет стан-батон [partner]."
			else
				if(partner.has_vagina())
					message = "прижимается лицом к пельмешку [partner]."
				else if(partner.has_penis())
					message = "берёт стан-батон [partner] в свой ротик."
				else
					message = "принимается лизать стан-батон [partner]."
				partner.set_is_fucking(src, CUM_TARGET_MOUTH)

		if ("do_facefuck")
			lust_increase = 10
			c_target = CUM_TARGET_MOUTH
			stp = "white/valtos/sounds/exrp/interactions/oral[rand(1, 2)].ogg"
			if(is_fucking(partner, CUM_TARGET_MOUTH))
				if(has_vagina())
					message = "елозит своим пельмешком по лицу [partner]."
				else if(has_penis())
					message = pick("грубо исследует [partner] в рот.","сильно прижимает голову [partner] к себе.")
			else
				if(has_vagina())
					message = "пихает [partner] лицом в свой пельмешек."
				else if(has_penis())
					if(is_fucking(partner, CUM_TARGET_THROAT))
						message = "достал свой стан-батон из проруби [partner]"
					else
						message = "просовывает свой стан-батон еще глубже в прорубь [partner]"
				else
					message = "елозит пельмешком по лицу [partner]."
				set_is_fucking(partner, CUM_TARGET_MOUTH)

		if ("do_throatfuck")
			lust_increase = 10
			c_target = CUM_TARGET_MOUTH
			stp = "white/valtos/sounds/exrp/interactions/oral[rand(1, 2)].ogg"
			if(is_fucking(partner, CUM_TARGET_THROAT))
				message = pick(list("невероятно сильно ловит клёв в проруби [partner].", "топит карпика в проруби [partner]."))
				if(rand(3) == 1) // 33%
					partner.emote("задыхается в захвате [src]")
					partner.adjustOxyLoss(1)
			else if(is_fucking(partner, CUM_TARGET_MOUTH))
				message = "суёт стан-батон глубже, заходя уже в прорубь [partner]."

			else
				message = "силой запихивает свой стан-батон в прорубь [partner]"
				set_is_fucking(partner , CUM_TARGET_THROAT)

		if ("do_anal")
			lust_increase = 10
			c_target = CUM_TARGET_ANUS
			stp = "white/valtos/sounds/exrp/interactions/bang[rand(1, 3)].ogg"
			if(is_fucking(partner, CUM_TARGET_ANUS))
				message = pick("исследует [partner] в шоколадницу.","нежно исследует пещеру [partner]","всаживает стан-батон в шоколадницу [partner] по самые гренки.")
			else
				message = "безжалостно прорывает шоколадницу [partner]."
				set_is_fucking(partner, CUM_TARGET_ANUS)

		if ("do_vaginal")
			lust_increase = 10
			c_target = CUM_TARGET_VAGINA
			stp = "white/valtos/sounds/exrp/interactions/champ[rand(1, 2)].ogg"
			if(is_fucking(partner, CUM_TARGET_VAGINA))
				message = "проникает в пельмешек [partner]."
			else
				message = "резким движением погружается внутрь [partner]"
				set_is_fucking(partner, CUM_TARGET_VAGINA)

		if ("do_mount")
			lust_increase = 10
			c_target = CUM_TARGET_VAGINA
			stp = "white/valtos/sounds/exrp/interactions/bang[rand(1, 3)].ogg"
			if(partner.is_fucking(src, CUM_TARGET_VAGINA))
				message = "скачет на стан-батоне [partner]."
			else
				message = "насаживает свой пельмешек на стан-батон [partner]."
				partner.set_is_fucking(src, CUM_TARGET_VAGINA)

		if ("do_mountass")
			lust_increase = 10
			c_target = CUM_TARGET_ANUS
			stp = "white/valtos/sounds/exrp/interactions/bang[rand(1, 3)].ogg"
			if(partner.is_fucking(src, CUM_TARGET_ANUS))
				message = "скачет на стан-батоне [partner]."
			else
				message = "опускает свой зад на стан-батон [partner]."
				partner.set_is_fucking(src, CUM_TARGET_ANUS)

		if ("do_fingering")
			lust_increase = 10
			c_target = null
			stp = "white/valtos/sounds/exrp/interactions/champ_fingering.ogg"
			message = pick(list("анализирует пельмешек [partner].", "измеряет глубину пельмешка [partner].", "проверяет на прочность пельмешек [partner]."))

		if ("do_fingerass")
			lust_increase = 10
			c_target = null
			stp = "white/valtos/sounds/exrp/interactions/champ_fingering.ogg"
			message = pick(list("анализирует шоколадницу [partner].", "измеряет глубину скважины [partner].", "проверяет на прочность задний привод [partner]."))

		if ("do_rimjob")
			lust_increase = 10
			c_target = null
			stp = "white/valtos/sounds/exrp/interactions/champ_fingering.ogg"
			message = "<b>[src]<b> вынюхивает след на заднем дворе [partner].</span>"

		if ("do_handjob")
			lust_increase = 10
			c_target = CUM_TARGET_HAND
			stp = "white/valtos/sounds/exrp/interactions/bang[rand(1, 3)].ogg"
			if(partner.is_fucking(src, CUM_TARGET_HAND))
				message = pick(list("шакалит [partner].", "работает рукой с головкой стан-батона [partner].", "включает и выключает стан-батон [partner] быстрее."))
			else
				message = "нежно обхватывает стан-батон [partner] рукой."
				partner.set_is_fucking(src, CUM_TARGET_HAND)

		if ("do_breastfuck")
			lust_increase = 10
			c_target = CUM_TARGET_BREASTS
			stp = "white/valtos/sounds/exrp/interactions/bang[rand(1, 3)].ogg"
			if(is_fucking(partner, CUM_TARGET_BREASTS))
				message = pick(list("исследует [partner] между горок.", "прокатывается у [partner] между горок."))
			else
				message = "взял горки [partner] рукой и включет и выключает ими свой стан-батон."
				set_is_fucking(partner , CUM_TARGET_BREASTS)

		if ("do_mountface")
			lust_increase = 1
			c_target = null
			stp = "white/valtos/sounds/exrp/interactions/squelch[rand(1, 3)].ogg"
			if(is_fucking(partner, GRINDING_FACE_WITH_ANUS))
				message = pick(list("кормит булочками [partner]", "даёт покушать булочек [partner]."))
			else
				message = pick(list("видит, что [partner] голоден и срочно принимается кормить булочками его.", "хочет накормить [partner] булочками."))
				set_is_fucking(partner , GRINDING_FACE_WITH_ANUS)

		if ("do_grindface")
			lust_increase = 1
			c_target = null
			stp = "white/valtos/sounds/exrp/interactions/foot_dry[rand(1, 4)].ogg"
			if(src.get_item_by_slot(ITEM_SLOT_FEET) != null)
				message = pick(list("поставил [get_shoes()] подошвой на лицо [partner].", "опускает свои [get_shoes()] на лицо [partner] и надавливает ими.", "грубо давит [get_shoes()] на лицо [partner]."))
			else
				message = pick(list("ставит свои оголённые ноги на лицо [partner].", "опускает свои массивные ступни на лицо [partner], и мнёт ими его.", "выставляет ноги на лицо [partner]."))
			set_is_fucking(partner , GRINDING_FACE_WITH_FEET)

		if ("do_grindmouth")
			lust_increase = 1
			c_target = null
			stp = "white/valtos/sounds/exrp/interactions/foot_wet[rand(1, 3)].ogg"
			if(src.get_item_by_slot(ITEM_SLOT_FEET) != null)
				message = pick(list("заставляет [partner] попробовать [get_shoes()].", "даёт слизать грязь с [get_shoes()] [partner]."))
			else
				message = pick(list("принуждает [partner] попробовать свой грязный палец на ноге.", "предлагает [partner] вкусить ступню.", "прикрывает рот и нос [partner] ступнёй, затем ждёт пока [partner] отключится и резко отпускает ступню."))
			set_is_fucking(partner , GRINDING_MOUTH_WITH_FEET)

		if ("do_nuts")
			lust_increase = 1
			c_target = CUM_TARGET_MOUTH
			stp = "white/valtos/sounds/exrp/interactions/nuts[rand(1, 4)].ogg"
			if(is_fucking(partner, NUTS_TO_FACE))
				message = pick(list("хватает [partner] за голову и принуждает вкусить яишницы.", "умоляет [partner] попробовать ещё больше божественной яишенки.", "нещадно принимается кормить [partner] яишницей.", "вытаскивает всё то, что [partner] не скушал и ждёт пока тот проглотит остатки."))
			else
				message = pick(list("видит, что [partner] очень голоден и спешит накормить его яишницей!", "стоит в сантиметре от лица [partner] держа в руках омлетик, затем резко впихивает в рот [partner] благословлённый омлетик."))
				set_is_fucking(partner , NUTS_TO_FACE)

		if ("do_thighs")
			lust_increase = 10
			c_target = THIGH_SMOTHERING
			var file = pick(list("bj10", "bj3", "foot_wet1", "foot_dry3"))
			stp = "white/valtos/sounds/exrp/interactions/[file].ogg"
			if(is_fucking(partner, THIGH_SMOTHERING))
				if(has_vagina())
					message = pick(list("берёт в ещё более крепкий захват ногами голову [partner] блокируя его обзор целиком.", "обхватывает голову [partner] ногами принуждая вкусить пельменей."))
				else if(has_penis())
					message = pick(list("берёт в ещё более крепкий захват ногами голову [partner] блокируя его обзор целиком.", "обхватывает голову [partner] ногами ещё сильнее и начинает усиленно кормить яишницей.", "вставляет кусок омлетика в беспомощный рот [partner], удерживая его лицо ловким захватом ногой."))
				else
					message = "захватывает голову [partner] ногами."
			else
				message = pick(list("залезает на плечи [partner] и берёт в умелый захват своими ногами.", "хватает голову [partner] ногами."))
				set_is_fucking(partner , THIGH_SMOTHERING)
			partner.adjustOxyLoss(1)

	visible_message("<span class='notice purple small'><b>[capitalize(src.name)]</b> [message]</span>")
	playsound(get_turf(src), stp, 50, 1, -1)
	handle_post_sex(lust_increase, c_target, partner)
	partner.handle_post_sex(lust_increase, c_target, src)
	partner.dir = get_dir(partner,src)
	do_fucking_animation(get_dir(src, partner))

/mob/proc/get_shoes()
	var/obj/A = get_item_by_slot(ITEM_SLOT_FEET)
	if(findtext_char(A.name,"the"))
		return copytext_char(A.name, 3, (length(A.name)) + 1)
	else
		return A.name

/mob/proc/handle_post_sex(var/amount, var/orifice, var/mob/partner)

	sleep(5)

	if(stat != CONSCIOUS)
		return
	if(amount)
		lust += amount
	if (lust >= lust_tolerance)
		cum(partner, orifice)
	else
		moan()
