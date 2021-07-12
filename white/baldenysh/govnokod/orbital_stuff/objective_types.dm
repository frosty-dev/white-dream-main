/datum/orbital_objective/headhunt
	name = "Охота за головами"
	var/generated = FALSE
	var/objective_type
	var/mob/mob_to_recover
	min_payout = 2000
	max_payout = 5000

/datum/orbital_objective/headhunt/get_text()
	return "Требуется ликвидировать опасного преступника, скрывающегося на [station_name]. \
			Живым или мертвым, его необходимо доставить на мостик и отправить к вашему нанимателю с помощью предоставленной системы доставки. \
			Следует принять во внимание, что преступник может быть экипирован гораздо лучше обычного рейнджера. \
			Возможно, может потребоваться помощь сотрудников службы безопасности."

/datum/orbital_objective/headhunt/generate_objective_stuff(turf/chosen_turf)
	var/mob/living/carbon/human/created_human = new(chosen_turf)
	created_human.ice_cream_mob = TRUE
	ADD_TRAIT(created_human, TRAIT_CLIENT_LEAVED, "ice_cream")
	notify_ghosts("Цель охоты за головами может быть занята.", source = created_human, action = NOTIFY_ORBIT, flashwindow = FALSE, ignore_key = POLL_IGNORE_SPLITPERSONALITY, notify_suiciders = FALSE)
	created_human.AddElement(/datum/element/point_of_interest)
	created_human.mind_initialize()
	for(var/mob/living/simple_animal/hostile/SA in range(10, created_human))
		qdel(SA)
	var/turf/open/T = locate() in shuffle(view(1, created_human))
	if(T)
		new /obj/item/clothing/suit/space/hardsuit/ancient(T)
		new /obj/item/tank/internals/oxygen(T)
		new /obj/item/clothing/mask/gas(T)
		new /obj/item/storage/belt/utility/full(T)
	objective_type = pick(list("dreamer"))
	switch(objective_type)
		if("dreamer")
			created_human.flavor_text = "И вот, после долгих скитаний по заброшенным станциям, ты наконец прибываешь на подходящее для постройки портала место. \
				Тебе удалось оторваться от прошлой группы охотников, но новая наверняка не заставит себя ждать. \
				Нужно как можно быстрее построить портал на Лаваленд, убить тварь и покончить со всем этим."
			created_human.equipOutfit(/datum/outfit/dreamer)
			created_human.mind.add_antag_datum(/datum/antagonist/dreamer_orbital)
			created_human.mind.set_level(/datum/skill/gaming, SKILL_LEVEL_LEGENDARY, TRUE)
			ADD_TRAIT(created_human, TRAIT_NOSOFTCRIT, "gaming")
			ADD_TRAIT(created_human, TRAIT_FREERUNNING, "gaming")

	mob_to_recover = created_human
	generated = TRUE

/datum/orbital_objective/headhunt/check_failed()
	if(generated)
		if(QDELETED(mob_to_recover))
			return TRUE
		switch(objective_type)
			if("dreamer")
				for(var/datum/antagonist/dreamer_orbital/DO in mob_to_recover.mind.antag_datums)
					for(var/datum/objective/slay/S  in DO.objectives)
						if(S.completed)
							return TRUE
	return FALSE


/*
/datum/orbital_objective/nuclear_bomb/on_assign(obj/machinery/computer/objective/objective_computer)
	var/area/A = GLOB.areas_by_type[/area/bridge]
	var/turf/open/T = locate() in shuffle(A.contents)
	nuclear_bomb = new /obj/machinery/nuclearbomb/decomission(T)

//If nobody takes up the ghost role, then we dont care if they died.
//I know, its a bit sad.
/datum/orbital_objective/headhunt/check_failed()
	if(generated)
		if(QDELETED(mob_to_recover))
			return TRUE
		if(mob_to_recover.stat == DEAD)
			if(mob_to_recover.key && death_caring)
				return TRUE
			if(!mob_to_recover.key)
				if(death_caring)
					//Spawn in a diary
					var/obj/item/disk/record/diary = new(get_turf(mob_to_recover))
					diary.setup_recover(src)
					tracked_diary = diary
					priority_announce("Сенсоры сообщают о том, что VIP, которого мы хотели достать, внезапно скончался, однако \
						его дневник поможет нам восстановить произошедшие события. Найдите его.")
				death_caring = FALSE
		else if(is_station_level(mob_to_recover.z))
			complete_objective()
		if(death_caring)
			return TRUE
	return FALSE


/obj/item/disk/record
	name = "Диск-дневник"
	desc = "Диск, который содержит интересную информацию."

/obj/item/disk/record/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/gps, "LOG[rand(1000, 9999)]", TRUE)

/obj/item/disk/record/proc/setup_recover(linked_mission)
	AddComponent(/datum/component/recoverable, linked_mission)

/obj/item/disk/record/examine(mob/user)
	. = ..()
	. += "<hr><span class='notice'>Активируй это в руке <b>на мостике</b> станции, чтобы отправить Нанотрейзен нужные данные и завершить контракт.</span>"


//=====================
// Centcom Official
//=====================

/datum/outfit/centcom_official_vip
	name = "Centcom VIP"

	uniform = /obj/item/clothing/under/rank/centcom/officer
	shoes = /obj/item/clothing/shoes/sneakers/black
	gloves = /obj/item/clothing/gloves/color/black
	ears = /obj/item/radio/headset/headset_cent/empty
	glasses = /obj/item/clothing/glasses/sunglasses
	belt = /obj/item/gun/energy/e_gun
	l_pocket = /obj/item/pen
	back = /obj/item/storage/backpack/satchel
	r_pocket = /obj/item/pda/heads
	l_hand = /obj/item/clipboard
	r_hand = /obj/item/gps
	id = /obj/item/card/id/away/old
*/
