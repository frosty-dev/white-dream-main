GLOBAL_VAR_INIT(prikol_mode, FALSE)
GLOBAL_LIST_EMPTY(frabbers)

/mob/living
	var/datum/cs_killcounter/killcounter

//nasral na living.dm

/datum/cs_killcounter
	var/mob/living/owner
	var/killcount = 0
	var/killstreak = 0
	var/maxkillstreak = 0
	var/time4kill = 10
	var/timer = 0
	var/force_enable = FALSE

/datum/cs_killcounter/New()
	. = ..()
	START_PROCESSING(SSobj, src)

/datum/cs_killcounter/Destroy()
	STOP_PROCESSING(SSobj, src)
	maxkillstreak = killstreak
	. = ..()

/datum/cs_killcounter/process()
	if(timer)
		timer--
	else
		maxkillstreak = killstreak
		killstreak = 0

/datum/cs_killcounter/proc/count_kill()
	killcount++

	killstreak++
	timer += time4kill

	if(!GLOB.prikol_mode || owner.mind.antag_datums || force_enable) //пиздец уебищно выглядит лень придумывать другое
		var/count = FALSE
		for(var/datum/antagonist/A in owner.mind.antag_datums)
			if(istype(A, /datum/antagonist/traitor) && (/datum/objective/hijack in A.objectives))
				count = TRUE
			else if(istype(A, /datum/antagonist/nukeop))
				count = TRUE
			else if(force_enable)
				count = TRUE

		if(!count)
			return

	killsound()

/datum/cs_killcounter/proc/killsound() // ya hz ebat' y menya kakayata huevaya liba zvukov iz cs
	var/turf/T = get_turf(owner)
	switch(killstreak)
		if(2)
			playsound(T,'white/hule/SFX/csSFX/doublekill1_ultimate.wav', 150, 5, pressure_affected = FALSE)
		if(3)
			playsound(T,'white/hule/SFX/csSFX/triplekill_ultimate.wav', 150, 5, pressure_affected = FALSE)
		if(4)
			playsound(T,'white/hule/SFX/csSFX/killingspree.wav', 150, 5, pressure_affected = FALSE)
		if(5)
			playsound(T,'white/hule/SFX/csSFX/godlike.wav', 150, 5, pressure_affected = FALSE)
		if(6)
			playsound(T,'white/hule/SFX/csSFX/monsterkill.wav', 150, 5, pressure_affected = FALSE)
		if(7)
			playsound(T,'white/hule/SFX/csSFX/multikill.wav', 150, 5, pressure_affected = FALSE)
		if(8)
			playsound(T,'white/hule/SFX/csSFX/multikill.wav', 150, 5, pressure_affected = FALSE)
		if(9 to INFINITY)
			playsound(T,'white/hule/SFX/csSFX/holyshit.wav', 150, 5, pressure_affected = FALSE)

/client/proc/toggle_prikol()
	set category = "Фан"
	set name = "Toggle P.R.I.K.O.L"

/*
	if(!(usr.ckey in GLOB.anonists))
		to_chat(usr, "<span class='userdanger'>Сорри, но ето бекдор, вам нельзя.........</span>")
		return
*/
	if(!check_rights())
		return

	GLOB.prikol_mode = !GLOB.prikol_mode

	if(GLOB.prikol_mode)
		message_admins("[key] toggled P.R.I.K.O.L mode on.")
	else
		message_admins("[key] toggled P.R.I.K.O.L mode off.")

/mob/living
	var/force_killcount = FALSE

//nasral na death.dm

/proc/secure_kill(var/frabberckey)
	if(!frabberckey)
		return

	if(GLOB.frabbers[frabberckey])
		GLOB.frabbers[frabberckey]++
	else
		GLOB.frabbers[frabberckey] = 1

	for(var/mob/living/L in GLOB.player_list)
		if(L.ckey == frabberckey)
			L.killcounter.count_kill()
