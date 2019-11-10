#define TURNTABLE_CHANNEL 1021 //jukebox channel

/mob/var/sound/music

/datum/turntable_soundtrack
	var/f_name
	var/name
	var/path

/obj/machinery/party/turntable
	name = "Jukebox"
	desc = "A jukebox is a partially automated music-playing device, usually a coin-operated machine, that will play a patron's selection from self-contained media."
	icon = 'code/shitcode/magkorobka.dmi'
	icon_state = "jukebox"
	var/obj/item/card/music/disk
	var/playing = 0
	var/datum/turntable_soundtrack/track = null
	var/volume = 100
	var/list/turntable_soundtracks = list()
	var/time = 0
	var/cooldown = 0
	anchored = 1
	density = 1

/obj/machinery/party/turntable/Initialize()
	..()
	for(var/obj/machinery/party/turntable/TT) // NO WAY
		if(TT != src)
			qdel(src)
	turntable_soundtracks = list()
	for(var/i in typesof(/datum/turntable_soundtrack) - /datum/turntable_soundtrack)
		var/datum/turntable_soundtrack/D = new i()
		if(D.path)
			turntable_soundtracks.Add(D)


/obj/machinery/party/turntable/attackby(obj/O, mob/user)
	if(istype(O, /obj/item/card/music) && !disk)
		user.dropItemToGround(O)
		O.forceMove(src)
		disk = O
		attack_hand(user)
	else if(istype(O, /obj/item/wrench))
		anchored = !anchored

/obj/machinery/party/turntable/attack_paw(mob/user)
	return src.attack_hand(user)

/obj/machinery/party/turntable/attack_hand(mob/user)
	if (..())
		return

	usr.set_machine(src)
	src.add_fingerprint(usr)

	var/t = "<body background=''><br><br><br><div align='center'><table border='0'><B><font color='maroon' size='6'>J</font><font size='5' color='purple'>uke Box</font> <font size='5' color='green'>Interface</font></B><br><br><br><br>"
	t += "<A href='?src=\ref[src];on=1'>On</A><br>"
	if(disk)
		t += "<A href='?src=\ref[src];eject=1'>Eject disk</A><br>"
	t += "<tr><td height='50' weight='50'></td><td height='50' weight='50'><A href='?src=\ref[src];off=1'><font color='maroon'>T</font><font color='lightgreen'>urn</font> <font color='red'>Off</font></A></td><td height='50' weight='50'></td></tr>"
	t += "<tr>"


	var/lastcolor = "green"
	for(var/i = 10; i <= 100; i += 10)
		t += "<A href='?src=\ref[src];set_volume=[i]'><font color='[lastcolor]'>[i]</font></A> "
		if(lastcolor == "green")
			lastcolor = "purple"
		else
			lastcolor = "green"

	var/i = 0
	for(var/datum/turntable_soundtrack/D in turntable_soundtracks)
		t += "<td height='50' weight='50'><A href='?src=\ref[src];on=\ref[D]'><font color='maroon'>[D.f_name]</font><font color='[lastcolor]'>[D.name]</font></A></td>"
		i++
		if(i == 1)
			lastcolor = pick("lightgreen", "purple")
		else
			lastcolor = pick("green", "purple")
		if(i == 3)
			i = 0
			t += "</tr><tr>"

	if(disk)
		if(disk.data)
			t += "<td height='50' weight='50'><A href='?src=\ref[src];on=\ref[disk.data]'><font color='maroon'>[disk.data.f_name]</font><font color='[lastcolor]'>[disk.data.name]</font></A></td>"
		else
			t += "<td height='50' weight='50'><font color='maroon'>D</font><font color='[lastcolor]'>isk empty</font></td>"

	t += "</table></div></body>"
	user << browse(t, "window=turntable;size=450x700;can_resize=0")
	onclose(user, "turntable")
	return

/obj/machinery/party/turntable/power_change()
	turn_off()

/obj/machinery/party/turntable/Topic(href, href_list)
	if(..())
		return
	if(href_list["on"])
		turn_on(locate(href_list["on"]))

	else if(href_list["off"])
		turn_off()

	else if(href_list["set_volume"])
		set_volume(text2num(href_list["set_volume"]))

	else if(href_list["eject"])
		if(disk)
			disk.loc = src.loc
			if(disk.data && track == disk.data)
				turn_off()
				track = null
			disk = null

