/obj/item/organ/cyberimp/brain/stats
	name = "имплант усиления"
	desc = "Этот кибернетический имплант намного усиливает один из показателей носителя."
	icon = 'white/valtos/icons/implants.dmi'
	icon_state = "int"
	implant_color = "#0E7E00"
	slot = ORGAN_SLOT_BRAIN_STATS
	var/s_type = "int"

/obj/item/organ/cyberimp/brain/stats/attack_self(mob/user)
	. = ..()
	switch(s_type)
		if("int")
			s_type = "str"
			to_chat(user, "<span class='notice'>Теперь имплант настроен на <b>СИЛУ</b>.</span>")
		if("str")
			s_type = "stm"
			to_chat(user, "<span class='notice'>Теперь имплант настроен на <b>ВЫНОСЛИВОСТЬ</b>.</span>")
		if("stm")
			s_type = "dex"
			to_chat(user, "<span class='notice'>Теперь имплант настроен на <b>ЛОВКОСТЬ</b>.</span>")
		if("dex")
			s_type = "int"
			to_chat(user, "<span class='notice'>Теперь имплант настроен на <b>ИНТЕЛЛЕКТ</b>.</span>")
	icon_state = s_type
	update_icon()

/obj/item/organ/cyberimp/brain/stats/on_life()
	..()
	var/mob/living/carbon/human/M = owner
	if(damage > 20)
		if((organ_flags & ORGAN_FAILING))
			switch(s_type)
				if("int")
					M.current_fate[MOB_INT] = -4
				if("str")
					M.current_fate[MOB_STR] = -4
				if("stm")
					M.current_fate[MOB_STM] = -4
				if("dex")
					M.current_fate[MOB_DEX] = -4
		else
			switch(s_type)
				if("int")
					M.current_fate[MOB_INT] = M.base_fate[MOB_INT]
				if("str")
					M.current_fate[MOB_STR] = M.base_fate[MOB_STR]
				if("stm")
					M.current_fate[MOB_STM] = M.base_fate[MOB_STM]
				if("dex")
					M.current_fate[MOB_DEX] = M.base_fate[MOB_DEX]
	else
		switch(s_type)
			if("int")
				M.current_fate[MOB_INT] = 4
			if("str")
				M.current_fate[MOB_STR] = 4
			if("stm")
				M.current_fate[MOB_STM] = 4
			if("dex")
				M.current_fate[MOB_DEX] = 4
	M.recalculate_stats()
	return

/obj/item/organ/cyberimp/brain/stats/Remove(mob/living/carbon/human/M, special = FALSE)
	. = ..()
	switch(s_type)
		if("int")
			M.current_fate[MOB_INT] = M.base_fate[MOB_INT]
		if("str")
			M.current_fate[MOB_STR] = M.base_fate[MOB_STR]
		if("stm")
			M.current_fate[MOB_STM] = M.base_fate[MOB_STM]
		if("dex")
			M.current_fate[MOB_DEX] = M.base_fate[MOB_DEX]
	M.recalculate_stats()

/obj/item/organ/cyberimp/brain/stats/Insert(mob/living/carbon/human/M)
	. = ..()
	switch(s_type)
		if("int")
			M.current_fate[MOB_INT] = 4
			to_chat(M, "<span class='notice'>Мои мозги работают быстрее!</span>")
		if("str")
			M.current_fate[MOB_STR] = 4
			to_chat(M, "<span class='notice'><b>Я ОЩУЩАЮ СИЛУ!</b></span>")
		if("stm")
			M.current_fate[MOB_STM] = 4
			to_chat(M, "<span class='notice'>Моя кожа каменеет, а кровь начинает кипеть!</span>")
		if("dex")
			M.current_fate[MOB_DEX] = 4
			to_chat(M, "<span class='notice'>Я чувствую, что могу дотрогнуться локтём до носа!</span>")
	M.recalculate_stats()

/obj/item/organ/cyberimp/brain/stats/emp_act(severity)
	. = ..()
	if((organ_flags & ORGAN_FAILING) || . & EMP_PROTECT_SELF)
		return
	organ_flags |= ORGAN_FAILING
	applyOrganDamage(severity)
	addtimer(CALLBACK(src, .proc/reboot), 90 / severity)

/obj/item/organ/cyberimp/brain/stats/proc/reboot()
	organ_flags &= ~ORGAN_FAILING


/datum/supply_pack/medical/stat_implants
	name = "Импланты усиления"
	desc = "Содержит несколько настраиваемых имплантов для усиления возможностей человека."
	cost = 9500
	contains = list(/obj/item/organ/cyberimp/brain/stats,
					/obj/item/organ/cyberimp/brain/stats,
					/obj/item/organ/cyberimp/brain/stats)
	crate_name = "импланты усиления"
