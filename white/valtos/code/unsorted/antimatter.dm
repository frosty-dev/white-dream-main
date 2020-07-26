
/datum/supply_pack/engine/am_jar
	name = "Antimatter Containment Jar Crate"
	desc = "Two Antimatter containment jars stuffed into a single crate."
	cost = 2000
	contains = list(/obj/item/am_containment,
					/obj/item/am_containment)
	crate_name = "antimatter jar crate"

/datum/supply_pack/engine/am_core
	name = "Antimatter Control Crate"
	desc = "The brains of the Antimatter engine, this device is sure to teach the station's powergrid the true meaning of real power."
	cost = 5000
	contains = list(/obj/machinery/power/am_control_unit)
	crate_name = "antimatter control crate"

/datum/supply_pack/engine/am_shielding
	name = "Antimatter Shielding Crate"
	desc = "Contains ten Antimatter shields, somehow crammed into a crate."
	cost = 2000
	contains = list(/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,) //9 shields: 3x3 containment and a core
	crate_name = "antimatter shielding crate"

/datum/export/large/am_control_unit
	cost = 4000
	unit_name = "antimatter control unit"
	export_types = list(/obj/machinery/power/am_control_unit)

/datum/export/large/am_shielding_container
	cost = 150
	unit_name = "packaged antimatter reactor section"
	export_types = list(/obj/item/am_shielding_container)

/obj/item/am_containment
	name = "сосуд для антивещества"
	desc = "Удерживает антивещество."
	icon = 'white/valtos/icons/antimatter.dmi'
	icon_state = "jar"
	density = FALSE
	anchored = FALSE
	force = 8
	throwforce = 10
	throw_speed = 1
	throw_range = 2

	var/fuel = 10000
	var/fuel_max = 10000//Lets try this for now
	var/stability = 100//TODO: add all the stability things to this so its not very safe if you keep hitting in on things


/obj/item/am_containment/ex_act(severity, target)
	switch(severity)
		if(1)
			explosion(get_turf(src), 1, 2, 3, 5)//Should likely be larger but this works fine for now I guess
			if(src)
				qdel(src)
		if(2)
			if(prob((fuel/10)-stability))
				explosion(get_turf(src), 1, 2, 3, 5)
				if(src)
					qdel(src)
				return
			stability -= 40
		if(3)
			stability -= 20
	//check_stability()
	return

/obj/item/am_containment/proc/usefuel(wanted)
	if(fuel < wanted)
		wanted = fuel
	fuel -= wanted
	return wanted

/obj/machinery/power/am_control_unit
	name = "блок управления антивеществом"
	desc = "Это устройство вводит антивещество в подключенные экранирующие устройства, чем больше антивещества вводится, тем больше вырабатывается энергии. Разверните устройство, чтобы настроить его."
	icon = 'white/valtos/icons/antimatter.dmi'
	icon_state = "control"
	anchored = FALSE
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 100
	active_power_usage = 1000

	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND | INTERACT_ATOM_UI_INTERACT | INTERACT_ATOM_REQUIRES_ANCHORED

	var/list/obj/machinery/am_shielding/linked_shielding
	var/list/obj/machinery/am_shielding/linked_cores
	var/obj/item/am_containment/fueljar
	var/update_shield_icons = 0
	var/stability = 100
	var/exploding = 0

	var/active = 0//On or not
	var/fuel_injection = 2//How much fuel to inject
	var/shield_icon_delay = 0//delays resetting for a short time
	var/reported_core_efficiency = 0

	var/power_cycle = 0
	var/power_cycle_delay = 4//How many ticks till produce_power is called
	var/stored_core_stability = 0
	var/stored_core_stability_delay = 0

	var/stored_power = 0//Power to deploy per tick


/obj/machinery/power/am_control_unit/Initialize()
	. = ..()
	linked_shielding = list()
	linked_cores = list()


/obj/machinery/power/am_control_unit/Destroy()//Perhaps damage and run stability checks rather than just del on the others
	for(var/obj/machinery/am_shielding/AMS in linked_shielding)
		AMS.control_unit = null
		qdel(AMS)
	QDEL_NULL(fueljar)
	return ..()


/obj/machinery/power/am_control_unit/process()
	if(exploding)
		explosion(get_turf(src),8,12,18,12)
		if(src)
			qdel(src)

	if(update_shield_icons && !shield_icon_delay)
		check_shield_icons()
		update_shield_icons = 0

	if(machine_stat & (NOPOWER|BROKEN) || !active)//can update the icons even without power
		return

	if(!fueljar)//No fuel but we are on, shutdown
		toggle_power()
		playsound(src.loc, 'sound/machines/buzz-two.ogg', 50, 0)
		return

	add_avail(stored_power)

	power_cycle++
	if(power_cycle >= power_cycle_delay)
		produce_power()
		power_cycle = 0

	return


