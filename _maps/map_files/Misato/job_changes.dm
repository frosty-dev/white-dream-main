#define JOB_MODIFICATION_MAP_NAME "Misato"

/datum/job/New()
	..()
	MAP_JOB_CHECK
	supervisors = "ордену Алого Рассвета"

/datum/outfit/job/New()
	..()
	MAP_JOB_CHECK
	box = /obj/item/storage/box/survival/radio

/datum/job/engineer
