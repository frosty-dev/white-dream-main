/datum/action/changeling/spiders
	name = "Распространение заражения"
	desc = "Наша форма разделяется, создавая паукообразных, которые превратятся в смертельных зверей. Стоит 45 химикатов."
	helptext = "Пауки - бездумные существа и могут полностью атаковать своих создателей. Требуется как минимум 3 поглощения ДНК."
	button_icon_state = "spread_infestation"
	chemical_cost = 45
	dna_cost = 1
	req_absorbs = 3

//Makes some spiderlings. Good for setting traps and causing general trouble.
/datum/action/changeling/spiders/sting_action(mob/user)
	..()
	spawn_atom_to_turf(/obj/structure/spider/spiderling/hunter, user, 2, FALSE)
	return TRUE
