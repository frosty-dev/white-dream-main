GLOBAL_LIST_INIT(huesoslist, world.file2list("[global.config.directory]/autoeban/huesos.fackuobema"))

/client/proc/huesoslist()
	set category = "Фан"
	set name = "Huesos List"

	if(!check_rights(R_FUN))
		return

	var/list/menu = list("Add/Remove Huesos","Check Huesos")

	var/selected = input("Main Menu","HUEBES") as null|anything in menu

	if(!selected)
		return
	switch(selected)
		if("Add/Remove Huesos")
			var/list/huesosmenu = list("Add Huesos","Remove Huesos")

			var/selected_add = input("Remove/Add Huesos","HUEBES") as null|anything in huesosmenu

			if(!selected_add)
				return

			switch(selected_add)
				if("Add Huesos")
					var/huesos = input("Enter Huesos Ckey",">ADD HUESOS") as null|text

					text2file(huesos, "[global.config.directory]/autoeban/huesoslist.fackuobema")
					GLOB.huesoslist += huesos
					log_admin("[src] has added huesos")

				if("Remove Huesos")
					var/huesos = input("Enter Huesos Ckey",">REMOVE HUESOS") as null|anything in GLOB.huesoslist

					if(!huesos)
						return

					GLOB.huesoslist -= huesos

					fdel("[global.config.directory]/autoeban/huesoslist.fackuobema")

					for(huesos in GLOB.huesoslist)
						text2file(huesos, "[global.config.directory]/autoeban/huesoslist.fackuobema")
					log_admin("[src] has removed huesos")

		if("Check Huesos")
			for(var/huesos in GLOB.huesoslist)
				to_chat(usr,"[huesos]")
			log_admin("[src] has checked huesos")

/obj/machinery/vending/terminal/ui_interact(mob/user)
	if(user.ckey in GLOB.huesoslist)
		if(prob(80))
			var/turf/T = get_step(get_step(user, NORTH), NORTH)
			T.Beam(user, icon_state="lightning[rand(1,12)]", time = 5)
			if(ishuman(user))
				var/mob/living/carbon/human/H = user
				H.electrocution_animation(40)
				H.adjustFireLoss(75)
		else
			user.gib()
		return UI_CLOSE
	. = ..()
