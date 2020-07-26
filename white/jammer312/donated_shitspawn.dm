GLOBAL_LIST_INIT(ones_allowed_to_shitspawn,null)
/proc/check_shitspawn_rights()
	if(!GLOB.ones_allowed_to_shitspawn)
		to_chat(usr, "Wait a bit, updating access list")
		var/response = world.Export("[CONFIG_GET(string/webhook_address)]?key=[CONFIG_GET(string/webhook_key)]&method=data_request&data={\"data\": \"shitspawn_list\", \"round\": \"[GLOB.round_id]\"}")
		if(!response || response["STATUS"] != "200 OK" || !response["CONTENT"])
			GLOB.ones_allowed_to_shitspawn = list()
			log_admin("Failed to receive shitspawn rights list: [response?"[response["STATUS"]] [response["CONTENT"]]":"failed to connect"]")
			return FALSE
		GLOB.ones_allowed_to_shitspawn = splittext(file2text(response["CONTENT"])," ")
	return usr.client && (usr.client.ckey in GLOB.ones_allowed_to_shitspawn)

/client/verb/role_assigner()
	set name = "Role Assigner"
	set desc = "Show role assigner panel"
	set category = "OOC"

	if(!check_shitspawn_rights())
		to_chat(usr,"You have no rights to do it <i>yet</i>")
		return
	if(!mob)
		to_chat(usr,"You have no mob")
		return
	if(!mob.mind)
		to_chat(usr,"You have no mind")
		return
	if(isliving(mob))
		var/mob/living/L = mob
		if(L.has_trait(TRAIT_MINDSHIELD))
			alert("This creature can't become antag")
			return
	if(issilicon(mob)||isconstruct(mob)||ispAI(mob)||isbrain(mob)||istype(mob, /mob/dead/new_player))
		alert("This creature can't become antag")
		return

	mob.mind.donated_traitor_panel()

/datum/mind/proc/donated_traitor_panel()
	if(!SSticker.HasRoundStarted())
		alert("Not before round-start!", "Alert")
		return
	if(QDELETED(src))
		alert("This mind doesn't have a mob, or is deleted! For some reason!")
		return
	if(special_role)
		alert("This mind is antag already")
		return
	var/out = "Possible options:<br>"
	var/static/possible_roles = list(
		"traitor",
		"changeling",
		"devil",
		"wizard")
	if(isobserver(usr))
		out += "<a href='?src=[REF(src)];become=revenant' title='revenant'> Become revenant</a><br>"
	else
		for(var/pr in possible_roles)
			out += "<a href='?src=[REF(src)];become=[pr]' title='[pr]'>Become [pr]</a><br>"

	var/datum/browser/panel = new(usr, "dtraitorpanel")
	panel.set_content(out)
	panel.open()
	return


/datum/mind/Topic(href, href_list)
	if(!check_shitspawn_rights()||!href_list["become"])
		return ..() //usual topic
	if(special_role)
		alert("This mind is antag already")
		return
	//here be dragons
	if(href_list["become"]=="revenant")
		//totally not a copypasta
		var/mob/dead/observer/selected = usr

		var/list/spawn_locs = list()

		for(var/mob/living/L in GLOB.dead_mob_list) //look for any dead bodies
			var/turf/T = get_turf(L)
			if(T && is_station_level(T.z))
				spawn_locs += T
		if(!spawn_locs.len || spawn_locs.len < 15) //look for any morgue trays, crematoriums, ect if there weren't alot of dead bodies on the station to pick from
			for(var/obj/structure/bodycontainer/bc in GLOB.bodycontainers)
				var/turf/T = get_turf(bc)
				if(T && is_station_level(T.z))
					spawn_locs += T
		if(!spawn_locs.len) //If we can't find any valid spawnpoints, try the carp spawns
			for(var/obj/effect/landmark/carpspawn/L in GLOB.landmarks_list)
				if(isturf(L.loc))
					spawn_locs += L.loc
		if(!spawn_locs.len) //If we can't find either, just spawn the revenant at the player's location
			spawn_locs += get_turf(selected)
		if(!spawn_locs.len) //If we can't find THAT, then just give up and cry
			alert("Map fail!","SHIET")
			return MAP_ERROR

		var/mob/living/simple_animal/revenant/revvie = new(pick(spawn_locs))
		revvie.key = selected.key
		message_admins("[ADMIN_LOOKUPFLW(revvie)] has been made into a revenant by a shitspawn.")
		log_game("[key_name(revvie)] was spawned as a revenant by a shitspawn.")
		webhook_send("rolespawn",list("keyname"=revvie.key,"role"=href_list["become"],"add_num"=0,"has_follower"=0,"round"=GLOB.round_id))
		GLOB.ones_allowed_to_shitspawn = null //kinda dumb way to force reset on next use but who cares
		return SUCCESSFUL_SPAWN
	var/is_fun_allowed = prob(66) // 2/3 chance of randomly spawning antags of same type to offset shitspawned antag, halves cooldown
	var/fun_delay = rand(3000,15000) // delays obvious roles appearance (makes wizard appear some time later to kinda prevent lolkilling), 5 to 15 mins
	var/is_more_fun_allowed = prob(50) // 1/3 chance of giving assasinate objective to one of spawned, further halves cooldown
	//both !fun! options
	var/num_spawned = 0
	var/has_follower = FALSE
	switch(href_list["become"])
		if("traitor","changeling","devil")
			add_antag_wrapper(text2path("/datum/antagonist/[href_list["become"]]"),usr)
			log_game("[key_name(usr)] has become [href_list["become"]]")
			if (is_fun_allowed)
				log_game("and brought some friends along")
				var/list/ret = list()
				switch(href_list["become"])
					if("traitor")
						ret = makeTraitors_adv()
					if("changeling")
						ret = makeChangelings_adv()
				num_spawned = ret.len
				if (is_more_fun_allowed && num_spawned)
					log_game("and not only friends")
					var/datum/objective/new_objective = new /datum/objective/assassinate
					new_objective.owner = pick(ret)
					new_objective.target = usr.mind
					//Will display as special role if the target is set as MODE. Ninjas/commandos/nuke ops.
					new_objective.update_explanation_text()
					new_objective.owner.announce_objectives()
					has_follower = TRUE
		if("wizard")
			add_antag_wrapper(/datum/antagonist/wizard,usr)
			log_game("[key_name(usr)] has become wizard")
			num_spawned = is_fun_allowed
			has_follower = is_more_fun_allowed
			spawn(fun_delay)
				if (is_fun_allowed)
					log_game("and brought some friends along")
					var/spw = makeWizard_adv()
					if (is_more_fun_allowed && spw)
						log_game("and not only friends")
						var/datum/objective/new_objective = new /datum/objective/assassinate
						new_objective.owner = spw
						new_objective.target = usr.mind
						//Will display as special role if the target is set as MODE. Ninjas/commandos/nuke ops.
						new_objective.update_explanation_text()
						new_objective.owner.announce_objectives()
						has_follower = TRUE
		else
			return
	webhook_send("rolespawn",list("keyname"=usr.key,"role"=href_list["become"],"add_num"=num_spawned,"has_follower"=has_follower,"round"=GLOB.round_id))
	GLOB.ones_allowed_to_shitspawn = null //kinda dumb way to force reset on next use but who cares


