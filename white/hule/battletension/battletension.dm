//частично спижжено со сталкербилда

#define BATTLE_MUSIC_PATH 			"white/hule/battletension/bm/"
#define BATTLE_MUSIC_TOUHOU 		list("80sspark.ogg","badapple.ogg")
#define BATTLE_MUSIC_SYNTH	 		list("digitalonslaught.ogg", "03 NARC.ogg")
#define BATTLE_MUSIC_PISTOLETOV	 	list("gladiator.ogg")

PROCESSING_SUBSYSTEM_DEF(btension)
	name = "Battle Tension"
	priority = 15
	flags = SS_NO_INIT
	wait = 10

/client/verb/toggle_battletension()
	set name = "Toggle Battle Tension"
	set desc = "Toggles battle music."
	set category = "Настройки"

	prefs.battlemusic = !prefs.battlemusic
	prefs.save_preferences()
	to_chat(usr, "<span class='danger'>Battle music [prefs.battlemusic ? "en" : "dis"]abled.</span>")

/mob/living
	var/datum/btension/battletension

//nasral na living_defense.dm & item_attack.dm & carbon_defense.dm & human_defence.dm

/mob/living/proc/create_tension(var/amount)
	if(client && !battletension)
		battletension = new /datum/btension
		battletension.owner = src

	if(!battletension || !client)
		return

	if(!client.prefs.battlemusic) //client != null? Let's runtime monkeys
		return

	if(!stat && battletension.tension && amount > 0)
		battletension.tension += amount
	else
		battletension.tension = amount

/datum/btension
	var/mob/living/owner
	var/tension = 0
	var/sound/bm

/datum/btension/New()
	. = ..()
	pick_sound()
	START_PROCESSING(SSbtension, src)

/datum/btension/Destroy()
	if(bm)
		qdel(bm)
	STOP_PROCESSING(SSbtension, src)
	. = ..()

/datum/btension/proc/get_sound_list(var/genre)
	var/list/genrelist
	if(genre)
		genrelist = genre
	else
		genrelist = pick(list(BATTLE_MUSIC_TOUHOU,BATTLE_MUSIC_SYNTH))

	var/list/bmlist = list()
	for(var/I in genrelist)
		bmlist += BATTLE_MUSIC_PATH + I
	return bmlist

/datum/btension/proc/pick_sound()
	var/sound/S = sound(pick(get_sound_list()))
	if(!S || !S.file)
		return
	S.repeat = 1
	S.channel = CHANNEL_BATTLETENSION
	S.falloff = 2
	S.wait = 0
	S.volume = 0
	S.status = SOUND_STREAM
	//S.environment = 0 //че это нахуй в доках нету
	bm = S
	SEND_SOUND(owner, bm)
	bm.status = SOUND_STREAM

/datum/btension/process()
	if(!bm || !bm.file)
		return

	switch(tension)
	/*
		if(-INFINITY to 0)
			bm.volume = 0
			SEND_SOUND(owner, bm)
			bm.status = SOUND_UPDATE
	*/
		if(1 to 30)
			bm.volume = tension
			SEND_SOUND(owner, bm)
			bm.status = SOUND_UPDATE
			tension -= 1
		if(31 to 79)
			bm.volume = tension
			SEND_SOUND(owner, bm)
			bm.status = SOUND_UPDATE
		/*	var/i
			for (i = 0, i < 10, i++)
				battle_screen_on()
				sleep(1)
				set_blurriness(0)
				sleep(1)*/
		if(80 to INFINITY)
			tension = 80
			bm.volume = 80
			SEND_SOUND(owner, bm)
			bm.status = SOUND_UPDATE

	if(tension > 0)
		tension -= 2
		if(tension <= 0)
			qdel(bm)
			pick_sound()
