/datum/emote/living/snort
	key = "snort"
	key_third_person = "snorts"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/snort/run_emote(mob/user, params)
	. = ..()
	playsound(user, 'white/baldenysh/sounds/snort.ogg', 50, 1)

/datum/emote/living/carbon/human/rsalute
	key = "rsalute"
	key_third_person = "salutes"
	message = "выполняет римский салют."
	message_param = "приветствует %t по-римски."
	restraint_check = TRUE
