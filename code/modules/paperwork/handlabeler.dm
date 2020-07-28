/obj/item/hand_labeler
	name = "этикетировщик"
	desc = "Комбинированный принтер этикеток, аппликатор и съемник - все в одном портативном устройстве. Разработанный, чтобы быть простым в эксплуатации и использовании."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "labeler0"
	inhand_icon_state = "flight"
	var/label = null
	var/labels_left = 30
	var/mode = 0

/obj/item/hand_labeler/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is pointing [src] at [user.p_them()]self. [user.p_theyre(TRUE)] going to label [user.p_them()]self as a suicide!</span>")
	labels_left = max(labels_left - 1, 0)

	var/old_real_name = user.real_name
	user.real_name += " (суицид)"
	// no conflicts with their identification card
	for(var/atom/A in user.GetAllContents())
		if(istype(A, /obj/item/card/id))
			var/obj/item/card/id/their_card = A

			// only renames their card, as opposed to tagging everyone's
			if(their_card.registered_name != old_real_name)
				continue

			their_card.registered_name = user.real_name
			their_card.update_label()

	// NOT EVEN DEATH WILL TAKE AWAY THE STAIN
	user.mind.name += " (суицид)"

	mode = 1
	icon_state = "labeler[mode]"
	label = "суицид"

	return OXYLOSS

/obj/item/hand_labeler/afterattack(atom/A, mob/user,proximity)
	. = ..()
	if(!proximity)
		return
	if(!mode)	//if it's off, give up.
		return

	if(!labels_left)
		to_chat(user, "<span class='warning'>Ярлыки закончились!</span>")
		return
	if(!label || !length(label))
		to_chat(user, "<span class='warning'>Не выбран текст!</span>")
		return
	if(length(A.name) + length(label) > 64)
		to_chat(user, "<span class='warning'>Текст слишком большой!</span>")
		return
	if(ismob(A))
		to_chat(user, "<span class='warning'>Как я этим буду помечать то! <i>Хотя, ручкой получится точно.</i></span>") // use a collar
		return

	user.visible_message("<span class='notice'><b>[user]</b> помечает <b>[A]</b> ярлыком \"[label]\".</span>", \
						 "<span class='notice'>Помечаю <b>[A]</b> ярлыком \"[label]\".</span>")
	A.AddComponent(/datum/component/label, label)
	playsound(A, 'sound/items/handling/component_pickup.ogg', 20, TRUE)
	labels_left--


/obj/item/hand_labeler/attack_self(mob/user)
	if(!user.IsAdvancedToolUser())
		to_chat(user, "<span class='warning'>Как этим пользоваться то!</span>")
		return
	mode = !mode
	icon_state = "labeler[mode]"
	if(mode)
		to_chat(user, "<span class='notice'>Включаю <b>[src]</b>.</span>")
		//Now let them chose the text.
		var/str = reject_bad_text(stripped_input(user, "Текст?", "Метка","", MAX_NAME_LEN), ascii_only = FALSE)
		if(!str || !length(str))
			to_chat(user, "<span class='warning'>Неправильный текст!</span>")
			return
		label = str
		to_chat(user, "<span class='notice'>Выбираю метку '[str]'.</span>")
	else
		to_chat(user, "<span class='notice'>Выключаю <b>[src]</b>.</span>")

/obj/item/hand_labeler/attackby(obj/item/I, mob/user, params)
	..()
	if(istype(I, /obj/item/hand_labeler_refill))
		to_chat(user, "<span class='notice'>Вставляю <b>[I]</b> в <b>[src]</b>.</span>")
		qdel(I)
		labels_left = initial(labels_left)	//Yes, it's capped at its initial value

/obj/item/hand_labeler/borg
	name = "этикетировщик киборга"

/obj/item/hand_labeler/borg/afterattack(atom/A, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(!iscyborg(user))
		return

	var/mob/living/silicon/robot/borgy = user

	var/starting_labels = initial(labels_left)
	var/diff = starting_labels - labels_left
	if(diff)
		labels_left = starting_labels
		// 50 per label. Magical cyborg paper doesn't come cheap.
		var/cost = diff * 50

		// If the cyborg manages to use a module without a cell, they get the paper
		// for free.
		if(borgy.cell)
			borgy.cell.use(cost)

/obj/item/hand_labeler_refill
	name = "рулон ярлыков для этикетировщика"
	icon = 'icons/obj/bureaucracy.dmi'
	desc = "Используйте его на ручном этикетировщике, чтобы наполнить его."
	icon_state = "labeler_refill"
	inhand_icon_state = "electropack"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
