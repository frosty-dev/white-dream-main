#define PRIKOL "prikol"
#define TECHNO "techno"
#define TOUHOU "touhou"
#define MORTAL "mortal"
#define NAZIST "nazist"

/area
	var/area_tension = 0
	var/enabled_area_tension = TRUE

PROCESSING_SUBSYSTEM_DEF(btension)
	name = "Battle Tension"
	priority = 15
	flags = SS_NO_INIT
	wait = 13
	var/forced_tension = FALSE

/datum/component/battletension
	var/mob/living/carbon/human/owner

	var/tension = 0
	var/sound/bm

/datum/component/battletension/Initialize()
	if(ishuman(parent))
		START_PROCESSING(SSbtension, src)
		owner = parent

/datum/component/battletension/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_BULLET_ACT, .proc/bulletact_react)
	RegisterSignal(parent, COMSIG_PARENT_ATTACKBY, .proc/attackby_react)

/datum/component/battletension/UnregisterFromParent()
	UnregisterSignal(parent, list(	COMSIG_ATOM_BULLET_ACT,
									COMSIG_PARENT_ATTACKBY
									))

/datum/component/battletension/Destroy()
	stop_bm()

	STOP_PROCESSING(SSbtension, src)
	owner = null
	return ..()

/datum/component/battletension/process()
	if(!owner.client)
		return
	if((!bm || !bm.file) && is_enabled())
		pick_sound()
		return

	if(owner.stat == DEAD && bm)
		bm.volume = 0
		bm.status = SOUND_UPDATE
		SEND_SOUND(owner, bm)
		return

	var/area/AR = get_area(owner)

	if(AR.area_tension && AR.enabled_area_tension)
		if(tension < AR.area_tension)
			tension += 3
		if(prob(30))
			AR.area_tension--
			if(AR.area_tension > 30)
				AR.area_tension = 30
	else if((HAS_TRAIT(owner, TRAIT_HACKER) || SSbtension.forced_tension) && tension <= 20)
		tension += 3

	if(tension <= 0 && bm)
		bm.volume = 0
		bm.status = SOUND_UPDATE
		SEND_SOUND(owner, bm)
		return

	if(tension >= 0)
		tension--

	if(bm)
		bm.volume = min(tension, owner.client.prefs.btvolume_max)
		bm.status = SOUND_UPDATE
		SEND_SOUND(owner, bm)

	switch(tension)
		if(0 to 60)
			tension--

		if(120 to INFINITY)
			tension = 80

/datum/component/battletension/proc/bulletact_react(datum/source, obj/projectile/P, def_zone)

	var/area/AR = get_area(P)

	AR.area_tension += P.damage

	create_tension(P.damage)

	if(!P.firer || P.firer == owner)
		return

	var/datum/component/battletension/BT = P.firer.GetComponent(/datum/component/battletension)

	if(BT)
		BT.create_tension(P.damage)


/datum/component/battletension/proc/attackby_react(datum/source, obj/item/I, mob/user)

	var/area/AR = get_area(user)

	AR.area_tension += I.force * 1.2

	create_tension(I.force * 1.2)

	if(!user || user == owner)
		return

	var/datum/component/battletension/BT = user.GetComponent(/datum/component/battletension)

	if(BT)
		BT.create_tension(I.force * 1.2)

/datum/component/battletension/proc/is_enabled()
	if(!owner || !owner.client || !owner.client.prefs.btprefsnew)
		return FALSE
	return TRUE

/datum/component/battletension/proc/create_tension(amount)
	if(!is_enabled())
		return

	amount = round(amount)

	if(tension)
		tension += amount
	else
		tension = amount

/datum/component/battletension/proc/stop_bm()
	if(bm)
		bm.volume = 0
		SEND_SOUND(owner, bm)
		qdel(bm)
		bm = null

/datum/component/battletension/proc/pick_sound(soundpath)
	stop_bm()

	var/sound/S

	if(soundpath)
		S = sound(soundpath)
	else
		var/list/soundlist = get_sound_list()
		if(soundlist && soundlist.len)
			S = sound(pick(soundlist))
		else
			return

	if(!S || !S.file)
		return

	S.repeat = 1
	S.channel = CHANNEL_BATTLETENSION
	S.falloff = 2
	S.wait = 0
	S.volume = 0
	S.status = 0
	S.environment = 0

	var/track_name = copytext(replacetext("[S.file]", ".ogg", ""), 25)
	to_chat(owner, "<span class='greenannounce'> > <b>ТЕКУЩИЙ ТРЕК: <i>[capitalize(track_name)]</i></b> \[<a href='?src=[REF(src)];switch=1'>ПЕРЕКЛЮЧИТЬ</a>\]</span>")
	tension = 30

	bm = S
	SEND_SOUND(owner, bm)

/datum/component/battletension/Topic(href,href_list)
	if(usr != owner)
		return
	if(href_list["switch"])
		pick_sound()
		return

