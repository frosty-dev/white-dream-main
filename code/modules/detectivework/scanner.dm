//CONTAINS: Detective's Scanner

// TODO: Split everything into easy to manage procs.

/obj/item/detective_scanner
	name = "судебно-медицинский сканер"
	desc = "Используется для удаленного сканирования объектов и биомассы на наличие ДНК и отпечатков пальцев. Может распечатать отчет со списком найденного."
	icon = 'icons/obj/device.dmi'
	icon_state = "forensicnew"
	w_class = WEIGHT_CLASS_SMALL
	inhand_icon_state = "electronic"
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	var/scanning = FALSE
	var/list/log = list()
	var/range = 8
	var/view_check = TRUE
	var/forensicPrintCount = 0
	actions_types = list(/datum/action/item_action/display_detective_scan_results)

/datum/action/item_action/display_detective_scan_results
	name = "Display Forensic Scanner Results"

/datum/action/item_action/display_detective_scan_results/Trigger()
	var/obj/item/detective_scanner/scanner = target
	if(istype(scanner))
		scanner.displayDetectiveScanResults(usr)

/obj/item/detective_scanner/attack_self(mob/user)
	if(log.len && !scanning)
		scanning = TRUE
		to_chat(user, "<span class='notice'>Печатаю отчет, пожалуйста подождите...</span>")
		addtimer(CALLBACK(src, .proc/PrintReport), 100)
	else
		to_chat(user, "<span class='notice'>Логи сканера пусты или же он используется.</span>")

/obj/item/detective_scanner/attack(mob/living/M, mob/user)
	return

/obj/item/detective_scanner/proc/PrintReport()
	// Create our paper
	var/obj/item/paper/P = new(get_turf(src))

	//This could be a global count like sec and med record printouts. See GLOB.data_core.medicalPrintCount AKA datacore.dm
	var/frNum = ++forensicPrintCount

	P.name = text("СМЗ-[] 'Судебно-Медицинская Запись'", frNum)
	P.info = text("<center><B>Судебно-Медицинская Запись - (СМЗ-[])</B></center><HR><BR>", frNum)
	P.info += jointext(log, "<BR>")
	P.info += "<HR><B>Примечания:</B><BR>"
	P.update_icon()

	if(ismob(loc))
		var/mob/M = loc
		M.put_in_hands(P)
		to_chat(M, "<span class='notice'>Отчет напечатан. Логи очищены.</span>")

	// Clear the logs
	log = list()
	scanning = FALSE

/obj/item/detective_scanner/afterattack(atom/A, mob/user, params)
	. = ..()
	scan(A, user)
	return FALSE

