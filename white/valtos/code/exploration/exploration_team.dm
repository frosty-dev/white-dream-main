/datum/job/exploration
	title = "Exploration Crew"
	ru_title = "Рейнджер"
	department_head = list("Head of Personnel", "Research Director")
	exp_type = EXP_TYPE_CREW
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	supervisors = "завхозу, главе персонала и научному руководителю"
	selection_color = "#dcba97"

	outfit = /datum/outfit/job/exploration

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_CAR

	display_order = JOB_DISPLAY_ORDER_SHAFT_MINER
	bounty_types = CIV_JOB_MINE

	metalocked = TRUE

/datum/job/exploration/equip(mob/living/carbon/human/H, visualsOnly, announce, latejoin, datum/outfit/outfit_override, client/preference_source)
	if(outfit_override)
		return ..()
	if(visualsOnly || latejoin)
		return ..()
	var/static/exploration_job_id = 0
	exploration_job_id ++
	switch(exploration_job_id)
		if(1)
			to_chat(H, "<span class='notice big'>Мне пришлось стать <span class'sciradio'>Учёным</span> в этой операции!</span>")
			to_chat(H, "<span class='notice'>Сканируем неизвестные штуки и получаем очки! Чудеса!</span>")
			outfit_override = /datum/outfit/job/exploration/scientist
		if(2)
			to_chat(H, "<span class='notice big'>Мне пришлось стать <span class'medradio'>Доктором</span> в этой операции!</span>")
			to_chat(H, "<span class='notice'>Необходимо следить за здоровьем товарищей.</span>")
			outfit_override = /datum/outfit/job/exploration/medic
		if(3)
			to_chat(H, "<span class='notice big'>Мне пришлось стать <span class'engradio'>Инженером</span> в этой операции!</span>")
			to_chat(H, "<span class='notice'>Установка взрывчатки и починка корпуса - моя обязанность.</span>")
			outfit_override = /datum/outfit/job/exploration/engineer
	. = ..(H, visualsOnly, announce, latejoin, outfit_override, preference_source)

/datum/outfit/job/exploration
	name = "Exploration Crew"
	jobtype = /datum/job/exploration

	belt = /obj/item/pda/exploration
	ears = /obj/item/radio/headset/headset_exploration
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/rank/cargo/exploration
	backpack_contents = list(
		/obj/item/kitchen/knife/combat/survival=1,\
		/obj/item/stack/marker_beacon/thirty=1)
	l_pocket = /obj/item/gps/mining/exploration
	r_pocket = /obj/item/gun/energy/e_gun/mini/exploration

	backpack = /obj/item/storage/backpack/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	duffelbag = /obj/item/storage/backpack/duffelbag

	id_trim = /datum/id_trim/job/exploration

	chameleon_extras = /obj/item/gun/energy/e_gun/mini/exploration

/datum/outfit/job/exploration/engineer
	name = "Exploration Crew (Engineer)"

	belt = /obj/item/storage/belt/utility/full
	r_pocket = /obj/item/pda/exploration

	backpack_contents = list(
		/obj/item/kitchen/knife/combat/survival=1,
		/obj/item/stack/marker_beacon/thirty=1,
		/obj/item/gun/energy/e_gun/mini/exploration=1,
		/obj/item/grenade/exploration=3,
		/obj/item/exploration_detonator=1,
		/obj/item/discovery_scanner=1
	)

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering

/datum/outfit/job/exploration/medic
	name = "Exploration Crew (Medical Doctor)"

	backpack_contents = list(
		/obj/item/kitchen/knife/combat/survival=1,
		/obj/item/stack/marker_beacon/thirty=1,
		/obj/item/storage/firstaid/medical=1,
		/obj/item/pinpointer/crew=1,
		/obj/item/sensor_device=1,
		/obj/item/roller=1,
		/obj/item/discovery_scanner=1
	)

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med

/datum/outfit/job/exploration/scientist
	name = "Exploration Crew (Scientist)"

	glasses = /obj/item/clothing/glasses/science

	backpack_contents = list(
		/obj/item/kitchen/knife/combat/survival=1,
		/obj/item/stack/marker_beacon/thirty=1,
		/obj/item/discovery_scanner=1
	)

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/tox

/datum/outfit/job/exploration/hardsuit
	name = "Exploration Crew (Hardsuit)"
	suit = /obj/item/clothing/suit/space/hardsuit/exploration
	suit_store = /obj/item/tank/internals/emergency_oxygen/double
	mask = /obj/item/clothing/mask/breath
