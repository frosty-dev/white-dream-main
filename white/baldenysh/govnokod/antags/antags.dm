/datum/antagonist/dreamer_orbital
	name = "Дример с Л******а"
	show_in_antagpanel = TRUE
	roundend_category = "Orbital Ruin Antags"
	antagpanel_category = "Other"

/datum/antagonist/dreamer_orbital/proc/forge_objectives()
	var/datum/objective/slay/slay = new
	slay.owner = owner
	slay.reward = 50 //ну а хули он посреди раунда без эквипа в жопе мира стартует
	objectives += slay
	if(prob(40))
		var/datum/objective/limited/limit = new //тун ту ду ту ту дун ту ту ду
		limit.time_to_do = 1 HOURS
		limit.owner = owner
		limit.reward = 50
		objectives += limit
	else
		var/datum/objective/survive/survive = new
		survive.owner = owner
		survive.reward = 15
		objectives += survive

/datum/antagonist/dreamer_orbital/on_gain()
	forge_objectives()
	owner.special_role = "Dreamer"
	. = ..()

