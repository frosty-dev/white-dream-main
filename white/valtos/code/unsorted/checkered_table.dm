// Shitcode

/obj/item/checkers_kit
	name = "шахматное поле"
	desc = "Сделано из блюспейс зубов."
	icon = 'white/valtos/icons/game_kit.dmi'
	icon_state = "chess"
	w_class = WEIGHT_CLASS_BULKY
	force = 7

/obj/item/checkers_kit/attack_self(mob/user)
	visible_message("<span class='warning'><b>[user]</b> разворачивает огромную доску!</span>")
	new /obj/checkered_table(get_turf(src))
	qdel(src)

/obj/checkered_table
	name = "шахматное поле"
	desc = "Крутое."
	icon = 'white/valtos/icons/checkers.dmi'
	icon_state = "table"
	anchored = TRUE
	pixel_x = -44
	pixel_y = -32
	appearance_flags = KEEP_TOGETHER
	var/table_grid[8][8]
	var/list/table_pool_left = list()
	var/list/table_pool_right = list()
	var/table_step = 12
	var/image/piece_active

/obj/checkered_table/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-клик для сброса поля к изначальному варианту.</span>"
	. += "<span class='notice'>Ctrl-Shift-клик по доске, чтобы её свернуть.</span>"
	. += "<span class='notice'>Ctrl-клик по шашке, чтобы её перевернуть.</span>"

/obj/checkered_table/Initialize()
	..()
	reset_table()
	setup_checkers()
	RegisterSignal(src, COMSIG_CLICK, .proc/table_click)
	RegisterSignal(src, COMSIG_CLICK_CTRL, .proc/table_click)
	RegisterSignal(src, COMSIG_CLICK_CTRL_SHIFT, .proc/table_click)

/obj/checkered_table/attack_paw(mob/user)
	return attack_hand(user)

/obj/checkered_table/proc/reset_table()
	overlays = null
	for(var/_x in 1 to 8)
		for(var/_y in 1 to 8)
			table_grid[_x][_y] = null
			table_pool_left.Cut()
			table_pool_right.Cut()

/obj/checkered_table/proc/setup_checkers()
	set_piece_on_table(1, 1, "white")
	set_piece_on_table(3, 1, "white")
	set_piece_on_table(5, 1, "white")
	set_piece_on_table(7, 1, "white")

	set_piece_on_table(2, 2, "white")
	set_piece_on_table(4, 2, "white")
	set_piece_on_table(6, 2, "white")
	set_piece_on_table(8, 2, "white")

	set_piece_on_table(1, 3, "white")
	set_piece_on_table(3, 3, "white")
	set_piece_on_table(5, 3, "white")
	set_piece_on_table(7, 3, "white")

	set_piece_on_table(2, 6, "black")
	set_piece_on_table(4, 6, "black")
	set_piece_on_table(6, 6, "black")
	set_piece_on_table(8, 6, "black")

	set_piece_on_table(1, 7, "black")
	set_piece_on_table(3, 7, "black")
	set_piece_on_table(5, 7, "black")
	set_piece_on_table(7, 7, "black")

	set_piece_on_table(2, 8, "black")
	set_piece_on_table(4, 8, "black")
	set_piece_on_table(6, 8, "black")
	set_piece_on_table(8, 8, "black")

/obj/checkered_table/proc/set_piece_on_table(_x, _y, piece_type)
	var/image/I = image('white/valtos/icons/piece.dmi', piece_type)
	I.pixel_x = (_x * table_step + 12) - table_step
	I.pixel_y = (_y * table_step) - table_step
	I.name = piece_type
	table_grid[_x][_y] = I
	overlays += I

/obj/checkered_table/proc/set_piece_on_pool(piece_type)
	var/image/I = image('white/valtos/icons/piece.dmi', piece_type)
	I.name = piece_type
	if(piece_type == "white")
		I.pixel_x = 0
		I.pixel_y = table_pool_left.len * 8
		table_pool_left += I
		overlays += I
	if(piece_type == "black")
		I.pixel_x = 108
		I.pixel_y = table_pool_right.len * 8
		table_pool_right += I
		overlays += I

