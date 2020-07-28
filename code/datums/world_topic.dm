// SETUP

/proc/TopicHandlers()
	. = list()
	var/list/all_handlers = subtypesof(/datum/world_topic)
	for(var/I in all_handlers)
		var/datum/world_topic/WT = I
		var/keyword = initial(WT.keyword)
		if(!keyword)
			warning("[WT] has no keyword! Ignoring...")
			continue
		var/existing_path = .[keyword]
		if(existing_path)
			warning("[existing_path] and [WT] have the same keyword! Ignoring [WT]...")
		else if(keyword == "key")
			warning("[WT] has keyword 'key'! Ignoring...")
		else
			.[keyword] = WT

// DATUM

/datum/world_topic
	var/keyword
	var/log = TRUE
	var/key_valid
	var/require_comms_key = FALSE

/datum/world_topic/proc/TryRun(list/input)
	key_valid = config && (CONFIG_GET(string/comms_key) == input["key"])
	var/key_cvalid = config && (CONFIG_GET(string/cross_key) == input["key"])
	if(require_comms_key && !key_valid)
		if(!key_cvalid) //хочу спать
			return "Bad Key"
	input -= "key"
	if(require_comms_key && !key_valid)
		. = "Bad Key"
		if (input["format"] == "json")
			. = list("error" = .)
	else
		. = Run(input)
	if (input["format"] == "json")
		. = json_encode(.)
	else if(islist(.))
		. = list2params(.)

/datum/world_topic/proc/Run(list/input)
	CRASH("Run() not implemented for [type]!")

// TOPICS

/datum/world_topic/ping
	keyword = "ping"
	log = FALSE

/datum/world_topic/ping/Run(list/input)
	. = 0
	for (var/client/C in GLOB.clients)
		++.

/datum/world_topic/playing
	keyword = "playing"
	log = FALSE

/datum/world_topic/playing/Run(list/input)
	return GLOB.player_list.len

/datum/world_topic/pr_announce
	keyword = "announce"
	require_comms_key = TRUE
	var/static/list/PRcounts = list()	//PR id -> number of times announced this round

/datum/world_topic/pr_announce/Run(list/input)
	var/list/payload = r_json_decode(input["payload"])
	var/id = "[payload["pull_request"]["id"]]"
	if(!PRcounts[id])
		PRcounts[id] = 1
	else
		++PRcounts[id]
		if(PRcounts[id] > PR_ANNOUNCEMENTS_PER_ROUND)
			return

	var/final_composed = "<span class='announce'>PR: [input[keyword]]</span>"
	for(var/client/C in GLOB.clients)
		C.AnnouncePR(final_composed)

/datum/world_topic/ahelp_relay
	keyword = "Ahelp"
	require_comms_key = TRUE

/datum/world_topic/ahelp_relay/Run(list/input)
	relay_msg_admins("<span class='adminnotice'><b><font color=red>HELP: </font> [input["source"]] [input["message_sender"]]: [input["message"]]</b></span>")

/datum/world_topic/comms_console
	keyword = "Comms_Console"
	require_comms_key = TRUE

/datum/world_topic/comms_console/Run(list/input)
	minor_announce(input["message"], "Входящее сообщение от [input["message_sender"]]")
	for(var/obj/machinery/computer/communications/CM in GLOB.machines)
		CM.overrideCooldown()

/datum/world_topic/news_report
	keyword = "News_Report"
	require_comms_key = TRUE

/datum/world_topic/news_report/Run(list/input)
	minor_announce(input["message"], "Breaking Update From [input["message_sender"]]")

/datum/world_topic/adminmsg
	keyword = "adminmsg"
	require_comms_key = TRUE

/datum/world_topic/adminmsg/Run(list/input)
	return TgsPm(input[keyword], input["msg"], input["sender"])

/datum/world_topic/namecheck
	keyword = "namecheck"
	require_comms_key = TRUE

/datum/world_topic/namecheck/Run(list/input)
	//Oh this is a hack, someone refactor the functionality out of the chat command PLS
	var/datum/tgs_chat_command/namecheck/NC = new
	var/datum/tgs_chat_user/user = new
	user.friendly_name = input["sender"]
	user.mention = user.friendly_name
	return NC.Run(user, input["namecheck"])
/*
/datum/world_topic/adminwho
	keyword = "adminwho"
	require_comms_key = TRUE

/datum/world_topic/adminwho/Run(list/input)
	return ircadminwho()
*/
/datum/world_topic/status
	keyword = "status"

