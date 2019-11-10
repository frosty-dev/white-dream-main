PROCESSING_SUBSYSTEM_DEF(btension)
	name = "Battle Tension"
	priority = 15
	flags = SS_NO_INIT
	wait = 10

/datum/component/battletension
	var/mob/living/owner

	var/tension = 0
	var/sound/bm

/datum/component/battletension/Initialize()
	START_PROCESSING(SSbtension, src)

	if(isliving(parent))
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
	if((!bm || !bm.file) && is_enabled())
		pick_sound()

	if(tension > 0)
		tension--
		if(tension <= 0)
			pick_sound()

	if(tension < 0)
		return

	if(bm)
		bm.volume = tension
		bm.status = SOUND_UPDATE
		SEND_SOUND(owner, bm)

	switch(tension)
		if(0 to 30)
			tension--

		if(80 to INFINITY)
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
	if(!owner || !owner.client || !owner.client.prefs.btprefs)
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
	S.channel = 1015
	S.falloff = 2
	S.wait = 0
	S.volume = 0
	S.status = 0

	bm = S
	SEND_SOUND(owner, bm)

/datum/component/battletension/proc/get_sound_list()
	var/list/result = list()
	var/list/sounds = list(
							list(
								"gladiator.ogg",
								"Battlefield.ogg"
							),
							list(
								"digitalonslaught.ogg",
								"03 NARC.ogg",
								"Maciej Niedzielski - Old Military Base.ogg",
								"Locknar - Industrial Complex.ogg",
								"Perturbator - Tactical Precision Disarray.ogg",
								"M O O N - Hydrogen.ogg",
								"Carpenter Brut - Roller Mobster.ogg",
								"Acid-Notation - The Yanderes Puppet Show.ogg",
								"Street Cleaner - Murdercycle.ogg",
								"Protector 101 - Hardware.ogg",
								""
							),
							list(
								"80sspark.ogg",
								"badapple.ogg",
								"Galaxy Collapse.ogg"
							),
							list(
								"unstoppable.ogg"
							),
							list(
								"German Military Marches - Lore, Lore, Lore.ogg"
							))
	if(!owner || !owner.client || !owner.client.prefs)
		return

	var/settings = owner.client.prefs.btprefs

	var/i = 0

	for(var/item in sounds)
		if(settings & 2**i)
			for(var/ii in item)
				result += "code/shitcode/hule/battletension/bm/" + ii
		i++

	return result

/client/verb/customize_battletension()
	set name = "Настроить Battle Tension"
	set desc = "Allows for advanced prikol immersion."
	set category = "Preferences"

	var/settings





	if(prefs.btprefs)
		if(islist(prefs.btprefs))
			prefs.btprefs = 0
			prefs.save_preferences()
		settings = prefs.btprefs
	else
		settings = 0

	var/list/options = list("приколов", "техноту", "тохо", "мк", "любить вайт")
	var/list/revmenu = list("приколов"=0, "техноту"=1, "тохо"=2, "мк"=3, "любить вайт"=4)

	var/list/menu = list()

	var/i = 0
	for(var/item in options)
		if(settings & 2**i)
			menu += "Не хочу " + item
		else
			menu += "Хочу " + item
		i++

	var/selected = input("a a a a a", "BT Customization") as null|anything in menu
	if(!selected)
		return
	selected = splittext(selected, " ")[2]

	var/settbit = 2**revmenu[selected]

	if(settings & settbit)
		settings &= ~settbit
		to_chat(usr, "<span class='danger'>Ты больше не хочешь [selected].</span>")
	else
		settings |= settbit
		to_chat(usr, "<span class='danger'>Теперь ты хочешь [selected].</span>")

	prefs.btprefs = settings
	prefs.save_preferences()

	if(mob)
		var/datum/component/battletension/BT = mob.GetComponent(/datum/component/battletension)
		if(BT)
			BT.pick_sound()
