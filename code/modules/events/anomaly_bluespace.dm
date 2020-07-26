/datum/round_event_control/anomaly/anomaly_bluespace
	name = "Anomaly: Bluespace"
	typepath = /datum/round_event/anomaly/anomaly_bluespace

	max_occurrences = 1
	weight = 15

/datum/round_event/anomaly/anomaly_bluespace
	startWhen = 3
	announceWhen = 10
	anomaly_path = /obj/effect/anomaly/bluespace

/datum/round_event/anomaly/anomaly_bluespace/announce(fake)
	priority_announce("Нестабильная блюспейс аномалия обнаружена на сканерах большой дальности. Ожидаемое место: [impact_area.name].", "Аномальная тревога", 'sound/ai/announcer/anomaly.ogg')
