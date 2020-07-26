/datum/looping_sound/effector_vaper
	start_sound = 'sound/machines/shower/shower_start.ogg'
	start_length = 2
	mid_sounds = list('sound/machines/shower/shower_mid1.ogg'=1,'sound/machines/shower/shower_mid2.ogg'=1,'sound/machines/shower/shower_mid3.ogg'=1)
	mid_length = 10
	end_sound = 'sound/machines/shower/shower_end.ogg'
	volume = 10

/obj/machinery/effector
	name = "парилка"
	desc = "Парит. Гы."
	icon = 'white/valtos/icons/effector.dmi'
	icon_state = "effector"
	var/workout = TRUE
	var/workdir = "up"
	var/datum/looping_sound/effector_vaper/soundloop
	var/temp_cd = 30

/obj/machinery/effector/attack_hand(mob/living/user)
	if(Adjacent(user) && user.pulling)
		if(isliving(user.pulling))
			var/mob/living/pushed_mob = user.pulling
			if(pushed_mob.buckled)
				to_chat(user, "<span class='warning'><b>[pushed_mob]</b> прикован к <b>[pushed_mob.buckled]</b>!</span>")
				return
			if(user.a_intent == INTENT_GRAB)
				if(user.grab_state < GRAB_AGGRESSIVE)
					to_chat(user, "<span class='warning'>Надо бы посильнее взять!</span>")
					return
				if(user.grab_state >= GRAB_NECK)
					user.emote("laugh")
					pushed_mob.visible_message("<span class='warning'><b>[user]</b> пытается принудить <b>[pushed_mob]</b> подышать паром над <b>парилкой</b>...</span>", \
									"<span class='userdanger'><b>[user]</b> пытается приставить <b>мою голову</b> к <b>парилке</b>...</span>")
					if(do_after(user, 35, target = pushed_mob) && temp_cd == 30)
						if(temp_cd < 30)
							return
						temp_cd = 0
						pushed_mob.Knockdown(10)
						pushed_mob.apply_damage(30, BURN, BODY_ZONE_HEAD)
						pushed_mob.apply_damage(60, STAMINA)
						pushed_mob.emote("scream")
						playsound(pushed_mob, 'sound/machines/shower/shower_mid1.ogg', 90, TRUE)
						pushed_mob.visible_message("<span class='danger'><b>[user]</b> принуждает <b>[pushed_mob]</b> вкусить свежий пар!</span>",
									"<span class='userdanger'><b>[user]</b> принуждает меня вкусить свежий пар!</span>")
						log_combat(user, pushed_mob, "head fried", null, "against <b>[src]</b>")
						SEND_SIGNAL(pushed_mob, COMSIG_ADD_MOOD_EVENT, "table", /datum/mood_event/table)
					else
						return
	return ..()

/obj/machinery/effector/Destroy()
	QDEL_NULL(soundloop)
	return ..()

/obj/machinery/effector/process()
	if(temp_cd < 30)
		temp_cd++
	if(workout)
		soundloop = new(list(src), TRUE)
		soundloop.start()
		workout = FALSE
	var/obj/effect/vaper_smoke/S = new(get_turf(src))
	switch(workdir)
		if("up")
			animate(S, pixel_y = 64, pixel_x = rand(-12, 12), transform = matrix()*2, alpha = 0, time = 40)
		if("down")
			animate(S, pixel_y = -64, pixel_x = rand(-12, 12), transform = matrix()*2, alpha = 0, time = 40)

/obj/effect/vaper_smoke
	name = "пар"
	alpha = 60
	layer = FLY_LAYER
	icon = 'white/valtos/icons/effector.dmi'
	icon_state = "smoke"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/vaper_smoke/Initialize()
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/vaper_smoke/LateInitialize()
	QDEL_IN(src, 80)
