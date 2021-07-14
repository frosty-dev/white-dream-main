/datum/job/scientist
	title = "Scientist"
	ru_title = "Учёный"
	department_head = list("Research Director")
	faction = "Station"
	total_positions = 5
	spawn_positions = 3
	supervisors = "научному руководителю"
	selection_color = "#ffeeff"
	exp_requirements = 60
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/scientist

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_SCI

	display_order = JOB_DISPLAY_ORDER_SCIENTIST
	bounty_types = CIV_JOB_SCI

	mail_goodies = list(
		/obj/item/raw_anomaly_core/random = 10,
		/obj/item/disk/tech_disk/spaceloot = 2,
		/obj/item/camera_bug = 1
	)

/datum/outfit/job/scientist
	name = "Scientist"
	jobtype = /datum/job/scientist

	belt = /obj/item/pda/toxins
	ears = /obj/item/radio/headset/headset_sci
	uniform = /obj/item/clothing/under/rank/rnd/scientist
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit = /obj/item/clothing/suit/toggle/labcoat/science

	r_pocket = /obj/item/discovery_scanner

	backpack_contents = list(/obj/item/modular_computer/tablet/preset/cheap=1)

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/tox

	id_trim = /datum/id_trim/job/scientist

/datum/outfit/job/scientist/pre_equip(mob/living/carbon/human/H)
	..()
	if(prob(0.4))
		neck = /obj/item/clothing/neck/tie/horrible
