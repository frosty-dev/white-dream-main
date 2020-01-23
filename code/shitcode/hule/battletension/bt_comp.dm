#define PRIKOL "prikol"
#define TECHNO "techno"
#define TOUHOU "touhou"
#define MORTAL "mortal"
#define NAZIST "nazist"

PROCESSING_SUBSYSTEM_DEF(btension)
	name = "Battle Tension"
	priority = 15
	flags = SS_NO_INIT
	wait = 13

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
	if((!bm || !bm.file) && is_enabled() && tension > 0)
		pick_sound()

	if(tension <= 0)
		stop_bm()

	if(tension >= 0)
		tension--

	if(bm)
		bm.volume = tension
		bm.status = SOUND_UPDATE
		SEND_SOUND(owner, bm)

	switch(tension)
		if(0 to 60)
			tension--

		if(120 to INFINITY)
			tension = 80

/datum/component/battletension/proc/bulletact_react(datum/source, obj/projectile/P, def_zone)
	create_tension(P.damage)

	if(!P.firer || P.firer == owner)
		return

	var/datum/component/battletension/BT = P.firer.GetComponent(/datum/component/battletension)

	if(BT)
		BT.create_tension(P.damage)


/datum/component/battletension/proc/attackby_react(datum/source, obj/item/I, mob/user)
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

	bm = S
	SEND_SOUND(owner, bm)

/datum/component/battletension/proc/get_sound_list()
	if(!owner || !owner.client || !owner.client.prefs)
		return

	var/list/result = list()
	var/list/genres = owner.client.prefs.btprefsnew

	var/list/bm_prikol = list('cfg/battle_music/prikol/Battlefield.ogg', 'cfg/battle_music/prikol/gladiator.ogg')
	var/list/bm_techno = list('cfg/battle_music/techno/03 NARC.ogg', 'cfg/battle_music/techno/Acid-Notation - The Yanderes Puppet Show.ogg', 'cfg/battle_music/techno/Carpenter Brut - Roller Mobster.ogg', 'cfg/battle_music/techno/M O O N - Hydrogen.ogg', 'cfg/battle_music/techno/Protector 101 - Hardware.ogg', 'cfg/battle_music/techno/Street Cleaner - Murdercycle.ogg')
	var/list/bm_touhou = list('cfg/battle_music/touhou/80sspark.ogg', 'cfg/battle_music/touhou/badapple.ogg', 'cfg/battle_music/touhou/Galaxy Collapse.ogg')
	var/list/bm_mortal = list('cfg/battle_music/mortal/unstoppable.ogg')
	var/list/bm_nazist = list('cfg/battle_music/nazist/German Military Marches - Lore, Lore, Lore.ogg')

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

/client/verb/customize_battletension()
	set name = " #️⃣ Настроить Battle Tension"
	set desc = "Allows for advanced prikol immersion."
	set category = "НАСТРОЙКИ"

	var/list/genres = list(PRIKOL, TECHNO, TOUHOU, MORTAL, NAZIST)
	var/settings

	if(prefs.btprefsnew == null)
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

	var/selected = input("BT Customization") as null|anything in menu
	if(!selected)
		return

	selected = splittext(selected, " ")[1]

	if(selected in settings)
		settings -= selected
		to_chat(usr, "<span class='danger'>Больше не хочу [selected].</span>")
	else
		settings += selected
		to_chat(usr, "<span class='danger'>Теперь хочу [selected].</span>")

	prefs.btprefsnew = settings
	prefs.save_preferences()

	if(mob)
		var/datum/component/battletension/BT = mob.GetComponent(/datum/component/battletension)
		if(BT)
			BT.pick_sound()
