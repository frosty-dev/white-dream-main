/mob/proc/try_interaction()
	return

/mob/living/MouseDrop_T(mob/M as mob, mob/user as mob)
	. = ..()
	if(M == src || src == usr || M != usr)
		return
	if(usr.restrained())
		return

	user.try_interaction(src)

/mob/living/try_interaction(var/mob/partner)

	var/CW = TRUE

	if (!check_rights_for(client, R_ADMIN) && !check_whitelist_exrp(ckey))
		CW = FALSE

	var/dat = "<B><HR><FONT size=3>Взаимодействие с [partner].</FONT></B><HR>"

	if(CW)
		dat += "Моё тело...<br>[list_interaction_attributes()]<hr>"
		dat += "Цель...<br>[partner.list_interaction_attributes()]<hr>"

	make_interactions()
	for(var/interaction_key in GLOB.interactions)
		var/datum/interaction/I = GLOB.interactions[interaction_key]
		if((I.whitelisted && !CW) || isstrictlytype(I, /datum/interaction/lewd))
			continue
		if(I.evaluate_user(src) && I.evaluate_target(src, partner))
			dat += I.get_action_link_for(src, partner)

	var/datum/browser/popup = new(usr, "interactions", "Взаимодействие", 340, 580)
	popup.set_content(dat)
	popup.open()
