#define SPAWN_WITH_FULL_CELL 2
#define SPAWN_WITH_DEAD_CELL 1
#define SPAWN_WITH_NO_CELL 0


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//		   Поскольку e_cost у большинства ammo_casing'ов исчисляется в сотнях, а заряд обычной батарейки		  //
//	из РнД - в 1000, рекомендуется использовать в качестве дефолтной батарейки /obj/item/stock_parts/cell/high,	  //
//		а e_cost увеличивать на десять, чтобы не получить еган на 1000 выстрелов без перезарядки.				  //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/obj/item/gun/energy/cellgun
	selfcharge = FALSE												//set to true to see the world burn
	ammo_type = list(/obj/item/ammo_casing/energy{e_cost = 1000 })	//при наличии более одного ammo_type вытащить батарею, нажав Z (use-item verb) не получится.
	cell_type = /obj/item/stock_parts/cell/high						//будет использована эта батарейка при SPAWN_WITH_FULL_CELL или SPAWN_WITH_DEAD_CELL.
	cell = null														//не трогать, батареи спавнятся строго в Initialize()
	shaded_charge = FALSE 											//оверлеи, отображающие уровень заряда. (см. energy.dm)
	var/spawn_with_cell = SPAWN_WITH_FULL_CELL
	var/accepts_any_cell = TRUE										//можно ли стрелять с пульсача и мизинчиковой батарейки
	var/load_sound = 'sound/weapons/gun/general/magazine_insert_empty.ogg'
	var/load_sound_volume = 40
	var/load_sound_vary = TRUE
	var/tac_reloads = TRUE											//можно ли заменить батарею, кликнув по оружию другой батареей
	var/show_charge_meter = TRUE									//показывать ли заряд вставленной батареи при экзамайне оружия
	var/can_eject = TRUE											//:thinking:

/obj/item/gun/energy/cellgun/Initialize()
	. = ..()
	if(spawn_with_cell)
		cell = new cell_type(src)
		if(spawn_with_cell == SPAWN_WITH_FULL_CELL)
			cell.give(cell.maxcharge)


	update_ammo_types()
	recharge_newshot(TRUE)

	if(selfcharge)					//понятия не имею, как этот цирк будет работать с selfcharge, но на всякий случай выпиливать не буду.
		START_PROCESSING(SSobj, src)
	update_icon()

/obj/item/gun/energy/cellgun/examine()
	. = ..()
	if(show_charge_meter)
		if(cell)
			.+= "Батарея заряжена на [round(cell.percent() )]%."
		else
			.+= "Батарея отсутствует."

/obj/item/gun/energy/cellgun/proc/insert_cell(mob/user, display_message = TRUE, obj/item/stock_parts/cell/BAT)
	/*if(!istype(BAT, obj/item/stock_parts/cell))
		to_chat(user, "<span class='warning'>[BAT.name] не батарея!</span>")
		return FALSE
	*/
	if(!accepts_any_cell && !istype(BAT, cell_type))
		to_chat(user, "<span class='warning'>[BAT] не вставляется в <b>[src]!</b></span>")
		return FALSE
	if(user.transferItemToLoc(BAT, src))
		cell = BAT
		if (display_message)
			to_chat(user, "<span class='notice'>Вставляю [BAT] в <b>[src]</b>.</span>")
		playsound(src, load_sound, load_sound_volume, load_sound_vary)
		update_icon()
		return TRUE
	else
		to_chat(user, "<span class='warning'>Не могу убрать <b>[src]</b> из своей руки!</span>")
		return FALSE


/obj/item/gun/energy/cellgun/proc/eject_cell(mob/user, display_message = TRUE, obj/item/stock_parts/cell/tac_load = null)
	playsound(src, load_sound, load_sound_volume, load_sound_vary)
	var/obj/item/stock_parts/cell/old_cell = cell //чтобы было что положить в руки после TaCtIcAl ReLoAdS
	old_cell.forceMove(drop_location())
	old_cell.update_icon()
	if(tac_load)
		if (insert_cell(user, FALSE, tac_load))
			to_chat(user, "<span class='notice'>Произвожу тактическую перезарядку <b>[src]</b>.</span>")
	else
		cell = null
	user.put_in_hands(old_cell)
	if (display_message)
		to_chat(user, "<span class='notice'>Вытаскиваю [old_cell] из <b>[src]</b>.</span>")
	update_icon()

