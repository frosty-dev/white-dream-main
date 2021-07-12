/atom/movable/butt_storage
	name = "задницевый костыль"
	desc = "при встрече сообщите кодерасту"
/atom/movable/butt_storage/Initialize(mapload, source)
	. = ..()
	verbs.Cut()
/atom/movable/butt_storage/ex_act(severity)
	return FALSE
/atom/movable/butt_storage/singularity_act()
	return
/atom/movable/butt_storage/singularity_pull()
	return
/atom/movable/butt_storage/blob_act()
	return
/atom/movable/butt_storage/onTransitZ()
	return
/atom/movable/butt_storage/movable/forceMove(atom/destination, no_tp=FALSE, harderforce = FALSE)
	return

/obj/item/organ/butt
	name = "задница"
	desc = "невероятно драгоценная часть тела"
	worn_icon = 'white/valtos/icons/clothing/mob/hat.dmi'
	icon = 'white/valtos/icons/clothing/hats.dmi'
	icon_state = "butt"
	worn_icon_state = "butt"
	zone = "groin"
	slot = "butt"
	throwforce = 5
	throw_speed = 4
	force = 5
	embedding = list("embed_chance" = 5) // This is a joke
	hitsound = 'white/valtos/sounds/poo2.ogg'
	body_parts_covered = HEAD
	slot_flags = ITEM_SLOT_HEAD
	var/loose = 0
	var/pocket_storage_component_path = /datum/component/storage/concrete/pockets/butt
	var/atom/movable/butt_storage/storage_handler
/*
/obj/item/organ/butt/Initialize()
	. = ..()

*/
/obj/item/organ/butt/xeno //XENOMORPH BUTTS ARE BEST BUTTS yes i agree
	name = "задница ксеноса"
	desc = "лучший трофей"
	icon_state = "xenobutt"
	worn_icon_state = "xenobutt"

/obj/item/organ/butt/xeno/ComponentInitialize()
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/butt/xeno
	. = ..()

/obj/item/organ/butt/bluebutt // bluespace butts, science
	name = "жопа хранения"
	desc = "Эта блюспейс жопа позвляет хранить огромное количество предметов в себе."
	icon_state = "bluebutt"
	worn_icon_state = "bluebutt"
	status = ORGAN_ROBOTIC

/obj/item/organ/butt/bluebutt/ComponentInitialize()
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/butt/bluebutt
	. = ..()

/obj/item/organ/butt/Insert(mob/living/carbon/C, special = 0, drop_if_replaced = TRUE)
	. = ..()
	storage_handler = new(C)
	storage_handler.AddComponent(pocket_storage_component_path)

/obj/item/organ/butt/Remove(mob/living/carbon/M, special = 0)
/*
	var/turf/T = get_turf(M)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		var/list/STR_contents = STR.contents()
		for(var/i in STR_contents)
			var/obj/item/I = i
			STR.remove_from_storage(I, T)
*/
	qdel(storage_handler)
	//var/datum/component/storage/STR = storage_handler.GetComponent(pocket_storage_component_path)
	//STR.Destroy()
	. = ..()

/obj/item/organ/butt/on_life()
	var/datum/component/storage/STR = storage_handler.GetComponent(/datum/component/storage)
	if(STR)
		var/list/STR_contents = STR.contents()
		for(var/obj/item/I in STR_contents)
			if(I.get_sharpness())
				owner.bleed(4)

/obj/item/organ/butt/attackby(var/obj/item/W, mob/user as mob, params) // copypasting bot manufucturing process, im a lazy fuck

	if(istype(W, /obj/item/bodypart/l_arm/robot) || istype(W, /obj/item/bodypart/r_arm/robot))
		if(istype(src, /obj/item/organ/butt/bluebutt)) //nobody sprited a blue butt buttbot
			to_chat(user, "<span class='warning'>Не получится!</span>")
			return
		user.dropItemToGround(W)
		qdel(W)
		var/turf/T = get_turf(src.loc)
		var/mob/living/simple_animal/bot/buttbot/B = new /mob/living/simple_animal/bot/buttbot(T)
		if(istype(src, /obj/item/organ/butt/xeno))
			B.xeno = 1
			B.icon_state = "buttbot_xeno"
			B.speech_list = list("хссс жопка", "хсс хсс пидор", "отличный трофей, придурок", "жопа", "инспекция жопы пришельца начата")
		to_chat(user, "<span class='notice'>Добавлю руку к жопе... Ммм?</span>")
		user.dropItemToGround(src)
		qdel(src)