/obj/machinery/power/am_control_unit/proc/produce_power()
	playsound(src.loc, 'sound/effects/bang.ogg', 25, 1)
	var/core_power = reported_core_efficiency//Effectively how much fuel we can safely deal with
	if(core_power <= 0)
		return 0//Something is wrong
	var/core_damage = 0
	var/fuel = fueljar.usefuel(fuel_injection)

	stored_power = (fuel/core_power)*fuel*2000
	//Now check if the cores could deal with it safely, this is done after so you can overload for more power if needed, still a bad idea
	if(fuel > (2*core_power))//More fuel has been put in than the current cores can deal with
		if(prob(50))
			core_damage = 1//Small chance of damage
		if((fuel-core_power) > 5)
			core_damage = 5//Now its really starting to overload the cores
		if((fuel-core_power) > 10)
			core_damage = 20//Welp now you did it, they wont stand much of this
		if(core_damage == 0)
			return
		for(var/obj/machinery/am_shielding/AMS in linked_cores)
			AMS.stability -= core_damage
			AMS.check_stability(1)
		playsound(src.loc, 'sound/effects/bang.ogg', 50, 1)
	return


/obj/machinery/power/am_control_unit/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	switch(severity)
		if(1)
			if(active)
				toggle_power()
			stability -= rand(15,30)
		if(2)
			if(active)
				toggle_power()
			stability -= rand(10,20)

/obj/machinery/power/am_control_unit/blob_act()
	stability -= 20
	if(prob(100-stability))//Might infect the rest of the machine
		for(var/obj/machinery/am_shielding/AMS in linked_shielding)
			AMS.blob_act()
		qdel(src)
		return
	check_stability()
	return


/obj/machinery/power/am_control_unit/ex_act(severity, target)
	stability -= (80 - (severity * 20))
	check_stability()
	return


/obj/machinery/power/am_control_unit/bullet_act(obj/projectile/Proj)
	. = ..()
	if(Proj.flag != "bullet")
		stability -= Proj.force
		check_stability()


/obj/machinery/power/am_control_unit/power_change()
	..()
	if(machine_stat & NOPOWER)
		if(active)
			toggle_power(1)
		else
			use_power = NO_POWER_USE

	else if(!machine_stat && anchored)
		use_power = IDLE_POWER_USE

	return


/obj/machinery/power/am_control_unit/update_icon()
	if(active)
		icon_state = "control_on"
	else icon_state = "control"
	//No other icons for it atm


/obj/machinery/power/am_control_unit/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_WRENCH)
		if(!anchored)
			W.play_tool_sound(src, 75)
			user.visible_message("<b>[user.name]</b> прикручивает <b>[src.name]</b> к полу.", \
				"<span class='notice'>Прикручиваю удерживающие болты к полу.</span>", \
				"<span class='italics'>Слышу как крутят что-то.</span>")
			src.anchored = TRUE
			connect_to_network()
		else if(!linked_shielding.len > 0)
			W.play_tool_sound(src, 75)
			user.visible_message("<b>[user.name]</b> откручивает <b>[src.name]</b> от пола.", \
				"<span class='notice'>Откручиваю от пола.</span>", \
				"<span class='italics'>Слышу как крутят что-то.</span>")
			src.anchored = FALSE
			disconnect_from_network()
		else
			to_chat(user, "<span class='warning'>Как только <b>[src.name]</b> собран и подключён он не может быть передвинут!</span>")

	else if(istype(W, /obj/item/am_containment))
		if(fueljar)
			to_chat(user, "<span class='warning'>Здесь уже есть [fueljar] внутри!</span>")
			return

		if(!user.transferItemToLoc(W, src))
			return
		fueljar = W
		user.visible_message("<b>[user.name]</b> загружает <b>[W.name]</b> внутрь <b>[src.name]</b>.", \
				"<span class='notice'>Загружаю <b>[W.name]</b>.</span>", \
				"<span class='italics'>Слышу стук.</span>")
	else
		return ..()


/obj/machinery/power/am_control_unit/take_damage(damage, damage_type = BRUTE, sound_effect = 1)
	switch(damage_type)
		if(BRUTE)
			if(sound_effect)
				if(damage)
					playsound(loc, 'sound/weapons/smash.ogg', 50, 1)
				else
					playsound(loc, 'sound/weapons/tap.ogg', 50, 1)
		if(BURN)
			if(sound_effect)
				playsound(src.loc, 'sound/items/welder.ogg', 100, 1)
		else
			return
	if(damage >= 20)
		stability -= damage/2
		check_stability()

