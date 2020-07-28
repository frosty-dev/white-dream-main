/obj/item/clothing/mask/breath
	desc = "Плотно прилегающая маска, которая может быть подключена к источнику воздуха."
	name = "дыхательная маска"
	icon_state = "breath"
	inhand_icon_state = "m_mask"
	body_parts_covered = 0
	clothing_flags = MASKINTERNALS
	visor_flags = MASKINTERNALS
	w_class = WEIGHT_CLASS_SMALL
	gas_transfer_coefficient = 0.1
	permeability_coefficient = 0.5
	actions_types = list(/datum/action/item_action/adjust)
	flags_cover = MASKCOVERSMOUTH
	visor_flags_cover = MASKCOVERSMOUTH
	resistance_flags = NONE

/obj/item/clothing/mask/breath/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] is wrapping \the [src.name]'s tube around [user.p_their()] neck! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return OXYLOSS

/obj/item/clothing/mask/breath/attack_self(mob/user)
	adjustmask(user)

/obj/item/clothing/mask/breath/AltClick(mob/user)
	..()
	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	else
		adjustmask(user)

/obj/item/clothing/mask/breath/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-клик [src.name] для настройки.</span>"

/obj/item/clothing/mask/breath/medical
	desc = "Обтягивающая стерильная маска, которая может быть подключена к источнику воздуха."
	name = "медицинская дыхательная маска"
	icon_state = "medical"
	inhand_icon_state = "m_mask"
	permeability_coefficient = 0.01
	equip_delay_other = 10