/obj/item/organ/butt/throw_impact(atom/hit_atom)
	..()
	playsound(src, 'white/valtos/sounds/poo2.ogg', 50, 1, 5)

///////////////////////////////////////////////////////////////mob stuff

/mob/living/carbon/proc/regeneratebutt()
	if(!getorganslot("butt"))
		if(ishuman(src) || ismonkey(src))
			var/obj/item/organ/butt/B = new()
			B.Insert(src)
		if(isalien(src))
			var/obj/item/organ/butt/xeno/X = new()
			X.Insert(src)

/mob/living/carbon/human/proc/checkbuttinspect(mob/living/carbon/user)
	if(user.zone_selected == "groin")
		var/obj/item/organ/butt/B = getorgan(/obj/item/organ/butt)
		if(!w_uniform)
			var/datum/component/storage/STR = B.storage_handler.GetComponent(B.pocket_storage_component_path)
			if(B && STR)
				user.visible_message("<span class='warning'>[user] начинает инспектировать [user == src ? "свою задницу" : "задницу [src]"]!</span>", "<span class='warning'>Начинаю инспектировать [user == src ? "свою задницу" : "задницу [src]"]!</span>")
				if(do_mob(user, src, 40))
					user.visible_message("<span class='warning'>[user] инспектирует [user == src ? "свою задницу" : "задницу [src]"]!</span>", "<span class='warning'>Инспектирую [user == src ? "свою задницу" : "задницу [src]"]!</span>")
					if (user.active_storage)
						user.active_storage.close(user)
					STR.orient2hud(user)
					STR.show_to(user)
					return TRUE
				else
					user.visible_message("<span class='warning'>[user] проваливает попытку инспекции [user == src ? "своей задницы" : "задницы [src]"]!</span>", "<span class='warning'>Не вышло проинспектировать [user == src ? "свою задницу" : "задницу [src]"]!</span>")
					return TRUE
			else
				to_chat(user, "<span class='warning'>Задницы нет!</span>")
				return TRUE
		else
			if(user == src)
				user.visible_message("<span class='warning'>[user] хватает себя за зад!</span>", "<span class='warning'>Хватаю себя за зад!</span>")
				to_chat(user,  "<span class='warning'>Надо бы снять одежду сперва!</span>")
			else
				user.visible_message("<span class='warning'>[user] хватает [src] за задницу!</span>", "<span class='warning'>Хватаю задницу [src]!</span>")
				to_chat(user, "<span class='warning'>Надо бы снять с [src] одежду!</span>")
				to_chat(src, "<span class='userdanger'>Мой зад кто-то схватил!</span>")
			return TRUE

/mob/living/carbon/human/grabbedby(mob/living/user, supress_message = FALSE)
	if (checkbuttinspect(user))
		return FALSE
	return ..()

/mob/living/carbon/proc/checkbuttinsert(obj/item/I, mob/living/carbon/user)
	if(user.zone_selected == "groin")
		if(user.a_intent == INTENT_GRAB)
			var/mob/living/carbon/human/buttowner = src
			if(!istype(buttowner))
				return FALSE
			if(buttowner.w_uniform)
				to_chat(user, "<span class='danger'>Надо бы снять одежду сперва!</span>")
				return FALSE
			var/obj/item/organ/butt/B = buttowner.getorgan(/obj/item/organ/butt)
			if(B)
				var/datum/component/storage/STR = B.storage_handler.GetComponent(B.pocket_storage_component_path)
				if(!STR)
					return FALSE
				user.visible_message("<span class='warning'>[user] начинает прятать [I] в [user == src ? "свою задницу" : "задницу [src]"].</span>", "<span class='warning'>Начинаю прятать [I] в [user == src ? "свою задницу" : "задницу [src]"].</span>")
				if(STR.can_be_inserted(I, 0, user) && do_mob(user, src, 20))
					STR.handle_item_insertion(I, 0, user)
					user.visible_message("<span class='warning'>[user] прячет [I] внутри [user == src ? "своей задницы" : "задницы [src]"].</span>", "<span class='warning'>Прячу [I] внутри [user == src ? "своей задницы" : "задницы [src]"].</span>")
				return TRUE
	return FALSE