/obj/machinery/power/am_control_unit/proc/add_shielding(obj/machinery/am_shielding/AMS, AMS_linking = 0)
	if(!istype(AMS))
		return 0
	if(!anchored)
		return 0
	if(!AMS_linking && !AMS.link_control(src))
		return 0
	linked_shielding.Add(AMS)
	update_shield_icons = 1
	return 1


/obj/machinery/power/am_control_unit/proc/remove_shielding(obj/machinery/am_shielding/AMS)
	if(!istype(AMS))
		return 0
	linked_shielding.Remove(AMS)
	update_shield_icons = 2
	if(active)
		toggle_power()
	return 1


/obj/machinery/power/am_control_unit/proc/check_stability()//TODO: make it break when low also might want to add a way to fix it like a part or such that can be replaced
	if(stability <= 0)
		qdel(src)
	return


/obj/machinery/power/am_control_unit/proc/toggle_power(powerfail = 0)
	active = !active
	if(active)
		use_power = ACTIVE_POWER_USE
		visible_message("<b>[src.name]</b> запускается.")
	else
		use_power = !powerfail
		visible_message("<b>[src.name]</b> выключается.")
	update_icon()
	return


/obj/machinery/power/am_control_unit/proc/check_shield_icons()//Forces icon_update for all shields
	if(shield_icon_delay)
		return
	shield_icon_delay = 1
	if(update_shield_icons == 2)//2 means to clear everything and rebuild
		for(var/obj/machinery/am_shielding/AMS in linked_shielding)
			if(AMS.processing)
				AMS.shutdown_core()
			AMS.control_unit = null
			addtimer(CALLBACK(AMS, /obj/machinery/am_shielding.proc/controllerscan), 10)
		linked_shielding = list()
	else
		for(var/obj/machinery/am_shielding/AMS in linked_shielding)
			AMS.update_icon()
	addtimer(CALLBACK(src, .proc/reset_shield_icon_delay), 20)

/obj/machinery/power/am_control_unit/proc/reset_shield_icon_delay()
	shield_icon_delay = 0

/obj/machinery/power/am_control_unit/proc/check_core_stability()
	if(stored_core_stability_delay || linked_cores.len <= 0)
		return
	stored_core_stability_delay = 1
	stored_core_stability = 0
	for(var/obj/machinery/am_shielding/AMS in linked_cores)
		stored_core_stability += AMS.stability
	stored_core_stability/=linked_cores.len
	addtimer(CALLBACK(src, .proc/reset_stored_core_stability_delay), 40)

/obj/machinery/power/am_control_unit/proc/reset_stored_core_stability_delay()
	stored_core_stability_delay = 0

/obj/machinery/power/am_control_unit/ui_interact(mob/user)
	. = ..()
	if((get_dist(src, user) > 1) || (machine_stat & (BROKEN|NOPOWER)))
		if(!isAI(user))
			user.unset_machine()
			user << browse(null, "window=AMcontrol")
			return

	var/dat = "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">"
	dat += "Панель управления антивеществом<BR>"
	dat += "<A href='?src=[REF(src)];close=1'>Закрыть</A><BR>"
	dat += "<A href='?src=[REF(src)];refresh=1'>Обновить</A><BR>"
	dat += "<A href='?src=[REF(src)];refreshicons=1'>Обновление силовой защиты</A><BR><BR>"
	dat += "Состояние: [(active?"Вводится":"Ожидает")] <BR>"
	dat += "<A href='?src=[REF(src)];togglestatus=1'>Переключить</A><BR>"

	dat += "Стабильность: [stability]%<BR>"
	dat += "Части реактора: [linked_shielding.len]<BR>"//TODO: perhaps add some sort of stability check
	dat += "Ядра: [linked_cores.len]<BR><BR>"
	dat += "- Текущая эффективность: [reported_core_efficiency]<BR>"
	dat += "- Средняя стабильность: [stored_core_stability] <A href='?src=[REF(src)];refreshstability=1'>(обновить)</A><BR>"
	dat += "В последний раз произведено: [DisplayPower(stored_power)]<BR>"

	dat += "Топливо: "
	if(!fueljar)
		dat += "<BR>Не обнаружено топливных ячеек."
	else
		dat += "<A href='?src=[REF(src)];ejectjar=1'>Изъять</A><BR>"
		dat += "- [fueljar.fuel]/[fueljar.fuel_max] юнитов<BR>"

		dat += "- Ввод: [fuel_injection] юнитов<BR>"
		dat += "- <A href='?src=[REF(src)];strengthdown=1'>--</A>|<A href='?src=[REF(src)];strengthup=1'>++</A><BR><BR>"


	user << browse(dat, "window=AMcontrol;size=420x500")
	onclose(user, "AMcontrol")
	return


