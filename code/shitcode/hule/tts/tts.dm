 //needs gtts module and ffmpeg

#define TTS_PATH "code/shitcode/hule/tts"

GLOBAL_VAR_INIT(tts, FALSE)
GLOBAL_LIST_INIT(tts_settings, list("ru"))//1-lang, 2-livingonly
GLOBAL_LIST_EMPTY(tts_datums)

PROCESSING_SUBSYSTEM_DEF(tts)
	name = "Text To Speech"
	priority = 15
	flags = SS_NO_INIT
	wait = 10

/proc/tts_core(var/msg, var/filename, var/lang)
	if(fexists("[TTS_PATH]/voiceq.txt"))
		fdel("[TTS_PATH]/voiceq.txt")

	var/list/paramslist = list()

	paramslist["msg"] = msg
	paramslist["name"] = filename
	paramslist["lang"] = lang

	var/params = list2params(paramslist)

	params = replacetext(params, "&", "\n")

	text2file(params,"[TTS_PATH]/voiceq.txt")

	if(world.system_type == UNIX)
		world.shelleo("python3 [TTS_PATH]/tts.py")
	else
		world.shelleo("python [TTS_PATH]/tts.py")

/atom/movable/proc/tts(var/msg, var/lang=GLOB.tts_settings[1], var/freq)
	var/namae
	if(!ismob(src))
		namae = name
	else
		var/mob/etot = src
		namae = etot.ckey

	tts_core(msg, namae, lang)

	if(fexists("[TTS_PATH]/lines/[namae].ogg"))
		for(var/mob/M in range(13))
			var/turf/T = get_turf(src)
			M.playsound_local(T, "[TTS_PATH]/lines/[namae].ogg", 100, channel = TTS.assigned_channel, frequency = freq)
		fdel("[TTS_PATH]/lines/[namae].ogg")
		fdel("[TTS_PATH]/conv/[namae].mp3")

/atom/movable
	var/datum/tts/TTS

/atom/movable/proc/grant_tts()
	if(!TTS)
		TTS = new /datum/tts
		TTS.owner = src

/atom/movable/proc/remove_tts()
	if(TTS)
		qdel(TTS)

/datum/tts
	var/atom/movable/owner
	var/cooldown = 0
	var/createtts = 0 //create tts on hear
	var/lang

	var/charcd = 0.2 //ticks for one char
	var/maxchars = 256 //sasai kudosai

	var/assigned_channel
	var/frequency = 1

/datum/tts/New()
	. = ..()
	assigned_channel = open_sound_channel()
	GLOB.tts_datums += src
	START_PROCESSING(SStts, src)

/datum/tts/Destroy()
	GLOB.tts_datums -= src
	STOP_PROCESSING(SStts, src)
	. = ..()

/datum/tts/process()
	if(cooldown > 0)
		cooldown--

/datum/tts/proc/generate_tts(msg)
	if(cooldown <= 0)
		msg = trim(msg, maxchars)
		cooldown = length(msg)*charcd
		if(lang)
			owner.tts(msg, lang, freq = frequency)
		else
			owner.tts(msg, freq = frequency)

/client/proc/anime_voiceover()
	set category = "Fun"
	set name = "ANIME VO"


	if(!(ckey in GLOB.anonists))
		return
/*
	if(!check_rights())
		return
*/
	var/list/menu = list("Cancel", "Toggle TTS", "Change Lang")

	var/selected = input("Main Menu", "ANIME VOICEOVER", "Cancel") as null|anything in menu

	switch(selected)
		if("Cancel")
			return

		if("Toggle TTS")
			GLOB.tts = !GLOB.tts

			if(GLOB.tts)
				message_admins("[key] toggled anime voiceover on.")
			else
				message_admins("[key] toggled anime voiceover off.")

		if("Change Lang")
			var/list/langlist = list("Cancel", "ru", "en", "en-gb", "ja", "fr")

			var/selectedlang = input("Main Menu", "ANIME VOICEOVER", null) as null|anything in langlist
			if(selectedlang == "Cancel")
				return

			message_admins("[key] sets anime voiceover lang to \"[selectedlang]\"")
			GLOB.tts_settings[1] = selectedlang

#undef TTS_PATH