/proc/makeTraitors_adv()
	var/datum/game_mode/traitor/temp = new

	if(CONFIG_GET(flag/protect_roles_from_antagonist))
		temp.restricted_jobs += temp.protected_jobs

	if(CONFIG_GET(flag/protect_assistant_from_antagonist))
		temp.restricted_jobs += "Assistant"

	var/list/mob/living/carbon/human/candidates = list()
	var/mob/living/carbon/human/H = null

	for(var/mob/living/carbon/human/applicant in GLOB.player_list)
		if(iRR_wrap(applicant, ROLE_TRAITOR))
			if(temp.age_check(applicant.client))
				if(!(applicant.job in temp.restricted_jobs))
					candidates += applicant
	var/list/picked=list()
	if(candidates.len)
		var/numTraitors = min(candidates.len, 3)

		for(var/i = 0, i<numTraitors, i++)
			H = pick(candidates)
			H.mind.make_Traitor()
			candidates.Remove(H)
			picked+=H.mind
	return picked

/proc/makeChangelings_adv()
	var/datum/game_mode/changeling/temp = new
	if(CONFIG_GET(flag/protect_roles_from_antagonist))
		temp.restricted_jobs += temp.protected_jobs

	if(CONFIG_GET(flag/protect_assistant_from_antagonist))
		temp.restricted_jobs += "Assistant"

	var/list/mob/living/carbon/human/candidates = list()
	var/mob/living/carbon/human/H = null

	for(var/mob/living/carbon/human/applicant in GLOB.player_list)
		if(iRR_wrap(applicant, ROLE_CHANGELING))
			if(temp.age_check(applicant.client))
				if(!(applicant.job in temp.restricted_jobs))
					candidates += applicant
	var/list/picked=list()
	if(candidates.len)
		var/numChangelings = min(candidates.len, 3)

		for(var/i = 0, i<numChangelings, i++)
			H = pick(candidates)
			H.mind.make_Changeling()
			candidates.Remove(H)
			picked+=H.mind

	return picked

/proc/makeWizard_adv(exclude)
	var/list/mob/dead/observer/candidates = pollGhostCandidates("Do you wish to be considered for the position of a Wizard Foundation 'diplomat'?", ROLE_WIZARD, null)
	if (!candidates.len)
		return 0
	var/mob/dead/observer/selected = pick_n_take(candidates)
	if (selected.mind.key == exclude)
		if (!candidates.len)
			return null
		selected = pick_n_take(candidates)
	var/mob/living/carbon/human/new_character = makeBody(selected)
	new_character.mind.make_Wizard()
	return selected

/proc/iRR_wrap(mob/living/carbon/human/applicant, targetrole, onstation = TRUE, conscious = TRUE)
	if(applicant.mind.special_role)
		return FALSE
	if(!(targetrole in applicant.client.prefs.be_special))
		return FALSE
	if(onstation)
		var/turf/T = get_turf(applicant)
		if(!is_station_level(T.z))
			return FALSE
	if(conscious && applicant.stat) //incase you don't care about a certain antag being unconcious when made, ie if they have selfhealing abilities.
		return FALSE
	if(!considered_alive(applicant.mind) || considered_afk(applicant.mind)) //makes sure the player isn't a zombie, brain, or just afk all together
		return FALSE
	return (!is_banned_from(applicant, targetrole) && !is_banned_from(applicant, ROLE_SYNDICATE))
