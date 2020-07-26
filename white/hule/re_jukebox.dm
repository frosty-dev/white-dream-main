/mob
	var/sound/jukebox_music

/obj/machinery/turntable
	name = "Музыкальный автомат"
	desc = "Классический музыкальный проигрыватель."
	icon = 'white/valtos/icons/jukeboxes.dmi'
	icon_state = "default"
	verb_say = "констатирует"
	density = TRUE
	var/active = FALSE
	var/list/rangers = list()
	var/stop = 0
	var/list/songs = list()
	var/datum/track/selection = null

	var/obj/item/card/music/disk
	var/playing_range = 12
	var/volume = 100
	var/env_sound = 0

/obj/machinery/turntable/donate
	desc = "Классический музыкальный проигрыватель. Пахнет помидорами."

/obj/machinery/turntable/Initialize()
	. = ..()

	icon_state = pick("default", "tall", "neon")

	if(icon_state == "tall")
		name = "Младший [r_lowertext(name)]"

	var/list/tracks = flist("[global.config.directory]/jukebox_music/sounds/")

	for(var/S in tracks)
		var/datum/track/T = new()
		T.song_path = file("[global.config.directory]/jukebox_music/sounds/[S]")
		var/list/L = splittext(S,"+")
		if(L.len != 3)
			continue
		T.song_name = L[1]
		T.song_length = text2num(L[2])
		T.song_beat = text2num(L[3])
		songs |= T

	if(songs.len)
		selection = pick(songs)

/obj/machinery/turntable/donate/Initialize()
	. = ..()
	for(var/obj/machinery/turntable/donate/TT) // NO WAY
		if(TT != src)
			qdel(src)

/obj/machinery/turntable/Destroy()
	dance_over()
	return ..()

/obj/machinery/turntable/process()
	if(!active && !selection)
		return

	var/turf/T = get_turf(src)

	for(var/mob/M in range(playing_range,src))
		if(!M.client || !M.jukebox_music)
			continue

		if(!(M in rangers))
			rangers[M] = TRUE

		var/turf/MT = get_turf(M)

		if(env_sound)
			M.jukebox_music.falloff = 12

			M.jukebox_music.y = 1
			var/dx = T.x - MT.x // Hearing from the right/left
			M.jukebox_music.x = dx
			var/dy = T.y - MT.y // Hearing from infront/behind
			M.jukebox_music.z = dy

		else
			M.jukebox_music.falloff = 8

			M.jukebox_music.x = 0
			M.jukebox_music.y = 1
			M.jukebox_music.z = 1

		M.jukebox_music.status = SOUND_UPDATE//|SOUND_STREAM
		M.jukebox_music.volume = volume

		SEND_SOUND(M, M.jukebox_music)

	for(var/mob/L in rangers)
		if(get_dist(src,L) > playing_range)
			rangers -= L
			if(!L || !L.client)
				continue

			L.jukebox_music.status = SOUND_UPDATE//|SOUND_STREAM
			L.jukebox_music.volume = 0

			SEND_SOUND(L, L.jukebox_music)

/obj/machinery/turntable/attackby(obj/item/I, mob/user)
	if(default_unfasten_wrench(user, I))
		return

	if(istype(I, /obj/item/card/music) && !disk)
		if(disk_insert(user, I, disk))
			disk = I
		return

	return ..()

/obj/machinery/turntable/proc/disk_insert(mob/user, obj/item/card/music/I, target)
	if(istype(I))
		if(target)
			to_chat(user, "<span class='warning'>Здесь уже есть диск!</span>")
			return FALSE
		if(!user.transferItemToLoc(I, src))
			return FALSE
		user.visible_message("<span class='notice'>[user] вставляет диск в музыкальный автомат.</span>", \
							"<span class='notice'>Вставляю диск в музыкальный автомат.</span>")
		playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
		updateUsrDialog()
		return TRUE

/obj/machinery/turntable/ui_interact(mob/user)
	. = ..()
	if(!user.canUseTopic(src, !issilicon(user)))
		return
	if (!anchored)
		to_chat(user,"<span class='warning'>Он же откручен!</span>")
		return
	if(!allowed(user))
		to_chat(user,"<span class='warning'>Ошибка! Доступа нет.</span>")
		user.playsound_local(src,'sound/misc/compiler-failure.ogg', 25, 1)
		return

	var/list/dat = list()
	dat +="<div class='statusDisplay' style='text-align:center'>"
	dat += "<b><A href='?src=[REF(src)];action=toggle'>[!active ? "СТАРТ" : "СТОП"]<b></A><br>"
	dat += "</div><br>"
	dat += "<A href='?src=[REF(src)];action=select'> Выбрать трек</A><br>"
	dat += "<A href='?src=[REF(src)];action=volume'> Громкость</A><br>"
	dat += "<A href='?src=[REF(src)];action=env'> Объёмный звук [!env_sound ? "ВЫКЛ" : "ВКЛ"]</A><br>"

	if(selection)
		if(selection.song_name)
			dat += "<br>Трек: [selection.song_name]<br>"
		if(selection.song_length)
			dat += "Длина трека: [DisplayTimeText(selection.song_length)]<br><br>"
	if(disk)
		dat += "<br><br><br><A href='?src=[REF(src)];action=eject'>Изъять диск</A><br>"

	var/datum/browser/popup = new(user, "vending", "[name]", 400, 350)
	popup.set_content(dat.Join())
	popup.open()


