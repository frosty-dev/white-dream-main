/proc/log_looc(text)
	if (CONFIG_GET(flag/log_looc))
		WRITE_LOG(GLOB.world_game_log, "LOOC: [text]")

/datum/admins/proc/togglelooc()
	set category = "Срв"
	set desc="can you even see verb descriptions anywhere?"
	set name=" 🔄 Toggle LOOC"
	toggle_looc()
	log_admin("[key_name(usr)] toggled LOOC.")
	message_admins("[key_name_admin(usr)] toggled LOOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, "Toggle LOOC|[GLOB.looc_allowed]")

/datum/admins/proc/toggleloocdead()
	set category = "Срв"
	set desc = "seriously, why do we even bother"
	set name = " 🔄 Toggle Dead LOOC"
	GLOB.dlooc_allowed = !(GLOB.dlooc_allowed)
	log_admin("[key_name(usr)] toggled Dead LOOC.")
	message_admins("[key_name_admin(usr)] toggled Dead LOOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, "Toggle Dead LOOC|[GLOB.dlooc_allowed]")
/*
TOGGLE_CHECKBOX(/datum/verbs/menu/Settings/Chat, listen_looc)()
	set name = " 🔄 LOOC"
	set category = "Настройки"
	set desc = "Show LOOC Chat"
	usr.client.prefs.chat_toggles ^= CHAT_LOOC
	usr.client.prefs.save_preferences()
	to_chat(usr, "You will [(usr.client.prefs.chat_toggles & CHAT_LOOC) ? "now" : "no longer"] see messages on the LOOC channel.")
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, "Toggle Seeing LOOC|[usr.client.prefs.chat_toggles & CHAT_LOOC]") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/verbs/menu/Settings/Chat/listen_looc/Get_checked(client/C)
	return C.prefs.chat_toggles & CHAT_LOOC

/client/verb/looc_wrapper()
	set name = "LOOC"
	set category = "OOC"

	var/msg = input(src, null, "LOOC") as text|null
	looc(msg)
*/
/client/verb/looc(msg as text)
	set name = "LOOC"
	set category = "OOC"

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Не хочу писать.</span>")
		return

	if(!mob)
		return

	if(!holder)
		if(!GLOB.looc_allowed)
			to_chat(src, "<span class='danger'>LOOC выключен.</span>")
			return
		if(!GLOB.dlooc_allowed && (mob.stat == DEAD))
			to_chat(usr, "<span class='danger'>LOOC для мёртвых не разрешен.</span>")
			return
		if(prefs.muted & MUTE_LOOC)
			to_chat(src, "<span class='danger'>Не хочу писать в LOOC.</span>")
			return
		if(src.shadowbanned_ooc || is_banned_from(ckey, "OOC"))
			to_chat(src, "<span class='danger'>Я точно не хочу писать в LOOC.</span>")
			return

	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	var/raw_msg = msg

	if(!msg)
		return

	msg = emoji_parse(msg)

	if(!holder)
		if(handle_spam_prevention(msg, MUTE_LOOC))
			return
		if(findtext(msg, "byond://"))
			to_chat(src, "<span class='bold'>Пидор.</span>")
			log_admin("[key_name(src)] has attempted to advertise in LOOC: [msg]")
			message_admins("[key_name_admin(src)] has attempted to advertise in LOOC: [msg]")
			qdel(src)
			return

	/*
	if(!prefs.chat_toggles & CHAT_LOOC)
		to_chat(src, "<span class='danger'>Не хочу писать в LOOC.</span>")
		return
	*/

	mob.log_talk("[key_name(src)]: [raw_msg]", LOG_LOOC)

	var/list/clients_to_hear = list()

	var/turf/looc_source = get_turf(mob.get_looc_source())
	var/list/stuff_that_hears = list()

	for(var/mob/M in get_hear(7, looc_source))
		stuff_that_hears += M

	for(var/mob/M in stuff_that_hears)
		if((((M.client_mobs_in_contents) && (M.client_mobs_in_contents.len <= 0)) || !M.client_mobs_in_contents))
			continue
		if(M.client) // && (M.client.prefs.chat_toggles & CHAT_LOOC)
			clients_to_hear += M.client
		for(var/mob/mob in M.client_mobs_in_contents)
			if(mob.client && mob.client.prefs) // && (mob.client.prefs.chat_toggles & CHAT_LOOC)
				clients_to_hear += mob.client

	var/message_admin = "<span class='looc'>LOOC: [ADMIN_LOOKUPFLW(mob)]: [msg]</span>"
	var/message_admin_remote = "<span class='looc'><font color='black'>(R)</font>LOOC: [ADMIN_LOOKUPFLW(mob)]: [msg]</span>"
	var/message_regular

	if(isobserver(mob)) //if you're a spooky ghost
		var/key_to_print = mob.key
		if(holder && holder.fakekey)
			key_to_print = holder.fakekey //stealthminning
		message_regular = "<span class='looc'>LOOC: [key_to_print]: [msg]</span>"
	else
		message_regular = "<span class='looc'>LOOC: [mob.name]: [msg]</span>"

	for(var/client/C in GLOB.clients)
		if(C in GLOB.admins)
			if(C in clients_to_hear)
				to_chat(C, message_admin)
			else
				to_chat(C, message_admin_remote)
		else if(C in clients_to_hear)
			to_chat(C, message_regular)

/mob/proc/get_looc_source()
	return src

/mob/living/silicon/ai/get_looc_source()
	if(eyeobj)
		return eyeobj
	return src

/proc/toggle_looc(toggle = null)
	GLOB.looc_allowed = (toggle || !GLOB.looc_allowed)
	message_admins("<span class='bold'>LOOC [GLOB.looc_allowed ? "выключен" : "включен"].</span>")
