//Dogs.

/mob/living/simple_animal/pet/dog
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	response_help_continuous = "гладит"
	response_help_simple = "гладит"
	response_disarm_continuous = "отталкивает"
	response_disarm_simple = "отталкивает"
	response_harm_continuous = "пинает"
	response_harm_simple = "пинает"
	speak = list("ТЯФ", "Вуф!", "Гав!", "АУУУУУУ!!!")
	speak_emote = list("гавкает", "вуфает")
	emote_hear = list("гавкает!", "вуфает!", "тявкает.","ластится.")
	emote_see = list("качает головой.", "гоняется за своим хвостом.","дрожит.")
	faction = list("neutral")
	see_in_dark = 5
	speak_chance = 1
	turns_per_move = 10
	can_be_held = TRUE
	var/turns_since_scan = 0
	var/obj/movement_target

	footstep_type = FOOTSTEP_MOB_CLAW

/mob/living/simple_animal/pet/dog/Life()
	..()

	//Feeding, chasing food, FOOOOODDDD
	if(!stat && !resting && !buckled)
		turns_since_scan++
		if(turns_since_scan > 5)
			turns_since_scan = 0
			if((movement_target) && !(isturf(movement_target.loc) || ishuman(movement_target.loc) ))
				movement_target = null
				stop_automated_movement = 0
			if( !movement_target || !(movement_target.loc in oview(src, 3)) )
				movement_target = null
				stop_automated_movement = 0
				for(var/obj/item/reagent_containers/food/snacks/S in oview(src,3))
					if(isturf(S.loc) || ishuman(S.loc))
						movement_target = S
						break
			if(movement_target)
				stop_automated_movement = 1
				step_to(src,movement_target,1)
				sleep(3)
				step_to(src,movement_target,1)
				sleep(3)
				step_to(src,movement_target,1)

				if(movement_target)		//Not redundant due to sleeps, Item can be gone in 6 decisecomds
					var/turf/T = get_turf(movement_target)
					if(!T)
						return
					if (T.x < src.x)
						setDir(WEST)
					else if (T.x > src.x)
						setDir(EAST)
					else if (T.y < src.y)
						setDir(SOUTH)
					else if (T.y > src.y)
						setDir(NORTH)
					else
						setDir(SOUTH)

					if(!Adjacent(movement_target)) //can't reach food through windows.
						return

					if(isturf(movement_target.loc))
						movement_target.attack_animal(src)
					else if(ishuman(movement_target.loc) )
						if(prob(20))
							emote("me", 1, "stares at [movement_target.loc]'s [movement_target] with a sad puppy-face")

		if(prob(1))
			emote("me", 1, pick("dances around.","chases its tail!"))
			INVOKE_ASYNC(GLOBAL_PROC, .proc/dance_rotate, src)

//Corgis and pugs are now under one dog subtype

/mob/living/simple_animal/pet/dog/corgi
	name = "Корги"
	real_name = "Корги"
	desc = "Это же корги."
	icon_state = "corgi"
	icon_living = "corgi"
	icon_dead = "corgi_dead"
	held_state = "corgi"
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/corgi = 3, /obj/item/stack/sheet/animalhide/corgi = 1)
	childtype = list(/mob/living/simple_animal/pet/dog/corgi/puppy = 95, /mob/living/simple_animal/pet/dog/corgi/puppy/void = 5)
	animal_species = /mob/living/simple_animal/pet/dog
	gold_core_spawnable = FRIENDLY_SPAWN
	collar_type = "corgi"
	var/obj/item/inventory_head
	var/obj/item/inventory_back
	var/shaved = FALSE
	var/nofur = FALSE 		//Corgis that have risen past the material plane of existence.

/mob/living/simple_animal/pet/dog/corgi/Destroy()
	QDEL_NULL(inventory_head)
	QDEL_NULL(inventory_back)
	return ..()

/mob/living/simple_animal/pet/dog/corgi/handle_atom_del(atom/A)
	if(A == inventory_head)
		inventory_head = null
		update_corgi_fluff()
		regenerate_icons()
	if(A == inventory_back)
		inventory_back = null
		update_corgi_fluff()
		regenerate_icons()
	return ..()


