GLOBAL_LIST(admin_objective_list) //Prefilled admin assignable objective list

/datum/objective
	var/datum/mind/owner				//The primary owner of the objective. !!SOMEWHAT DEPRECATED!! Prefer using 'team' for new code.
	var/datum/team/team					//An alternative to 'owner': a team. Use this when writing new code.
	var/name = "generic objective" 		//Name for admin prompts
	var/explanation_text = "Nothing"	//What that person is supposed to do.
	var/team_explanation_text			//For when there are multiple owners.
	var/datum/mind/target = null		//If they are focused on a particular person.
	var/target_amount = 0				//If they are focused on a particular number. Steal objectives have their own counter.
	var/completed = FALSE				//currently only used for custom objectives.
	var/martyr_compatible = FALSE		//If the objective is compatible with martyr objective, i.e. if you can still do it while dead.
	var/reward = 5

/datum/objective/New(text)
	if(text)
		explanation_text = text

/datum/objective/proc/get_owners() // Combine owner and team into a single list.
	. = (team?.members) ? team.members.Copy() : list()
	if(owner)
		. += owner

/datum/objective/proc/admin_edit(mob/admin)
	return

//Shared by few objective types
/datum/objective/proc/admin_simple_target_pick(mob/admin)
	var/list/possible_targets = list()
	var/def_value
	for(var/datum/mind/possible_target in SSticker.minds)
		if ((possible_target != src) && ishuman(possible_target.current))
			possible_targets += possible_target.current

	possible_targets = list("Ничего", "Random") + sortNames(possible_targets)


	if(target?.current)
		def_value = target.current

	var/mob/new_target = input(admin,"Select target:", "Objective target", def_value) as null|anything in possible_targets
	if (!new_target)
		return

	if (new_target == "Ничего.")
		target = null
	else if (new_target == "Random")
		find_target()
	else
		target = new_target.mind

	update_explanation_text()

/datum/objective/proc/considered_escaped(datum/mind/M)
	if(!considered_alive(M))
		return FALSE
	if(considered_exiled(M))
		return FALSE
	if(M.force_escaped)
		return TRUE
	if(SSticker.force_ending || SSticker.mode.station_was_nuked) // Just let them win.
		return TRUE
	if(SSshuttle.emergency.mode != SHUTTLE_ENDGAME)
		return FALSE
	var/area/current_area = get_area(M.current)
	if(!current_area || istype(current_area, /area/shuttle/escape/brig)) // Fails if they are in the shuttle brig
		return FALSE
	var/turf/current_turf = get_turf(M.current)
	return current_turf.onCentCom() || current_turf.onSyndieBase()

/datum/objective/proc/check_completion()
	return completed

/datum/objective/proc/is_unique_objective(possible_target, dupe_search_range)
	if(!islist(dupe_search_range))
		stack_trace("Non-list passed as duplicate objective search range")
		dupe_search_range = list(dupe_search_range)

	for(var/A in dupe_search_range)
		var/list/objectives_to_compare
		if(istype(A,/datum/mind))
			var/datum/mind/M = A
			objectives_to_compare = M.get_all_objectives()
		else if(istype(A,/datum/antagonist))
			var/datum/antagonist/G = A
			objectives_to_compare = G.objectives
		else if(istype(A,/datum/team))
			var/datum/team/T = A
			objectives_to_compare = T.objectives
		for(var/datum/objective/O in objectives_to_compare)
			if(istype(O, type) && O.get_target() == possible_target)
				return FALSE
	return TRUE

/datum/objective/proc/get_target()
	return target

/datum/objective/proc/get_crewmember_minds()
	. = list()
	for(var/V in GLOB.data_core.locked)
		var/datum/data/record/R = V
		var/datum/mind/M = R.fields["mindref"]
		if(M)
			. += M

//dupe_search_range is a list of antag datums / minds / teams
/datum/objective/proc/find_target(dupe_search_range, blacklist)
	var/list/datum/mind/owners = get_owners()
	if(!dupe_search_range)
		dupe_search_range = get_owners()
	var/list/possible_targets = list()
	var/try_target_late_joiners = FALSE
	for(var/I in owners)
		var/datum/mind/O = I
		if(O.late_joiner)
			try_target_late_joiners = TRUE
	for(var/datum/mind/possible_target in get_crewmember_minds())
		if(is_valid_target(possible_target) && !(possible_target in owners) && ishuman(possible_target.current) && (possible_target.current.stat != DEAD) && is_unique_objective(possible_target,dupe_search_range))
			if (!(possible_target in blacklist))
				possible_targets += possible_target
	if(try_target_late_joiners)
		var/list/all_possible_targets = possible_targets.Copy()
		for(var/I in all_possible_targets)
			var/datum/mind/PT = I
			if(!PT.late_joiner)
				possible_targets -= PT
		if(!possible_targets.len)
			possible_targets = all_possible_targets
	if(possible_targets.len > 0)
		target = pick(possible_targets)
	if(target.assigned_role in list("Russian Officer", "Trader", "Hacker","Veteran", "Security Officer", "Warden", "Detective", "Head of Security", "Captain", "Chief Engineer", "Research Director", "Chief Medical Officer", "Field Medic", "AI", "Cyborg"))
		reward+=reward
	update_explanation_text()
	return target

