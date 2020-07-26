
//////////////////////////////////////OUTFITS//////////////////////////////////////
/datum/outfit/schoolshooter
	name = "Schoolshooter (clothes)"

	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = /obj/item/clothing/gloves/fingerless
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/armor/vest/leather
	shoes = /obj/item/clothing/shoes/combat
	head = /obj/item/clothing/head/soft/black
	l_pocket = /obj/item/switchblade
	back = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/military

/datum/outfit/schoolshooter/typeone
	name = "Schoolshooter 1"

	suit_store = /obj/item/gun/ballistic/automatic/m90/columbine
	r_pocket = /obj/item/ammo_box/magazine/m9mm
	backpack_contents = list(
								/obj/item/ammo_box/c9mm = 1,
								/obj/item/ammo_box/magazine/m9mm = 1,
								/obj/item/grenade/iedcasing = 3,
								/obj/item/grenade/c4 = 2,
								/obj/item/book/granter/martial/cqc = 1
							)

/datum/outfit/schoolshooter/typetwo
	name = "Schoolshooter 2"

	suit_store = /obj/item/gun/ballistic/shotgun/automatic/combat
	backpack_contents = list(
								/obj/item/grenade/iedcasing = 3,
								/obj/item/storage/box/lethalshot = 3,
								/obj/item/grenade/c4 = 2,
								/obj/item/book/granter/crafting_recipe/cookbook = 1
							)


//////////////////////////////////////TEAM//////////////////////////////////////

/datum/team/schoolshooters
	name = "Schoolshooters"
	member_name = "schoolshooter"

/datum/team/schoolshooters/New()
	..()
	var/datum/objective/hijack/O = new
	objectives += O

/datum/team/schoolshooters/is_solo()
	return FALSE

/datum/team/schoolshooters/roundend_report()
	var/list/result = list()

	var/won = TRUE
	for(var/datum/objective/O in objectives)
		if(!O.check_completion())
			won = FALSE
	if(won)
		result += "<span class='greentext big'>[name] team fulfilled its mission!</span>"
	else
		result += "<span class='redtext big'>[name] team failed its mission.</span>"

	result += "<span class='header'>The [name] were:</span>"
	for(var/datum/mind/shooter in members)
		result += printplayer(shooter)
	result += printobjectives(objectives)

	return "<div class='panel redborder'>[result.Join("<br>")]</div>"

//////////////////////////////////////OBJECTIVES//////////////////////////////////////


//////////////////////////////////////ANTAG//////////////////////////////////////

/datum/antagonist/schoolshooter
	name = "Schoolshooter"
	roundend_category = "schoolshooters"
	antagpanel_category = "Traitor"
	show_in_antagpanel = FALSE
	can_hijack = HIJACK_HIJACKER
	var/datum/team/schoolshooters/team

/datum/antagonist/schoolshooter/create_team(datum/team/abductor_team/new_team)
	if(!new_team)
		return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	team = new_team

/datum/antagonist/schoolshooter/on_gain()
	owner.special_role = "Schoolshooter"
	owner.assigned_role = "Schoolshooter"
	objectives += team.objectives
	return ..()

//////////////////////////////////////ROUND EVENT//////////////////////////////////////

/datum/round_event_control/schoolshooters
	name = "Spawn Schoolshooters"
	typepath = /datum/round_event/ghost_role/schoolshooters
	max_occurrences = 10
	min_players = 20
	earliest_start = 30 MINUTES
	//gamemode_blacklist = list("nuclear")

/datum/round_event/ghost_role/schoolshooters
	minimum_required = 2
	role_name = "schoolshooters"
	fakeable = FALSE

/datum/round_event/ghost_role/schoolshooters/spawn_role()
	var/list/funny_names = list("Podjog Saraev", "Rulon Oboev", "Ushat Pomoev")

	var/list/possible_spawns = list()
	for(var/turf/X in GLOB.xeno_spawn)
		if(istype(X.loc, /area/maintenance))
			possible_spawns += X

	if(!possible_spawns.len)
		message_admins("No valid spawn locations found, aborting...")
		return MAP_ERROR

	var/turf/landing_turf = pick(possible_spawns)

	var/list/candidates = get_candidates(ROLE_TRAITOR, null, ROLE_TRAITOR)

	if(candidates.len < 2)
		return NOT_ENOUGH_PLAYERS

	var/mob/living/carbon/human/first = makeBody(pick_n_take(candidates))
	var/mob/living/carbon/human/second = makeBody(pick_n_take(candidates))

	var/datum/team/schoolshooters/T = new

	spawned_mobs += list(first, second)

	first.equipOutfit(/datum/outfit/schoolshooter/typeone)
	second.equipOutfit(/datum/outfit/schoolshooter/typetwo)

	for(var/mob/living/carbon/human/M in spawned_mobs)
		M.mind.add_antag_datum(/datum/antagonist/schoolshooter, T)
		M.forceMove(landing_turf)
		log_game("[key_name(M)] has been selected as Schoolshooter.")
		var/namae = pick(funny_names)
		funny_names -= namae
		M.real_name = namae


	return SUCCESSFUL_SPAWN




