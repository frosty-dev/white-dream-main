/datum/action/changeling/biodegrade
	name = "Биодеградация"
	desc = "Растворяет ограничения или другие объекты, препятствующие свободному движению. Стоит 30 химикатов."
	helptext = "Это очевидно для соседних людей и может разрушить стандартные ограничения и шкафы."
	button_icon_state = "biodegrade"
	chemical_cost = 30 //High cost to prevent spam
	dna_cost = 2
	req_human = 1

/datum/action/changeling/biodegrade/sting_action(mob/living/carbon/human/user)
	var/used = FALSE // only one form of shackles removed per use
	if(!user.restrained() && !user.legcuffed && isopenturf(user.loc))
		to_chat(user, "<span class='warning'>Мы уже свободны!</span>")
		return FALSE

	if(user.handcuffed)
		var/obj/O = user.get_item_by_slot(ITEM_SLOT_HANDCUFFED)
		if(!istype(O))
			return FALSE
		user.visible_message("<span class='warning'><b>[user]</b> изрыгает шар кислоты на <b>[O]</b>!</span>", \
			"<span class='warning'>Мы изрыгаем кислотную слизь на наши наручники!</span>")

		addtimer(CALLBACK(src, .proc/dissolve_handcuffs, user, O), 30)
		used = TRUE

	if(user.legcuffed)
		var/obj/O = user.get_item_by_slot(ITEM_SLOT_LEGCUFFED)
		if(!istype(O))
			return FALSE
		user.visible_message("<span class='warning'><b>[user]</b> изрыгает шар кислоты на <b>[O]</b>!</span>", \
			"<span class='warning'>Мы изрыгаем кислотную слизь на наши стяжки!</span>")

		addtimer(CALLBACK(src, .proc/dissolve_legcuffs, user, O), 30)
		used = TRUE

	if(user.wear_suit && user.wear_suit.breakouttime && !used)
		var/obj/item/clothing/suit/S = user.get_item_by_slot(ITEM_SLOT_OCLOTHING)
		if(!istype(S))
			return FALSE
		user.visible_message("<span class='warning'><b>[user]</b> изрыгает шар кислоты на <b>[S]</b>!</span>", \
			"<span class='warning'>Мы изрыгаем кислотную слизь на нашу смирительную рубашку!</span>")
		addtimer(CALLBACK(src, .proc/dissolve_straightjacket, user, S), 30)
		used = TRUE


	if(istype(user.loc, /obj/structure/closet) && !used)
		var/obj/structure/closet/C = user.loc
		if(!istype(C))
			return FALSE
		C.visible_message("<span class='warning'>Петли <b>[C]</b> вдруг начинают таять и бегать!</span>")
		to_chat(user, "<span class='warning'>Мы изрыгаем кислотную смесь внутри <b>[C]</b>!</span>")
		addtimer(CALLBACK(src, .proc/open_closet, user, C), 70)
		used = TRUE

	if(istype(user.loc, /obj/structure/spider/cocoon) && !used)
		var/obj/structure/spider/cocoon/C = user.loc
		if(!istype(C))
			return FALSE
		C.visible_message("<span class='warning'><b>[src]</b> дёргается и начинает разваливаться!</span>")
		to_chat(user, "<span class='warning'>Мы выделяем кислотные ферменты из нашей кожи и начинаем плавить кокон...</span>")
		addtimer(CALLBACK(src, .proc/dissolve_cocoon, user, C), 25) //Very short because it's just webs
		used = TRUE
	..()
	return used

/datum/action/changeling/biodegrade/proc/dissolve_handcuffs(mob/living/carbon/human/user, obj/O)
	if(O && user.handcuffed == O)
		user.visible_message("<span class='warning'><b>[O]</b> растворяется в луже шипящей слизи.</span>")
		new /obj/effect/decal/cleanable/greenglow(O.drop_location())
		qdel(O)

/datum/action/changeling/biodegrade/proc/dissolve_legcuffs(mob/living/carbon/human/user, obj/O)
	if(O && user.legcuffed == O)
		user.visible_message("<span class='warning'><b>[O]</b> растворяется в луже шипящей слизи.</span>")
		new /obj/effect/decal/cleanable/greenglow(O.drop_location())
		qdel(O)

/datum/action/changeling/biodegrade/proc/dissolve_straightjacket(mob/living/carbon/human/user, obj/S)
	if(S && user.wear_suit == S)
		user.visible_message("<span class='warning'><b>[S]</b> растворяется в луже шипящей слизи.</span>")
		new /obj/effect/decal/cleanable/greenglow(S.drop_location())
		qdel(S)

/datum/action/changeling/biodegrade/proc/open_closet(mob/living/carbon/human/user, obj/structure/closet/C)
	if(C && user.loc == C)
		C.visible_message("<span class='warning'>Дверь <b>[C]</b> ломается и открывается!</span>")
		new /obj/effect/decal/cleanable/greenglow(C.drop_location())
		C.welded = FALSE
		C.locked = FALSE
		C.broken = TRUE
		C.open()
		to_chat(user, "<span class='warning'>Нам удалось открыть контейнер сдерживающий нас!</span>")

/datum/action/changeling/biodegrade/proc/dissolve_cocoon(mob/living/carbon/human/user, obj/structure/spider/cocoon/C)
	if(C && user.loc == C)
		new /obj/effect/decal/cleanable/greenglow(C.drop_location())
		qdel(C) //The cocoon's destroy will move the changeling outside of it without interference
		to_chat(user, "<span class='warning'>Мы растворяем кокон!</span>")