/datum/objective/proc/is_valid_target(possible_target)
	return TRUE

/datum/objective/escape/escape_with_identity/is_valid_target(possible_target)
	var/list/datum/mind/owners = get_owners()
	for(var/datum/mind/M in owners)
		if(!M)
			continue
		var/datum/antagonist/changeling/changeling = M.has_antag_datum(/datum/antagonist/changeling)
		if(!changeling)
			continue
		var/datum/mind/T = possible_target
		if(!istype(T) || isIPC(T.current))
			return FALSE
	return TRUE

/datum/objective/proc/find_target_by_role(role, role_type=FALSE,invert=FALSE)//Option sets either to check assigned role or special role. Default to assigned., invert inverts the check, eg: "Don't choose a Ling"
	var/list/datum/mind/owners = get_owners()
	var/list/possible_targets = list()
	for(var/datum/mind/possible_target in get_crewmember_minds())
		if(!(possible_target in owners) && ishuman(possible_target.current))
			var/is_role = FALSE
			if(role_type)
				if(possible_target.special_role == role)
					is_role = TRUE
			else
				if(possible_target.assigned_role == role)
					is_role = TRUE

			if(invert)
				if(is_role)
					continue
				possible_targets += possible_target
				break
			else if(is_role)
				possible_targets += possible_target
				break
	if(length(possible_targets))
		target = pick(possible_targets)
	update_explanation_text()
	return target

/datum/objective/proc/update_explanation_text()
	if(team_explanation_text && LAZYLEN(get_owners()) > 1)
		explanation_text = team_explanation_text

/datum/objective/proc/give_special_equipment(special_equipment)
	var/datum/mind/receiver = pick(get_owners())
	if(receiver?.current)
		if(ishuman(receiver.current))
			var/mob/living/carbon/human/H = receiver.current
			var/list/slots = list("backpack" = ITEM_SLOT_BACKPACK)
			for(var/eq_path in special_equipment)
				var/obj/O = new eq_path
				H.equip_in_one_of_slots(O, slots)

/datum/objective/assassinate
	name = "assasinate"
	var/target_role_type=FALSE
	martyr_compatible = TRUE
	reward = 15

/datum/objective/assassinate/find_target_by_role(role, role_type=FALSE,invert=FALSE)
	if(!invert)
		target_role_type = role_type
	..()

/datum/objective/assassinate/check_completion()
	return completed || (!considered_alive(target) || considered_afk(target) || considered_exiled(target))

/datum/objective/assassinate/update_explanation_text()
	..()
	if(target?.current)
		explanation_text = "Убить [target.name], на должности [!target_role_type ? target.assigned_role : target.special_role]."
	else
		explanation_text = "Ничего."

/datum/objective/assassinate/admin_edit(mob/admin)
	admin_simple_target_pick(admin)

/datum/objective/assassinate/internal
	var/stolen = FALSE 		//Have we already eliminated this target?

/datum/objective/assassinate/internal/update_explanation_text()
	..()
	if(target && !target.current)
		explanation_text = "Убить [target.name], который был уничтожен"

/datum/objective/mutiny
	name = "mutiny"
	var/target_role_type=FALSE
	martyr_compatible = 1
	reward = 40

/datum/objective/mutiny/find_target_by_role(role, role_type=FALSE,invert=FALSE)
	if(!invert)
		target_role_type = role_type
	..()

/datum/objective/mutiny/check_completion()
	if(!target || !considered_alive(target) || considered_afk(target) || considered_exiled(target))
		return TRUE
	var/turf/T = get_turf(target.current)
	return !T || !is_station_level(T.z)

/datum/objective/mutiny/update_explanation_text()
	..()
	if(target && target.current)
		explanation_text = "Убить или проимплантировать и отправить в ссылку в гейтвей [target.name], на должности [!target_role_type ? target.assigned_role : target.special_role]."
	else
		explanation_text = "Ничего."

/datum/objective/maroon
	name = "maroon"
	var/target_role_type=FALSE
	martyr_compatible = TRUE
	reward = 15

/datum/objective/maroon/find_target_by_role(role, role_type=FALSE,invert=FALSE)
	if(!invert)
		target_role_type = role_type
	..()

/datum/objective/maroon/check_completion()
	return !target || !considered_alive(target) || (!target.current.onCentCom() && !target.current.onSyndieBase())

/datum/objective/maroon/update_explanation_text()
	if(target && target.current)
		explanation_text = "Не дать [target.name], на должности [!target_role_type ? target.assigned_role : target.special_role], покинуть станцию в живом виде."
	else
		explanation_text = "Ничего."

/datum/objective/maroon/admin_edit(mob/admin)
	admin_simple_target_pick(admin)