/obj/machinery/turntable/Topic(href, href_list)
	if(..())
		return
	add_fingerprint(usr)
	switch(href_list["action"])
		if("toggle")
			if (QDELETED(src))
				return
			if(!active)
				activate_music()
				updateUsrDialog()
			else if(active)
				dance_over()
				updateUsrDialog()

		if("select")
			var/list/available = list()
			for(var/datum/track/S in songs)
				available[S.song_name] = S

			if(disk)
				if(disk.data)
					available[disk.data.song_name] = disk.data

			var/selected = input(usr, "Выбирай мудро", "Трек:") as null|anything in available
			if(QDELETED(src) || !selected || !istype(available[selected], /datum/track))
				return
			if(active)
				dance_over()
			selection = available[selected]
			updateUsrDialog()

		if("eject")
			if(disk)
				disk.loc = src.loc
				if(active)
					dance_over()
				if(selection == disk.data)
					selection = null
				disk = null

			updateUsrDialog()

		if("volume")
			var/new_volume = input(usr, "Громкость", null) as num|null
			if(new_volume)
				volume = max(0, min(100, new_volume))
			updateUsrDialog()

		if("env")
			env_sound = !env_sound
			updateUsrDialog()

/obj/machinery/turntable/proc/activate_music()
	if(selection)
		var/sound/S = sound(selection.song_path)
		S.repeat = 1
		S.channel = CHANNEL_CUSTOM_JUKEBOX
		S.falloff = 12
		S.wait = 0
		S.volume = 0
		S.status = 0 //SOUND_STREAM

		S.x = 0
		S.z = 1
		S.y = 1

		for(var/mob/M)
			M.jukebox_music = S
			SEND_SOUND(M, M.jukebox_music)

	update_icon()
	START_PROCESSING(SSobj, src)
	active = TRUE

/obj/machinery/turntable/proc/dance_over()
	rangers = list()

	for(var/mob/M)
		M.jukebox_music = null
		M.stop_sound_channel(CHANNEL_CUSTOM_JUKEBOX)

	playsound(src,'sound/machines/terminal_off.ogg',50,1)
	update_icon()
	STOP_PROCESSING(SSobj, src)
	active = FALSE

/obj/item/card/music
	icon_state = "data_3"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	w_class = 1.0
	var/datum/track/data
	var/uploader_ckey

/obj/machinery/musicwriter
	name = "записыватель мозговых импульсов МК-3"
	icon = 'white/valtos/icons/musicconsole.dmi'
	icon_state = "off"
	var/coin = 0
	var/mob/retard //current user
	var/retard_name
	var/writing = 0

/obj/machinery/musicwriter/attackby(obj/item/I, mob/user)
	if(default_unfasten_wrench(user, I))
		return
	if(istype(I, /obj/item/coin))
		user.dropItemToGround(I)
		qdel(I)
		coin++
		return

/obj/machinery/musicwriter/ui_interact(mob/user)
	. = ..()
	if(!user.canUseTopic(src, !issilicon(user)))
		return
	if (!anchored)
		to_chat(user,"<span class='warning'>Надо бы прикрутить!</span>")
		return
	if(!allowed(user))
		to_chat(user,"<span class='warning'>Ошибка! Нет доступа.</span>")
		user.playsound_local(src,'sound/misc/compiler-failure.ogg', 25, 1)
		return

	var/list/dat = list()

	if(writing)
		dat += "Сканирование мозгов завершено. <br>Записываем мозги [retard_name]... Подождите!"
	else if(!coin)
		dat += "Вставьте монетку."
	else
		dat += "<A href='?src=[REF(src)];action=write'>Записать</A>"

	var/datum/browser/popup = new(user, "vending", "[name]", 400, 350)
	popup.set_content(dat.Join())
	popup.open()

/obj/machinery/musicwriter/Topic(href, href_list)
	if(..())
		return
	add_fingerprint(usr)
	switch(href_list["action"])
		if("write")
			if(!writing && !retard && coin)
				icon_state = "on"
				writing = 1
				retard = usr
				retard_name = retard.name
				var/N = sanitize(input("Название") as text|null)
				//retard << "Please stand still while your data is uploading"
				if(N)
					var/sound/S = input("Файл") as sound|null
					if(S)
						var/datum/track/T = new()
						var/obj/item/card/music/disk = new
						T.song_path = S
						//T.f_name = copytext(N, 1, 2)
						T.song_name = N
						disk.data = T
						disk.name = "диск ([N])"
						disk.loc = src.loc
						disk.uploader_ckey = retard.ckey
						var/mob/M = usr
						message_admins("[M.real_name]([M.ckey]) uploaded <A HREF='?_src_=holder;listensound=\ref[S]'>sound</A> named as [N]. <A HREF='?_src_=holder;wipedata=\ref[disk]'>Wipe</A> data.")
						coin--

				icon_state = "off"
				writing = 0
				retard = null
				retard_name = null