/obj/item/detective_scanner/proc/scan(atom/A, mob/user)
	set waitfor = FALSE
	if(!scanning)
		// Can remotely scan objects and mobs.
		if((get_dist(A, user) > range) || (!(A in view(range, user)) && view_check) || (loc != user))
			return

		scanning = TRUE

		user.visible_message("<span class='notice'>[user] указывает на [src.name] в [A] и начинает судебно-медицинское сканирование.</span>")
		to_chat(user, "<span class='notice'>Сканирую [A]. Сканер начинает анализ результатов...</span>")


		// GATHER INFORMATION

		//Make our lists
		var/list/fingerprints = list()
		var/list/blood = A.return_blood_DNA()
		var/list/fibers = A.return_fibers()
		var/list/reagents = list()

		var/target_name = A.name

		// Start gathering

		if(ishuman(A))

			var/mob/living/carbon/human/H = A
			if(!H.gloves)
				fingerprints += md5(H.dna.uni_identity)

		else if(!ismob(A))

			fingerprints = A.return_fingerprints()

			// Only get reagents from non-mobs.
			if(A.reagents && A.reagents.reagent_list.len)

				for(var/datum/reagent/R in A.reagents.reagent_list)
					reagents[R.name] = R.volume

					// Get blood data from the blood reagent.
					if(istype(R, /datum/reagent/blood))

						if(R.data["blood_DNA"] && R.data["blood_type"])
							var/blood_DNA = R.data["blood_DNA"]
							var/blood_type = R.data["blood_type"]
							LAZYINITLIST(blood)
							blood[blood_DNA] = blood_type

		// We gathered everything. Create a fork and slowly display the results to the holder of the scanner.

		var/found_something = FALSE
		add_log("<B>[station_time_timestamp()][get_timestamp()] - [target_name]</B>", 0)

		// Fingerprints
		if(length(fingerprints))
			sleep(30)
			add_log("<span class='info'><B>Отпечатки:</B></span>")
			for(var/finger in fingerprints)
				add_log("[finger]")
			found_something = TRUE

		// Blood
		if (length(blood))
			sleep(30)
			add_log("<span class='info'><B>Кровь:</B></span>")
			found_something = TRUE
			for(var/B in blood)
				add_log("Type: <font color='red'>[blood[B]]</font> ДНК (UE): <font color='red'>[B]</font>")

		//Fibers
		if(length(fibers))
			sleep(30)
			add_log("<span class='info'><B>Волокна:</B></span>")
			for(var/fiber in fibers)
				add_log("[fiber]")
			found_something = TRUE

		//Reagents
		if(length(reagents))
			sleep(30)
			add_log("<span class='info'><B>Реагенты:</B></span>")
			for(var/R in reagents)
				add_log("Reagent: <font color='red'>[R]</font> Объем: <font color='red'>[reagents[R]]</font>")
			found_something = TRUE

		// Get a new user
		var/mob/holder = null
		if(ismob(src.loc))
			holder = src.loc

		if(!found_something)
			add_log("<I># Судебно-медецинских следов не обнаружено #</I>", 0) // Don't display this to the holder user
			if(holder)
				to_chat(holder, "<span class='warning'>Не в состоянии обнаружить какие-либо отпечатки, материалы, волокна, или кровь на [target_name]!</span>")
		else
			if(holder)
				to_chat(holder, "<span class='notice'>Сканирование [target_name] завершено.</span>")

		add_log("---------------------------------------------------------", 0)
		scanning = FALSE
		return

/obj/item/detective_scanner/proc/add_log(msg, broadcast = 1)
	if(scanning)
		if(broadcast && ismob(loc))
			var/mob/M = loc
			to_chat(M, msg)
		log += "&nbsp;&nbsp;[msg]"
	else
		CRASH("[src] [REF(src)] добавляет лог, когда он не был переведен в режим сканирования!")

/proc/get_timestamp()
	return time2text(world.time + 432000, ":ss")

/obj/item/detective_scanner/AltClick(mob/living/user)
	// Best way for checking if a player can use while not incapacitated, etc
	if(!user.canUseTopic(src, be_close=TRUE))
		return
	if(!LAZYLEN(log))
		to_chat(user, "<span class='notice'>Не удалось очистить логи, логи сканера пусты.</span>")
		return
	if(scanning)
		to_chat(user, "<span class='notice'>Не удалось очистить логи, сканер используется.</span>")
		return
	to_chat(user, "<span class='notice'>Логи сканера очищены.</span>")
	log = list()

/obj/item/detective_scanner/examine(mob/user)
	. = ..()
	if(LAZYLEN(log) && !scanning)
		. += "<hr><span class='notice'>Alt+ЛКМ чтобы очистить логи сканера.</span>"

/obj/item/detective_scanner/proc/displayDetectiveScanResults(mob/living/user)
	// No need for can-use checks since the action button should do proper checks
	if(!LAZYLEN(log))
		to_chat(user, "<span class='notice'>Не удалось отобразить логи, логи сканера пусты.</span>")
		return
	if(scanning)
		to_chat(user, "<span class='notice'>Не удалось отобразить логи, сканер используется.</span>")
		return
	to_chat(user, "<span class='notice'><B>Отчет сканера</B></span>")
	for(var/iterLog in log)
		to_chat(user, iterLog)
