/datum/antagonist/nightmare
	name = "Nightmare"
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE

/datum/antagonist/nightmare/on_gain()
	var/datum/objective/survive/S = new
	S.reward = 30
	S.owner = owner
	objectives+=S
	. = ..()
