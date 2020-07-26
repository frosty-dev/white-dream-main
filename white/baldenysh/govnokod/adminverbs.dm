/client/proc/retrieve_file()
	set category = "Дбг"
	set name = "Retrieve file"

	if(!check_rights())
		return

	var/filepath = input("Enter file path", "SALO RETRIEVAL TERMINAL V0.77") as null|text
	if(fexists(filepath))
		usr << ftp("[filepath]")
	else
		to_chat(usr,"<span class='warning'>Такого файла не существует.</span>")

/client/proc/manage_lists()
	set category = "Дбг"
	set name = "Manage autoeban"

	if(!check_rights())
		return

	var/list/listoflists = list(
								"bad words" = list(GLOB.bad_words, "cfg/autoeban/bad_words.fackuobema"),
								"exclusions (start)" =  list(GLOB.exc_start, "cfg/autoeban/exc_start.fackuobema"),
								"exclusions (end)" =  list(GLOB.exc_end, "cfg/autoeban/exc_end.fackuobema"),
								"exclusions (full)" = list(GLOB.exc_full, "cfg/autoeban/exc_full.fackuobema"),
								"debix list" = list(GLOB.neobuchaemie_debili, "cfg/autoeban/debix_list.fackuobema")
								)

	var/selected = input("Main Menu", "Manage autoeban") as null|anything in listoflists

	if(!islist(listoflists[selected]))
		return

	var/list/L = listoflists[selected]
	var/list/LT = L[1]
	var/owtext = input(usr, "[selected]", "Manage list", LT.Join("\n")) as message|null

	if(!owtext) // retort
		return

	LT.Remove(LT)
	LT.Add(splittext(owtext,"\n"))

	if(fexists(L[2]))
		fdel(L[2])

	log_admin("[key_name(usr)] edits [selected].")
	message_admins("[key_name_admin(usr)] редактирует [selected].")

	text2file(LT.Join("\n"), L[2])
