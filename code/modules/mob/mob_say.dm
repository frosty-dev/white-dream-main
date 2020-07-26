//Speech verbs.

///Say verb
/mob/verb/say_verb_wrapper()
	set name = "Say"
	set category = "IC"

	var/list/speech_bubble_recipients = list()
	var/bubble_type = "default"

	if(isliving(src))
		var/mob/living/L = src
		bubble_type = L.bubble_icon

	var/image/I = image('icons/mob/talk.dmi', src, "[bubble_type]0", FLY_LAYER)

	if(!stat || stat == 1)
		/*
		var/list/listening = get_hearers_in_view(9, src)
		for(var/mob/M in listening)
			if(!M.client)
				continue
			var/client/C = M.client
			speech_bubble_recipients.Add(C)
		*/
		speech_bubble_recipients = GLOB.clients
		I.alpha = 0
		animate(I, time = 7, loop = -1, easing = SINE_EASING, alpha = 255)
		animate(time = 7, alpha = 80)
		flick_overlay(I, speech_bubble_recipients, -1)

	var/msg = input("", "Say") as null|text

	if(msg)
		if(speech_bubble_recipients.len)
			remove_images_from_clients(I, speech_bubble_recipients)
		say_verb(msg)
	else if(speech_bubble_recipients.len)
		animate(I, time = 7, loop = 1, alpha = 0)
		spawn(7)
			remove_images_from_clients(I, speech_bubble_recipients)

/mob/verb/say_verb(message as text)
	set name = "Say"
	set hidden = 1

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Не могу говорить.</span>")
		return
	if(message)
		say(message)

///Whisper verb
/mob/verb/whisper_verb_wrapper()
	set name = "Whisper"
	set category = "IC"

	var/msg = input(src, null, "Whisper") as text|null
	if(msg)
		whisper_verb(msg)

/mob/verb/whisper_verb(message as text)
	set name = "Whisper"
	set hidden = 1

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Не могу шептать.</span>")
		return
	whisper(message)

///whisper a message
/mob/proc/whisper(message, datum/language/language=null)
	say(message, language) //only living mobs actually whisper, everything else just talks

///The me emote verb
/mob/verb/me_verb_wrapper()
	set name = "Me"
	set category = "IC"

	var/msg = input(src, null, "Me") as text|null
	if(msg)
		me_verb(msg)

/mob/verb/me_verb(message as text)
	set name = "Me"
	set hidden = 1

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Не могу изображать.</span>")
		return

	message = trim(copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN))
	var/ckeyname = "[usr.ckey]/[usr.name]"
	webhook_send_me(ckeyname, message)

	usr.emote("me",1,message,TRUE)

///Speak as a dead person (ghost etc)
/mob/proc/say_dead(var/message)
	var/name = real_name
	var/alt_name = ""

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Не могу говорить</span>")
		return

	var/jb = is_banned_from(ckey, "Deadchat")
	if(QDELETED(src))
		return

	if(jb)
		to_chat(src, "<span class='danger'>Мне нельзя говорить.</span>")
		return



	if (src.client)
		if(src.client.prefs.muted & MUTE_DEADCHAT)
			to_chat(src, "<span class='danger'>Не хочу говорить.</span>")
			return

		if(src.client.handle_spam_prevention(message,MUTE_DEADCHAT))
			return

	var/mob/dead/observer/O = src
	if(isobserver(src) && O.deadchat_name)
		name = "[O.deadchat_name]"
	else
		if(mind && mind.name)
			name = "[mind.name]"
		else
			name = real_name
		if(name != real_name)
			alt_name = " (died as [real_name])"

	var/spanned = say_quote(message)
	var/source = "<span class='game'><span class='prefix'>Призрак</span> <span class='name'>[name]</span>[alt_name]"
	var/rendered = " <span class='message'>[emoji_parse(spanned)]</span></span>"
	log_talk(message, LOG_SAY, tag="DEAD")
	if(SEND_SIGNAL(src, COMSIG_MOB_DEADSAY, message) & MOB_DEADSAY_SIGNAL_INTERCEPT)
		return
	var/displayed_key = key
	if(client.holder?.fakekey)
		displayed_key = null
	deadchat_broadcast(rendered, source, follow_target = src, speaker_key = displayed_key)

///Check if this message is an emote
/mob/proc/check_emote(message, forced)
	if(message[1] == "*")
		emote(copytext(message, length(message[1]) + 1), intentional = !forced)
		return TRUE

///Check if the mob has a hivemind channel
/mob/proc/hivecheck()
	return 0

///Check if the mob has a ling hivemind
/mob/proc/lingcheck()
	return LINGHIVE_NONE

/**
  * Get the mode of a message
  *
  * Result can be
  * * MODE_WHISPER (Quiet speech)
  * * MODE_SING (Singing)
  * * MODE_HEADSET (Common radio channel)
  * * A department radio (lots of values here)
  */
/mob/proc/get_message_mode(message)
	var/key = message[1]
	if(key == "#")
		return MODE_WHISPER
	else if(key == "%")
		return MODE_SING
	else if(key == ";")
		return MODE_HEADSET
	else if((length(message) > (length(key) + 1)) && (key in GLOB.department_radio_prefixes))
		var/key_symbol = lowertext(message[length(key) + 1])
		return GLOB.department_radio_keys[key_symbol]
