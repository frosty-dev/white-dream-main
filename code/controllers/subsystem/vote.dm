SUBSYSTEM_DEF(vote)
	name = "Vote"
	wait = 10

	flags = SS_KEEP_TIMING|SS_NO_INIT

	runlevels = RUNLEVEL_LOBBY | RUNLEVELS_DEFAULT

	var/initiator = null
	var/started_time = null
	var/time_remaining = 0
	var/mode = null
	var/question = null
	var/list/choices = list()
	var/list/voted = list()
	var/list/voting = list()
	var/list/generated_actions = list()

/datum/controller/subsystem/vote/fire()	//called by master_controller
	if(mode)
		time_remaining = round((started_time + CONFIG_GET(number/vote_period) - world.time)/10)

		if(time_remaining < 0)
			result()
			for(var/client/C in voting)
				C << browse(null, "window=vote;can_close=0")
			reset()
		else
			var/datum/browser/client_popup
			for(var/client/C in voting)
				client_popup = new(C, "vote", "ГОЛОСОВАНИЕ")
				client_popup.set_window_options("can_close=0")
				client_popup.set_content(interface(C))
				client_popup.open(FALSE)


/datum/controller/subsystem/vote/proc/reset()
	initiator = null
	time_remaining = 0
	mode = null
	question = null
	choices.Cut()
	voted.Cut()
	voting.Cut()
	remove_action_buttons()

/datum/controller/subsystem/vote/proc/get_result()
	//get the highest number of votes
	var/greatest_votes = 0
	var/total_votes = 0
	for(var/option in choices)
		var/votes = choices[option]
		total_votes += votes
		if(votes > greatest_votes)
			greatest_votes = votes
	//default-vote for everyone who didn't vote
	if(!CONFIG_GET(flag/default_no_vote) && choices.len)
		var/list/non_voters = GLOB.directory.Copy()
		non_voters -= voted
		for (var/non_voter_ckey in non_voters)
			var/client/C = non_voters[non_voter_ckey]
			if (!C || C.is_afk())
				non_voters -= non_voter_ckey
		if(non_voters.len > 0)
			if(mode == "перезапуск")
				choices["Продолжаем"] += non_voters.len
				if(choices["Продолжаем"] >= greatest_votes)
					greatest_votes = choices["Продолжаем"]
			else if(mode == "режим")
				if(GLOB.master_mode in choices)
					choices[GLOB.master_mode] += non_voters.len
					if(choices[GLOB.master_mode] >= greatest_votes)
						greatest_votes = choices[GLOB.master_mode]
			else if(mode == "карту")
				for (var/non_voter_ckey in non_voters)
					var/client/C = non_voters[non_voter_ckey]
					if(C.prefs.preferred_map)
						if(choices[C.prefs.preferred_map]) //No votes if the map isn't in the vote.
							var/preferred_map = C.prefs.preferred_map
							choices[preferred_map] += 1
							greatest_votes = max(greatest_votes, choices[preferred_map])
					else if(config.defaultmap)
						if(choices[config.defaultmap]) //No votes if the map isn't in the vote.
							var/default_map = config.defaultmap.map_name
							choices[default_map] += 1
							greatest_votes = max(greatest_votes, choices[default_map])
	//get all options with that many votes and return them in a list
	. = list()
	if(greatest_votes)
		for(var/option in choices)
			if(choices[option] == greatest_votes)
				. += option
	return .

/datum/controller/subsystem/vote/proc/announce_result()
	var/list/winners = get_result()
	var/text
	if(winners.len > 0)
		if(question)
			text += "<b>[question]</b>"
		else
			text += "<b>Голосование за [mode]</b>"
		for(var/i=1,i<=choices.len,i++)
			var/votes = choices[choices[i]]
			if(!votes)
				votes = 0
			text += "\n<b>[choices[i]]:</b> [votes]"
		if(mode != "что-то")
			if(winners.len > 1)
				text = "\n<b>Голоса разделились между:</b>"
				for(var/option in winners)
					text += "\n\t[option]"
			. = pick(winners)
			text += "\n<b>Результат: [.]</b>"
		else
			text += "\n<b>Не голосовало:</b> [GLOB.clients.len-voted.len]"
	else
		text += "<b>Результат: ЕДИНАЯ РОССИЯ!</b>"
	log_vote(text)
	remove_action_buttons()
	to_chat(world, "\n<span class='purple'>[text]</span>")
	return .