/datum/objective/debrain
	name = "debrain"
	var/target_role_type=0
	reward = 15

/datum/objective/debrain/find_target_by_role(role, role_type=FALSE,invert=FALSE)
	if(!invert)
		target_role_type = role_type
	..()

/datum/objective/debrain/check_completion()
	if(!target)//If it's a Развлекаться.
		return TRUE
	if(!target.current || !isbrain(target.current))
		return FALSE
	var/atom/A = target.current
	var/list/datum/mind/owners = get_owners()

	while(A.loc) // Check to see if the brainmob is on our person
		A = A.loc
		for(var/datum/mind/M in owners)
			if(M.current && M.current.stat != DEAD && A == M.current)
				return TRUE
	return FALSE

/datum/objective/debrain/update_explanation_text()
	..()
	if(target?.current)
		explanation_text = "Украсть мозг [target.name], на должности [!target_role_type ? target.assigned_role : target.special_role]."
	else
		explanation_text = "Ничего."

/datum/objective/debrain/admin_edit(mob/admin)
	admin_simple_target_pick(admin)

/datum/objective/protect//The opposite of killing a dude.
	name = "protect"
	martyr_compatible = TRUE
	var/target_role_type = FALSE
	var/human_check = TRUE
	reward = 20

/datum/objective/protect/find_target_by_role(role, role_type=FALSE,invert=FALSE)
	if(!invert)
		target_role_type = role_type
	..()
	return target

/datum/objective/protect/check_completion()
	var/obj/item/organ/brain/brain_target
	if(human_check)
		brain_target = target.current.getorganslot(ORGAN_SLOT_BRAIN)
	//Protect will always suceed when someone suicides
	if(!target)
		return FALSE
	if((human_check && brain_target) && brain_target?.suicided)
		return FALSE
	return considered_alive(target, enforce_human = human_check)

/datum/objective/protect/update_explanation_text()
	..()
	if(target?.current)
		explanation_text = "Защитить [target.name], на должности [!target_role_type ? target.assigned_role : target.special_role]."
	else
		explanation_text = "Ничего."

/datum/objective/protect/admin_edit(mob/admin)
	admin_simple_target_pick(admin)

/datum/objective/protect/nonhuman
	name = "protect nonhuman"
	human_check = FALSE

/datum/objective/jailbreak
	name = "jailbreak"
	martyr_compatible = TRUE //why not?
	var/target_role_type
	reward = 20

/datum/objective/jailbreak/find_target_by_role(role, role_type, invert=FALSE)
	if(!invert)
		target_role_type = role_type
	return ..()

/datum/objective/jailbreak/check_completion()
	return completed || (considered_escaped(target))

/datum/objective/jailbreak/update_explanation_text()
	..()
	if(target?.current)
		explanation_text = "Убедиться в том, что [target.name], на должноости [!target_role_type ? target.assigned_role : target.special_role] сбежит живым и вне заключения."
	else
		explanation_text = "Ничего."

/datum/objective/jailbreak/admin_edit(mob/admin)
	admin_simple_target_pick(admin)

/datum/objective/jailbreak/detain
	name = "detain"
	reward = 10

/datum/objective/jailbreak/detain/check_completion()
	return completed || (!considered_escaped(target) && (considered_alive(target) && target.current.onCentCom()))

/datum/objective/jailbreak/detain/update_explanation_text()
	..()
	if(target?.current)
		explanation_text = "Убедиться в том, что [target.name], на должноости [!target_role_type ? target.assigned_role : target.special_role] будет доставлен в зоне заключения и в наручниках."
	else
		explanation_text = "Ничего."

/datum/objective/hijack
	name = "hijack"
	explanation_text = "Захватить шаттл, чтобы ни один преданный член экипажа Нанотрейзен не был на нём в живых."
	team_explanation_text = "Захватить шаттл, чтобы ни один преданный член экипажа Нанотрейзен не был на нём в живых."
	martyr_compatible = FALSE //Technically you won't get both anyway.
	/// Overrides the hijack speed of any antagonist datum it is on ONLY, no other datums are impacted.
	var/hijack_speed_override = 1
	reward = 45

/datum/objective/hijack/check_completion() // Requires all owners to escape.
	if(SSshuttle.emergency.mode != SHUTTLE_ENDGAME)
		return FALSE
	var/list/datum/mind/owners = get_owners()
	for(var/datum/mind/M in owners)
		if(!considered_alive(M) || !SSshuttle.emergency.shuttle_areas[get_area(M.current)])
			return FALSE
	return SSshuttle.emergency.is_hijacked()

/datum/objective/elimination
	name = "elimination"
	explanation_text = "Slaughter all loyalist crew aboard the shuttle. You, and any likeminded individuals, must be the only remaining people on the shuttle."
	team_explanation_text = "Slaughter all loyalist crew aboard the shuttle. You, and any likeminded individuals, must be the only remaining people on the shuttle. Leave no team member behind."
	martyr_compatible = FALSE
	reward = 25

