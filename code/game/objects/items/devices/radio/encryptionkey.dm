/obj/item/encryptionkey
	name = "стандартный ключ шифрования"
	desc = "Ключ шифрования радиогарнитуры."
	icon = 'icons/obj/radio.dmi'
	icon_state = "cypherkey"
	w_class = WEIGHT_CLASS_TINY
	var/translate_binary = FALSE
	var/syndie = FALSE
	var/independent = FALSE
	var/list/channels = list()

/obj/item/encryptionkey/Initialize()
	. = ..()
	if(!channels.len)
		desc = "Ключ шифрования радиогарнитуры. Никаких специальных кодов в нем нет. Вы, наверное, должны сказать кодеру!"

/obj/item/encryptionkey/examine(mob/user)
	. = ..()
	if(LAZYLEN(channels))
		var/list/examine_text_list = list()
		for(var/i in channels)
			examine_text_list += "[GLOB.channel_tokens[i]] - [lowertext(i)]"

		. += "<hr><span class='notice'>Имеет доступ к следующим каналам; [jointext(examine_text_list, ", ")].</span>"

/obj/item/encryptionkey/syndicate
	name = "ключ шифрования синдиката"
	icon_state = "syn_cypherkey"
	channels = list(RADIO_CHANNEL_SYNDICATE = 1)
	syndie = TRUE//Signifies that it de-crypts Syndicate transmissions

/obj/item/encryptionkey/binary
	name = "ключ бинарного транслятора"
	icon_state = "bin_cypherkey"
	translate_binary = TRUE

/obj/item/encryptionkey/headset_sec
	name = "ключ шифрования безопасности"
	icon_state = "sec_cypherkey"
	channels = list(RADIO_CHANNEL_SECURITY = 1)

/obj/item/encryptionkey/headset_eng
	name = "инженерный ключ шифрования"
	icon_state = "eng_cypherkey"
	channels = list(RADIO_CHANNEL_ENGINEERING = 1)

/obj/item/encryptionkey/headset_rob
	name = "ключ шифрования роботехников"
	icon_state = "rob_cypherkey"
	channels = list(RADIO_CHANNEL_SCIENCE = 1, RADIO_CHANNEL_ENGINEERING = 1)

/obj/item/encryptionkey/headset_med
	name = "ключ шифрования медбея"
	icon_state = "med_cypherkey"
	channels = list(RADIO_CHANNEL_MEDICAL = 1)

/obj/item/encryptionkey/headset_medsec
	name = "ключ шифрования медбея и охраны"
	icon_state = "med_cypherkey"
	channels = list(RADIO_CHANNEL_MEDICAL = 1, RADIO_CHANNEL_SECURITY = 1)

/obj/item/encryptionkey/headset_sci
	name = "ключ шифрования научного отдела"
	icon_state = "sci_cypherkey"
	channels = list(RADIO_CHANNEL_SCIENCE = 1)

/obj/item/encryptionkey/headset_medsci
	name = "ключ шифрования медбея и научки"
	icon_state = "medsci_cypherkey"
	channels = list(RADIO_CHANNEL_SCIENCE = 1, RADIO_CHANNEL_MEDICAL = 1)

/obj/item/encryptionkey/headset_srvsec
	name = "ключ шифрования закона и порядка"
	icon_state = "srvsec_cypherkey"
	channels = list(RADIO_CHANNEL_SERVICE = 1, RADIO_CHANNEL_SECURITY = 1)

/obj/item/encryptionkey/headset_srvmed
	name = "ключ шифрования психолога"
	icon_state = "srvmed_cypherkey"
	channels = list(RADIO_CHANNEL_MEDICAL = 1, RADIO_CHANNEL_SERVICE = 1)

/obj/item/encryptionkey/headset_com
	name = "ключ шифрования командования"
	icon_state = "com_cypherkey"
	channels = list(RADIO_CHANNEL_COMMAND = 1)

