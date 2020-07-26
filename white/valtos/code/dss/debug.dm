/client/proc/set_stats()
	set category = "Дбг"
	set name = "Set Stats"

	if(!src.holder)
		to_chat(src, "Only administrators may use this command.", confidential = TRUE)
		return

	var/list/keys = list()
	for(var/mob/living/carbon/human/M in GLOB.player_list)
		keys += M.client

	var/client/selection = input("Please, select a player!", "Set Stat", null, null) as null|anything in sortKey(keys)

	if(!selection)
		to_chat(src, "No keys found.", confidential = TRUE)
		return

	var/mob/living/carbon/human/M = selection.mob

	var/list/pickerlist = list()
	var/list/statlist = M.get_stats()

	for (var/i in statlist)
		pickerlist += list(list("value" = statlist[i], "name" = i))

	var/list/result = presentpicker(usr, "Modify stats", "Modify stats: [M]", Button1="Save", Button2 = "Cancel", Timeout=FALSE, inputtype = "text", values = pickerlist)

	if (islist(result))
		if (result["button"] != 2)
			M.set_stats(text2num(result["values"][MOB_STR]),\
						text2num(result["values"][MOB_STM]),\
						text2num(result["values"][MOB_INT]),\
						text2num(result["values"][MOB_DEX]))
			log_admin("[key_name(usr)] modified the stats on [M] ([type]) to STR: [M.current_fate[MOB_STR]], STM: [M.current_fate[MOB_STM]], INT: [M.current_fate[MOB_INT]], DEX: [M.current_fate[MOB_DEX]]")
			message_admins("<span class='notice'>[key_name_admin(usr)] modified the stats on [M] ([type]) to STR: [M.current_fate[MOB_STR]], STM: [M.current_fate[MOB_STM]], INT: [M.current_fate[MOB_INT]], DEX: [M.current_fate[MOB_DEX]]</span>")