/datum/objective/elimination/check_completion()
	if(SSshuttle.emergency.mode != SHUTTLE_ENDGAME)
		return FALSE
	var/list/datum/mind/owners = get_owners()
	for(var/datum/mind/M in owners)
		if(!considered_alive(M, enforce_human = FALSE) || !SSshuttle.emergency.shuttle_areas[get_area(M.current)])
			return FALSE
	return SSshuttle.emergency.elimination_hijack()

/datum/objective/elimination/highlander
	name="highlander elimination"
	explanation_text = "Escape on the shuttle alone. Ensure that nobody else makes it out."
	reward = 40

/datum/objective/elimination/highlander/check_completion()
	if(SSshuttle.emergency.mode != SHUTTLE_ENDGAME)
		return FALSE
	var/list/datum/mind/owners = get_owners()
	for(var/datum/mind/M in owners)
		if(!considered_alive(M, enforce_human = FALSE) || !SSshuttle.emergency.shuttle_areas[get_area(M.current)])
			return FALSE
	return SSshuttle.emergency.elimination_hijack(filter_by_human = FALSE, solo_hijack = TRUE)

/datum/objective/block
	name = "no organics on shuttle"
	explanation_text = "Не позволить никаким органическим формам жизни выбраться на шаттле живыми."
	martyr_compatible = 1
	reward = 40

/datum/objective/block/check_completion()
	if(SSshuttle.emergency.mode != SHUTTLE_ENDGAME)
		return TRUE
	for(var/mob/living/player in GLOB.player_list)
		if(player.mind && player.stat != DEAD && !issilicon(player))
			if(get_area(player) in SSshuttle.emergency.shuttle_areas)
				return FALSE
	return TRUE

/datum/objective/purge
	name = "no mutants on shuttle"
	explanation_text = "Убедиться, что на борту эвакуационного шаттла нет мутантных гуманоидов."
	martyr_compatible = TRUE
	reward = 20

/datum/objective/purge/check_completion()
	if(SSshuttle.emergency.mode != SHUTTLE_ENDGAME)
		return TRUE
	for(var/mob/living/player in GLOB.player_list)
		if((get_area(player) in SSshuttle.emergency.shuttle_areas) && player.mind && player.stat != DEAD && ishuman(player))
			var/mob/living/carbon/human/H = player
			if(H.dna.species.id != "human")
				return FALSE
	return TRUE

/datum/objective/robot_army
	name = "robot army"
	explanation_text = "По крайней мере восемь активных киборгов синхронизировались со мной."
	martyr_compatible = FALSE
	reward = 25

/datum/objective/robot_army/check_completion()
	var/counter = 0
	var/list/datum/mind/owners = get_owners()
	for(var/datum/mind/M in owners)
		if(!M.current || !isAI(M.current))
			continue
		var/mob/living/silicon/ai/A = M.current
		for(var/mob/living/silicon/robot/R in A.connected_robots)
			if(R.stat != DEAD)
				counter++
	return counter >= 8

/datum/objective/escape
	name = "escape"
	explanation_text = "Сбежать на шаттле или спасательной капсуле живым и без содержания под стражей."
	team_explanation_text = "Сбежать на шаттле или спасательной капсуле живым и без содержания под стражей."
	reward = 10

/datum/objective/escape/check_completion()
	// Require all owners escape safely.
	var/list/datum/mind/owners = get_owners()
	for(var/datum/mind/M in owners)
		if(!considered_escaped(M))
			return FALSE
	return TRUE

/datum/objective/escape/escape_with_identity
	name = "escape with identity"
	var/target_real_name // Has to be stored because the target's real_name can change over the course of the round
	var/target_missing_id

/datum/objective/escape/escape_with_identity/find_target(dupe_search_range)
	target = ..()
	update_explanation_text()

/datum/objective/escape/escape_with_identity/update_explanation_text()
	if(target?.current)
		target_real_name = target.current.real_name
		explanation_text = "Сбежать на шаттле или спасательной капсуле под личностью [target_real_name], на должности [target.assigned_role]"
		var/mob/living/carbon/human/H
		if(ishuman(target.current))
			H = target.current
		if(H && H.get_id_name() != target_real_name)
			target_missing_id = 1
		else
			explanation_text += " имея при себе карту цели."
		explanation_text += "." //Proper punctuation is important!

	else
		explanation_text = "Ничего."

/datum/objective/escape/escape_with_identity/check_completion()
	if(!target || !target_real_name)
		return TRUE
	var/list/datum/mind/owners = get_owners()
	for(var/datum/mind/M in owners)
		if(!ishuman(M.current) || !considered_escaped(M))
			continue
		var/mob/living/carbon/human/H = M.current
		if(H.dna.real_name == target_real_name && (H.get_id_name() == target_real_name || target_missing_id))
			return TRUE
	return FALSE

/datum/objective/escape/escape_with_identity/admin_edit(mob/admin)
	admin_simple_target_pick(admin)

