/datum/objective/slay
	name = "slay"
	explanation_text = "Ликвидировать существо класса \"МЕГАФАУНА\"."
	var/target_megafauna_type
	martyr_compatible = TRUE
	reward = 30

/datum/objective/slay/New()
	var/list/mob/living/simple_animal/hostile/megafauna/mflist = list()
	for(var/mob/living/simple_animal/hostile/megafauna/MF in world)
		if(!is_mining_level(MF.z))
			continue
		/* похуй
		if(istype(MF, /mob/living/simple_animal/hostile/megafauna/legion)) // оно при убийстве самого первого уже засчитывается, несмешно
			continue
		*/
		mflist.Add(MF)
	var/mob/living/simple_animal/hostile/megafauna/target = pick(mflist)
	target_megafauna_type = target.type
	explanation_text += " Подвид: \"[uppertext(target.name)]\""
	RegisterSignal(SSdcs, COMSIG_GLOB_MOB_DEATH, .proc/check_target_death)

/datum/objective/slay/proc/check_target_death(datum/source, mob/living/dead, gibbed)
	if(completed)
		return
	if(!istype(dead, target_megafauna_type))
		return
	var/list/datum/mind/nearest_minds = list()
	for(var/mob/living/L in range(16, dead))
		if(L.mind)
			nearest_minds.Add(L.mind)
	var/list/datum/mind/nearest_slayers = nearest_minds & get_owners()
	if(!nearest_slayers.len)
		return
	var/datum/mind/nearest_slayer
	var/min_dist = 99
	for(var/datum/mind/M in nearest_slayers)
		var/mob/living/L = M.current
		var/curdist = get_dist_euclidian(L, dead)
		if(curdist < min_dist)
			min_dist = curdist
			nearest_slayer = M
	if(nearest_slayer != owner)
		return
	completed = TRUE
	var/mob/living/L = owner.current
	to_chat(L, "<span class='notice'><big>Ликвидация цели успешна!</big></span>")

