/datum/action/changeling/adrenaline
	name = "Адреналиновые железы"
	desc = "Мы развиваем дополнительные железы адреналина по всему телу. Стоимость в 30 химикатов."
	helptext = "Мгновенно удаляет все оглушения и добавляет кратковременное уменьшение других оглушений. Может использоваться в бессознательном состоянии. Продолжение использования отравляет организм."
	button_icon_state = "adrenaline"
	chemical_cost = 30
	dna_cost = 2
	req_human = 1
	req_stat = UNCONSCIOUS

//Recover from stuns.
/datum/action/changeling/adrenaline/sting_action(mob/living/user)
	..()
	to_chat(user, "<span class='notice'>Мы ощущаем прилив энергии.</span>")
	user.SetKnockdown(0)
	user.set_resting(FALSE)
	user.reagents.add_reagent(/datum/reagent/medicine/changelingadrenaline, 4) //20 seconds
	user.reagents.add_reagent(/datum/reagent/medicine/changelinghaste, 3) //6 seconds, for a really quick burst of speed
	return TRUE
