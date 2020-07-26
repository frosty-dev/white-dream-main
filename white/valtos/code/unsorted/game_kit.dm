/*
CONTAINS:
THAT STUPID GAME KIT

*/
/obj/item/game_kit
	name = "Игровой набор"
	icon = 'white/valtos/icons/game_kit.dmi'
	icon_state = "chess"
	var/selected = null
	var/board_stat = null
	var/data = ""
	//var/base_url = "http://svn.slurm.us/public/spacestation13/misc/game_kit"
	inhand_icon_state = "chess"
	w_class = WEIGHT_CLASS_NORMAL
	desc = "Шашки или шахматы? Да какая разница, всё равно в это никто не будет играть."

/obj/item/game_kit/Initialize()
	. = ..()
	board_stat = "CRBBCRBBCRBBCRBBBBCRBBCRBBCRBBCRCRBBCRBBCRBBCRBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBCBBBCBBBCBBBCBCBBBCBBBCBBBCBBBBBCBBBCBBBCBBBCB"
	selected = "CR"
	interaction_flags_item &= ~INTERACT_ITEM_ATTACK_HAND_PICKUP

/obj/item/game_kit/proc/update()
	var/dat = text("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><CENTER><B>Игровое поле</B></CENTER><BR><a href='?src=\ref[];mode=hia'>[]</a> <a href='?src=\ref[];mode=remove'>Х</a><HR><table width= 256  border= 0  height= 256  cellspacing= 0  cellpadding= 0 >", src, (src.selected ? text("Выбрано: []", src.selected) : "Ничего не выбрано"), src)
	for (var/y = 1 to 8)
		dat += "<tr>"

		for (var/x = 1 to 8)
			var/tilecolor = (y + x) % 2 ? "#999999" : "#ffffff"
			var/piece = copytext(src.board_stat, ((y - 1) * 8 + x) * 2 - 1, ((y - 1) * 8 + x) * 2 + 1)

			dat += "<td>"
			dat += "<td style='background-color:[tilecolor]' width=32 height=32>"
			if (piece != "BB")
				dat += "<a href='?src=\ref[src];s_board=[x] [y]'><img src='board_[piece].png' width=32 height=32 border=0>"
			else
				dat += "<a href='?src=\ref[src];s_board=[x] [y]'><img src='board_none.png' width=32 height=32 border=0>"
			dat += "</td>"

		dat += "</tr>"

	dat += "</table><HR><B>Шашки:</B><BR>"
	for (var/piece in list("CB", "CR"))
		dat += "<a href='?src=\ref[src];s_piece=[piece]'><img src='board_[piece].png' width=32 height=32 border=0></a>"

	dat += "<HR><B>Фигуры:</B><BR>"
	for (var/piece in list("WP", "WK", "WQ", "WI", "WN", "WR"))
		dat += "<a href='?src=\ref[src];s_piece=[piece]'><img src='board_[piece].png' width=32 height=32 border=0></a>"
	dat += "<br>"
	for (var/piece in list("BP", "BK", "BQ", "BI", "BN", "BR"))
		dat += "<a href='?src=\ref[src];s_piece=[piece]'><img src='board_[piece].png' width=32 height=32 border=0></a>"
	src.data = dat

/obj/item/game_kit/MouseDrop(atom/over_object)
	. = ..()
	var/mob/living/M = usr
	if(!istype(M) || M.incapacitated() || !Adjacent(M))
		return

	if(over_object == M)
		M.put_in_hands(src)

	else if(istype(over_object, /obj/screen/inventory/hand))
		var/obj/screen/inventory/hand/H = over_object
		M.putItemFromInventoryInHandIfPossible(src, H.held_index)

	add_fingerprint(M)

/obj/item/game_kit/attack_paw(mob/user)
	return attack_hand(user)

/obj/item/game_kit/attack_hand(mob/user)
	if(!isliving(user))
		return
	if (!(src.data))
		update()
	user.machine = src
	var/datum/asset/stuff = get_asset_datum(/datum/asset/simple/game_kit)
	stuff.send(user)
	user << browse(src.data, "window=game_kit;size=300x550")
	onclose(user, "game_kit")
	add_fingerprint(user)
	return ..()

/obj/item/game_kit/Topic(href, href_list)
	..()
	if ((usr.stat || usr.restrained()))
		return

	if (usr.contents.Find(src) || (in_range(src, usr) && istype(src.loc, /turf)))
		if (href_list["s_piece"])
			src.selected = href_list["s_piece"]
		else if (href_list["mode"])
			if (href_list["mode"] == "remove")
				src.selected = "удаление"
			else
				src.selected = null
		else if (href_list["s_board"])
			if (!( src.selected ))
				src.selected = href_list["s_board"]
			else
				var/tx = text2num(copytext(href_list["s_board"], 1, 2))
				var/ty = text2num(copytext(href_list["s_board"], 3, 4))
				if ((copytext(src.selected, 2, 3) == " " && length(src.selected) == 3))
					var/sx = text2num(copytext(src.selected, 1, 2))
					var/sy = text2num(copytext(src.selected, 3, 4))
					var/place = ((sy - 1) * 8 + sx) * 2 - 1
					src.selected = copytext(src.board_stat, place, place + 2)
					if (place == 1)
						src.board_stat = text("BB[]", copytext(src.board_stat, 3, 129))
					else
						if (place == 127)
							src.board_stat = text("[]BB", copytext(src.board_stat, 1, 127))
						else
							if (place)
								src.board_stat = text("[]BB[]", copytext(src.board_stat, 1, place), copytext(src.board_stat, place + 2, 129))
					place = ((ty - 1) * 8 + tx) * 2 - 1
					if (place == 1)
						src.board_stat = text("[][]", src.selected, copytext(src.board_stat, 3, 129))
					else
						if (place == 127)
							src.board_stat = text("[][]", copytext(src.board_stat, 1, 127), src.selected)
						else
							if (place)
								src.board_stat = text("[][][]", copytext(src.board_stat, 1, place), src.selected, copytext(src.board_stat, place + 2, 129))
					src.selected = null
				else
					if (src.selected == "удаление")
						var/place = ((ty - 1) * 8 + tx) * 2 - 1
						if (place == 1)
							src.board_stat = text("BB[]", copytext(src.board_stat, 3, 129))
						else
							if (place == 127)
								src.board_stat = text("[]BB", copytext(src.board_stat, 1, 127))
							else
								if (place)
									src.board_stat = text("[]BB[]", copytext(src.board_stat, 1, place), copytext(src.board_stat, place + 2, 129))
					else
						if (length(src.selected) == 2)
							var/place = ((ty - 1) * 8 + tx) * 2 - 1
							if (place == 1)
								src.board_stat = text("[][]", src.selected, copytext(src.board_stat, 3, 129))
							else
								if (place == 127)
									src.board_stat = text("[][]", copytext(src.board_stat, 1, 127), src.selected)
								else
									if (place)
										src.board_stat = text("[][][]", copytext(src.board_stat, 1, place), src.selected, copytext(src.board_stat, place + 2, 129))
		update()
		for(var/mob/M in viewers(1, src))
			if ((M.client && M.machine == src))
				src.attack_hand(M)
