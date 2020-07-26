/proc/priority_announce(text, title = "", sound = 'sound/ai/announcer/alert.ogg', type, sender_override)
	if(!text)
		return

	var/announcement

	//announcement += "<hr class='veryalert'>"

	if(type == "Priority")
		announcement += "<h1 class='alert'>Срочное Объявление</h1>"
		if (title && length(title) > 0)
			announcement += "<h2 class='alert'>[html_encode(title)]</h2>"
	else if(type == "Captain")
		announcement += "<h1 class='alert'>Капитан Объявляет</h1>"
		GLOB.news_network.SubmitArticle(text, "Капитан Объявляет", "Станционные Объявления", null)

	else
		if(!sender_override)
			announcement += "<h1 class='alert'>[command_name()]</h1>"
		else
			announcement += "<h1 class='alert'>[sender_override]</h1>"
		if (title && length(title) > 0)
			announcement += "<h2 class='alert'>[html_encode(title)]</h2>"

		if(!sender_override)
			if(title == "")
				GLOB.news_network.SubmitArticle(text, "Центральное Командование", "Станционные Объявления", null)
			else
				GLOB.news_network.SubmitArticle(title + "<br>" + text, "Центральное Командование", "Станционные Объявления", null)

	announcement += "<span class='alert'>[html_encode(text)]</span>"
	announcement += "<br><br>"

	var/s = sound(sound)
	for(var/mob/M in GLOB.player_list)
		if(!isnewplayer(M) && M.can_hear())
			to_chat(M, announcement)
			if(M.client.prefs.toggles & SOUND_ANNOUNCEMENTS)
				SEND_SOUND(M, s)

/proc/print_command_report(text = "", title = null, announce=TRUE)
	if(!title)
		title = "Секретно: [command_name()]"

	if(announce)
		priority_announce("Отчет был загружен и распечатан на всех коммуникационных консолях.", "Входящее Секретное Сообщение", 'sound/ai/announcer/alert.ogg')

	var/datum/comm_message/M  = new
	M.title = title
	M.content =  text

	SScommunications.send_message(M)

/proc/minor_announce(message, title = "Внимание:", alert)
	if(!message)
		return

	for(var/mob/M in GLOB.player_list)
		if(!isnewplayer(M) && M.can_hear())
			to_chat(M, "<h1 class='alert'>[html_encode(title)]</h1><BR><span class='alert'>[html_encode(message)]</span><BR><BR>")
			if(M.client.prefs.toggles & SOUND_ANNOUNCEMENTS)
				if(alert)
					SEND_SOUND(M, sound('sound/misc/notice1.ogg'))
				else
					SEND_SOUND(M, sound('sound/misc/notice2.ogg'))
