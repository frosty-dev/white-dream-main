/datum/round_event_control/anomaly/anomaly_pyro
	name = "Anomaly: Pyroclastic"
	typepath = /datum/round_event/anomaly/anomaly_pyro

	max_occurrences = 5
	weight = 20

/datum/round_event/anomaly/anomaly_pyro
	startWhen = 3
	announceWhen = 10
	anomaly_path = /obj/effect/anomaly/pyro

/datum/round_event/anomaly/anomaly_pyro/announce(fake)
	priority_announce("Пирокластическая аномалия обнаружена на сканерах большой дальности. Ожидаемое место: [impact_area.name].", "Аномальная тревога", 'sound/ai/announcer/anomaly.ogg')
