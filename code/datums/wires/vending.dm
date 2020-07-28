/datum/wires/vending
	holder_type = /obj/machinery/vending
	proper_name = "Vending Unit"

/datum/wires/vending/New(atom/holder)
	wires = list(
		WIRE_THROW, WIRE_SHOCK, WIRE_SPEAKER,
		WIRE_CONTRABAND, WIRE_IDSCAN
	)
	add_duds(1)
	..()

/datum/wires/vending/interactable(mob/user)
	var/obj/machinery/vending/V = holder
	if(!issilicon(user) && V.seconds_electrified && V.shock(user, 100))
		return FALSE
	if(V.panel_open)
		return TRUE

/datum/wires/vending/get_status()
	var/obj/machinery/vending/V = holder
	var/list/status = list()
	status += "Оранжевый индикатор [V.seconds_electrified ? "горит" : "не горит"]."
	status += "Красный индикатор [V.shoot_inventory ? "не горит" : "мигает"]."
	status += "Зелёный индикатор [V.extended_inventory ? "горит" : "не горит"]."
	status += "[V.scan_id ? "Фиолетовый" : "Жёлтый"] индикатор горит."
	status += "Белый индикатор [V.age_restrictions ? "горит" : "не горит"]."
	status += "Индикатор динамика [V.shut_up ? "не горит" : "горит"]."
	return status

/datum/wires/vending/on_pulse(wire)
	var/obj/machinery/vending/V = holder
	switch(wire)
		if(WIRE_THROW)
			V.shoot_inventory = !V.shoot_inventory
		if(WIRE_CONTRABAND)
			V.extended_inventory = !V.extended_inventory
		if(WIRE_SHOCK)
			V.seconds_electrified = MACHINE_DEFAULT_ELECTRIFY_TIME
		if(WIRE_IDSCAN)
			V.scan_id = !V.scan_id
		if(WIRE_SPEAKER)
			V.shut_up = !V.shut_up
		if(WIRE_AGELIMIT)
			V.age_restrictions = !V.age_restrictions

/datum/wires/vending/on_cut(wire, mend)
	var/obj/machinery/vending/V = holder
	switch(wire)
		if(WIRE_THROW)
			V.shoot_inventory = !mend
		if(WIRE_CONTRABAND)
			V.extended_inventory = FALSE
		if(WIRE_SHOCK)
			if(mend)
				V.seconds_electrified = MACHINE_NOT_ELECTRIFIED
			else
				V.seconds_electrified = MACHINE_ELECTRIFIED_PERMANENT
		if(WIRE_IDSCAN)
			V.scan_id = mend
		if(WIRE_SPEAKER)
			V.shut_up = mend
