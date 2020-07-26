/datum/bounty/item/mech/New()
	..()
	description = "Высшее руководство попросило отправить одного [name] меха как можно скорее. Отправьте его, чтобы получить большую оплату."

/datum/bounty/item/mech/ship(obj/O)
	if(!applies_to(O))
		return
	if(istype(O, /obj/mecha))
		var/obj/mecha/M = O
		M.wreckage = null // So the mech doesn't explode.
	..()

/datum/bounty/item/mech/mark_high_priority(scale_reward)
	return ..(max(scale_reward * 0.7, 1.2))

/datum/bounty/item/mech/ripleymkii
	name = "APLU MK-II \"Рипли\""
	reward = 13000
	wanted_types = list(/obj/mecha/working/ripley/mkii)

/datum/bounty/item/mech/clarke
	name = "Кларк"
	reward = 16000
	wanted_types = list(/obj/mecha/working/clarke)

/datum/bounty/item/mech/odysseus
	name = "Одиссей"
	reward = 11000
	wanted_types = list(/obj/mecha/medical/odysseus)

/datum/bounty/item/mech/gygax
	name = "Гигакс"
	reward = 28000
	wanted_types = list(/obj/mecha/combat/gygax)

/datum/bounty/item/mech/durand
	name = "Дюранд"
	reward = 20000
	wanted_types = list(/obj/mecha/combat/durand)
