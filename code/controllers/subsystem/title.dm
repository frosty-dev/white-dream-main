SUBSYSTEM_DEF(title)
	name = "Title Screen"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_TITLE

	var/file_path
	var/icon/icon
	var/icon/previous_icon
	var/turf/closed/indestructible/splashscreen/splash_turf
	var/ctt = ""
	var/enabled_shit = TRUE

/datum/controller/subsystem/title/Initialize()
	if(file_path && icon)
		return

	if(fexists("data/previous_title.dat"))
		var/previous_path = file2text("data/previous_title.dat")
		if(istext(previous_path))
			previous_icon = new(previous_icon)
	fdel("data/previous_title.dat")

	var/list/provisional_title_screens = flist("[global.config.directory]/title_screens/images/")
	var/list/title_screens = list()
	var/use_rare_screens = prob(1)

	SSmapping.HACK_LoadMapConfig()
	for(var/S in provisional_title_screens)
		var/list/L = splittext(S,"+")
		if((L.len == 1 && L[1] != "blank.png")|| (L.len > 1 && ((use_rare_screens && lowertext(L[1]) == "rare") || (lowertext(L[1]) == lowertext(SSmapping.config.map_name)))))
			title_screens += S

	if(length(title_screens))
		file_path = "[global.config.directory]/title_screens/images/[pick(title_screens)]"

	if(!file_path)
		file_path = "icons/runtime/default_title.dmi"

	ASSERT(fexists(file_path))

	icon = new(fcopy_rsc(file_path))

	if(splash_turf && enabled_shit)
		splash_turf.icon = 'icons/protocol_c.dmi'
		splash_turf.icon_state = "blank"
		set_load_state("init1")

	return ..()

/datum/controller/subsystem/title/proc/set_load_state(state)
	if(splash_turf && enabled_shit)
		new /obj/rs_rs_rs(splash_turf)
		switch(state)
			if("init1")
				sm("-------------------------------------------------------------------------------------------------")
				sm("")
				sm("\[BI-[rand(1000, 9999)]\]:    ONLINE    \[9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08\]")
				sm("\[EY-[rand(1000, 9999)]\]:    ONLINE    \[7c7d31f4816deb275fc4101b94fdf7841037df407e062d4e897a42fd975e3a11\]")
				sm("\[AO-[rand(1000, 9999)]\]:    ONLINE    \[c7962f8eddec633e32eb7a3c800c851df1551edc6664a60f2b665c8b82be0cb8\]")
				sm("\[RW-[rand(1000, 9999)]\]:    ONLINE    \[53ae23b3ab3992a580ecd3ef63302212a359f6441cd1fdc9bef4156eaa0173f5\]")
				sm("\[BN-[rand(1000, 9999)]\]:    ONLINE    \[7d1fc9ead962730d880e9f1047842017710f5b7f165778724ea638f13c93aa3c\]")
				sm("\[SI-[rand(1000, 9999)]\]:    ONLINE    \[404cdd7bc109c432f8cc2443b45bcfe95980f5107215c645236e577929ac3e52\]")
				sm("")
				sm("-------------------------------------------------------------------------------------------------")
			if("init2")
				sm("")
				sm("@> NODE RECREATION PROCESS STARTED:")
				sm("")
				sm("        > BIOS                - STABLE -                \[0[rand(1, 5)]% CORRUPTION\]")
				sm("        > CPU                 - STABLE -                \[[rand(22, 77)]% FREE\]")
				sm("        > MEM                 - STABLE -                \[[rand(11, 33)]% FREE\]")
				sm("        > MB                  - STABLE -                \[[rand(95, 99)]% INTEGRITY\]")
				sm("        > TEMP                - STABLE -                \[-[rand(30, 50)] C\]")
				sm("")
				sm("")
			if("atoms1")
				sm("@> INFRASTRUCTURE ROUTES OPTIMIZATION STARTED:")
				sm("")
				sm("        > 127.0.0.1           - READY -                 \[f528764d624db129b32c21fbca0cb8d6\]")
				sm("        > 77.88.8.8           - READY -                 \[ec5b16d37efebb673356702a72ef4635\]")
				sm("        > STATION13.RU        - READY -                 \[dec20fe05cd8bcbfae7db11a2995f85c\]")
				sm("")
				sm("")
				sm("@> PROCESSING MAINFRAME RECREATION...")
				sm("")
				sm("        > WORLD               - DONE -")
				sm("        > ATOMS               ", FALSE)
			if("atoms2")
				sm("- DONE -")
				sm("        > DISEASES            ", FALSE)
			if("diseases")
				sm("- DONE -")
				sm("        > AIR                 ", FALSE)
			if("air")
				sm("- DONE -")
				sm("        > ASSETS              ", FALSE)
			if("assets")
				sm("- DONE -")
				sm("        > SMOOTHING           ", FALSE)
			if("smoothing")
				sm("- DONE -")
				sm("        > OVERLAYS            ", FALSE)
			if("overlays")
				sm("- DONE -")
				sm("        > LIGHT               ", FALSE)
			if("light")
				sm("- DONE -")
				sm("        > SHUTTLE             ", FALSE)
			if("shuttle")
				sm("- DONE -")
				sm("")
			if("end")
				sm("@> world.execute(white)")
				sm("")
				sm("        > ぷろとこう_はかい")
				sm("\n\n\n\n")
				var/nn = 0
				while(nn != 5)
					sleep(1)
					sm("\n\n\n\n")
					nn++
				cls()