/obj/item/encryptionkey/heads/captain
	name = "ключ шифрования капитана"
	icon_state = "cap_cypherkey"
	channels = list(RADIO_CHANNEL_COMMAND = 1, RADIO_CHANNEL_SECURITY = 1, RADIO_CHANNEL_ENGINEERING = 0, RADIO_CHANNEL_SCIENCE = 0, RADIO_CHANNEL_MEDICAL = 0, RADIO_CHANNEL_SUPPLY = 0, RADIO_CHANNEL_SERVICE = 0, RADIO_CHANNEL_EXPLORATION = 0)

/obj/item/encryptionkey/heads/rd
	name = "ключ шифрования научного руководителя"
	icon_state = "rd_cypherkey"
	channels = list(RADIO_CHANNEL_SCIENCE = 1, RADIO_CHANNEL_COMMAND = 1)

/obj/item/encryptionkey/heads/hos
	name = "ключ шифрования начальника охраны"
	icon_state = "hos_cypherkey"
	channels = list(RADIO_CHANNEL_SECURITY = 1, RADIO_CHANNEL_COMMAND = 1)

/obj/item/encryptionkey/heads/ce
	name = "ключ шифрования старшего инженера"
	icon_state = "ce_cypherkey"
	channels = list(RADIO_CHANNEL_ENGINEERING = 1, RADIO_CHANNEL_COMMAND = 1)

/obj/item/encryptionkey/heads/cmo
	name = "ключ шифрования старшего медицинского офицера"
	icon_state = "cmo_cypherkey"
	channels = list(RADIO_CHANNEL_MEDICAL = 1, RADIO_CHANNEL_COMMAND = 1)

/obj/item/encryptionkey/heads/hop
	name = "ключ шифрования главы персонала"
	icon_state = "hop_cypherkey"
	channels = list(RADIO_CHANNEL_SUPPLY = 1, RADIO_CHANNEL_SERVICE = 1, RADIO_CHANNEL_COMMAND = 1)

/obj/item/encryptionkey/headset_cargo
	name = "ключ шифрования снабжения"
	icon_state = "cargo_cypherkey"
	channels = list(RADIO_CHANNEL_SUPPLY = 1)

/obj/item/encryptionkey/headset_mining
	name = "ключ шифрования шахтёров"
	icon_state = "cargo_cypherkey"
	channels = list(RADIO_CHANNEL_SUPPLY = 1, RADIO_CHANNEL_SCIENCE = 1)


/obj/item/encryptionkey/headset_exp
	name = "ключ шифрования рейнджеров"
	icon_state = "exp_cypherkey"
	channels = list(RADIO_CHANNEL_EXPLORATION = 1)

/obj/item/encryptionkey/headset_expteam
	name = "ключ шифрования команды рейнджеров"
	icon_state = "expteam_cypherkey"
	channels = list(RADIO_CHANNEL_EXPLORATION = 1, RADIO_CHANNEL_SCIENCE = 1)

/obj/item/encryptionkey/headset_curator
	name = "ключ шифрования куратора"
	icon_state = "srv_cypherkey"
	channels = list(RADIO_CHANNEL_SERVICE = 1, RADIO_CHANNEL_EXPLORATION = 1)

/obj/item/encryptionkey/headset_service
	name = "ключ шифрования сервиса"
	icon_state = "srv_cypherkey"
	channels = list(RADIO_CHANNEL_SERVICE = 1)

/obj/item/encryptionkey/headset_cent
	name = "ключ шифрования ЦК"
	icon_state = "cent_cypherkey"
	independent = TRUE
	channels = list(RADIO_CHANNEL_CENTCOM = 1)

/obj/item/encryptionkey/ai //ported from NT, this goes 'inside' the AI.
	channels = list(RADIO_CHANNEL_COMMAND = 1, RADIO_CHANNEL_SECURITY = 1, RADIO_CHANNEL_ENGINEERING = 1, RADIO_CHANNEL_SCIENCE = 1, RADIO_CHANNEL_MEDICAL = 1, RADIO_CHANNEL_SUPPLY = 1, RADIO_CHANNEL_SERVICE = 1, RADIO_CHANNEL_EXPLORATION = 1, RADIO_CHANNEL_AI_PRIVATE = 1)

/obj/item/encryptionkey/secbot
	channels = list(RADIO_CHANNEL_AI_PRIVATE = 1, RADIO_CHANNEL_SECURITY = 1)
