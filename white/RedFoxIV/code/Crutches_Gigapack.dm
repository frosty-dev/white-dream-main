//Гигапак костылей.
//Пополнять по необходимости.
//На оффтг за такое бы запермили без права обжалования.
//Хорошо, что мы не оффтг.



//Вызов ЕРТ с какими-то там условиями
//==================================================================================================================================
//Спизжено у валтоса, который свою очередь спиздил этот кусок кода из code\modules\admin\verbs\one_click_antag.dm.
//Я постарался переписать код так, чтобы можно было вызывать один и тот же метод для разных команд ЕРТ.
//В первую очередь сделано для консоли коммуникаций.
//
//то, что несколько идентичных кусков кода не только не являются одним методом, но и ещё разбросаны по разным файлам - зашквар.
//С другой стороны, в vscode переход по дефайнам до смешного прост, а QC у нас как такового вообще нет.
//Так что не похуй ли?

/*
* Вызов ЕРТ с какими-то там условиями, предложение мёртвым игрокам роли в команде.
* Костыль? Костыль.
* mission - задание ЕРТ
* team_name - название команды ЕРТ
* team_name_genitive_case - название команды ЕРТ в родительном падеже (блять)
* antag_datum_leader - инстанс датума антага для лидера (а-ля new /datum/antagonist/ert/janitor/heavy)
* antag_datum - инстанс датума антага для остальных членов команды.
*/
/proc/general_ert_request(mission, team_name, team_name_genitive_case, antag_datum_leader, antag_datum_member, mob/Sender)
	var/msg = copytext_char(sanitize(mission), 1, MAX_MESSAGE_LEN)
	var/teamname_gc = copytext_char(sanitize(team_name_genitive_case), 1, MAX_MESSAGE_LEN)
	var/teamname = copytext_char(sanitize(team_name), 1, MAX_MESSAGE_LEN)

	message_admins("[Sender] собирается вызвать [teamname_gc] с миссией: [msg]")
	var/list/mob/dead/observer/candidates = pollGhostCandidates("Хотите быть в специальном отряде быстрого реагирования?", "deathsquad", null)
	var/teamSpawned = FALSE

	if(candidates.len > 0)
		//Pick the (un)lucky players
		var/numagents = min(7, candidates.len)

		//Create team
		var/datum/team/ert/ert_team = new /datum/team/ert

		//Asign team objective
		var/datum/objective/missionobj = new
		missionobj.team = ert_team
		missionobj.explanation_text = msg
		missionobj.completed = TRUE
		missionobj.reward = 15
		ert_team.objectives += missionobj
		ert_team.mission = missionobj

		var/list/spawnpoints = GLOB.emergencyresponseteamspawn
		var/index = 0
		while(numagents && candidates.len)
			var/spawnloc = spawnpoints[index+1]
			//loop through spawnpoints one at a time
			index = (index + 1) % spawnpoints.len
			var/mob/dead/observer/chosen_candidate = pick(candidates)
			candidates -= chosen_candidate
			if(!chosen_candidate.key)
				continue

			//Spawn the body
			var/mob/living/carbon/human/ERTOperative = new /mob/living/carbon/human(spawnloc)
			chosen_candidate.client.prefs.copy_to(ERTOperative)
			ERTOperative.key = chosen_candidate.key

			//Give antag datum
			var/datum/antagonist/ert/ert_antag

			if(numagents == 1)
				ert_antag = antag_datum_leader
			else
				ert_antag = antag_datum_member

			ERTOperative.mind.add_antag_datum(ert_antag,ert_team)
			ERTOperative.mind.assigned_role = ert_antag.name

			//Logging and cleanup
			log_game("[key_name(ERTOperative)] has been selected as an [ert_antag.name]")
			numagents--
			teamSpawned++

		if (teamSpawned)
			message_admins("[Sender] вызывает [teamname] с миссией: [msg]")

		return TRUE
	else
		return FALSE

/proc/janitor_ert_request(input, usr)
	general_ert_request(input, "бригада уборщиков", "бригаду уборщиков", new /datum/antagonist/ert/janitor/heavy, new /datum/antagonist/ert/janitor, usr)

/proc/sobr_ert_request(input, usr)
	general_ert_request(input, "СОБР", "СОБР", new /datum/antagonist/ert/sobr/leader, new /datum/antagonist/ert/sobr, usr)

/proc/engineer_ert_request(input, usr)
	general_ert_request(input, "Ремонтная бригада", "ремонтную бригаду", new /datum/antagonist/ert/engineer/red, new /datum/antagonist/ert/engineer, usr)

/proc/deathsquad_request(input, cumshit)
	general_ert_request(input, "Отряд смерти", "отряд смерти", new /datum/antagonist/ert/deathsquad/leader, new /datum/antagonist/ert/deathsquad, cumshit)
