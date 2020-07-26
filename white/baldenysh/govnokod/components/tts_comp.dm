/datum/component/tts
	var/mob/owner

	var/next_line_time = 0
	var/creation = 0 //create tts on hear
	var/lang

	var/charcd = 0.2 //ticks for one char
	var/maxchars = 128 //sasai kudosai

	var/assigned_channel
	var/frequency = 1

/datum/component/tts/Initialize()
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE

	owner = parent
	assigned_channel = open_sound_channel_for_tts()
	. = ..()

/datum/component/tts/RegisterWithParent()
	RegisterSignal(owner, COMSIG_MOB_SAY, .proc/handle_speech)
	RegisterSignal(owner, COMSIG_MOVABLE_HEAR, .proc/handle_hearing)

/datum/component/tts/UnregisterFromParent()
	UnregisterSignal(owner, COMSIG_MOB_SAY)
	UnregisterSignal(owner, COMSIG_MOVABLE_HEAR)

/datum/component/tts/proc/handle_speech(datum/source, list/speech_args)
	if(GLOB.tts)
		prikolize(speech_args[SPEECH_MESSAGE])

/datum/component/tts/proc/handle_hearing(datum/source, list/hearing_args)
	var/atom/A = hearing_args[HEARING_SPEAKER]
	var/datum/component/tts/TTS = A.GetComponent(/datum/component/tts)
	if(!TTS || !TTS.creation || GLOB.tts)
		return
	prikolize(hearing_args[HEARING_RAW_MESSAGE])

/datum/component/tts/proc/prikolize(msg)
	if(world.time < next_line_time)
		return
	next_line_time = world.time
	msg = trim(msg, maxchars)
	next_line_time += length(msg)*charcd * 10
	if(lang)
		owner.tts(msg, lang, freq = frequency)
	else
		owner.tts(msg, freq = frequency)