/datum/controller/subsystem/title/proc/sm(msg, newline = TRUE)
	if(splash_turf && enabled_shit)
		if(newline)
			ctt += "[msg]\n"
		else
			ctt += "[msg]"
		splash_turf.maptext = "<font style=\"font-size: 7px; -dm-text-outline: 1px black; font-family: 'Courier'; color:'#aaffff'; \">[ctt]</font>"

/datum/controller/subsystem/title/proc/cls()
	if(splash_turf && enabled_shit)
		splash_turf.maptext = ""
		ctt = null
		uplayers()
		for(var/obj/rs_rs_rs/O in splash_turf)
			qdel(O)

/datum/controller/subsystem/title/proc/uplayers()
	if(splash_turf && enabled_shit && !ctt)
		var/list/caa = list()
		var/tcc = ""
		for(var/client/C in GLOB.clients)
			if (C.holder)
				caa += "\t#> USER <b>[C.key]</b> ONLINE\n"
			else
				caa += "\t@> USER [C.key] ONLINE\n"
		for(var/line in GLOB.whitelist)
			caa += "@> USER [line] ONLINE\n"
		for(var/line in sortList(caa))
			tcc += "[line]\n"
		splash_turf.maptext = "<font style=\"font-size: 7px; -dm-text-outline: 1px black; font-family: 'Courier'; color:'#aaffff'; \">[tcc]</font>"

/datum/controller/subsystem/title/proc/afterload()
	if(splash_turf && enabled_shit)
		splash_turf.do_cring()
		splash_turf.icon_state = null
		splash_turf.icon = icon
		splash_turf.add_overlay('icons/wd_logo.png')

/obj/rs_rs_rs
	name = "странная штука"
	layer = 24
	plane = 24
	blend_mode = 3
	alpha = 125
	icon = 'white/valtos/icons/d.dmi'
	icon_state = "rect"
	color = "#aaaaaa"
	pixel_x = 240
	pixel_y = 176

/obj/rs_rs_rs/Initialize()
	. = ..()
	var/lor = 120
	if (prob(50))
		lor = -lor
		color = "#222222"

	var/soe = rand(6, 8)
	var/zof = rand(0.1, 0.5)

	animate(src, transform = matrix().Scale(soe,soe), time = 50, loop = -1, flags = ANIMATION_PARALLEL)
	animate(	 transform = matrix().Scale(zof,zof), time = 200)
	animate(	 transform = matrix().Scale(soe,soe), time = 50)

	animate(src, transform = turn(matrix(), lor), 	  time = 50, loop = -1, flags = ANIMATION_PARALLEL)
	animate(	 transform = turn(matrix(), lor*2),   time = 200)
	animate(	 transform = turn(matrix(), lor*3),   time = 50)

/datum/controller/subsystem/title/vv_edit_var(var_name, var_value)
	. = ..()
	if(.)
		switch(var_name)
			if("icon")
				if(splash_turf)
					splash_turf.icon = icon

/datum/controller/subsystem/title/Shutdown()
	if(file_path)
		var/F = file("data/previous_title.dat")
		WRITE_FILE(F, file_path)

	SStitle.icon = 'icons/end.png'

	for(var/client/thing in GLOB.clients)
		if(!thing)
			continue
		thing.fit_viewport()
		var/obj/screen/splash/S = new(thing, FALSE)
		S.Fade(FALSE,FALSE)

/datum/controller/subsystem/title/Recover()
	icon = SStitle.icon
	splash_turf = SStitle.splash_turf
	file_path = SStitle.file_path
	previous_icon = SStitle.previous_icon