/obj/machinery/party/turntable/process()
	if(cooldown)
		time++
		if(time >= cooldown)
			time = 0
		else
			return

	if(playing)
		update_sound()

/obj/machinery/party/turntable/proc/turn_on(var/datum/turntable_soundtrack/selected)
	if(playing)
		turn_off()
	if(selected)
		track = selected
	if(!track)
		return

	for(var/mob/M)
		create_sound(M)
	update_sound()

	/*var/area/A = get_area(src)
	for(var/area/RA in A.related)
		for(var/obj/machinery/party/lasermachine/L in RA)
			L.turnon(L.dir)*/

	playing = 1
	process()

/obj/machinery/party/turntable/proc/turn_off()
	if(!playing)
		return
	for(var/mob/M)
		M.music = null
		SEND_SOUND(M, sound(null, channel = TURNTABLE_CHANNEL, wait = 0))

	playing = 0
/*	var/area/A = get_area(src)
	/or(var/area/RA in A.related)
		for(var/obj/machinery/party/lasermachine/L in RA)
			L.turnoff()*/

/obj/machinery/party/turntable/proc/set_volume(var/new_volume)
	volume = max(0, min(100, new_volume))
	if(playing)
		update_sound(1)

/obj/machinery/party/turntable/proc/update_sound(update = 0)
	var/area/A = get_area(src)
	for(var/mob/M)
		if(!M.client)
			continue

		if(!M.music)
			create_sound(M)
			continue

		var/area/MA = get_area(M)

		if(MA == A && (M.music.volume != volume || update))
			//to_chat(M, "<span class='notice'>In range. Volume: [M.music.volume]. Update: [update]</span>")
			M.music.status = SOUND_UPDATE//|SOUND_STREAM
			M.music.volume = volume
			SEND_SOUND(M, M.music)

		else if(MA != A && M.music.volume != 0)
			//to_chat(M, "<span class='notice'>!In range. Volume: [M.music.volume].</span>")
			M.music.status = SOUND_UPDATE//|SOUND_STREAM
			M.music.volume = 0
			SEND_SOUND(M, M.music)


/obj/machinery/party/turntable/proc/create_sound(mob/M)
	//var/area/A = get_area(src)
	//var/inRange = (get_area(M) in A.related)
	var/sound/S = sound(track.path)
	S.repeat = 1
	S.channel = TURNTABLE_CHANNEL
	S.falloff = 2
	S.wait = 0
	S.volume = 0
	S.status = 0 //SOUND_STREAM
	M.music = S
	SEND_SOUND(M, S)

/obj/item/card/music
	icon_state = "data_3"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	w_class = 1.0
	var/datum/turntable_soundtrack/data
	var/uploader_ckey

/obj/machinery/party/musicwriter
	name = "Memories writer"
	icon = 'code/shitcode/magkorobka.dmi'
	icon_state = "writer_off"
	var/coin = 0
	//var/obj/item/weapon/disk/music/disk
	var/mob/retard //current user
	var/retard_name
	var/writing = 0

/obj/machinery/party/musicwriter/attackby(obj/O, mob/user)
	if(istype(O, /obj/item/coin))
		user.dropItemToGround(O)
		qdel(O)
		coin++

/obj/machinery/party/musicwriter/attack_hand(mob/user)
	var/dat = ""
	if(writing)
		dat += "Memory scan completed. <br>Writing from scan of [retard_name] mind... Please Stand By."
	else if(!coin)
		dat += "Please insert a coin."
	else
		dat += "<A href='?src=\ref[src];write=1'>Write</A>"

	user << browse(dat, "window=musicwriter;size=200x100")
	onclose(user, "onclose")
	return

/obj/machinery/party/musicwriter/Topic(href, href_list)
	if(href_list["write"])
		if(!writing && !retard && coin)
			icon_state = "writer_on"
			writing = 1
			retard = usr
			retard_name = retard.name
			var/N = sanitize(input("Name of music") as text|null)
			//retard << "Please stand still while your data is uploading"
			if(N)
				var/sound/S = input("Your music file") as sound|null
				if(S)
					var/datum/turntable_soundtrack/T = new
					var/obj/item/card/music/disk = new
					T.path = S
					T.f_name = copytext(N, 1, 2)
					T.name = copytext(N, 2)
					disk.data = T
					disk.name = "disk ([N])"
					disk.loc = src.loc
					disk.uploader_ckey = retard.ckey
					var/mob/M = usr
					message_admins("[M.real_name]([M.ckey]) uploaded <A HREF='?_src_=holder;listensound=\ref[S]'>sound</A> named as [N]. <A HREF='?_src_=holder;wipedata=\ref[disk]'>Wipe</A> data.")
					coin--

			icon_state = "writer_off"
			writing = 0
			retard = null
			retard_name = null


