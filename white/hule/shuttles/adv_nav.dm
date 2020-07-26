/obj/machinery/computer/camera_advanced/shuttle_docker/adv
	name = "advanced navigation computer"

/obj/machinery/computer/camera_advanced/shuttle_docker/adv/GrantActions(mob/living/user)
	jumpto_ports = list()
	jump_action = new /datum/action/innate/camera_jump/shuttle_docker_adv
	..()

/datum/action/innate/camera_jump/shuttle_docker_adv
	name = "Jump to Coordinate Location"
	button_icon_state = "camera_jump"

/datum/action/innate/camera_jump/shuttle_docker_adv/Activate()
	if(QDELETED(target) || !isliving(target))
		return

	var/mob/living/C = target
	var/mob/camera/ai_eye/remote/remote_eye = C.remote_control
	var/obj/machinery/computer/camera_advanced/shuttle_docker/adv/console = remote_eye.origin

	playsound(console, 'sound/machines/terminal_prompt.ogg', 25, 0)

	var/list/P = splittext(input("Input position as x;y;z", "Where we are going to?", null) as null|text, ";")

	if(!(text2num(P[3]) in console.z_lock))
		playsound(console, 'sound/machines/terminal_prompt_deny.ogg', 25, 0)
		return

	if(QDELETED(src) || QDELETED(target) || !isliving(target))
		return

	playsound(src, "terminal_type", 25, 0)
	if(P)
		var/turf/T = locate(text2num(P[1]),text2num(P[2]),text2num(P[3]))
		if(T)
			playsound(console, 'sound/machines/terminal_prompt_confirm.ogg', 25, 0)
			remote_eye.setLoc(T)
			//to_chat(target, "<span class='notice'>Jumped to [selected]</span>")
			C.overlay_fullscreen("flash", /obj/screen/fullscreen/flash/static)
			C.clear_fullscreen("flash", 3)
	else
		playsound(console, 'sound/machines/terminal_prompt_deny.ogg', 25, 0)