/mob/living/simple_animal/pet/dog/pug
	name = "Мопс"
	real_name = "Мопс"
	desc = "А это мопс."
	icon = 'icons/mob/pets.dmi'
	icon_state = "pug"
	icon_living = "pug"
	icon_dead = "pug_dead"
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/pug = 3)
	gold_core_spawnable = FRIENDLY_SPAWN
	collar_type = "pug"
	held_state = "pug"

/mob/living/simple_animal/pet/dog/corgi/exoticcorgi
	name = "Экзотический корги"
	desc = "Как мило, так и красочно!"
	icon = 'icons/mob/pets.dmi'
	icon_state = "corgigrey"
	icon_living = "corgigrey"
	icon_dead = "corgigrey_dead"
	animal_species = /mob/living/simple_animal/pet/dog/corgi/exoticcorgi
	nofur = TRUE

/mob/living/simple_animal/pet/dog/Initialize()
	. = ..()
	var/dog_area = get_area(src)
	for(var/obj/structure/bed/dogbed/D in dog_area)
		if(!D.owner)
			D.update_owner(src)
			break

/mob/living/simple_animal/pet/dog/corgi/Initialize()
	. = ..()
	regenerate_icons()

/mob/living/simple_animal/pet/dog/corgi/exoticcorgi/Initialize()
		. = ..()
		var/newcolor = rgb(rand(0, 255), rand(0, 255), rand(0, 255))
		add_atom_colour(newcolor, FIXED_COLOUR_PRIORITY)

/mob/living/simple_animal/pet/dog/corgi/death(gibbed)
	..(gibbed)
	regenerate_icons()

/mob/living/simple_animal/pet/dog/corgi/show_inv(mob/user)
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	user.set_machine(src)


	var/dat = 	"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><div align='center'><b>Инвентарь [name]</b></div><p>"
	dat += "<br><B>Голова:</B> <A href='?src=[REF(src)];[inventory_head ? "remove_inv=head'>[inventory_head]" : "add_inv=head'>Ничего"]</A>"
	dat += "<br><B>Спина:</B> <A href='?src=[REF(src)];[inventory_back ? "remove_inv=back'>[inventory_back]" : "add_inv=back'>Ничего"]</A>"
	dat += "<br><B>Ошейник:</B> <A href='?src=[REF(src)];[pcollar ? "remove_inv=collar'>[pcollar]" : "add_inv=collar'>Ничего"]</A>"

	user << browse(dat, "window=mob[REF(src)];size=325x500")
	onclose(user, "mob[REF(src)]")

/mob/living/simple_animal/pet/dog/corgi/getarmor(def_zone, type)
	var/armorval = 0

	if(def_zone)
		if(def_zone == BODY_ZONE_HEAD)
			if(inventory_head)
				armorval = inventory_head.armor.getRating(type)
		else
			if(inventory_back)
				armorval = inventory_back.armor.getRating(type)
		return armorval
	else
		if(inventory_head)
			armorval += inventory_head.armor.getRating(type)
		if(inventory_back)
			armorval += inventory_back.armor.getRating(type)
	return armorval*0.5

/mob/living/simple_animal/pet/dog/corgi/attackby(obj/item/O, mob/user, params)
	if (istype(O, /obj/item/razor))
		if (shaved)
			to_chat(user, "<span class='warning'>Этот корги уже побрит!</span>")
			return
		if (nofur)
			to_chat(user, "<span class='warning'>У этого корги нет шерсти!</span>")
			return
		user.visible_message("<span class='notice'>[user] начинает брить [src] используя [O].</span>", "<span class='notice'>Начинаю брить [src] используя [O]...</span>")
		if(do_after(user, 50, target = src))
			user.visible_message("<span class='notice'>[user] бреет [src] используя [O].</span>")
			playsound(loc, 'sound/items/welder2.ogg', 20, TRUE)
			shaved = TRUE
			icon_living = "[initial(icon_living)]_shaved"
			icon_dead = "[initial(icon_living)]_shaved_dead"
			if(stat == CONSCIOUS)
				icon_state = icon_living
			else
				icon_state = icon_dead
		return
	..()
	update_corgi_fluff()