/obj/machinery/power/am_control_unit/Topic(href, href_list)
	if(..())
		return

	if(href_list["close"])
		usr << browse(null, "window=AMcontrol")
		usr.unset_machine()
		return

	if(href_list["togglestatus"])
		toggle_power()

	if(href_list["refreshicons"])
		update_shield_icons = 1

	if(href_list["ejectjar"])
		if(fueljar)
			fueljar.forceMove(drop_location())
			fueljar = null
			//fueljar.control_unit = null currently it does not care where it is
			//update_icon() when we have the icon for it

	if(href_list["strengthup"])
		fuel_injection++

	if(href_list["strengthdown"])
		fuel_injection--
		if(fuel_injection < 0)
			fuel_injection = 0

	if(href_list["refreshstability"])
		check_core_stability()

	updateDialog()
	return

//like orange but only checks north/south/east/west for one step
/proc/cardinalrange(var/center)
	var/list/things = list()
	for(var/direction in GLOB.cardinals)
		var/turf/T = get_step(center, direction)
		if(!T)
			continue
		things += T.contents
	return things

/obj/machinery/am_shielding
	name = "реакторная секция антивещества"
	desc = "Это устройство было построено с использованием плазменной формы жизни, которая, по-видимому, увеличивает естественную способность плазмы реагировать с нейтрино при одновременном снижении горючести."

	icon = 'white/valtos/icons/antimatter.dmi'
	icon_state = "shield"
	density = TRUE
	dir = NORTH
	use_power = NO_POWER_USE//Living things generally dont use power
	idle_power_usage = 0
	active_power_usage = 0

	var/obj/machinery/power/am_control_unit/control_unit = null
	var/processing = FALSE//To track if we are in the update list or not, we need to be when we are damaged and if we ever
	var/stability = 100//If this gets low bad things tend to happen
	var/efficiency = 1//How many cores this core counts for when doing power processing, plasma in the air and stability could affect this
	var/coredirs = 0
	var/dirs = 0


/obj/machinery/am_shielding/Initialize()
	. = ..()
	addtimer(CALLBACK(src, .proc/controllerscan), 10)

/obj/machinery/am_shielding/proc/overheat()
	visible_message("<span class='danger'><b>[src]</b> тает!</span>")
	new /obj/effect/hotspot(loc)
	qdel(src)

/obj/machinery/am_shielding/proc/collapse()
	visible_message("<span class='notice'><b>[src]</b> схлопывается обратно в контейнер!</span>")
	new /obj/item/am_shielding_container(drop_location())
	qdel(src)

/obj/machinery/am_shielding/proc/controllerscan(priorscan = 0)
	//Make sure we are the only one here
	if(!isturf(loc))
		collapse()
	for(var/obj/machinery/am_shielding/AMS in loc.contents)
		if(AMS == src)
			continue
		collapse()
		return

	//Search for shielding first
	for(var/obj/machinery/am_shielding/AMS in cardinalrange(src))
		if(AMS && AMS.control_unit && link_control(AMS.control_unit))
			break

	if(!control_unit)//No other guys nearby look for a control unit
		for(var/direction in GLOB.cardinals)
		for(var/obj/machinery/power/am_control_unit/AMC in cardinalrange(src))
			if(AMC.add_shielding(src))
				break

	if(!control_unit)
		if(!priorscan)
			addtimer(CALLBACK(src, .proc/controllerscan, 1), 20)
			return
		collapse()


/obj/machinery/am_shielding/Destroy()
	if(control_unit)
		control_unit.remove_shielding(src)
	if(processing)
		shutdown_core()
	//Might want to have it leave a mess on the floor but no sprites for now
	return ..()


/obj/machinery/am_shielding/CanPass(atom/movable/mover, turf/target)
	. = ..()
	return 0

/obj/machinery/am_shielding/process()
	if(!processing)
		. = PROCESS_KILL
	//TODO: core functions and stability
	//TODO: think about checking the airmix for plasma and increasing power output
	return


/obj/machinery/am_shielding/emp_act()//Immune due to not really much in the way of electronics.
	return

/obj/machinery/am_shielding/ex_act(severity, target)
	stability -= (80 - (severity * 20))
	check_stability()
	return


