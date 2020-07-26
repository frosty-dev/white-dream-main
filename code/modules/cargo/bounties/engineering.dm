/datum/bounty/item/engineering/gas
	name = "Полная канистра плюоксия"
	description = "РнД ЦК исследует сверхкомпактные внутренние устройства. Отправьте им бак, полный плуоксиума, и вы получите компенсацию."
	reward = 7500
	wanted_types = list(/obj/item/tank)
	var/moles_required = 20 // A full tank is 28 moles, but CentCom ignores that fact.
	var/gas_type = /datum/gas/pluoxium

/datum/bounty/item/engineering/gas/applies_to(obj/O)
	if(!..())
		return FALSE
	var/obj/item/tank/T = O
	return T.air_contents.get_moles(gas_type) >= moles_required

/datum/bounty/item/engineering/gas/nitryl_tank
	name = "Полная канистра Нитрила"
	description = "Персонал станции 88, не являющиеся людьми, были вызван для тестирования препаратов, улучшающих их эффективность. Отправьте им резервуар, полный нитрила, чтобы они могли начать эксперимент."
	gas_type = /datum/gas/nitryl

/datum/bounty/item/engineering/gas/freon_tank
	name = "Полная канистра Фреона"
	description = "Суперматерия Станции 33 начала процесс деламинации. Доставьте баллон с фреоновым газом, чтобы помочь им остановить его!"
	gas_type = /datum/gas/freon

/datum/bounty/item/engineering/gas/tritium_tank
	name = "Полная канисра Тритиума"
	description = "Станция 49 надеется начать свою исследовательскую программу. Отправьте им канистру, полную трития."
	gas_type = /datum/gas/tritium

/datum/bounty/item/engineering/gas/hydrogen_tank
	name = "Полная канистра Гидрогена"
	description = "Наш отдел исследований и разработок занимается разработкой более эффективных электрических батарей, использующих водород в качестве катализатора. Отправьте нам полный бак Гидрогена."
	gas_type = /datum/gas/hydrogen

/datum/bounty/item/engineering/energy_ball
	name = "Удержанный шар теслы"
	description = "Станция 24 наводнена ордами разгневанных молей. Они запрашивают ультимативную убийцу насекомых."
	reward = 75000 //requires 14k credits of purchases, not to mention cooperation with engineering/heads of staff to set up inside the cramped shuttle
	wanted_types = list(/obj/singularity/energy_ball)

/datum/bounty/item/engineering/energy_ball/applies_to(obj/O)
	if(!..())
		return FALSE
	var/obj/singularity/energy_ball/T = O
	return !T.miniball
