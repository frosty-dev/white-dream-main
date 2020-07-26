/datum/component/soundplayer
	var/atom/soundsource

	var/sound/cursound
	var/active = FALSE
	var/playing_range = 15
	var/list/listener_comps = list()

	var/environmental = TRUE
	var/env_id = 12
	var/repeating = TRUE
	var/playing_volume = 100
	var/playing_falloff = 4
	var/playing_channel

/datum/component/soundplayer/Initialize()
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	soundsource = parent
	playing_channel = open_sound_channel()
	START_PROCESSING(SSprocessing, src)
	. = ..()
	set_sound(sound('white/baldenysh/sounds/hardbass_loop.ogg'))

/datum/component/soundplayer/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	stop_sounds()
	for(var/datum/component/soundplayer_listener/SPL in listener_comps)
		qdel(SPL)
	. = ..()

/datum/component/soundplayer/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, .proc/update_sounds)

/datum/component/soundplayer/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_MOVABLE_MOVED)

/datum/component/soundplayer/process()
	if(!active || !cursound)
		return
	for(var/client/C)
		if(!C.mob)
			continue
		var/mob/M = C.mob
		var/list/mycomps = (M.GetComponents(/datum/component/soundplayer_listener) & listener_comps)
		if(mycomps && mycomps.len)
			continue
		var/datum/component/soundplayer_listener/SPL = M.AddComponent(/datum/component/soundplayer_listener, src)
		listener_comps += SPL
		SPL.update_sound()

/datum/component/soundplayer/proc/update_sounds()
	for(var/datum/component/soundplayer_listener/SPL in listener_comps)
		SPL.update_sound()

/datum/component/soundplayer/proc/stop_sounds()
	active = FALSE
	for(var/datum/component/soundplayer_listener/SPL in listener_comps)
		qdel(SPL)

/datum/component/soundplayer/proc/set_sound(var/newsound)
	if(istext(newsound))
		cursound = sound(newsound)
	else
		cursound = newsound
	cursound.wait = 0
	cursound.volume = 0
	update_sounds()

/datum/component/soundplayer/proc/set_channel(var/chan)
	playing_channel = chan
	if(cursound)
		cursound.channel = chan
	update_sounds()

////////////////////////////////////////////////

/datum/component/soundplayer_listener
	dupe_mode = COMPONENT_DUPE_ALLOWED
	var/datum/component/soundplayer/myplayer
	var/mob/listener

/datum/component/soundplayer_listener/Initialize(var/datum/component/soundplayer/player)
	if(!ismob(parent) || !istype(player))
		return COMPONENT_INCOMPATIBLE
	listener = parent
	myplayer = player
	. = ..()

/datum/component/soundplayer_listener/Destroy()
	myplayer.listener_comps -= src
	SEND_SOUND(listener, sound(null, repeat = 0, wait = 0, channel = myplayer.playing_channel))
	. = ..()

/datum/component/soundplayer_listener/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, .proc/update_sound)
	RegisterSignal(parent, COMSIG_MOB_LOGOUT, .proc/qdel_check)

/datum/component/soundplayer_listener/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(parent, COMSIG_MOB_LOGOUT)

/datum/component/soundplayer_listener/proc/get_player_sound()
	var/list/sounds = listener.client.SoundQuery()
	for(var/sound/S in sounds)
		if(S.file == myplayer.cursound.file)
			return S
	for(var/sound/S in sounds)
		if(S.channel == myplayer.playing_channel && S.repeat == myplayer.repeating)
			return S
	return FALSE

/datum/component/soundplayer_listener/proc/qdel_check()
	if(!listener || !listener.client || !myplayer || !myplayer.cursound)
		qdel(src)
		return TRUE
	return FALSE

/datum/component/soundplayer_listener/proc/update_sound()
	if(qdel_check())
		return
	var/sound/S = get_player_sound()
	if(!S)
		S = myplayer.cursound
		S.status = 0
		S.volume = 0
		S.repeat = myplayer.repeating
		S.falloff = myplayer.playing_falloff
		S.channel = myplayer.playing_channel
		S.environment = myplayer.env_id
		S.y = 1
		SEND_SOUND(listener, S)
	S.status = SOUND_UPDATE
	S.channel = myplayer.playing_channel
	var/turf/TT = get_turf(listener)
	var/turf/MT = get_turf(myplayer.soundsource)
	var/dist = get_dist(TT, MT)
	if(dist <= myplayer.playing_range)
		var/vol = myplayer.playing_volume - max(dist - myplayer.playing_range, 0) * 2
		S.volume = vol
		S.falloff = myplayer.playing_falloff
		S.environment = myplayer.env_id
	else
		S.volume = 0
	if(myplayer.environmental)
		var/dx = MT.x - TT.x
		S.x = dx
		var/dy = MT.y - TT.y
		S.z = dy
	else
		S.x = 0
		S.z = 1
	SEND_SOUND(listener, S)
	S.volume = 0
