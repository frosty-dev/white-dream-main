/obj/item/boombox
	name = "Взрыв каробка"
	desc = "Магнитола, разыскиваемая в одном из смежных секторов. Почему-то пахнет малиной."
	icon = 'white/baldenysh/icons/obj/boombox.dmi'
	lefthand_file = 'white/valtos/icons/lefthand.dmi'
	righthand_file = 'white/valtos/icons/righthand.dmi'
	icon_state = "boombox"
	verb_say = "констатирует"

	var/list/songs = list()
	var/datum/track/selection = null
	var/obj/item/card/data/music/disk
	var/playing = FALSE

	var/ui_x = 370
	var/ui_y = 313

/proc/open_sound_channel_for_boombox()
	var/static/next_channel = CHANNEL_HIGHEST_AVAILABLE + 1
	. = ++next_channel
	if(next_channel > CHANNEL_BOOMBOX_AVAILABLE)
		next_channel = CHANNEL_HIGHEST_AVAILABLE + 1

/obj/item/boombox/single
	desc = "Единственная и неповторимая."

/obj/item/boombox/Initialize()
	. = ..()
	var/datum/component/soundplayer/SP = AddComponent(/datum/component/soundplayer)
	SP.set_channel(open_sound_channel_for_boombox())
	load_tracks()
	color = color_matrix_rotate_hue(rand(0, 360))

/obj/item/boombox/update_icon()
	if(playing)
		icon_state = "[initial(icon_state)]_active"
	else
		icon_state = "[initial(icon_state)]"

/obj/item/boombox/proc/load_tracks()
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

/obj/item/boombox/single/Initialize()
	. = ..()
	for(var/obj/item/boombox/single/BB) // NO WAY
		if(BB != src)
			qdel(src)

/obj/item/boombox/proc/startsound()
	if(!selection)
		return
	var/datum/component/soundplayer/SP = GetComponent(/datum/component/soundplayer)
	SP.set_sound(sound(selection.song_path))
	SP.active = TRUE
	playing = TRUE
	update_icon()

/obj/item/boombox/proc/stopsound()
	var/datum/component/soundplayer/SP = GetComponent(/datum/component/soundplayer)
	SP.stop_sounds()
	playsound(get_turf(src),'sound/machines/terminal_off.ogg',50,1)
	playing = FALSE
	update_icon()

/obj/item/boombox/proc/toggle_env()
	var/datum/component/soundplayer/SP = GetComponent(/datum/component/soundplayer)
	SP.environmental = !SP.environmental

/obj/item/boombox/proc/set_volume(var/vol)
	var/datum/component/soundplayer/SP = GetComponent(/datum/component/soundplayer)
	SP.playing_volume = vol

/obj/item/boombox/attackby(obj/item/I, mob/user)
	if(disk_insert(user, I, disk))
		disk = I
		if(!selection)
			selection = disk.track
		ui_interact(user)
	return ..()

/obj/item/boombox/proc/disk_insert(mob/user, obj/item/card/data/music/I, target)
	if(istype(I))
		if(target)
			to_chat(user, "<span class='warning'>Здесь уже есть диск!</span>")
			return FALSE
		if(!user.transferItemToLoc(I, src))
			return FALSE
		user.visible_message("<span class='notice'>[user] вставляет диск в [src].</span>", \
							"<span class='notice'>Вставляю диск в [src].</span>")
		playsound(get_turf(src), 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
		return TRUE

/obj/item/boombox/proc/eject_disk(mob/user)
	if(disk)
		if(user)
			user.put_in_hands(disk)
		else
			disk.forceMove(get_turf(src))
		if(playing)
			stopsound()
		else
			playsound(get_turf(src), 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
		if(selection == disk.track)
			selection = null
		disk = null

/obj/item/boombox/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.always_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "BoomBox", name, ui_x, ui_y, master_ui, state)
		ui.open()

/obj/item/boombox/ui_status(mob/user)
	if(IsAdminGhost(user))
		return UI_INTERACTIVE
	if(!isliving(user))
		return UI_UPDATE
	if(get_dist(get_turf(src), user) < 1.5)
		return UI_INTERACTIVE
	else
		return UI_CLOSE

/obj/item/boombox/ui_data(mob/user)
	var/list/data = list()
	var/datum/component/soundplayer/SP = GetComponent(/datum/component/soundplayer)
	data["name"] = name
	data["active"] = playing
	data["volume"] = SP.playing_volume
	data["curtrack"] = selection && selection.song_name ? selection.song_name : FALSE
	data["curlength"] = selection && selection.song_length ? selection.song_length : FALSE
	data["env"] = SP.environmental

	data["disk"] = disk ? TRUE : FALSE
	data["disktrack"] = disk && disk.track ? disk.track.song_name : FALSE

	return data

/obj/item/boombox/ui_act(action, params)
	if(..())
		return
	. = TRUE
	switch(action)
		if("toggle")
			if(!playing)
				startsound()
			else
				stopsound()
		if("select")
			var/list/available = list()
			for(var/datum/track/S in songs)
				available[S.song_name] = S
			if(disk)
				if(disk.track)
					available[disk.track.song_name] = disk.track
			var/selected = input(usr, "Выбирай мудро", "Трек:") as null|anything in available
			if(QDELETED(src) || !selected || !istype(available[selected], /datum/track))
				return
			if(playing)
				stopsound()
			selection = available[selected]
		if("change_volume")
			var/target = text2num(params["volume"])
			set_volume(clamp(target, 0, 100))
		if("eject")
			eject_disk(usr)
		if("env")
			toggle_env()
	update_icon()

/obj/machinery/turntable
	name = "музыкальный автомат"
	desc = "Классический музыкальный проигрыватель."
	icon = 'white/valtos/icons/jukeboxes.dmi'
	icon_state = "default"
	verb_say = "констатирует"
	density = TRUE
	var/obj/item/boombox/bbox

/obj/machinery/turntable/Initialize()
	. = ..()
	icon_state = pick("default", "tall", "neon")
	if(icon_state == "tall")
		name = "младший [name]"
	bbox = new(src)
	bbox.name = name

/obj/machinery/turntable/Destroy()
	if(bbox)
		qdel(bbox)
	. = ..()

/obj/machinery/turntable/ui_interact(mob/user)
	bbox.ui_interact(user)

/obj/machinery/turntable/attackby(obj/item/I, mob/user)
	if(bbox.disk_insert(user, I, bbox.disk))
		bbox.disk = I
		return
	return ..()

/obj/machinery/turntable/wrench_act(mob/living/user, obj/item/I)
	..()
	default_unfasten_wrench(user, I)
	return TRUE

/obj/machinery/turntable/donate
	desc = "Классический музыкальный проигрыватель. Пахнет помидорами."

/obj/machinery/turntable/donate/Initialize()
	. = ..()
	for(var/obj/machinery/turntable/donate/TT)
		if(TT != src)
			qdel(src)

//переделать нафиг

/obj/item/card/data/music
	icon_state = "data_3"
	var/datum/track/track
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
						var/obj/item/card/data/music/disk = new
						T.song_path = S
						//T.f_name = copytext(N, 1, 2)
						T.song_name = N
						disk.track = T
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