/mob/living/simple_animal/pet/dog/corgi/Topic(href, href_list)
	if(!(iscarbon(usr) || iscyborg(usr)) || !usr.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		usr << browse(null, "window=mob[REF(src)]")
		usr.unset_machine()
		return

	//Removing from inventory
	if(href_list["remove_inv"])
		var/remove_from = href_list["remove_inv"]
		switch(remove_from)
			if(BODY_ZONE_HEAD)
				if(inventory_head)
					usr.put_in_hands(inventory_head)
					inventory_head = null
					update_corgi_fluff()
					regenerate_icons()
				else
					to_chat(usr, "<span class='warning'>Снимать нечего с головы!</span>")
					return
			if("back")
				if(inventory_back)
					usr.put_in_hands(inventory_back)
					inventory_back = null
					update_corgi_fluff()
					regenerate_icons()
				else
					to_chat(usr, "<span class='warning'>Снимать нечего с спины!</span>")
					return
			if("collar")
				if(pcollar)
					usr.put_in_hands(pcollar)
					pcollar = null
					update_corgi_fluff()
					regenerate_icons()

		show_inv(usr)

	//Adding things to inventory
	else if(href_list["add_inv"])
		var/add_to = href_list["add_inv"]

		switch(add_to)
			if("collar")
				var/obj/item/clothing/neck/petcollar/P = usr.get_active_held_item()
				if(!istype(P))
					to_chat(usr,"<span class='warning'>Это не ошейник.</span>")
					return
				add_collar(P, usr)
				update_corgi_fluff()

			if(BODY_ZONE_HEAD)
				place_on_head(usr.get_active_held_item(),usr)

			if("back")
				if(inventory_back)
					to_chat(usr, "<span class='warning'>На нём уже что-то есть!</span>")
					return
				else
					var/obj/item/item_to_add = usr.get_active_held_item()

					if(!item_to_add)
						usr.visible_message("<span class='notice'>[usr] гладит [src].</span>", "<span class='notice'>Держу свою руку на спине [src]. Да?</span>")
						return

					if(!usr.temporarilyRemoveItemFromInventory(item_to_add))
						to_chat(usr, "<span class='warning'>[capitalize(item_to_add)] застрял в моей руке, у меня не получится повесить его на спину [src]!</span>")
						return

					if(istype(item_to_add, /obj/item/grenade/c4)) // last thing he ever wears, I guess
						item_to_add.afterattack(src,usr,1)
						return

					//The objects that corgis can wear on their backs.
					var/allowed = FALSE
					if(ispath(item_to_add.dog_fashion, /datum/dog_fashion/back))
						allowed = TRUE

					if(!allowed)
						to_chat(usr, "<span class='warning'>Вешаю [item_to_add] на спину [src], но оно спадает!</span>")
						item_to_add.forceMove(drop_location())
						if(prob(25))
							step_rand(item_to_add)
						dance_rotate(src, set_original_dir=TRUE)
						return

					item_to_add.forceMove(src)
					src.inventory_back = item_to_add
					update_corgi_fluff()
					regenerate_icons()

		show_inv(usr)
	else
		return ..()

//Corgis are supposed to be simpler, so only a select few objects can actually be put
//to be compatible with them. The objects are below.
//Many  hats added, Some will probably be removed, just want to see which ones are popular.
// > some will probably be removed

/mob/living/simple_animal/pet/dog/corgi/proc/place_on_head(obj/item/item_to_add, mob/user)

	if(istype(item_to_add, /obj/item/grenade/c4)) // last thing he ever wears, I guess
		item_to_add.afterattack(src,user,1)
		return

	if(inventory_head)
		if(user)
			to_chat(user, "<span class='warning'>Не могу посадить больше одной на [src]!</span>")
		return
	if(!item_to_add)
		user.visible_message("<span class='notice'>[user] гладит [src].</span>", "<span class='notice'>Держу свою руку на голове [src]. Да?</span>")
		if(flags_1 & HOLOGRAM_1)
			return
		SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, src, /datum/mood_event/pet_animal, src)
		return

	if(user && !user.temporarilyRemoveItemFromInventory(item_to_add))
		to_chat(user, "<span class='warning'>[capitalize(item_to_add)] застрял в моей руке, у меня не получится положить его на голову [src]!</span>")
		return 0

	var/valid = FALSE
	if(ispath(item_to_add.dog_fashion, /datum/dog_fashion/head))
		valid = TRUE

	//Various hats and items (worn on his head) change Ian's behaviour. His attributes are reset when a hat is removed.

	if(valid)
		if(health <= 0)
			to_chat(user, "<span class='notice'>Просто скучный, безжизненный взгляд виден в глазах [real_name] пока я пытаюсь напялить [item_to_add] на н[ru_ego()].</span>")
		else if(user)
			user.visible_message("<span class='notice'>[user] надевает [item_to_add] на голову [real_name]. [src] смотрит на [user] и гавкает радостно.</span>",
				"<span class='notice'>Надеваю [item_to_add] на голову [real_name]. [src] смотрит на меня своеобразно, затем [ru_who()] подвиливает хвостиком и гавкает радостно.</span>",
				"<span class='hear'>Слышу дружественно звучащий лай.</span>")
		item_to_add.forceMove(src)
		src.inventory_head = item_to_add
		update_corgi_fluff()
		regenerate_icons()
	else
		to_chat(user, "<span class='warning'>Надеваю [item_to_add] на голову [src], но оно спадает!</span>")
		item_to_add.forceMove(drop_location())
		if(prob(25))
			step_rand(item_to_add)
		dance_rotate(src, set_original_dir=TRUE)

	return valid

