/mob/dead/observer
	var/old_icon
	var/old_icon_state

/mob/dead/observer/proc/swap_icons()
	if(old_icon)
		var/swap

		swap = icon
		icon = old_icon
		old_icon = swap

		swap = icon_state
		icon_state = old_icon_state
		old_icon_state = swap

		if(icon_state == "ghost")
			var/datum/sprite_accessory/S
			if(facial_hairstyle)
				S = GLOB.facial_hairstyles_list[facial_hairstyle]
				if(S)
					facial_hair_overlay = mutable_appearance(S.icon, "[S.icon_state]", -HAIR_LAYER)
					if(facial_hair_color)
						facial_hair_overlay.color = "#" + facial_hair_color
					facial_hair_overlay.alpha = 200
					add_overlay(facial_hair_overlay)
			if(hairstyle)
				S = GLOB.hairstyles_list[hairstyle]
				if(S)
					hair_overlay = mutable_appearance(S.icon, "[S.icon_state]", -HAIR_LAYER)
					if(hair_color)
						hair_overlay.color = "#" + hair_color
					hair_overlay.alpha = 200
					add_overlay(hair_overlay)
		else
			if(hair_overlay)
				cut_overlay(hair_overlay)
				hair_overlay = null

			if(facial_hair_overlay)
				cut_overlay(facial_hair_overlay)
				facial_hair_overlay = null

		updatedir = 1

	else
		if(fexists("data/custom_ghosts/[ckey].dmi"))
			old_icon = file("data/custom_ghosts/[ckey].dmi")
			old_icon_state = ckey

			swap_icons()

/mob/dead/observer/verb/custom_ghost_form()
	set name = "#️⃣ Кастомный Спрайт Призрака"
	set category = "Настройки"
	set desc = "Customize your ghastly appearance."

	if(fexists("data/custom_ghosts/[ckey].dmi"))
		swap_icons()
	else
		to_chat(src,"<span class='warning'>Кастомный спрайт не найден.</span>")