/obj/checkered_table/proc/activate_piece_from_pool(piece_type)
	if(piece_type == "white")
		piece_active = table_pool_left[table_pool_left.len]
		overlays -= piece_active
		piece_active.icon_state = "[piece_active.icon_state]_picked"
		overlays += piece_active
	if(piece_type == "black")
		piece_active = table_pool_right[table_pool_right.len]
		overlays -= piece_active
		piece_active.icon_state = "[piece_active.icon_state]_picked"
		overlays += piece_active

/obj/checkered_table/proc/remove_piece_from_pool(piece_type)
	overlays -= piece_active
	if(piece_type == "white")
		table_pool_left.Cut(table_pool_left.len)
	if(piece_type == "black")
		table_pool_right.Cut(table_pool_right.len)

/obj/checkered_table/proc/remove_piece_from_table(image/piece)
	if(piece.pixel_x  == 0 || piece.pixel_x == 108)
		remove_piece_from_pool(piece.name)
		return
	overlays -= piece
	var/_x = FLOOR(((piece.pixel_x / table_step)), 1)
	var/_y = FLOOR(((piece.pixel_y / table_step) + 1), 1)
	table_grid[_x][_y] = null

/obj/checkered_table/proc/get_letter(n)
	var/list/nwords = list("A", "B", "C", "D", "E", "F", "G", "H")
	return nwords[n]

/obj/checkered_table/proc/table_click(datum/source, location, control, params, mob/user)
	if(!isliving(user))
		return

	var/list/PR = params2list(params)

	if(PR["alt"])
		reset_table()
		setup_checkers()
		visible_message("<span class='warning'><b>[user]</b> сбрасывает доску к началу.</span>")
		return

	if(PR["ctrl"] && PR["shift"])
		reset_table()
		visible_message("<span class='warning'><b>[user]</b> сворачивает доску.</span>")
		new /obj/item/checkers_kit(get_turf(src))
		qdel(src)
		return

	var/_x_clicked = text2num(PR["icon-x"])
	var/_y_clicked = text2num(PR["icon-y"])

	if(_x_clicked < 12 || _x_clicked > 108)
		if(piece_active)
			remove_piece_from_table(piece_active)
			set_piece_on_pool(piece_active.name)
			piece_active = null
		else
			if(_x_clicked < 12)
				activate_piece_from_pool("white")

			else if (_x_clicked > 108)
				activate_piece_from_pool("black")

		return

	var/_x = FLOOR(_x_clicked/table_step, 1)
	var/_y = FLOOR((_y_clicked + 12)/table_step, 1)

	var/image/clicked_piece = table_grid[_x][_y]

	if(!piece_active && clicked_piece)
		overlays -= clicked_piece
		clicked_piece.icon_state = "[clicked_piece.icon_state]_picked"
		overlays += clicked_piece
		piece_active = clicked_piece
		playsound(src.loc, 'white/valtos/sounds/checkers/capture.wav', 50)
		visible_message("<span class='notice'><b>[user]</b> поднимает шашку в квадрате <b>[get_letter(_y)][_x]</b>.</span>")
	else if (piece_active && clicked_piece)
		overlays -= piece_active
		piece_active.icon_state = "[piece_active.name]"
		overlays += piece_active
		piece_active = null
		playsound(src.loc, 'white/valtos/sounds/checkers/capture.wav', 50)
		visible_message("<span class='notice'><b>[user]</b> ставит шашку на место.</span>")
	else if (clicked_piece && PR["ctrl"])
		overlays -= clicked_piece
		clicked_piece.icon_state = "[piece_active.name]"
		if(clicked_piece.icon == 'white/valtos/icons/piece.dmi')
			clicked_piece.icon = 'white/valtos/icons/masterpiece.dmi'
		else
			clicked_piece.icon = 'white/valtos/icons/piece.dmi'
		overlays += clicked_piece
		playsound(src.loc, 'white/valtos/sounds/checkers/capture.wav', 50)
		visible_message("<span class='notice'><b>[user]</b> переворачивает шашку в квадрате <b>[get_letter(_y)][_x]</b>.</span>")
	else if (piece_active && !clicked_piece)
		remove_piece_from_table(piece_active)
		overlays -= piece_active
		piece_active.icon_state = "[piece_active.name]"
		set_piece_on_table(_x, _y, piece_active.icon_state)
		piece_active = null
		playsound(src.loc, 'white/valtos/sounds/checkers/move.wav', 50)
		visible_message("<span class='notice'><b>[user]</b> переносит шашку в квадрат <b>[get_letter(_y)][_x]</b>.</span>")
