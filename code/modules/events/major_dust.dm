/datum/round_event_control/meteor_wave/major_dust
	name = "Major Space Dust"
	typepath = /datum/round_event/meteor_wave/major_dust
	weight = 90

/datum/round_event/meteor_wave/major_dust
	wave_name = "space dust"

/datum/round_event/meteor_wave/major_dust/announce(fake)
	var/reason = pick(
		"Станция проходит сквозь облако мусора, ожидается незначительное повреждение внешнего оборудования и кострукций.",
		"Подразделение супероружия Нанотрейзена проводит испытания нового прототипа [pick("метафизической","ониксовой","взрывной","супер-коллизионной","реактивной")] \
		[pick("пушки","артиллерии","боярки","крейсерной обшивки","\[REDACTED\]")], \
		ожидается небольшой мусор.",
		"Соседняя станция бросает в вас камни. (Возможно, они устали от ваших сообщений.)")
	priority_announce(pick(reason), "Опасность столкновения", 'sound/ai/announcer/meteors.ogg')