/mob/living/simple_animal/pet/dog/corgi/proc/update_corgi_fluff()
	// First, change back to defaults
	name = real_name
	desc = initial(desc)
	// BYOND/DM doesn't support the use of initial on lists.
	speak = list("ЯП", "Вуф!", "Гав!", "АУУУУУУ")
	speak_emote = list("гавкает", "вуфает")
	emote_hear = list("гавкает!", "вуфает!", "тявкает.","ластится.")
	emote_see = list("мотает головой.", "бегает за своим хвостом.","дрожит.")
	desc = initial(desc)
	set_light(0)

	if(inventory_head && inventory_head.dog_fashion)
		var/datum/dog_fashion/DF = new inventory_head.dog_fashion(src)
		DF.apply(src)

	if(inventory_back && inventory_back.dog_fashion)
		var/datum/dog_fashion/DF = new inventory_back.dog_fashion(src)
		DF.apply(src)

//IAN! SQUEEEEEEEEE~
/mob/living/simple_animal/pet/dog/corgi/ian
	name = "Ян"
	real_name = "Ян"	//Intended to hold the name without altering it.
	gender = MALE
	desc = "Это любимый корги главы персонала."
	response_help_continuous = "гладит"
	response_help_simple = "гладит"
	response_disarm_continuous = "толкает"
	response_disarm_simple = "толкает"
	response_harm_continuous = "пинает"
	response_harm_simple = "пинает"
	gold_core_spawnable = NO_SPAWN
	unique_pet = TRUE
	var/age = 0
	var/record_age = 1
	var/memory_saved = FALSE
	var/saved_head //path

/mob/living/simple_animal/pet/dog/corgi/ian/Initialize()
	. = ..()
	//parent call must happen first to ensure IAN
	//is not in nullspace when child puppies spawn
	Read_Memory()
	if(age == 0)
		var/turf/target = get_turf(loc)
		if(target)
			var/mob/living/simple_animal/pet/dog/corgi/puppy/P = new /mob/living/simple_animal/pet/dog/corgi/puppy(target)
			P.name = "Ян"
			P.real_name = "Ян"
			P.gender = MALE
			P.desc = "Это любимый щенок корги главы персонала."
			Write_Memory(FALSE)
			return INITIALIZE_HINT_QDEL
	else if(age == record_age)
		icon_state = "old_corgi"
		icon_living = "old_corgi"
		held_state = "old_corgi"
		icon_dead = "old_corgi_dead"
		desc = "В зрелом возрасте [record_age], Ян не такой бодрый, как раньше, но он всегда будет любимым корги главы персонала." //RIP
		turns_per_move = 20

/mob/living/simple_animal/pet/dog/corgi/ian/Life()
	if(!stat && SSticker.current_state == GAME_STATE_FINISHED && !memory_saved)
		Write_Memory(FALSE)
		memory_saved = TRUE
	..()

/mob/living/simple_animal/pet/dog/corgi/ian/death()
	if(!memory_saved)
		Write_Memory(TRUE)
	..()

