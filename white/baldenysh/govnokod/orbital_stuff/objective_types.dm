/datum/orbital_objective/headhunt
	name = "Охота за головами"
	var/generated = FALSE
	var/objective_type
	var/mob/living/mob_to_recover
	min_payout = 2000
	max_payout = 5000

/datum/orbital_objective/headhunt/get_text()
	return "Требуется ликвидировать опасного преступника, скрывающегося на [station_name]. \
			Живым или мертвым, его необходимо доставить на мостик и отправить к вашему нанимателю с помощью предоставленной системы доставки. \
			Следует принять во внимание, что преступник может быть экипирован гораздо лучше обычного рейнджера. \
			Возможно, может потребоваться помощь сотрудников службы безопасности."

/datum/orbital_objective/headhunt/on_assign(obj/machinery/computer/objective/objective_computer)
	new /obj/effect/pod_landingzone(empty_pod_turf, empty_pod)
	var/area/A = GLOB.areas_by_type[/area/bridge]
	var/turf/open/T = locate() in shuffle(A.contents)

	var/obj/structure/closet/supplypod/centcompod/empty_pod = new()

	RegisterSignal(empty_pod, COMSIG_ATOM_ENTERED, .proc/enter_check)

	empty_pod.stay_after_drop = TRUE
	empty_pod.reversing = TRUE
	empty_pod.explosionSize = list(0,0,0,1)
	empty_pod.leavingSound = 'sound/effects/podwoosh.ogg'

/datum/orbital_objective/headhunt/proc/enter_check(datum/source, entered_mob)
	if(!istype(source, /obj/structure/closet/supplypod/extractionpod))
		return
	if(!isliving(sent_mob))
		return
	if(entered_mob != mob_to_recover)
		return
	var/mob/living/M = entered_mob
	if (iscarbon(M))
		for(var/obj/item/W in M)
			if (ishuman(M))
				var/mob/living/carbon/human/H = M
				if(W == H.w_uniform)
					continue
				if(W == H.shoes)
					continue
			M.dropItemToGround(W)

	var/obj/structure/closet/supplypod/extractionpod/pod = source
	pod.startExitSequence(pod)
	complete_objective()

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
