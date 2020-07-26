/datum/round_event_control/mice_migration
	name = "Mice Migration"
	typepath = /datum/round_event/mice_migration
	weight = 10

/datum/round_event/mice_migration
	var/minimum_mice = 5
	var/maximum_mice = 15

/datum/round_event/mice_migration/announce(fake)
	var/cause = pick("космозимы", "урезания бюджетов", "Рагнарёка",
		"холодного космоса", "\[REDACTED\]", "изменения климата",
		"невезения")
	var/plural = pick("группа", "стая", "толпа", "рой",
		"пакет", "не более чем из [maximum_mice]")
	var/name = pick("грызунов", "мышей", "пищащих штук",
		"пожирателей проводов", "\[REDACTED\]", "паразитирующих уничтожителей энергии")
	var/movement = pick("мигрировала", "переехала", "приползла", "спустилась")
	var/location = pick("технические тоннели", "технические зоны",
		"\[REDACTED\]", "места, где находятся вкусные провода")

	priority_announce("По причине [cause], [plural] [name] [movement] в [location].", "Миграционная тревога", 'sound/ai/announcer/migration.ogg')

/datum/round_event/mice_migration/start()
	SSminor_mapping.trigger_migration(rand(minimum_mice, maximum_mice))