/mob/living/simple_animal/pet/dog/corgi/ian/proc/Read_Memory()
	if(fexists("data/npc_saves/Ian.sav")) //legacy compatability to convert old format to new
		var/savefile/S = new /savefile("data/npc_saves/Ian.sav")
		S["age"] 		>> age
		S["record_age"]	>> record_age
		S["saved_head"] >> saved_head
		fdel("data/npc_saves/Ian.sav")
	else
		var/json_file = file("data/npc_saves/Ian.json")
		if(!fexists(json_file))
			return
		var/list/json = r_json_decode(file2text(json_file))
		age = json["age"]
		record_age = json["record_age"]
		saved_head = json["saved_head"]
	if(isnull(age))
		age = 0
	if(isnull(record_age))
		record_age = 1
	if(saved_head)
		place_on_head(new saved_head)

/mob/living/simple_animal/pet/dog/corgi/ian/proc/Write_Memory(dead)
	var/json_file = file("data/npc_saves/Ian.json")
	var/list/file_data = list()
	if(!dead)
		file_data["age"] = age + 1
		if((age + 1) > record_age)
			file_data["record_age"] = record_age + 1
		else
			file_data["record_age"] = record_age
		if(inventory_head)
			file_data["saved_head"] = inventory_head.type
		else
			file_data["saved_head"] = null
	else
		file_data["age"] = 0
		file_data["record_age"] = record_age
		file_data["saved_head"] = null
	fdel(json_file)
	WRITE_FILE(json_file, json_encode(file_data))

/mob/living/simple_animal/pet/dog/corgi/ian/narsie_act()
	playsound(src, 'sound/magic/demon_dies.ogg', 75, TRUE)
	var/mob/living/simple_animal/pet/dog/corgi/narsie/N = new(loc)
	N.setDir(dir)
	gib()

/mob/living/simple_animal/pet/dog/corgi/narsie
	name = "Нарс-Ян"
	desc = "Ия! Ия!"
	icon_state = "narsian"
	icon_living = "narsian"
	icon_dead = "narsian_dead"
	faction = list("neutral", "cult")
	gold_core_spawnable = NO_SPAWN
	nofur = TRUE
	unique_pet = TRUE
	held_state = "narsian"

/mob/living/simple_animal/pet/dog/corgi/narsie/Life()
	..()
	for(var/mob/living/simple_animal/pet/P in range(1, src))
		if(P != src && !istype(P,/mob/living/simple_animal/pet/dog/corgi/narsie))
			visible_message("<span class='warning'>[src] пожирает [P]!</span>", \
			"<span class='cult big bold'>ВКУСНЫЕ ДУШИ</span>")
			playsound(src, 'sound/magic/demon_attack1.ogg', 75, TRUE)
			narsie_act()
			if(P.mind)
				if(P.mind.hasSoul)
					P.mind.hasSoul = FALSE //Nars-Ian ate your soul; you don't have one anymore
				else
					visible_message("<span class='cult big bold'>... Оу, кто-то съел меня до этого.</span>")
			P.gib()

/mob/living/simple_animal/pet/dog/corgi/narsie/update_corgi_fluff()
	..()
	speak = list("Тари'карат-паснар!", "Ия! Ия!", "БРУБУХБУБХУХ")
	speak_emote = list("воет", "зловеще лает")
	emote_hear = list("лает эхом!", "вуфает навязчиво!", "тявкает сверхъестественный образом.", "бормочет что-то невыразимое.")
	emote_see = list("общается с неназванным.", "обдумывает пожирание некоторых душ.", "шатается.")

/mob/living/simple_animal/pet/dog/corgi/narsie/narsie_act()
	adjustBruteLoss(-maxHealth)