/datum/controller/subsystem/vote/proc/result()
	. = announce_result()
	var/restart = FALSE
	if(.)
		switch(mode)
			if("перезапуск")
				if(. == "Заканчиваем")
					restart = TRUE
			if("режим")
				if(GLOB.master_mode != .)
					SSticker.save_mode(.)
					if(SSticker.HasRoundStarted())
						restart = TRUE
					else
						GLOB.master_mode = .
			if("карту")
				SSmapping.changemap(global.config.maplist[.])
				SSmapping.map_voted = TRUE
	if(restart)
		var/active_admins = FALSE
		for(var/client/C in GLOB.admins)
			if(!C.is_afk() && check_rights_for(C, R_SERVER))
				active_admins = TRUE
				break
		if(!active_admins)
			SSticker.Reboot("Голосвание за перезапуск успешно!", "restart vote", 1)	//no delay in case the restart is due to lag
		else
			to_chat(world, "<span style='green'> > Кто-то из педалей может перезапустить раунд. Пните их.</span>")
			message_admins("A restart vote has passed, but there are active admins on with +server, so it has been canceled. If you wish, you may restart the server.")

	return .

/datum/controller/subsystem/vote/proc/submit_vote(vote)
	if(mode)
		if(CONFIG_GET(flag/no_dead_vote) && usr.stat == DEAD && !usr.client.holder)
			return FALSE
		if(!(usr.ckey in voted))
			if(vote && 1<=vote && vote<=choices.len)
				voted += usr.ckey
				choices[choices[vote]]++	//check this
				return vote
	return FALSE

/datum/controller/subsystem/vote/proc/initiate_vote(vote_type, initiator_key)
	if(!Master.current_runlevel) //Server is still intializing.
		to_chat(usr, "<span class='warning'>Cannot start vote, server is not done initializing.</span>")
		return FALSE
	var/admin = FALSE
	var/ckey = ckey(initiator_key)
	if(GLOB.admin_datums[ckey])
		admin = TRUE

	if(!mode)
		if(started_time)
			var/next_allowed_time = (started_time + CONFIG_GET(number/vote_delay))
			if(mode)
				to_chat(usr, "<span class='warning'>There is already a vote in progress! please wait for it to finish.</span>")
				return FALSE


			if(next_allowed_time > world.time && !admin)
				to_chat(usr, "<span class='warning'>A vote was initiated recently, you must wait [DisplayTimeText(next_allowed_time-world.time)] before a new vote can be started!</span>")
				return FALSE

		reset()
		switch(vote_type)
			if("перезапуск")
				choices.Add("Заканчиваем","Продолжаем")
			if("режим")
				choices.Add(config.votable_modes)
			if("карту")
				if(!admin && SSmapping.map_voted)
					to_chat(usr, "<span class='warning'>Следующая карта уже была выбрана.</span>")
					return FALSE
				for(var/map in config.maplist)
					var/datum/map_config/VM = config.maplist[map]
					if(!VM.votable || (VM.map_name in SSpersistence.blocked_maps))
						continue
					choices.Add(VM.map_name)
			if("что-то")
				question = stripped_input(usr,"Что же мы спросим?")
				if(!question)
					return FALSE
				for(var/i=1,i<=10,i++)
					var/option = capitalize(stripped_input(usr,"Пиши вариант ответа или жми отмену для начала"))
					if(!option || mode || !usr.client)
						break
					choices.Add(option)
			else
				return FALSE
		mode = vote_type
		initiator = initiator_key
		started_time = world.time
		var/text = "Голосование за [mode] начато [initiator]."
		if(mode == "что-то")
			text += "\n[question]"
		log_vote(text)
		var/vp = CONFIG_GET(number/vote_period)
		to_chat(world, "\n<span class='purple'><b>[text]</b>\nЖми на большую кнопку <b>Голосуй!</b> или кликни <a href='?src=[REF(src)]'>сюда</a>, чтобы разместить свой голос.\nУ тебя есть [DisplayTimeText(vp)]а.</span>")
		time_remaining = round(vp/10)
		for(var/c in GLOB.clients)
			var/client/C = c
			var/datum/action/vote/V = new
			if(question)
				V.name = "Голос: [question]"
			C.player_details.player_actions += V
			V.Grant(C.mob)
			generated_actions += V
			if(C.prefs.toggles & SOUND_ANNOUNCEMENTS)
				SEND_SOUND(C, sound('sound/misc/bloop.ogg'))
		return TRUE
	return FALSE

