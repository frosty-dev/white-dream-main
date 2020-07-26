/obj/item/clothing/mask/balaclava
	name = "балаклава"
	desc = "LOADSAMONEY"
	icon_state = "balaclava"
	inhand_icon_state = "balaclava"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR
	w_class = WEIGHT_CLASS_SMALL
	actions_types = list(/datum/action/item_action/adjust)

/obj/item/clothing/mask/balaclava/attack_self(mob/user)
	adjustmask(user)

/obj/item/clothing/mask/infiltrator
	name = "балаклава разведчика"
	desc = "Слишком палевная маска для маскировки. Тем не менее, некоторые задачи она может решать."
	icon_state = "syndicate_balaclava"
	inhand_icon_state = "syndicate_balaclava"
	clothing_flags = MASKINTERNALS
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR
	w_class = WEIGHT_CLASS_SMALL
	armor = list("melee" = 10, "bullet" = 5, "laser" = 5,"energy" = 5, "bomb" = 0, "bio" = 0, "rad" = 10, "fire" = 100, "acid" = 40)
	resistance_flags = FIRE_PROOF | ACID_PROOF

	var/voice_unknown = FALSE ///This makes it so that your name shows up as unknown when wearing the mask.

/obj/item/clothing/mask/infiltrator/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_MASK)
		return
	to_chat(user, "Натягиваю балаклаву на лицо, и перед глазами появляется отображение данных.")
	ADD_TRAIT(user, TRAIT_DIAGNOSTIC_HUD, MASK_TRAIT)
	var/datum/atom_hud/H = GLOB.huds[DATA_HUD_DIAGNOSTIC_BASIC]
	H.add_hud_to(user)
	voice_unknown = TRUE

/obj/item/clothing/mask/infiltrator/dropped(mob/living/carbon/human/user)
	to_chat(user, "Снимаю балаклаву, и внутренняя система маски тихо отключается.")
	REMOVE_TRAIT(user, TRAIT_DIAGNOSTIC_HUD, MASK_TRAIT)
	var/datum/atom_hud/H = GLOB.huds[DATA_HUD_DIAGNOSTIC_BASIC]
	H.remove_hud_from(user)
	voice_unknown = FALSE
	return ..()

/obj/item/clothing/mask/luchador
	name = "маска Лучадора"
	desc = "Носится сильными бойцами, летающими высоко, чтобы победить своих врагов!"
	icon_state = "luchag"
	inhand_icon_state = "luchag"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	w_class = WEIGHT_CLASS_SMALL
	modifies_speech = TRUE

/obj/item/clothing/mask/luchador/handle_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = replacetext_char(message, "капитан", "CAPITÁN")
		message = replacetext_char(message, "станция", "ESTACIÓN")
		message = replacetext_char(message, "сир", "SEÑOR")
		message = replacetext_char(message, "это ", "el ")
		message = replacetext_char(message, "мой ", "mi ")
		message = replacetext_char(message, "так ", "es ")
		message = replacetext_char(message, "такое", "es")
		message = replacetext_char(message, "друг", "amigo")
		message = replacetext_char(message, "братан", "amigo")
		message = replacetext_char(message, "привет", "hola")
		message = replacetext_char(message, " горячий", " caliente")
		message = replacetext_char(message, " очень ", " muy ")
		message = replacetext_char(message, "меч", "espada")
		message = replacetext_char(message, "библиотека", "biblioteca")
		message = replacetext_char(message, "предатель", "traidor")
		message = replacetext_char(message, "маг", "mago")
		message = r_uppertext(message)	//Things end up looking better this way (no mixed cases), and it fits the macho wrestler image.
		if(prob(25))
			message += " OLE!"
	speech_args[SPEECH_MESSAGE] = message

/obj/item/clothing/mask/luchador/tecnicos
	name = "маска Техникоса"
	desc = "Носится сильными бойцами, которые отстаивают справедливость и честно сражаются."
	icon_state = "luchador"
	inhand_icon_state = "luchador"

/obj/item/clothing/mask/luchador/rudos
	name = "маска Рудоса"
	desc = "Носят надежные бойцы, которые готовы сделать все, чтобы победить."
	icon_state = "luchar"
	inhand_icon_state = "luchar"

/obj/item/clothing/mask/russian_balaclava
	name = "русская балаклава"
	desc = "Защищает лицо от чрезвычайно опасных вспышек фотокамер."
	icon_state = "rus_balaclava"
	inhand_icon_state = "rus_balaclava"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR
	w_class = WEIGHT_CLASS_SMALL