///////////////////////////////////////////////////////////////////other

/obj/item/clothing/proc/checkbuttuniform(mob/user)
	var/obj/item/organ/butt/B = user.getorgan(/obj/item/organ/butt)
	if(B)
		var/datum/component/storage/STR = B.storage_handler.GetComponent(B.pocket_storage_component_path)
		if(STR)
			STR.close_all()

/atom/GetAllContents(var/T)
	. = ..()
	if (istype(src, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = src
		var/obj/item/organ/butt/B = H.getorgan(/obj/item/organ/butt)

		if (B)
			. += B.contents

/mob/living/simple_animal/bot/buttbot
	name = "жопобот"
	desc = "Жопа с рукой. Вопросы???"
	icon = 'white/valtos/icons/objects.dmi'
	icon_state = "buttbot"
	layer = 5.0
	density = 0
	anchored = 0
	flags_1 = HEAR_1
	health = 25
	var/xeno = 0 //Do we hiss when buttspeech?
	var/cooldown = 0
	var/list/speech_buffer = list()
	var/list/speech_list = list("жопа.", "жопы.", "задница.", "пук.", "assblast usa", "НАЧИНАЮ ИНСПЕКЦИЮ ЗАДНИЦ", "вуп") //Hilarious.

/mob/living/simple_animal/bot/buttbot/Initialize()
	. = ..()
	if(xeno)
		icon_state = "buttbot_xeno"
		speech_list = list("хссс жопка", "хсс хсс пидор", "отличный трофей, придурок", "жопа", "инспекция жопы пришельца начата")

/mob/living/simple_animal/bot/buttbot/explode()
	visible_message("<span class='userdanger'>[capitalize(src.name)] взрывается!</span>")
	var/turf/T = get_turf(src)

	if(prob(50))
		new /obj/item/bodypart/l_arm/robot(T)
	if(xeno)
		new /obj/item/organ/butt/xeno(T)
	else
		new /obj/item/organ/butt(T)

	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(3, 1, src)
	s.start()

	// new /obj/effect/decal/cleanable/blood/oil(loc)
	..() //qdels us and removes us from processing objects

/mob/living/simple_animal/bot/buttbot/handle_automated_action()
	if (!..())
		return

	if(isturf(src.loc))
		var/anydir = pick(GLOB.cardinals)
		if(Process_Spacemove(anydir))
			Move(get_step(src, anydir), anydir)

	if(prob(5) && cooldown < world.time)
		cooldown = world.time + 200 //20 seconds
		if(xeno) //Hiss like a motherfucker
			playsound(loc, "hiss", 15, 1, 1)
		if(prob(70) && speech_buffer.len)
			speak(buttificate(pick(speech_buffer)))
			if(prob(5))
				speech_buffer.Remove(pick(speech_buffer)) //so they're not magic wizard guru buttbots that hold arcane information collected during an entire round.
		else
			speak(pick(speech_list))

/mob/living/simple_animal/bot/buttbot/Hear(message, atom/movable/speaker, message_langs, raw_message, radio_freq)
	//Also dont imitate ourselves. Imitate other buttbots though heheh
	if(speaker != src && prob(40))
		if(speech_buffer.len >= 20)
			speech_buffer -= pick(speech_buffer)
		speech_buffer |= html_decode(raw_message)
	..()

/proc/buttificate(phrase)
	var/params = replacetext_char(phrase, " ", "&")
	var/list/buttphrase = params2list(params)
	var/finalphrase = ""
	for(var/p in buttphrase)
		if(prob(20))
			p="жопа"
		finalphrase = finalphrase+p+" "
	finalphrase = replacetext_char(finalphrase, " #39 ","'")
	finalphrase = replacetext_char(finalphrase, " s "," ") //this is really dumb and hacky, gets rid of trailing 's' character on the off chance that '#39' gets swapped
	if(findtext_char(finalphrase,"жопа"))
		return finalphrase
	return

/datum/crafting_recipe/food/buttkebab
	name = "Butt Kebab"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/organ/butt = 1
	)
	result = /obj/item/food/kebab/butt
	category = CAT_MEAT

/obj/item/food/kebab/butt
	name = "butt-kebab"
	desc = "Butt on a stick."
	icon_state = "buttkebab"
	icon = 'white/valtos/icons/objects.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("жопа" = 2, "метал" = 1)
	foodtypes = MEAT | GROSS

/datum/crafting_recipe/food/assburger
	name = "Assburger"
	reqs = list(
			/obj/item/food/meat/steak/plain = 1,
			/obj/item/food/bun = 1,
			/obj/item/organ/butt = 1
	)

	result = /obj/item/food/burger/assburger
	subcategory = CAT_BURGER

/obj/item/food/burger/assburger
	name = "assburger"
	desc = "What the hell, that's not domesticated donkey meat, it's a literal buttburger!"
	tastes = list("butt" = 4)
	foodtypes = MEAT | GRAIN | GROSS
	food_reagents = list(/datum/reagent/drug/fartium = 10, /datum/reagent/consumable/nutriment = 2)
	icon = 'white/valtos/icons/objects.dmi'
	icon_state = "assburger"

/datum/crafting_recipe/food/asspie
	name = "Asspie"
	reqs = list(
		/datum/reagent/consumable/blackpepper = 1,
		/datum/reagent/consumable/salt = 1,
		/obj/item/food/pie/plain = 1,
		/obj/item/organ/butt = 1)
	result = /obj/item/food/pie/asspie
	subcategory = CAT_PIE

/obj/item/food/pie/asspie
	name = "asspie"
	desc = "A delicious pie made from domesticated donkey, OH WAIT IS THAT A BUTT!"
	icon = 'white/valtos/icons/objects.dmi'
	icon_state = "asspie"
	tastes = list("пирог" = 2, "жопа" = 4)
	food_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 1, /datum/reagent/drug/fartium = 10)
	foodtypes = GRAIN | DAIRY | SUGAR | GROSS