/obj/machinery/am_shielding/bullet_act(obj/projectile/Proj)
	. = ..()
	if(Proj.flag != "bullet")
		stability -= Proj.force/2
		check_stability()


/obj/machinery/am_shielding/update_icon()
	dirs = 0
	coredirs = 0
	cut_overlays()
	for(var/direction in GLOB.alldirs)
		var/turf/T = get_step(loc, direction)
		for(var/obj/machinery/machine in T)
			if(istype(machine, /obj/machinery/am_shielding))
				var/obj/machinery/am_shielding/shield = machine
				if(shield.control_unit == control_unit)
					if(shield.processing)
						coredirs |= direction
					if(direction in GLOB.cardinals)
						dirs |= direction

			else
				if(istype(machine, /obj/machinery/power/am_control_unit) && (direction in GLOB.cardinals))
					var/obj/machinery/power/am_control_unit/control = machine
					if(control == control_unit)
						dirs |= direction


	var/prefix = ""
	var/icondirs=dirs

	if(coredirs)
		prefix="core"

	icon_state = "[prefix]shield_[icondirs]"

	if(core_check())
		add_overlay("core[control_unit && control_unit.active]")
		if(!processing)
			setup_core()
	else if(processing)
		shutdown_core()


/obj/machinery/am_shielding/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1)
	switch(damage_type)
		if(BRUTE)
			if(sound_effect)
				if(damage_amount)
					playsound(loc, 'sound/weapons/smash.ogg', 50, 1)
				else
					playsound(loc, 'sound/weapons/tap.ogg', 50, 1)
		if(BURN)
			if(sound_effect)
				playsound(src.loc, 'sound/items/welder.ogg', 100, 1)
		else
			return
	if(damage_amount >= 10)
		stability -= damage_amount/2
		check_stability()


//Call this to link a detected shilding unit to the controller
/obj/machinery/am_shielding/proc/link_control(obj/machinery/power/am_control_unit/AMC)
	if(!istype(AMC))
		return 0
	if(control_unit && control_unit != AMC)
		return 0//Already have one
	control_unit = AMC
	control_unit.add_shielding(src,1)
	return 1


//Scans cards for shields or the control unit and if all there it
/obj/machinery/am_shielding/proc/core_check()
	for(var/direction in GLOB.alldirs)
		var/found_am_device=0
		for(var/obj/machinery/machine in get_step(loc, direction))
			if(!machine)
				continue//Need all for a core
			if(istype(machine, /obj/machinery/am_shielding) || istype(machine, /obj/machinery/power/am_control_unit))
				found_am_device = 1
				break
		if(!found_am_device)
			return 0
	return 1


/obj/machinery/am_shielding/proc/setup_core()
	processing = TRUE
	GLOB.machines |= src
	START_PROCESSING(SSmachines, src)
	if(!control_unit)
		return
	control_unit.linked_cores.Add(src)
	control_unit.reported_core_efficiency += efficiency
	return


/obj/machinery/am_shielding/proc/shutdown_core()
	processing = FALSE
	if(!control_unit)
		return
	control_unit.linked_cores.Remove(src)
	control_unit.reported_core_efficiency -= efficiency
	return


/obj/machinery/am_shielding/proc/check_stability(injecting_fuel = 0)
	if(stability > 0)
		return
	if(injecting_fuel && control_unit)
		control_unit.exploding = 1
	if(src)
		overheat()
	return


/obj/machinery/am_shielding/proc/recalc_efficiency(new_efficiency)//tbh still not 100% sure how I want to deal with efficiency so this is likely temp
	if(!control_unit || !processing)
		return
	if(stability < 50)
		new_efficiency /= 2
	control_unit.reported_core_efficiency += (new_efficiency - efficiency)
	efficiency = new_efficiency
	return



/obj/item/am_shielding_container
	name = "секция реактора с насадкой из антивещества"
	desc = "Небольшая единица хранения, содержащая секцию реактора антиматерии. Использовать место возле блока управления антивеществом или развернутой секции реактора антивещества. Используйте мультитул для активации этого пакета."
	icon = 'white/valtos/icons/antimatter.dmi'
	icon_state = "box"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	flags_1 = CONDUCT_1
	throwforce = 5
	throw_speed = 1
	throw_range = 2
	custom_materials = list(/datum/material/iron=100)

/obj/item/am_shielding_container/multitool_act(mob/living/user, obj/item/I)
	if(isturf(loc))
		new/obj/machinery/am_shielding(loc)
		qdel(src)
		return TRUE
