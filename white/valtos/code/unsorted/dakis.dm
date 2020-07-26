
//////////////////////////////////
//dakimakuras
//////////////////////////////////

/obj/item/storage/daki
	name = "дакимакура"
	var/custom_name = null
	desc = "Большая подушка с изображением девушки в компрометирующей позе."
	icon = 'white/valtos/icons/daki.dmi'
	lefthand_file = 'white/valtos/icons/lefthand.dmi'
	righthand_file = 'white/valtos/icons/righthand.dmi'
	icon_state = "daki_base"
	slot_flags = ITEM_SLOT_BACK
	w_class = 4
	var/spam_flag = 0
	var/cooldowntime = 20

/obj/item/storage/daki/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 21
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_items = 3

/obj/item/storage/daki/attack_self(mob/living/user)
	var/body_choice
	if(icon_state == "daki_base")
		body_choice = input("Выбери же образ.") in list(
		"Callie",
		"Casca",
		"Chaika",
		"Elisabeth",
		"Foxy Grandpa",
		"Haruko",
		"Holo",
		"Hotwheels",
		"Ian",
		"Jolyne",
		"Kurisu", //Kurisu is the ideal girl." - Me, Logos.
		"Marie",
		"Mugi",
		"Nar'Sie",
		"Patchouli",
		"Plutia",
		"Rei",
		"Reisen",
		"Naga",
		"Squid",
		"Squigly",
		"Tomoko",
		"Toriel",
		"Umaru",
		"Yaranaika",
		"Yoko")

		icon_state = "daki_[body_choice]"
		custom_name = stripped_input(user, "Как её зовут?")
		if(length(custom_name) > MAX_NAME_LEN)
			to_chat(user, "<span class='danger'>Имя слишком длинное!</span>")
			return FALSE
		if(custom_name)
			name = custom_name + " " + name
			desc = "Большая подушка с изображением [custom_name] в компрометирующей позе."
	else
		if(!spam_flag)
			spam_flag = 1
			if(user.a_intent == "help")
				user.visible_message("<span class='notice'><b>[user]</b> обнимает <b>дакимакуру [custom_name]</b>.</span>")
				playsound(src.loc, "rustle", 50, 1, -5)
			if(user.a_intent == "disarm")
				user.visible_message("<span class='notice'><b>[user]</b>] целует <b>дакимакуру [custom_name]</b>.</span>")
				playsound(src.loc, "rustle", 50, 1, -5)
			if(user.a_intent == "grab")
				user.visible_message("<span class='warning'><b>[user]</b> вдерживает в <b>дакимакуру [custom_name]</b>!</span>")
				playsound(src.loc, 'sound/items/bikehorn.ogg', 50, 1)
			if(user.a_intent == "harm")
				user.visible_message("<span class='danger'><b>[user]</b> бьёт <b>дакимакуру [custom_name]</b>!</span>")
				playsound(user.loc, 'sound/effects/shieldbash.ogg', 50, 1)
			spawn(cooldowntime)
				spam_flag = 0

////////////////////////////

/datum/quirk/weeb
	name = "Виабушник"
	desc = "Аниме пожрало последние твои накопления и материализовалось в бесполезную подушку."
	value = 0
	mob_trait = "weeb"
	gain_text = "<span class='notice'>Я взял с собой дакимакуру. Сберечь её бы надо.</span>"
	lose_text = "<span class='danger'>Вайфу не актуальны. Так википедия сказал.</span>"
	medical_record_text = "Пациент испытывает тягу к анимешным персонажам."

/datum/quirk/weeb/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/storage/daki/P = new(get_turf(H))
	var/list/slots = list(
						"backpack" = ITEM_SLOT_BACKPACK,
						"hands" = ITEM_SLOT_HANDS,
						)
	H.equip_in_one_of_slots(P, slots, qdel_on_fail = FALSE)
