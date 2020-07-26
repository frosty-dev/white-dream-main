/datum/action/changeling/chameleon_skin
	name = "Кожа хамелеона"
	desc = "Наша пигментация кожи быстро меняется в соответствии с нашей нынешней средой. Стоит 25 химикатов."
	helptext = "Позволяет нам стать невидимыми после нескольких секунд стояния на месте. Может быть включено и выключено."
	button_icon_state = "chameleon_skin"
	dna_cost = 2
	chemical_cost = 25
	req_human = 1

/datum/action/changeling/chameleon_skin/sting_action(mob/user)
	var/mob/living/carbon/human/H = user //SHOULD always be human, because req_human = 1
	if(!istype(H)) // req_human could be done in can_sting stuff.
		return
	..()
	if(H.dna.get_mutation(CHAMELEON))
		H.dna.remove_mutation(CHAMELEON)
	else
		H.dna.add_mutation(CHAMELEON)
	return TRUE

/datum/action/changeling/chameleon_skin/Remove(mob/user)
	if(user.has_dna())
		var/mob/living/carbon/C = user
		C.dna.remove_mutation(CHAMELEON)
	..()
