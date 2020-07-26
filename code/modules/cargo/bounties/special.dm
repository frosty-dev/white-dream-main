/datum/bounty/item/alien_organs
	name = "Органы ксеноморфов"
	description = "НТ заинтересованы в изучении биологии ксеноморфа. Отправьте их органы!"
	reward = 25000
	required_count = 3
	wanted_types = list(/obj/item/organ/brain/alien, /obj/item/organ/alien, /obj/item/organ/body_egg/alien_embryo, /obj/item/organ/liver/alien, /obj/item/organ/tongue/alien, /obj/item/organ/eyes/night_vision/alien)

/datum/bounty/item/syndicate_documents
	name = "Документы Синдиката"
	description = "Данные в отношении синдиката высоко ценится в ЦК. Если вы найдете документы синдиката , отправьте их. Вы могли бы спасти жизни."
	reward = 15000
	wanted_types = list(/obj/item/documents/syndicate, /obj/item/documents/photocopy)

/datum/bounty/item/syndicate_documents/applies_to(obj/O)
	if(!..())
		return FALSE
	if(istype(O, /obj/item/documents/photocopy))
		var/obj/item/documents/photocopy/Copy = O
		return (Copy.copy_type && ispath(Copy.copy_type, /obj/item/documents/syndicate))
	return TRUE

/datum/bounty/item/adamantine
	name = "Адамантин"
	description = "Отделение аномальных материалов НТ остро нуждается в адамантине. Отправьте им крупный груз, и мы сделаем так, чтобы оно того стоило."
	reward = 35000
	required_count = 10
	wanted_types = list(/obj/item/stack/sheet/mineral/adamantine)

/datum/bounty/item/trash
	name = "Мусор"
	description = "Недавно группа уборщиков исчерпала мусор для очистки, без всякого мусора ЦК хочет уволить их, чтобы сократить расходы. Отправьте партию мусора, чтобы они были заняты, и они дадут вам небольшую компенсацию."
	reward = 1000
	required_count = 10
	wanted_types = list(/obj/item/trash)

/datum/bounty/more_bounties
	name = "Больше заказов"
	description = "Выполните достаточно заказов, и ЦК отправит новые!"
	reward = 5 // number of bounties
	var/required_bounties = 5

/datum/bounty/more_bounties/can_claim()
	return ..() && completed_bounty_count() >= required_bounties

/datum/bounty/more_bounties/completion_string()
	return "[min(required_bounties, completed_bounty_count())]/[required_bounties] заказов"

/datum/bounty/more_bounties/reward_string()
	return "До [reward] новых заказов"

/datum/bounty/more_bounties/claim()
	if(can_claim())
		claimed = TRUE
		for(var/i = 0; i < reward; ++i)
			try_add_bounty(random_bounty())
