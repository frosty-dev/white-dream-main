/datum/action/changeling/lesserform
	name = "Меньшая форма"
	desc = "Мы перестраиваемся и становимся меньше. Мы становимся обезьяной. Стоит 5 химикатов."
	helptext = "Трансформация значительно уменьшает наши размеры, позволяя нам выскользнуть из манжеты и пролезть через вентиляционные отверстия."
	button_icon_state = "lesser_form"
	chemical_cost = 5
	dna_cost = 1
	req_human = 1

//Transform into a monkey.
/datum/action/changeling/lesserform/sting_action(mob/living/carbon/human/user)
	if(!user || user.notransform)
		return FALSE
	to_chat(user, "<span class='warning'>Наши гены кричат!</span>")
	..()
	user.monkeyize(TR_KEEPITEMS | TR_KEEPIMPLANTS | TR_KEEPORGANS | TR_KEEPDAMAGE | TR_KEEPVIRUS | TR_KEEPSTUNS | TR_KEEPREAGENTS | TR_KEEPSE | TR_KEEPSTAMINADAMAGE)
	return TRUE