/datum/crafting_recipe/buttshoes
	name = "butt shoes"
	result = /obj/item/clothing/shoes/buttshoes
	reqs = list(/obj/item/organ/butt = 2,
				/obj/item/clothing/shoes/sneakers = 1)
	tool_paths = list(/obj/item/wirecutters)
	time = 50
	category = CAT_CLOTHING

/obj/item/clothing/shoes/buttshoes
	desc = "Зачем?"
	name = "жопобуты"
	worn_icon = 'white/valtos/icons/clothing/mob/shoe.dmi'
	icon = 'white/valtos/icons/clothing/shoes.dmi'
	icon_state = "buttshoes"
	worn_icon_state = "buttshoes"

/obj/item/clothing/shoes/buttshoes/Initialize()
	. = ..()
	AddComponent(/datum/component/squeak, list('white/valtos/sounds/poo2.ogg'), 50)

/datum/design/bluebutt
	name = "Butt Of Holding"
	desc = "This butt has bluespace properties, letting you store more items in it. Four tiny items, or two small ones, or one normal one can fit."
	id = "bluebutt"
	build_type = PROTOLATHE
	materials = list(MAT_GOLD = 500, MAT_SILVER = 500) //quite cheap, for more convenience
	build_path = /obj/item/organ/butt/bluebutt
	category = list("Блюспейс разработки")

/mob/living/carbon/human/create_internal_organs()
	internal_organs += new /obj/item/organ/butt
	return ..()

/datum/component/storage/concrete/pockets/butt
	silent = TRUE
	max_items = 2
	max_combined_w_class = WEIGHT_CLASS_NORMAL
	max_w_class = WEIGHT_CLASS_SMALL
	drop_all_on_deconstruct = TRUE
	drop_all_on_destroy = TRUE

/datum/component/storage/concrete/pockets/butt/xeno
	max_items = 3
	max_combined_w_class = WEIGHT_CLASS_HUGE
	max_w_class = WEIGHT_CLASS_HUGE	//That's a BIG ass yo
	drop_all_on_deconstruct = TRUE
	drop_all_on_destroy = TRUE

/datum/component/storage/concrete/pockets/butt/bluebutt
	max_items = 4
	max_combined_w_class = WEIGHT_CLASS_NORMAL
	max_w_class = WEIGHT_CLASS_NORMAL
	drop_all_on_deconstruct = TRUE
	drop_all_on_destroy = TRUE