/datum/objective/survive
	name = "survive"
	explanation_text = "Выжить."
	reward = 5

/datum/objective/survive/check_completion()
	var/list/datum/mind/owners = get_owners()
	for(var/datum/mind/M in owners)
		if(!considered_alive(M))
			return FALSE
	return TRUE

/datum/objective/limited
	name = "time limit"
	explanation_text = "Выполнить все задания за определённое время."
	var/time_to_do = 36000 // 1 час на все дела вот эти
	var/timerid
	reward = 20

/datum/objective/New(text)
	..()
	update_explanation_text()

/datum/objective/limited/update_explanation_text()
	..()
	explanation_text = "Выполнить все задания за [DisplayTimeText(time_to_do)]."
	timerid = addtimer(CALLBACK(src, .proc/kill_agents), time_to_do)

	var/list/datum/mind/owners = get_owners()
	for(var/datum/mind/M in owners)
		if(M?.current)
			if(isliving(M.current))
				var/mob/living/H = M.current
				to_chat(H, "<span class='warning'><big>В МОЁ ТЕЛО ВВЕДЕНО ВЕЩЕСТВО, КОТОРОЕ РАЗОРВЁТ МЕНЯ ЧЕРЕЗ [uppertext(DisplayTimeText(time_to_do))]. НУЖНО ВЫПОЛНИТЬ ВСЕ ЗАДАНИЯ СРОЧНО!</big></span>")
				SEND_SOUND(H, 'white/valtos/sounds/timertick.ogg')

/datum/objective/limited/proc/kill_agents()
	var/list/datum/mind/owners = get_owners()
	for(var/datum/mind/M in owners)
		if(M?.current)
			if(isliving(M.current))
				var/mob/living/H = M.current
				to_chat(H, "<span class='warning'><big>ВРЕМЯ ВЫШЛО!</big></span>")
				SEND_SOUND(H, 'white/valtos/sounds/timerring.ogg')
				spawn(50)
					H?.gib()

/datum/objective/limited/admin_edit(mob/admin)
	var/def_value = 36000
	var/mob/new_timer = input(admin, "Какое время ставим в секундах?", "Таймер", def_value) as num|null
	if (!new_timer)
		return

	time_to_do = new_timer * 10

	deltimer(timerid)
	timerid = null

	update_explanation_text()

/datum/objective/limited/check_completion()
	var/list/datum/mind/owners = get_owners()
	for(var/datum/mind/M in owners)
		if(!considered_alive(M))
			return FALSE
	return TRUE

/datum/objective/survive/malf //Like survive, but for Malf AIs
	name = "survive AI"
	explanation_text = "Prevent your own deactivation."
	reward = 10

/datum/objective/survive/malf/check_completion()
	var/list/datum/mind/owners = get_owners()
	for(var/datum/mind/mindobj in owners)
		if(!istype(mindobj, /mob/living/silicon/robot) && !considered_alive(mindobj, FALSE)) //Shells (and normal borgs for that matter) are considered alive for Malf
			return FALSE
		return TRUE

/datum/objective/martyr
	name = "martyr"
	explanation_text = "Погибнуть красиво."
	reward = 15

/datum/objective/martyr/check_completion()
	var/list/datum/mind/owners = get_owners()
	for(var/datum/mind/M in owners)
		if(considered_alive(M))
			return FALSE
		if(M.current?.suiciding) //killing yourself ISN'T glorious.
			return FALSE
	return TRUE

/datum/objective/nuclear
	name = "nuclear"
	explanation_text = "Уничтожить станцию ядерным устройством."
	martyr_compatible = TRUE
	reward = 50

/datum/objective/nuclear/check_completion()
	if(SSticker && SSticker.mode && SSticker.mode.station_was_nuked)
		return TRUE
	return FALSE

GLOBAL_LIST_EMPTY(possible_items)
/datum/objective/steal
	name = "steal"
	var/datum/objective_item/targetinfo = null //Save the chosen item datum so we can access it later.
	var/obj/item/steal_target = null //Needed for custom objectives (they're just items, not datums).
	martyr_compatible = FALSE
	reward = 15

/datum/objective/steal/get_target()
	return steal_target

/datum/objective/steal/New()
	..()
	if(!GLOB.possible_items.len)//Only need to fill the list when it's needed.
		for(var/I in subtypesof(/datum/objective_item/steal))
			new I

/datum/objective/steal/find_target(dupe_search_range)
	var/list/datum/mind/owners = get_owners()
	if(!dupe_search_range)
		dupe_search_range = get_owners()
	var/approved_targets = list()
	check_items:
		for(var/datum/objective_item/possible_item in GLOB.possible_items)
			if(!is_unique_objective(possible_item.targetitem,dupe_search_range))
				continue
			for(var/datum/mind/M in owners)
				if(M.current.mind.assigned_role in possible_item.excludefromjob)
					continue check_items
			approved_targets += possible_item
	if (length(approved_targets))
		return set_target(pick(approved_targets))
	return set_target(null)

