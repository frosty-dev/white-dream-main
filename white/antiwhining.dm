
/client
	var/shadowbanned_ooc = 0
	var/totalmsg = 0
	var/whinecount = 0
	var/tg_insult = 0

/proc/whiningcheck(var/client/C, var/msg)
	msg = lowertext(msg)

	var/list/T1I = list("новотг","тг","тгшники","вайт","дизарм","дня","билд")
	var/list/T1W = list("бей","бея","гринотг","тгрин","вг")

	var/list/T2I = list("говно","ссанина","менять","пиздец","параша")
	var/list/T2W = list("лучше","раньше")

	var/list/rjach = list("вот вайт при моде", "вот вайт при чудце")

	for(var/L in rjach)
		if(findtext(msg, L) && !(C.ckey in GLOB.petushiniy_list))
			GLOB.petushiniy_list += C.ckey

	var/list/ML = splittext(msg, " ")

	for(var/W in ML)
		if(W in T1I)
			for(var/WI in ML)
				if(WI in T2I)
					C.tg_insult = 1
					C.whinecount++
		if(W in T1W)
			for(var/WW in ML)
				if(WW in T2W)
					C.whinecount++

	if(C.whinecount == 0)
		return

	C.totalmsg++

	if(C.totalmsg >= 5)
		var/index = C.whinecount/C.totalmsg
		if(index >= 0.5 && C.tg_insult)
			C.shadowbanned_ooc = 1
			message_admins("[key_name_admin(C)] was shadowbanned by system.")

