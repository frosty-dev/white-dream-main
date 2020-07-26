/atom/proc/ru_get_examine_name(mob/user)
	switch (rand(0, 100))
		if (1)
			. = "непримечательный [src.name]"
		if (2)
			. = "обычный [src.name]"
		if (3)
			. = "невероятный [src.name]"
		else
			. = "[src.name]"
	var/list/override = list(gender == PLURAL ? " " : " ", " ", "[name]")
	if(article)
		. = "[src.name]"
		override[EXAMINE_POSITION_ARTICLE] = article
	if(SEND_SIGNAL(src, COMSIG_ATOM_GET_EXAMINE_NAME, user, override) & COMPONENT_EXNAME_CHANGED)
		. = "[src.name]"

///Generate the full examine string of this atom (including icon for goonchat)
/atom/proc/ru_get_examine_string(mob/user)
	return "[icon2html(src, user)] <b>[capitalize(ru_get_examine_name(user))]</b>"