/obj/item/gun/energy/cellgun/update_icon(force_update)
	if(QDELETED(src))
		return
	//..() //не дай бог это всё сломает нахуй
	var/ratio
	if(!automatic_charge_overlays)
		return
	if(cell) //prevents nullpointer exceptions
		ratio = CEILING(clamp(cell.charge / cell.maxcharge, 0, 1) * charge_sections, 1)
	else
		ratio = 0
	cut_overlays()
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]
	var/iconState = "[icon_state]_charge"
	var/itemState = null
	if(!initial(inhand_icon_state))
		itemState = icon_state
	if (modifystate)
		add_overlay("[icon_state]_[shot.select_name]")
		iconState += "_[shot.select_name]"
		if(itemState)
			itemState += "[shot.select_name]"
	if(cell.charge < shot.e_cost)
		add_overlay("[icon_state]_empty")
	else
		if(!shaded_charge)
			var/mutable_appearance/charge_overlay = mutable_appearance(icon, iconState)
			for(var/i = ratio, i >= 1, i--)
				charge_overlay.pixel_x = ammo_x_offset * (i - 1)
				charge_overlay.pixel_y = ammo_y_offset * (i - 1)
				add_overlay(charge_overlay)
		else
			add_overlay("[icon_state]_charge[ratio]")
	if(itemState)
		itemState += "[ratio]"
		inhand_icon_state = itemState


/obj/item/gun/energy/cellgun/attackby(obj/item/A, mob/user, params)
	. = ..()
	if (.)
		return
	if (istype(A, /obj/item/stock_parts/cell))
		var/obj/item/stock_parts/cell/BAT = A
		if (!cell)
			insert_cell(user, TRUE, BAT)
		else
			if(tac_reloads)
				eject_cell(user, FALSE, BAT)
			else
				to_chat(user, "<span class='notice'>В <b>[src]</b> уже вставлена <b>[cell]</b>.</span>")
		return
	else
		to_chat(user, "<span class='warning'><b>[A.name]</b> не вставляется в <b>[src]</b>!</span>")
		return

	//можно запилить модификации для лазеров типа увеличения скорострельности, дамага и прочая поебень из какой-нибуть статодрочерской ммо
	//да хоть замена лазеров на obj/projectile/leather_bullet

	/*
	if(istype(A, /obj/item/suppressor))
		var/obj/item/suppressor/S = A
		if(!can_suppress)
			to_chat(user, "<span class='warning'>Ты без понятия как приделать [S.name] к <b>[src.name]</b>!</span>")
			return
		if(!user.is_holding(src))
			to_chat(user, "<span class='warning'>Нужно держать в руках <b>[src.name]</b>, чтобы приделать [S.name]!</span>")
			return
		if(suppressed)
			to_chat(user, "<span class='warning'><b>[src.name]</b> уже имеет глушитель!</span>")
			return
		if(user.transferItemToLoc(A, src))
			to_chat(user, "<span class='notice'>Ты прикрутил [S.name] к <b>[src.name]</b>.</span>")
			install_suppressor(A)
			return
	*/

/obj/item/gun/energy/cellgun/attack_self(mob/living/user)
	if(ammo_type.len > 1)
		select_fire(user)
		update_icon()
		return

	if(cell)
		eject_cell(user)
		return

/obj/item/gun/energy/cellgun/attack_hand(mob/user)
	if( loc == user && user.is_holding(src) && cell)
		eject_cell(user)
		return
	return ..()


/obj/item/gun/energy/cellgun/dead
	spawn_with_cell = SPAWN_WITH_DEAD_CELL

/obj/item/gun/energy/cellgun/nocell
	spawn_with_cell = SPAWN_WITH_NO_CELL