/datum/controller/subsystem/vote/proc/interface(client/C)
	if(!C)
		return
	var/admin = FALSE
	var/trialmin = FALSE
	if(C.holder)
		admin = TRUE
		if(check_rights_for(C, R_ADMIN))
			trialmin = TRUE
	voting |= C

	if(mode)
		if(question)
			. += "<h2>ГОЛОСОВАНИЕ: '[question]'</h2>"
		else
			. += "<h2>ГОЛОСОВАНИЕ: [capitalize(mode)]</h2>"
		. += "Времени осталось: [time_remaining] s<hr><ul>"
		for(var/i=1,i<=choices.len,i++)
			var/votes = choices[choices[i]]
			if(!votes)
				votes = 0
			. += "<li><a href='?src=[REF(src)];vote=[i]'>[choices[i]]</a> \[[votes]\]</li>"
		. += "</ul><hr>"
		if(admin)
			. += "(<a href='?src=[REF(src)];vote=cancel'>Отменить</a>) "
	else
		. += "<h2>Начнём же голосование</h2><hr><ul><li>"
		//restart
		var/avr = CONFIG_GET(flag/allow_vote_restart)
		if(trialmin || avr)
			. += "<a href='?src=[REF(src)];vote=restart'>Перезапуск</a>"
		else
			. += "<font color='grey'>Перезапуск (Disallowed)</font>"
		if(trialmin)
			. += "\t(<a href='?src=[REF(src)];vote=toggle_restart'>[avr ? "Allowed" : "Disallowed"]</a>)"
		. += "</li><li>"
		//gamemode
		var/avm = CONFIG_GET(flag/allow_vote_mode)
		if(trialmin || avm)
			. += "<a href='?src=[REF(src)];vote=gamemode'>Режим</a>"
		else
			. += "<font color='grey'>Режим (Disallowed)</font>"
		if(trialmin)
			. += "\t(<a href='?src=[REF(src)];vote=toggle_gamemode'>[avm ? "Allowed" : "Disallowed"]</a>)"

		. += "</li>"
		//map
		var/avmap = CONFIG_GET(flag/allow_vote_map)
		if(trialmin || avmap)
			. += "<a href='?src=[REF(src)];vote=map'>Карта</a>"
		else
			. += "<font color='grey'>Карта (Disallowed)</font>"
		if(trialmin)
			. += "\t(<a href='?src=[REF(src)];vote=toggle_map'>[avmap ? "Allowed" : "Disallowed"]</a>)"

		. += "</li>"
		//custom
		if(trialmin)
			. += "<li><a href='?src=[REF(src)];vote=custom'>Своё</a></li>"
		. += "</ul><hr>"
	. += "<a href='?src=[REF(src)];vote=close' style='position:absolute;right:50px'>Закрыть</a>"
	return .


/datum/controller/subsystem/vote/Topic(href,href_list[],hsrc)
	if(!usr || !usr.client)
		return	//not necessary but meh...just in-case somebody does something stupid

	var/trialmin = FALSE
	if(usr.client.holder)
		if(check_rights_for(usr.client, R_ADMIN))
			trialmin = TRUE

	switch(href_list["vote"])
		if("close")
			voting -= usr.client
			usr << browse(null, "window=vote")
			return
		if("cancel")
			if(usr.client.holder)
				reset()
		if("toggle_restart")
			if(usr.client.holder && trialmin)
				CONFIG_SET(flag/allow_vote_restart, !CONFIG_GET(flag/allow_vote_restart))
		if("toggle_gamemode")
			if(usr.client.holder && trialmin)
				CONFIG_SET(flag/allow_vote_mode, !CONFIG_GET(flag/allow_vote_mode))
		if("toggle_map")
			if(usr.client.holder && trialmin)
				CONFIG_SET(flag/allow_vote_map, !CONFIG_GET(flag/allow_vote_map))
		if("restart")
			if(CONFIG_GET(flag/allow_vote_restart) || usr.client.holder)
				initiate_vote("перезапуск",usr.key)
		if("gamemode")
			if(CONFIG_GET(flag/allow_vote_mode) || usr.client.holder)
				initiate_vote("режим",usr.key)
		if("map")
			if(CONFIG_GET(flag/allow_vote_map) || usr.client.holder)
				initiate_vote("карту",usr.key)
		if("custom")
			if(usr.client.holder)
				initiate_vote("что-то",usr.key)
		else
			submit_vote(round(text2num(href_list["vote"])))
	usr.vote()

/datum/controller/subsystem/vote/proc/remove_action_buttons()
	for(var/v in generated_actions)
		var/datum/action/vote/V = v
		if(!QDELETED(V))
			V.remove_from_client()
			V.Remove(V.owner)
	generated_actions = list()

/mob/verb/vote()
	set category = "OOC"
	set name = " 📝 Голосование"

	var/datum/browser/popup = new(src, "vote", "ГОЛОСОВАНИЕ")
	popup.set_window_options("can_close=0")
	popup.set_content(SSvote.interface(client))
	popup.open(FALSE)

/datum/action/vote
	name = "Голосуй!"
	button_icon_state = "vote"

/datum/action/vote/Trigger()
	if(owner)
		owner.vote()
		remove_from_client()
		Remove(owner)

/datum/action/vote/IsAvailable()
	return TRUE

/datum/action/vote/proc/remove_from_client()
	if(!owner)
		return
	if(owner.client)
		owner.client.player_details.player_actions -= src
	else if(owner.ckey)
		var/datum/player_details/P = GLOB.player_details[owner.ckey]
		if(P)
			P.player_actions -= src