/mob/living/simple_animal/pet/dog/corgi/regenerate_icons()
	..()
	if(inventory_head)
		var/image/head_icon
		var/datum/dog_fashion/DF = new inventory_head.dog_fashion(src)

		if(!DF.obj_icon_state)
			DF.obj_icon_state = inventory_head.icon_state
		if(!DF.obj_alpha)
			DF.obj_alpha = inventory_head.alpha
		if(!DF.obj_color)
			DF.obj_color = inventory_head.color

		if(health <= 0)
			head_icon = DF.get_overlay(dir = EAST)
			head_icon.pixel_y = -8
			head_icon.transform = turn(head_icon.transform, 180)
		else
			head_icon = DF.get_overlay()

		add_overlay(head_icon)

	if(inventory_back)
		var/image/back_icon
		var/datum/dog_fashion/DF = new inventory_back.dog_fashion(src)

		if(!DF.obj_icon_state)
			DF.obj_icon_state = inventory_back.icon_state
		if(!DF.obj_alpha)
			DF.obj_alpha = inventory_back.alpha
		if(!DF.obj_color)
			DF.obj_color = inventory_back.color

		if(health <= 0)
			back_icon = DF.get_overlay(dir = EAST)
			back_icon.pixel_y = -11
			back_icon.transform = turn(back_icon.transform, 180)
		else
			back_icon = DF.get_overlay()
		add_overlay(back_icon)

	return



/mob/living/simple_animal/pet/dog/corgi/puppy
	name = "Щенок корги"
	real_name = "Корги"
	desc = "Это же щеночек корги!"
	icon_state = "puppy"
	icon_living = "puppy"
	icon_dead = "puppy_dead"
	density = FALSE
	pass_flags = PASSMOB
	mob_size = MOB_SIZE_SMALL
	collar_type = "puppy"

//puppies cannot wear anything.
/mob/living/simple_animal/pet/dog/corgi/puppy/Topic(href, href_list)
	if(href_list["remove_inv"] || href_list["add_inv"])
		to_chat(usr, "<span class='warning'>Не могу надеть это на [src]!</span>")
		return
	..()


/mob/living/simple_animal/pet/dog/corgi/puppy/void		//Tribute to the corgis born in nullspace
	name = "Пустотный щеник"
	real_name = "Пустота"
	desc = "Щенок корги, наполненный энергией дальнего космоса..."
	icon_state = "void_puppy"
	icon_living = "void_puppy"
	icon_dead = "void_puppy_dead"
	nofur = TRUE
	unsuitable_atmos_damage = 0
	minbodytemp = TCMB
	maxbodytemp = T0C + 40
	held_state = "void_puppy"

/mob/living/simple_animal/pet/dog/corgi/puppy/void/Process_Spacemove(movement_dir = 0)
	return 1	//Void puppies can navigate space.


//LISA! SQUEEEEEEEEE~
/mob/living/simple_animal/pet/dog/corgi/lisa
	name = "Лиза"
	real_name = "Лиза"
	gender = FEMALE
	desc = "Она разорвёт тебя на части."
	gold_core_spawnable = NO_SPAWN
	unique_pet = TRUE
	icon_state = "lisa"
	icon_living = "lisa"
	icon_dead = "lisa_dead"
	response_help_continuous = "гладит"
	response_help_simple = "гладит"
	response_disarm_continuous = "толкает"
	response_disarm_simple = "толкает"
	response_harm_continuous = "пинает"
	response_harm_simple = "пинает"
	held_state = "lisa"
	var/puppies = 0

//Lisa already has a cute bow!
/mob/living/simple_animal/pet/dog/corgi/lisa/Topic(href, href_list)
	if(href_list["remove_inv"] || href_list["add_inv"])
		to_chat(usr, "<span class='warning'>[src] уже имеет милый вид!</span>")
		return
	..()

/mob/living/simple_animal/pet/dog/corgi/lisa/Life()
	..()

	make_babies()

/mob/living/simple_animal/pet/dog/attack_hand(mob/living/carbon/human/M)
	. = ..()
	switch(M.a_intent)
		if("help")
			wuv(1,M)
		if("harm")
			wuv(-1,M)

/mob/living/simple_animal/pet/dog/proc/wuv(change, mob/M)
	if(change)
		if(change > 0)
			if(M && stat != DEAD) // Added check to see if this mob (the dog) is dead to fix issue 2454
				new /obj/effect/temp_visual/heart(loc)
				emote("me", 1, "тявкает радостно!")
				SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, src, /datum/mood_event/pet_animal, src)
		else
			if(M && stat != DEAD) // Same check here, even though emote checks it as well (poor form to check it only in the help case)
				emote("me", 1, "воет!")