/datum/objective/steal/proc/set_target(datum/objective_item/item)
	if(item)
		targetinfo = item
		steal_target = targetinfo.targetitem
		explanation_text = "Украсть [targetinfo.name]"
		give_special_equipment(targetinfo.special_equipment)
		return steal_target
	else
		explanation_text = "Ничего."
		return

/datum/objective/steal/admin_edit(mob/admin)
	var/list/possible_items_all = GLOB.possible_items
	var/new_target = input(admin,"Select target:", "Objective target", steal_target) as null|anything in sortNames(possible_items_all)+"custom"
	if (!new_target)
		return

	if (new_target == "custom") //Can set custom items.
		var/custom_path = input(admin,"Search for target item type:","Type") as null|text
		if (!custom_path)
			return
		var/obj/item/custom_target = pick_closest_path(custom_path, make_types_fancy(subtypesof(/obj/item)))
		var/custom_name = initial(custom_target.name)
		custom_name = stripped_input(admin,"Enter target name:", "Objective target", custom_name)
		if (!custom_name)
			return
		steal_target = custom_target
		explanation_text = "Украсть [custom_name]."

	else
		set_target(new_target)

/datum/objective/steal/check_completion()
	var/list/datum/mind/owners = get_owners()
	if(!steal_target)
		return TRUE
	for(var/datum/mind/M in owners)
		if(!isliving(M.current))
			continue

		var/list/all_items = M.current.GetAllContents()	//this should get things in cheesewheels, books, etc.

		for(var/obj/I in all_items) //Check for items
			if(istype(I, steal_target))
				if(!targetinfo) //If there's no targetinfo, then that means it was a custom objective. At this point, we know you have the item, so return 1.
					return TRUE
				else if(targetinfo.check_special_completion(I))//Returns 1 by default. Items with special checks will return 1 if the conditions are fulfilled.
					return TRUE

			if(targetinfo && (I.type in targetinfo.altitems)) //Ok, so you don't have the item. Do you have an alternative, at least?
				if(targetinfo.check_special_completion(I))//Yeah, we do! Don't return 0 if we don't though - then you could fail if you had 1 item that didn't pass and got checked first!
					return TRUE
	return FALSE

GLOBAL_LIST_EMPTY(possible_items_special)
/datum/objective/steal/special //ninjas are so special they get their own subtype good for them
	name = "steal special"
	reward = 15

/datum/objective/steal/special/New()
	..()
	if(!GLOB.possible_items_special.len)
		for(var/I in subtypesof(/datum/objective_item/special) + subtypesof(/datum/objective_item/stack))
			new I

/datum/objective/steal/special/find_target(dupe_search_range)
	return set_target(pick(GLOB.possible_items_special))

/datum/objective/download
	name = "download"
	reward = 10

/datum/objective/download/proc/gen_amount_goal()
	target_amount = rand(20,40)
	update_explanation_text()
	return target_amount

/datum/objective/download/update_explanation_text()
	..()
	explanation_text = "Скачать [target_amount] исследований на диск."

/datum/objective/download/check_completion()
	var/datum/techweb/checking = new
	var/list/datum/mind/owners = get_owners()
	for(var/datum/mind/owner in owners)
		if(ismob(owner.current))
			var/mob/M = owner.current			//Yeah if you get morphed and you eat a quantum tech disk with the RD's latest backup good on you soldier.
			if(ishuman(M))
				var/mob/living/carbon/human/H = M
				if(H && (H.stat != DEAD) && istype(H.wear_suit, /obj/item/clothing/suit/space/space_ninja))
					var/obj/item/clothing/suit/space/space_ninja/S = H.wear_suit
					S.stored_research.copy_research_to(checking)
			var/list/otherwise = M.GetAllContents()
			for(var/obj/item/disk/tech_disk/TD in otherwise)
				TD.stored_research.copy_research_to(checking)
	return checking.researched_nodes.len >= target_amount

/datum/objective/download/admin_edit(mob/admin)
	var/count = input(admin,"How many nodes ?","Nodes",target_amount) as num|null
	if(count)
		target_amount = count
	update_explanation_text()

/datum/objective/capture
	name = "capture"
	reward = 20

/datum/objective/capture/proc/gen_amount_goal()
	target_amount = rand(5,10)
	update_explanation_text()
	return target_amount

/datum/objective/capture/update_explanation_text()
	. = ..()
	explanation_text = "Capture [target_amount] lifeform\s with an energy net. Live, rare specimens are worth more."

