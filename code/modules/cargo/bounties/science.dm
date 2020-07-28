/datum/bounty/item/science/boh
	name = "Bag of Holding"
	description = "НТ хорошо использовали бы рюкзаки большой вместимости. Если у вас есть, пожалуйста, отправьте их."
	reward = 10000
	wanted_types = list(/obj/item/storage/backpack/holding)

/datum/bounty/item/science/tboh
	name = "Trash Bag of Holding"
	description = "НТ хотели бы использовать мешки для мусора большой емкости. Если у вас есть, пожалуйста, отправьте их."
	reward = 10000
	wanted_types = list(/obj/item/storage/backpack/holding)

/datum/bounty/item/science/bluespace_syringe
	name = "Блюспейс шприц"
	description = "НТ хочет использовать шприцы большой емкости. Если у вас есть, пожалуйста, отправьте их."
	reward = 10000
	wanted_types = list(/obj/item/reagent_containers/syringe/bluespace)

/datum/bounty/item/science/bluespace_body_bag
	name = "Блюспейс мешок для трупов"
	description = "НТ хочет использовать сумки для тела большой емкости. Если у вас есть, пожалуйста, отправьте их."
	reward = 10000
	wanted_types = list(/obj/item/bodybag/bluespace)

/datum/bounty/item/science/nightvision_goggles
	name = "Очки ночного видения"
	description = "Электрический шторм сломал все лампы на ЦК. Пока руководство ожидает замены, возможно, несколько очков ночного видения могут быть отправлены?"
	reward = 10000
	wanted_types = list(/obj/item/clothing/glasses/night, /obj/item/clothing/glasses/meson/night, /obj/item/clothing/glasses/hud/health/night, /obj/item/clothing/glasses/hud/security/night, /obj/item/clothing/glasses/hud/diagnostic/night)

/datum/bounty/item/science/experimental_welding_tool
	name = "Экспериментальный сварочный инструмент"
	description = "Недавняя авария привела к взрыву большинства сварочных инструментов ЦК. Отправители будут вознаграждены."
	reward = 10000
	required_count = 3
	wanted_types = list(/obj/item/weldingtool/experimental)

/datum/bounty/item/science/cryostasis_beaker
	name = "Крио-стакан"
	description = "Химики ЦК обнаружили новый химикат, который можно хранить только в стаканах с криостазом. Единственная проблема в том, что у них их нет! Исправьте это, чтобы получить оплату."
	reward = 10000
	wanted_types = list(/obj/item/reagent_containers/glass/beaker/noreact)

/datum/bounty/item/science/diamond_drill
	name = "Алмазная шахтёрская дрель"
	description = "Центральное командование готово выплачивать трехмесячную зарплату в обмен на одну алмазную дрель"
	reward = 15000
	wanted_types = list(/obj/item/pickaxe/drill/diamonddrill, /obj/item/mecha_parts/mecha_equipment/drill/diamonddrill)

/datum/bounty/item/science/floor_buffer
	name = "Улучшение напольного буфера"
	description = "Один из уборщиков ЦК сделал небольшое состояние, делая ставки на скачках карпа. Теперь они хотели бы заказать улучшение напольного буфера."
	reward = 10000
	wanted_types = list(/obj/item/janiupgrade)

/datum/bounty/item/science/advanced_mop
	name = "Продвинутая Швабра"
	description = "Прошу прощения. Я хотел бы попросить 17 кр за переделку метлой. Или это, или продвинутая швабра."
	reward = 10000
	wanted_types = list(/obj/item/mop/advanced)

/datum/bounty/item/science/advanced_egun
	name = "Продвинутый е-ган"
	description = "С ростом цен на зарядные устройства, высшее руководство заинтересовано в покупке оружия с автоматическим питанием. Если вы отправите один, они заплатят."
	reward = 10000
	wanted_types = list(/obj/item/gun/energy/e_gun/nuclear)

/datum/bounty/item/science/bepis_disc
	name = "Reformatted Tech Disk"
	description = "It turns out the diskettes the BEPIS prints experimental nodes on are extremely space-efficient. Send us one of your spares when you're done with it."
	reward = 4000
	wanted_types = list(/obj/item/disk/tech_disk/major)