/*
/obj/machinery/party/mixer
	name = "mixer"
	desc = "A mixing board for mixing music"
	icon = 'icons/effects/lasers2.dmi'
	icon_state = "mixer"
	density = 0
	anchored = 1

/obj/machinery/party/lasermachine
	name = "laser machine"
	desc = "A laser machine that shoots lasers."
	icon = 'icons/effects/lasers2.dmi'
	icon_state = "lasermachine"
	dir = 4
	anchored = 1
	var/mirrored = 0

/obj/effect/laser2
	name = "laser"
	desc = "A laser..."
	icon = 'icons/effects/lasers2.dmi'
	icon_state = "laserred1"
	anchored = 1
	layer = 4

/obj/machinery/party/lasermachine/proc/turnon(laser_dir)
	var/wall = 0
	var/cycle = 1
	var/area/A = get_area(src)
	var/X = 1
	var/Y = 0
	if(mirrored == 0)
		while(wall == 0)
			if(cycle == 1)
				var/obj/effect/laser2/F = new/obj/effect/laser2(src)
				F.x = src.x+X
				F.y = src.y+Y
				F.z = src.z
				F.dir = laser_dir
				F.icon_state = "laserred1"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					qdel(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				X++
			if(cycle == 2)
				var/obj/effect/laser2/F = new/obj/effect/laser2(src)
				F.x = src.x+X
				F.y = src.y+Y
				F.z = src.z
				F.dir = laser_dir
				F.icon_state = "laserred2"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					qdel(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				Y++
			if(cycle == 3)
				var/obj/effect/laser2/F = new/obj/effect/laser2(src)
				F.x = src.x+X
				F.y = src.y+Y
				F.z = src.z
				F.dir = laser_dir
				F.icon_state = "laserred3"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					qdel(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				X++
	if(mirrored == 1)
		while(wall == 0)
			if(cycle == 1)
				var/obj/effect/laser2/F = new/obj/effect/laser2(src)
				F.x = src.x+X
				F.y = src.y-Y
				F.z = src.z
				F.icon_state = "laserred1m"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					qdel(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				Y++
			if(cycle == 2)
				var/obj/effect/laser2/F = new/obj/effect/laser2(src)
				F.x = src.x+X
				F.y = src.y-Y
				F.z = src.z
				F.icon_state = "laserred2m"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					qdel(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				X++
			if(cycle == 3)
				var/obj/effect/laser2/F = new/obj/effect/laser2(src)
				F.x = src.x+X
				F.y = src.y-Y
				F.z = src.z
				F.icon_state = "laserred3m"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					qdel(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				X++



/obj/machinery/party/lasermachine/proc/turnoff()
	var/area/A = src.loc.loc
	for(var/area/RA in A.related)
		for(var/obj/effect/laser2/F in RA)
			qdel(F)

/obj/machinery/party/lasermachine/Move()
	..()
	turnon(src.dir)
*/


/*
/mob/var/datum/hear_music/hear_music
#define NONE_MUSIC 0
#define UPLOADING 1
#define PLAYING 2
/datum/hear_music
	var/mob/target = null
	//var/sound/sound
	var/status = NONE_MUSIC
	var/stop = 0
	proc/play(sound/S)
		status = NONE_MUSIC
		if(!target)
			return
		if(!S)
			return
		status = UPLOADING
		target << browse_rsc(S)
		//sound = S
		if(target.hear_music != src)
			qdel(src)
		if(!stop)
			target << S
			status = PLAYING
		else
			qdel(src)
	proc/stop()
		if(!target)
			return
		if(status == PLAYING)
			var/sound/S = sound(null)
			S.channel = 10
			S.wait = 1
			target << S
			qdel(src)
		else if(status == UPLOADING)
			stop = 1
		target.hear_music = null
*/
