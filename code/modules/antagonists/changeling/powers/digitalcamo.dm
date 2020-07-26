/datum/action/changeling/digitalcamo
	name = "Цифровой камуфляж"
	desc = "Развивая способность искажать нашу форму и пропорции, мы побеждаем общие алгоритмы, используемые для обнаружения форм жизни на камерах."
	helptext = "Мы не можем быть отслежены камерой или замечены ИИ юнитами при использовании этого навыка. Однако люди, смотрящие на нас, найдут нас... странными."
	button_icon_state = "digital_camo"
	dna_cost = 1
	active = FALSE

//Prevents AIs tracking you but makes you easily detectable to the human-eye.
/datum/action/changeling/digitalcamo/sting_action(mob/user)
	..()
	if(active)
		to_chat(user, "<span class='notice'>Мы возвращаемся к норме.</span>")
		user.RemoveElement(/datum/element/digitalcamo)
	else
		to_chat(user, "<span class='notice'>Мы искажаем нашу форму, чтобы скрыться от ИИ.</span>")
		user.AddElement(/datum/element/digitalcamo)
	active = !active
	return TRUE

/datum/action/changeling/digitalcamo/Remove(mob/user)
	user.RemoveElement(/datum/element/digitalcamo)
	..()
