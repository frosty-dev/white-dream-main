/datum/wires/robot
	holder_type = /mob/living/silicon/robot
	randomize = TRUE

/datum/wires/robot/New(atom/holder)
	wires = list(
		WIRE_AI, WIRE_CAMERA,
		WIRE_LAWSYNC, WIRE_LOCKDOWN,
		WIRE_RESET_MODULE
	)
	add_duds(2)
	..()

/datum/wires/robot/interactable(mob/user)
	var/mob/living/silicon/robot/R = holder
	if(R.wiresexposed)
		return TRUE

/datum/wires/robot/get_status()
	var/mob/living/silicon/robot/R = holder
	var/list/status = list()
	status += "Индикатор синхронизации законов [R.lawupdate ? "горит" : "не горит"]."
	status += "Индикатор соединения с ИИ показывает [R.connected_ai ? R.connected_ai.name : "NULL"]."
	status += "Индикатор питания камеры [!isnull(R.builtInCamera) && R.builtInCamera.status ? "горит" : "не горит"]."
	status += "Индикатор блокировки [R.lockcharge ? "горит" : "не горит"]."
	status += "Здесь есть символ звёздочки под проводом цвета [get_wire_name(WIRE_RESET_MODULE)]."
	return status

/datum/wires/robot/on_pulse(wire, user)
	var/mob/living/silicon/robot/R = holder
	switch(wire)
		if(WIRE_AI) // Pulse to pick a new AI.
			if(!R.emagged)
				var/new_ai
				if(user)
					new_ai = select_active_ai(user, R.z)
				else
					new_ai = select_active_ai(R, R.z)
				R.notify_ai(DISCONNECT)
				if(new_ai && (new_ai != R.connected_ai))
					R.connected_ai = new_ai
					if(R.shell)
						R.undeploy() //If this borg is an AI shell, disconnect the controlling AI and assign ti to a new AI
						R.notify_ai(AI_SHELL)
					else
						R.notify_ai(TRUE)
		if(WIRE_CAMERA) // Pulse to disable the camera.
			if(!QDELETED(R.builtInCamera) && !R.scrambledcodes)
				R.builtInCamera.toggle_cam(usr, 0)
				R.visible_message("<span class='notice'>Линза камеры <b>[R.name]</b> медленно фокусируется.</span>", "<span class='notice'>Линза моей камеры медленно фокусируется.</span>")
		if(WIRE_LAWSYNC) // Forces a law update if possible.
			if(R.lawupdate)
				R.visible_message("<span class='notice'><b>[R.name]</b> изящно звянькает.</span>", "<span class='notice'>Протоколы синхронизации законов задействованы.</span>")
				R.lawsync()
				R.show_laws()
		if(WIRE_LOCKDOWN)
			R.SetLockdown(!R.lockcharge) // Toggle
		if(WIRE_RESET_MODULE)
			if(R.has_module())
				R.visible_message("<span class='notice'><b>[R.name]</b> начинает дёргаться.</span>", "<span class='notice'>Дисплей модулей мерцает.</span>")

/datum/wires/robot/on_cut(wire, mend)
	var/mob/living/silicon/robot/R = holder
	switch(wire)
		if(WIRE_AI) // Cut the AI wire to reset AI control.
			if(!mend)
				R.notify_ai(DISCONNECT)
				if(R.shell)
					R.undeploy()
				R.connected_ai = null
		if(WIRE_LAWSYNC) // Cut the law wire, and the borg will no longer receive law updates from its AI. Repair and it will re-sync.
			if(mend)
				if(!R.emagged)
					R.lawupdate = TRUE
			else if(!R.deployed) //AI shells must always have the same laws as the AI
				R.lawupdate = FALSE
		if (WIRE_CAMERA) // Disable the camera.
			if(!QDELETED(R.builtInCamera) && !R.scrambledcodes)
				R.builtInCamera.status = mend
				R.builtInCamera.toggle_cam(usr, 0)
				R.visible_message("<span class='notice'>Линза камеры <b>[R.name]</b> громко фокусируется.</span>", "<span class='notice'>Линза моей камеры громко фокусируется.</span>")
		if(WIRE_LOCKDOWN) // Simple lockdown.
			R.SetLockdown(!mend)
		if(WIRE_RESET_MODULE)
			if(R.has_module() && !mend)
				R.ResetModule()