/datum/objective/capture/check_completion()//Basically runs through all the mobs in the area to determine how much they are worth.
	var/captured_amount = 0
	var/area/centcom/holding/A = GLOB.areas_by_type[/area/centcom/holding]
	for(var/mob/living/carbon/human/M in A)//Humans.
		if(ismonkey(M))
			captured_amount+=0.1
			continue
		if(M.stat == DEAD)//Dead folks are worth less.
			captured_amount+=0.5
			continue
		captured_amount+=1
	for(var/mob/living/carbon/alien/larva/M in A)//Larva are important for research.
		if(M.stat == DEAD)
			captured_amount+=0.5
			continue
		captured_amount+=1
	for(var/mob/living/carbon/alien/humanoid/M in A)//Aliens are worth twice as much as humans.
		if(istype(M, /mob/living/carbon/alien/humanoid/royal/queen))//Queens are worth three times as much as humans.
			if(M.stat == DEAD)
				captured_amount+=1.5
			else
				captured_amount+=3
			continue
		if(M.stat == DEAD)
			captured_amount+=1
			continue
		captured_amount+=2
	return captured_amount >= target_amount

/datum/objective/capture/admin_edit(mob/admin)
	var/count = input(admin,"How many mobs to capture ?","capture",target_amount) as num|null
	if(count)
		target_amount = count
	update_explanation_text()

/datum/objective/protect_object
	name = "protect object"
	var/obj/protect_target

/datum/objective/protect_object/proc/set_target(obj/O)
	protect_target = O
	update_explanation_text()

/datum/objective/protect_object/update_explanation_text()
	. = ..()
	if(protect_target)
		explanation_text = "Protect [protect_target] at all costs."
	else
		explanation_text = "Ничего."

/datum/objective/protect_object/check_completion()
	return !QDELETED(protect_target)

//Changeling Objectives

/datum/objective/absorb
	name = "absorb"
	reward = 10

/datum/objective/absorb/proc/gen_amount_goal(lowbound = 4, highbound = 6)
	target_amount = rand (lowbound,highbound)
	var/n_p = 1 //autowin
	var/list/datum/mind/owners = get_owners()
	if (SSticker.current_state == GAME_STATE_SETTING_UP)
		for(var/i in GLOB.new_player_list)
			var/mob/dead/new_player/P = i
			if(P.ready == PLAYER_READY_TO_PLAY && !(P.mind in owners))
				n_p ++
	else if (SSticker.IsRoundInProgress())
		for(var/mob/living/carbon/human/P in GLOB.player_list)
			if(!(P.mind.has_antag_datum(/datum/antagonist/changeling)) && !(P.mind in owners))
				n_p ++
	target_amount = min(target_amount, n_p)

	update_explanation_text()
	return target_amount

/datum/objective/absorb/update_explanation_text()
	. = ..()
	explanation_text = "Extract [target_amount] compatible genome\s."

/datum/objective/absorb/admin_edit(mob/admin)
	var/count = input(admin,"How many people to absorb?","absorb",target_amount) as num|null
	if(count)
		target_amount = count
	update_explanation_text()

/datum/objective/absorb/check_completion()
	var/list/datum/mind/owners = get_owners()
	var/absorbedcount = 0
	for(var/datum/mind/M in owners)
		if(!M)
			continue
		var/datum/antagonist/changeling/changeling = M.has_antag_datum(/datum/antagonist/changeling)
		if(!changeling || !changeling.stored_profiles)
			continue
		absorbedcount += changeling.absorbedcount
	return absorbedcount >= target_amount

/datum/objective/absorb_most
	name = "absorb most"
	explanation_text = "Extract more compatible genomes than any other Changeling."
	reward = 20

/datum/objective/absorb_most/check_completion()
	var/list/datum/mind/owners = get_owners()
	var/absorbedcount = 0
	for(var/datum/mind/M in owners)
		if(!M)
			continue
		var/datum/antagonist/changeling/changeling = M.has_antag_datum(/datum/antagonist/changeling)
		if(!changeling || !changeling.stored_profiles)
			continue
		absorbedcount += changeling.absorbedcount

	for(var/datum/antagonist/changeling/changeling2 in GLOB.antagonists)
		if(!changeling2.owner || changeling2.owner == owner || !changeling2.stored_profiles || changeling2.absorbedcount < absorbedcount)
			continue
		return FALSE
	return TRUE

/datum/objective/absorb_changeling
	name = "absorb changeling"
	explanation_text = "Absorb another Changeling."
	reward = 20

/datum/objective/absorb_changeling/check_completion()
	var/list/datum/mind/owners = get_owners()
	for(var/datum/mind/M in owners)
		if(!M)
			continue
		var/datum/antagonist/changeling/changeling = M.has_antag_datum(/datum/antagonist/changeling)
		if(!changeling)
			continue
		var/total_genetic_points = changeling.geneticpoints

		for(var/datum/action/changeling/p in changeling.purchasedpowers)
			total_genetic_points += p.dna_cost

		if(total_genetic_points > initial(changeling.geneticpoints))
			return TRUE
	return FALSE

//End Changeling Objectives

/datum/objective/destroy
	name = "destroy AI"
	martyr_compatible = TRUE
	reward = 25

/datum/objective/destroy/find_target(dupe_search_range)
	var/list/possible_targets = active_ais(1)
	var/mob/living/silicon/ai/target_ai = pick(possible_targets)
	target = target_ai.mind
	update_explanation_text()
	return target