/datum/world_topic/status/Run(list/input)
	. = list()
	var/wl = 1
	if(GLOB.whitelist)
		wl = GLOB.whitelist.len
	.["version"] = GLOB.game_version
	.["mode"] = GLOB.master_mode
	.["respawn"] = config ? !CONFIG_GET(flag/norespawn) : FALSE
	.["enter"] = GLOB.enter_allowed
	.["vote"] = CONFIG_GET(flag/allow_vote_mode)
	.["ai"] = CONFIG_GET(flag/allow_ai)
	.["host"] = world.host ? world.host : null
	.["round_id"] = GLOB.round_id
	.["players"] = wl + GLOB.clients.len
	.["revision"] = GLOB.revdata.commit
	.["revision_date"] = GLOB.revdata.date
	.["hub"] = GLOB.hub_visibility


	var/list/adm = get_admin_counts()
	var/list/presentmins = adm["present"]
	var/list/afkmins = adm["afk"]
	.["admins"] = presentmins.len + afkmins.len //equivalent to the info gotten from adminwho
	.["gamestate"] = SSticker.current_state

	.["map_name"] = SSmapping.config?.map_name || "Loading..."

	if(key_valid)
		.["active_players"] = get_active_player_count()
		if(SSticker.HasRoundStarted())
			.["real_mode"] = SSticker.mode.name
			// Key-authed callers may know the truth behind the "secret"

	.["security_level"] = get_security_level()
	.["round_duration"] = SSticker ? round((world.time-SSticker.round_start_time)/10) : 0
	// Amount of world's ticks in seconds, useful for calculating round duration

	//Time dilation stats.
	.["time_dilation_current"] = SStime_track.time_dilation_current
	.["time_dilation_avg"] = SStime_track.time_dilation_avg
	.["time_dilation_avg_slow"] = SStime_track.time_dilation_avg_slow
	.["time_dilation_avg_fast"] = SStime_track.time_dilation_avg_fast

	//pop cap stats
	.["soft_popcap"] = CONFIG_GET(number/soft_popcap) || 0
	.["hard_popcap"] = CONFIG_GET(number/hard_popcap) || 0
	.["extreme_popcap"] = CONFIG_GET(number/extreme_popcap) || 0
	.["popcap"] = max(CONFIG_GET(number/soft_popcap), CONFIG_GET(number/hard_popcap), CONFIG_GET(number/extreme_popcap)) //generalized field for this concept for use across ss13 codebases
	.["bunkered"] = CONFIG_GET(flag/panic_bunker) || FALSE
	if(SSshuttle && SSshuttle.emergency)
		.["shuttle_mode"] = SSshuttle.emergency.mode
		// Shuttle status, see /__DEFINES/stat.dm
		.["shuttle_timer"] = SSshuttle.emergency.timeLeft()
		// Shuttle timer, in seconds

/datum/world_topic/players
	keyword = "players"
	log = FALSE

/datum/world_topic/players/Run(list/input)
	return GLOB.whitelist.len + GLOB.player_list.len

/datum/world_topic/adminwho
	keyword = "adminwho"
	log = FALSE

/datum/world_topic/adminwho/Run(list/input)
	var/msg = "А вот на Украине..."
	/*for(var/adm in GLOB.admins)
		var/client/C = adm
		if(!C.holder.fakekey)
			msg += "\t[C] is a [C.holder.rank]"
			msg += "\n"*/
	return msg

/datum/world_topic/who
	keyword = "who"
	log = FALSE

/datum/world_topic/who/Run(list/input)
	var/msg = "Текущие игроки:\n"
	var/n = 0
	for(var/client/C in GLOB.clients)
		n++
		if(C.holder && C.holder.fakekey)
			msg += "\t[C.holder.fakekey]\n"
		else
			msg += "\t[C.key]\n"
	for(var/cc in GLOB.whitelist)
		n++
		msg += "\t[cc]\n"
	msg += "Всего: [n]"
	return msg

/datum/world_topic/asay
	keyword = "asay"
	require_comms_key = TRUE

/datum/world_topic/asay/Run(list/input)
	var/msg = "<font color='[GLOB.OOC_COLOR]'><span class='adminobserver'><span class='prefix'> > Discord -> ASAY</span> <EM>[input["admin"]]</EM>: <span class='message linkify'>[copytext_char(input["asay"], 23, -7)]</span></span></font>"
	to_chat(GLOB.admins, msg)

/datum/world_topic/ooc
	keyword = "ooc"
	require_comms_key = TRUE

/datum/world_topic/ooc/Run(list/input)
	if(!GLOB.ooc_allowed&&!input["isadmin"])
		return "globally muted"

	if(is_banned_from(ckey(input["ckey"]), "OOC"))
		return "you are retard"

	for(var/client/C in GLOB.clients)
		if(C.prefs.chat_toggles & CHAT_OOC) // ooc ignore
			to_chat(C, "<font color='[GLOB.OOC_COLOR]'><span class='ooc'><span class='prefix'> > Discord -> OOC:</span> <EM>[input["ckey"]]:</EM> <span class='message linkify'>[cp1252_to_utf8(input["ooc"])]</span></span></font>")

/datum/world_topic/ahelp
	keyword = "adminhelp"
	require_comms_key = TRUE

/datum/world_topic/ahelp/Run(list/input)
	var/r_ckey = ckey(input["ckey"])
	var/s_admin = input["admin"]
	var/msg = input["response"]
	var/keywordparsedmsg = keywords_lookup(msg)
	var/client/recipient = GLOB.directory[r_ckey]
	if(!recipient)
		return "FAIL"
	if(!recipient.current_ticket)
		new /datum/admin_help(msg, recipient, TRUE)
	to_chat(recipient, "<font color='red' size='4'><b>-- Discord administrator private message --</b></font>")
	to_chat(recipient, "<font color='red'>Admin PM from-<b>[s_admin]</b>: [msg]</font>")
	to_chat(recipient, "<font color='red'><i>Write to ahelp to reply.</i></font>")
	to_chat(src, "<font color='blue'>Admin PM to-<b>[key_name(recipient, 1, 1)]</b>: [msg]</font>")

	recipient.giveadminhelpverb() //reset ahelp CD to allow fast reply

	admin_ticket_log(recipient, "<font color='blue'>PM From [s_admin]: [keywordparsedmsg]</font>")
	//BWOINK
	SEND_SOUND(recipient, sound('sound/effects/adminhelp.ogg'))
	log_admin_private("PM: IRC -> [r_ckey]: [sanitize(msg)]")
	for(var/client/X in GLOB.admins)
		to_chat(X, "<font color='blue'><B>PM: DISCORD([s_admin]) -&gt; [key_name(recipient, X, 0)]</B> [keywordparsedmsg]</font>")
	webhook_send_ahelp("[input["admin"]] -> [ckey(input["ckey"])]", input["response"])
