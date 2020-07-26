/obj/item/clothing/shoes/magboots
	desc = "Магнитные ботинки, часто используемые во время экстравагантных действий, чтобы гарантировать, что пользователь остается надежно прикрепленным к транспортному средству."
	name = "магнитки"
	icon_state = "magboots0"
	var/magboot_state = "magboots"
	var/magpulse = 0
	var/slowdown_active = 2
	permeability_coefficient = 0.05
	actions_types = list(/datum/action/item_action/toggle)
	strip_delay = 70
	equip_delay_other = 70
	resistance_flags = FIRE_PROOF

/obj/item/clothing/shoes/magboots/verb/toggle()
	set name = "Toggle Magboots"
	set category = "Объект"
	set src in usr
	if(!can_use(usr))
		return
	attack_self(usr)


/obj/item/clothing/shoes/magboots/attack_self(mob/user)
	if(magpulse)
		clothing_flags &= ~NOSLIP
		slowdown = SHOES_SLOWDOWN
	else
		clothing_flags |= NOSLIP
		slowdown = slowdown_active
	magpulse = !magpulse
	icon_state = "[magboot_state][magpulse]"
	to_chat(user, "<span class='notice'>Переключаю магниты в состояние [magpulse ? "вкл" : "выкл"].</span>")
	user.update_inv_shoes()	//so our mob-overlays update
	user.update_gravity(user.has_gravity())
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/clothing/shoes/magboots/negates_gravity()
	return clothing_flags & NOSLIP

/obj/item/clothing/shoes/magboots/examine(mob/user)
	. = ..()
	. += "Они [magpulse ? "включены" : "выключены"]."


/obj/item/clothing/shoes/magboots/advance
	desc = "Усовершенствованные магнитные ботинки, которые имеют более легкое магнитное притяжение, уменьшая нагрузку на пользователя."
	name = "продвинутые магнитки"
	icon_state = "advmag0"
	magboot_state = "advmag"
	slowdown_active = SHOES_SLOWDOWN
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/clothing/shoes/magboots/syndie
	desc = "Магнитные сапоги с обратной конструкцией, которые имеют сильное магнитное притяжение. Собственность Горлекс Мародеров."
	name = "кроваво-красные магнитки"
	icon_state = "syndiemag0"
	magboot_state = "syndiemag"
