/obj/item/clothing/mask/tape
	name = "лента"
	desc = "Будет больно отрывать это."
	icon = 'white/valtos/icons/clothing/masks.dmi'
	worn_icon = 'white/valtos/icons/clothing/mob/mask.dmi'
	icon_state = "tape"
	flags_cover = MASKCOVERSMOUTH
	w_class = WEIGHT_CLASS_SMALL
	gas_transfer_coefficient = 0.90
	strip_delay = 10
	modifies_speech = TRUE
	var/used = FALSE

/obj/item/clothing/mask/tape/attack_hand(mob/user as mob)
	if (!user) return
	if (istype(src.loc, /obj/item/storage))
		return ..()
	var/mob/living/carbon/human/H = user
	if(loc == user && H.wear_mask == src)
		to_chat(H, "<span class='userdanger'>Лента срывается с моего лица. Это было не самое приятное ощущение.</span>")
		playsound(user, 'white/valtos/sounds/ducttape2.ogg', 50, 1)
		H.apply_damage(2, BRUTE, "head")
		user.emote("scream")
		user.dropItemToGround(user.get_active_held_item())
		used = TRUE
		qdel(src)
	else
		..()

/obj/item/clothing/mask/tape/dropped(mob/user as mob)
	if (!user) return
	if (istype(src.loc, /obj/item/storage) || used)
		return ..()
	var/mob/living/carbon/human/H = user
	..()
	if(H.wear_mask == src && !used)
		to_chat(H, "<span class='userdanger'>Лента срывается с моего лица. Это было не самое приятное ощущение..</span>")
		playsound(user, 'white/valtos/sounds/ducttape2.ogg', 50, 1)
		H.apply_damage(2, BRUTE, "head")
		user.dropItemToGround(user.get_active_held_item())
		user.emote("scream")
		qdel(src)

/obj/item/clothing/mask/tape/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_MESSAGE] = muffledspeech(speech_args[SPEECH_MESSAGE])

/proc/muffledspeech(phrase)
	phrase = html_decode(phrase)
	var/leng=length(phrase)
	var/counter=length(phrase)
	var/newphrase=""
	var/newletter=""
	var/is_upper = FALSE
	while(counter>=1)
		newletter=copytext(phrase,(leng-counter)+1,(leng-counter)+2)
		is_upper = FALSE
		if(uppertext(newletter) == newletter)
			is_upper = TRUE
		else if(lowertext(newletter) == newletter)
			is_upper = FALSE

		if(newletter in list(" ", "!", "?", ".", ","))
			//do nothing
		else if(lowertext(newletter) in list("а", "е", "и", "о", "у", "ю"))
			if(is_upper)
				newletter = "ПФ"
			else
				newletter = "пф"
		else
			if(is_upper)
				newletter = "М"
			else
				newletter = "м"
		newphrase+="[newletter]"
		counter-=1
	return newphrase
