#define TTS_PATH "white/hule/tts"

GLOBAL_VAR_INIT(tts, FALSE)
GLOBAL_LIST_EMPTY(tts_datums)

PROCESSING_SUBSYSTEM_DEF(tts)
	name = "Text To Speech"
	priority = 15
	flags = SS_NO_INIT
	wait = 20

/proc/tts_core(var/msg, var/filename, var/voice)
	world.shelleo("DISPLAY=:0.0 wine ~/main/white/hule/tts/balcon/balcon.exe -t \"[url_decode(msg)]\" -w \"[TTS_PATH]/lines/[filename].wav\" -n \"[voice]\" -enc 1251")

/atom/movable/proc/tts(var/msg, var/voice, var/freq)
	var/namae
	if(!ismob(src))
		namae = name
	else
		var/mob/etot = src
		namae = etot.ckey

	tts_core(msg, namae, voice)

	if(fexists("[TTS_PATH]/lines/[namae].wav"))
		for(var/mob/M in range(13))
			var/turf/T = get_turf(src)
			M.playsound_local(T, "[TTS_PATH]/lines/[namae].wav", 100, channel = TTS.assigned_channel, vary = TRUE, frequency = freq)
		fdel("[TTS_PATH]/lines/[namae].wav")

/atom/movable
	var/datum/tts/TTS

/atom/movable/proc/grant_tts(var/voice)
	if(!TTS)
		TTS = new /datum/tts
		TTS.owner = src
		if(ismob(src))
			var/mob/M = src
			switch(M.gender)
				if("male")
					TTS.voicename = pick(list("Maxim", "Nicolai"))
				if("female")
					TTS.voicename = pick(list("Alyona", "Tatyana"))
				if("plural")
					TTS.voicename = pick(list("Maxim", "Nicolai", "Alyona", "Tatyana"))

/atom/movable/proc/remove_tts()
	if(TTS)
		qdel(TTS)

/datum/tts
	var/atom/movable/owner
	var/cooldown = 0
	var/createtts = 0 //create tts on hear
	var/voicename = "Nicolai"
	var/charcd = 0.2 //ticks for one char
	var/maxchars = 256 //sasai kudosai
	var/freq = 1
	var/assigned_channel

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
		owner.tts(msg, voicename, freq)

/client/proc/anime_voiceover()
	set category = "Фан"
	set name = "ANIME VO"

	GLOB.tts = !GLOB.tts

	if(GLOB.tts)
		message_admins("[key] toggled anime voiceover on.")
	else
		message_admins("[key] toggled anime voiceover off.")

#undef TTS_PATH
