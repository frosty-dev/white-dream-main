/datum/ert/sobr
	roles = list(/datum/antagonist/ert/sobr)
	leader_role = /datum/antagonist/ert/sobr/leader
	teamsize = 7
	opendoors = FALSE
	rename_team = "СОБР"
	mission = "Уничтожить террористов на станции."
	polldesc = "специальный отряд быстрого реагирования"

/datum/antagonist/ert/sobr
	name = "СОБР"
	outfit = /datum/outfit/sobr
	random_names = FALSE
	role = "Отряд СОБР"

/datum/antagonist/ert/sobr/leader
	name = "Лидер СОБР"
	outfit = /datum/outfit/sobr/leader
	role = "Лидер отряда СОБР"

/datum/outfit/sobr
	name = "СОБР"

	uniform = /obj/item/clothing/under/rank/sobr
	suit = /obj/item/clothing/suit/armor/bulletproof/omon
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/fingerless
	ears = /obj/item/radio/headset/headset_cent
	glasses = /obj/item/clothing/glasses/sunglasses
	belt = /obj/item/storage/belt/military/army/wzzzz/sobr
	back = /obj/item/gun/ballistic/automatic/ak47
	l_pocket = /obj/item/reagent_containers/pill/viagra
	r_pocket = /obj/item/ammo_box/magazine/ak47mag
	id = /obj/item/card/id/centcom

/datum/outfit/sobr/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/W = H.wear_id
	W.access = get_centcom_access(name)
	W.access += ACCESS_WEAPONS
	W.assignment = name
	W.registered_name = H.real_name
	W.update_label()

/datum/outfit/sobr/leader
	name = "Лидер СОБР"

	uniform = /obj/item/clothing/under/rank/sobr
	suit = /obj/item/clothing/suit/armor/bulletproof/omon
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/fingerless
	ears = /obj/item/radio/headset/headset_cent
	glasses = /obj/item/clothing/glasses/sunglasses
	belt = /obj/item/storage/belt/military/army/wzzzz/sobr
	back = /obj/item/gun/ballistic/automatic/ak47
	l_pocket = /obj/item/reagent_containers/pill/viagra
	r_pocket = /obj/item/ammo_box/magazine/ak47mag
	id = /obj/item/card/id/centcom

/obj/item/storage/belt/military/army/wzzzz/sobr

/obj/item/storage/belt/military/army/wzzzz/sobr/PopulateContents()
	new /obj/item/reagent_containers/food/snacks/burger(src)
	new /obj/item/ammo_box/magazine/ak47mag(src)
	new /obj/item/ammo_box/magazine/ak47mag(src)
	new /obj/item/ammo_box/magazine/ak47mag(src)
	new /obj/item/reagent_containers/hypospray/medipen/survival(src)
	new /obj/item/grenade/syndieminibomb/concussion(src)
	new /obj/item/grenade/syndieminibomb/concussion(src)

/proc/sobr_request(text, mob/Sender)
	var/msg = copytext_char(sanitize(text), 1, MAX_MESSAGE_LEN)
	for(var/obj/machinery/computer/communications/C in GLOB.machines)
		C.overrideCooldown()
	var/list/mob/dead/observer/candidates = pollGhostCandidates("Хотите быть в специальном отряде быстрого реагирования?", "deathsquad", null)
	var/teamSpawned = FALSE

	if(candidates.len > 0)
		//Pick the (un)lucky players
		var/numagents = min(7, candidates.len)

		//Create team
		var/datum/team/ert/ert_team = new /datum/ert/sobr

		//Asign team objective
		var/datum/objective/missionobj = new
		missionobj.team = ert_team
		missionobj.explanation_text = msg
		missionobj.completed = TRUE
		ert_team.objectives += missionobj
		ert_team.mission = missionobj

		var/list/spawnpoints = GLOB.emergencyresponseteamspawn
		var/index = 0
		while(numagents && candidates.len)
			var/spawnloc = spawnpoints[index+1]
			//loop through spawnpoints one at a time
			index = (index + 1) % spawnpoints.len
			var/mob/dead/observer/chosen_candidate = pick(candidates)
			candidates -= chosen_candidate
			if(!chosen_candidate.key)
				continue

			//Spawn the body
			var/mob/living/carbon/human/ERTOperative = new /mob/living/carbon(spawnloc)
			chosen_candidate.client.prefs.copy_to(ERTOperative)
			ERTOperative.key = chosen_candidate.key

			//Give antag datum
			var/datum/antagonist/ert/ert_antag

			if(numagents == 1)
				ert_antag = new /datum/antagonist/ert/sobr/leader
			else
				ert_antag = new /datum/antagonist/ert/sobr

			ERTOperative.mind.add_antag_datum(ert_antag,ert_team)
			ERTOperative.mind.assigned_role = ert_antag.name

			//Logging and cleanup
			log_game("[key_name(ERTOperative)] has been selected as an [ert_antag.name]")
			numagents--
			teamSpawned++

		if (teamSpawned)
			message_admins("[Sender.name] вызывает СОБР с миссией: [msg]")

		return TRUE
	else
		return FALSE