/datum/objective/destroy/check_completion()
	if(target?.current)
		return target.current.stat == DEAD || target.current.z > 6 || !target.current.ckey //Borgs/brains/AIs count as dead for traitor objectives.
	return TRUE

/datum/objective/destroy/update_explanation_text()
	..()
	if(target?.current)
		explanation_text = "Destroy [target.name], the experimental AI."
	else
		explanation_text = "Ничего."

/datum/objective/destroy/admin_edit(mob/admin)
	var/list/possible_targets = active_ais(1)
	if(possible_targets.len)
		var/mob/new_target = input(admin,"Select target:", "Objective target") as null|anything in sortNames(possible_targets)
		target = new_target.mind
	else
		to_chat(admin, "<span class='boldwarning'>No active AIs with minds.</span>")
	update_explanation_text()

/datum/objective/destroy/internal
	var/stolen = FALSE 		//Have we already eliminated this target?

/datum/objective/steal_five_of_type
	name = "steal five of"
	explanation_text = "Steal at least five items!"
	var/list/wanted_items = list()
	reward = 10

/datum/objective/steal_five_of_type/New()
	..()
	wanted_items = typecacheof(wanted_items)

/datum/objective/steal_five_of_type/check_completion()
	var/list/datum/mind/owners = get_owners()
	var/stolen_count = 0
	for(var/datum/mind/M in owners)
		if(!isliving(M.current))
			continue
		var/list/all_items = M.current.GetAllContents()	//this should get things in cheesewheels, books, etc.
		for(var/obj/I in all_items) //Check for wanted items
			if(is_type_in_typecache(I, wanted_items))
				stolen_count++
	return stolen_count >= 5

/datum/objective/steal_five_of_type/summon_guns
	name = "steal guns"
	explanation_text = "Steal at least five guns!"
	wanted_items = list(/obj/item/gun)
	reward = 10

/datum/objective/steal_five_of_type/summon_magic
	name = "steal magic"
	explanation_text = "Steal at least five magical artefacts!"
	wanted_items = list()
	reward = 10

/datum/objective/steal_five_of_type/summon_magic/New()
	wanted_items = GLOB.summoned_magic_objectives
	..()

/datum/objective/steal_five_of_type/summon_magic/check_completion()
	var/list/datum/mind/owners = get_owners()
	var/stolen_count = 0
	for(var/datum/mind/M in owners)
		if(!isliving(M.current))
			continue
		var/list/all_items = M.current.GetAllContents()	//this should get things in cheesewheels, books, etc.
		for(var/obj/I in all_items) //Check for wanted items
			if(istype(I, /obj/item/book/granter/spell))
				var/obj/item/book/granter/spell/spellbook = I
				if(!spellbook.used || !spellbook.oneuse) //if the book still has powers...
					stolen_count++ //it counts. nice.
			else if(is_type_in_typecache(I, wanted_items))
				stolen_count++
	return stolen_count >= 5

//Created by admin tools
/datum/objective/custom
	name = "custom"
	reward = 5

/datum/objective/custom/admin_edit(mob/admin)
	var/expl = stripped_input(admin, "Custom objective:", "Objective", explanation_text)
	if(expl)
		explanation_text = expl

//Ideally this would be all of them but laziness and unusual subtypes
/proc/generate_admin_objective_list()
	GLOB.admin_objective_list = list()

	var/list/allowed_types = sortList(list(
		/datum/objective/assassinate,
		/datum/objective/maroon,
		/datum/objective/debrain,
		/datum/objective/protect,
		/datum/objective/jailbreak,
		/datum/objective/jailbreak/detain,
		/datum/objective/destroy,
		/datum/objective/hijack,
		/datum/objective/escape,
		/datum/objective/survive,
		/datum/objective/limited,
		/datum/objective/martyr,
		/datum/objective/steal,
		/datum/objective/download,
		/datum/objective/nuclear,
		/datum/objective/capture,
		/datum/objective/absorb,
		/datum/objective/custom
	),/proc/cmp_typepaths_asc)

	for(var/T in allowed_types)
		var/datum/objective/X = T
		GLOB.admin_objective_list[initial(X.name)] = T

/datum/objective/contract
	var/payout = 0
	var/payout_bonus = 0
	var/area/dropoff = null

// Generate a random valid area on the station that the dropoff will happen.
/datum/objective/contract/proc/generate_dropoff()
	var/found = FALSE
	while (!found)
		var/area/dropoff_area = pick(GLOB.sortedAreas)
		if(dropoff_area && is_station_level(dropoff_area.z) && !dropoff_area.outdoors)
			dropoff = dropoff_area
			found = TRUE

// Check if both the contractor and contract target are at the dropoff point.
/datum/objective/contract/proc/dropoff_check(mob/user, mob/target)
	var/area/user_area = get_area(user)
	var/area/target_area = get_area(target)

	return (istype(user_area, dropoff) && istype(target_area, dropoff))
