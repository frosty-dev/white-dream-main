/mob/living/carbon/verb/give_verb()
	set category = "IC"
	set name = "Дать"
	set src in view(1)

	if(src == usr)
		to_chat(usr,"<span class='warning'>А?</span>")
		return

	if(!ismonkey(src)&&!ishuman(src) || isalien(src) || src.stat || usr.stat || !src.client)
		to_chat(usr,"<span class='warning'><b>[src.name]</b> не может что-то сейчас брать.</span>")
		return

	var/obj/item/I = usr.get_active_held_item()
	if(!I)
		to_chat(usr,"<span class='warning'>А у меня в руке ничего и нет, что я могу дать <b>[src]</b>.</span>")
		return

	if(!usr.canUnEquip(I))
		return

	var/list/empty_hands = get_empty_held_indexes()
	if(!empty_hands.len)
		to_chat(usr,"<span class='warning'>Руки <b>[src]</b> полны.</span>")
		return

	switch(alert(src,"[usr] хочет дать мне [I]. Взять?",,"Да","Нет"))
		if("Да")
			if(!I || !usr)
				return
			if(!Adjacent(usr))
				to_chat(src,"<span class='warning'>Надо бы ближе стоять.</span>")
				to_chat(usr,"<span class='warning'><b>[usr]</b> слишком далеко.</span>")
				return

			if(I != usr.get_active_held_item())
				to_chat(usr,"<span class='warning'>Надо бы держать предмет в руке.</span>")
				to_chat(src,"<span class='warning'><b>[usr]</b> не хочет отдавать <b>[I]</b> мне.</span>")
				return

			if(!(src.mobility_flags & MOBILITY_STAND) || src.handcuffed)
				to_chat(usr,"<span class='warning'>Руки <b>[src]</b> связаны.</span>")
				return

			empty_hands = get_empty_held_indexes()
			if(!empty_hands.len)
				to_chat(src,"<span class='warning'>Мои руки заняты.</span>")
				to_chat(usr,"<span class='warning'>Руки <b>[src]</b> заняты.</span>")
				return

			if(!usr.dropItemToGround(I))
				return

			if(!put_in_hands(I))
				to_chat(src,"<span class='warning'>Не удалось взять <b>[I]</b>, так что <b>[usr]</b> сдаётся!</span>")
				to_chat(usr,"<span class='warning'><b>[src]</b> не может взять <b>[I]</b>!</span>")
				return

			src.visible_message("<span class='notice'><b>[usr]</b> передаёт <b>[I]</b> <b>[src]</b>.</span>")
		if("Нет")
			src.visible_message("<span class='warning'><b>[usr]</b> пытается передать <b>[I]</b> <b>[src]</b>, но <b>[src]</b> не хочет брать его.</span>")