/datum/component/battletension/proc/get_sound_list()
	if(!owner || !owner.client || !owner.client.prefs)
		return

	var/list/result = list()
	var/list/genres = owner.client.prefs.btprefsnew

	// Все треки должны быть проиндексированы здесь для того, чтобы игра добавляла их в кэш при компиляции и юзер не докачивал их посреди игры

	/*
		Также, чтобы трек был допущен в коммит, нужно прописать в папке с добавляемым треком команду:
			git add TRACKNAME.ogg
	*/

	var/list/bm_prikol = list(  'cfg/battle_music/prikol/Battlefield.ogg',
								'cfg/battle_music/prikol/gladiator.ogg',
								'cfg/battle_music/prikol/Ketchup.ogg',
								'cfg/battle_music/prikol/HIJACKED_GOVNOVOZ.ogg')
	var/list/bm_techno = list(  'cfg/battle_music/techno/03 NARC.ogg',
								'cfg/battle_music/techno/Acid-Notation - The Yanderes Puppet Show.ogg',
								'cfg/battle_music/techno/Carpenter Brut - Roller Mobster.ogg',
								'cfg/battle_music/techno/M O O N - Hydrogen.ogg',
								'cfg/battle_music/techno/Protector 101 - Hardware.ogg',
								'cfg/battle_music/techno/Street Cleaner - Murdercycle.ogg',
								'cfg/battle_music/techno/Umwelt - Faceless Power.ogg',
								'cfg/battle_music/techno/Overpass.ogg',
								'cfg/battle_music/techno/breakmedown.ogg')
	var/list/bm_touhou = list(  'cfg/battle_music/touhou/80sspark.ogg',
								'cfg/battle_music/touhou/badapple.ogg',
								'cfg/battle_music/touhou/Galaxy Collapse.ogg',
								'cfg/battle_music/touhou/Night of Bad Times.ogg',
								'cfg/battle_music/touhou/owenwasher.ogg')
	var/list/bm_mortal = list(  'cfg/battle_music/mortal/unstoppable.ogg')
	var/list/bm_nazist = list(  'cfg/battle_music/nazist/German Military Marches - Lore, Lore, Lore.ogg')
	var/list/bm_hacker = list(  'cfg/battle_music/hacker/Lena Raine - Electroheist.ogg',
								'cfg/battle_music/hacker/Remi Gallego - Payload.ogg')

	if((HAS_TRAIT(owner, TRAIT_HACKER)))
		return bm_hacker

	for(var/genre in genres)
		switch (genre)
			if (PRIKOL)
				result += bm_prikol
			if (TECHNO)
				result += bm_techno
			if (TOUHOU)
				result += bm_touhou
			if (MORTAL)
				result += bm_mortal
			if (NAZIST)
				result += bm_nazist

	return result

/client/verb/random_battletension()
	set name = " ▶️ Переключить трек"
	set desc = "Меняет текущий трек рандомно. Круто."
	set category = "Настройки"

	if(mob && ishuman(mob))
		var/datum/component/battletension/BT = mob.GetComponent(/datum/component/battletension)
		if(BT)
			BT.pick_sound()
	else
		to_chat(usr, "<span class='danger'> > Жаль, что я не <b>человек</b>.</span>")

/client/verb/customize_battletension()
	set name = "#️⃣ Настроить Battle Tension"
	set desc = "Allows for advanced prikol immersion."
	set category = "Настройки"

	var/list/genres = list(PRIKOL, TECHNO, TOUHOU, MORTAL, NAZIST)
	var/settings

	if(prefs.btvolume_max == null)
		prefs.btvolume_max = 10
		prefs.btprefsnew = genres
		prefs.save_preferences()

	if(prefs.btprefsnew)
		settings = prefs.btprefsnew

	var/list/menu = list()

	for(var/genre in genres)
		if(genre in settings)
			menu += genre + " ON"
		else
			menu += genre + " OFF"

	menu += "Громкость: [prefs.btvolume_max]%"

	var/selected = input("BT Customization") as null|anything in menu
	if(!selected)
		return

	selected = splittext(selected, " ")[1]

	if(selected == "Громкость:")
		var/new_volume = input(usr, "Громкость", null) as num|null
		if(new_volume)
			prefs.btvolume_max = max(0, min(100, new_volume))
			to_chat(usr, "<span class='danger'> > Выбрана максимальная громкость в [prefs.btvolume_max]%.</span>")
	else if(selected in settings)
		settings -= selected
		to_chat(usr, "<span class='danger'> > Больше не хочу [selected].</span>")
	else
		settings += selected
		to_chat(usr, "<span class='danger'> > Теперь хочу [selected].</span>")

	prefs.btprefsnew = settings
	prefs.save_preferences()

	if(mob)
		var/datum/component/battletension/BT = mob.GetComponent(/datum/component/battletension)
		if(BT)
			BT.pick_sound()
