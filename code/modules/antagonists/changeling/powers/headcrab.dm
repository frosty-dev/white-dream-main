/datum/action/changeling/headcrab
	name = "Последний шанс"
	desc = "Мы жертвуем нашим текущим телом в момент нужды, давая нам контроль над сосудом, который может посадить наше подобие в новом хозяине. Стоит 20 химикатов."
	helptext = "Мы будем контролировать маленькое хрупкое существо. Мы можем напасть на труп, подобный этому, чтобы посадить яйцо, которое постепенно созреет для нас в новой форме."
	button_icon_state = "last_resort"
	chemical_cost = 20
	dna_cost = 1
	req_human = 1

/datum/action/changeling/headcrab/sting_action(mob/user)
	set waitfor = FALSE
	if(alert("Мы уверены, что хотим покончить с собой и создать сосуд?",,"Да", "Нет") == "Нет")
		return
	..()
	var/datum/mind/M = user.mind
	var/list/organs = user.getorganszone(BODY_ZONE_HEAD, 1)

	for(var/obj/item/organ/I in organs)
		I.Remove(user, 1)

	explosion(get_turf(user), 0, 0, 2, 0, TRUE)
	for(var/mob/living/carbon/human/H in range(2,user))
		var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
		to_chat(H, "<span class='userdanger'>Меня ослепило душем из крови!</span>")
		H.Stun(20)
		H.blur_eyes(20)
		eyes?.applyOrganDamage(5)
		H.confused += 3
	for(var/mob/living/silicon/S in range(2,user))
		to_chat(S, "<span class='userdanger'>Мои датчики отключило потоком крови!</span>")
		S.Paralyze(60)
	var/turf = get_turf(user)
	user.gib()
	. = TRUE
	sleep(5) // So it's not killed in explosion
	var/mob/living/simple_animal/hostile/headcrab/crab = new(turf)
	for(var/obj/item/organ/I in organs)
		I.forceMove(crab)
	crab.origin = M
	if(crab.origin)
		crab.origin.active = 1
		crab.origin.transfer_to(crab)
		to_chat(crab, "<span class='warning'>Мы вырвались из остатков своего бывшего тела в потоке крови!</span>")
