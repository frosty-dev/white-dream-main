/obj/item/export_scanner
	name = "сканер экспорта"
	desc = "Устройство, используемое для проверки объектов по экспорту и в базе данных НТ."
	icon = 'icons/obj/device.dmi'
	icon_state = "export_scanner"
	inhand_icon_state = "radio"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	siemens_coefficient = 1
	var/obj/machinery/computer/cargo/cargo_console = null

/obj/item/export_scanner/examine(user)
	. = ..()
	if(!cargo_console)
		. += "<span class='notice'>[src] не подключен к консоли снабжения.</span>"

/obj/item/export_scanner/afterattack(obj/O, mob/user, proximity)
	. = ..()
	if(!istype(O) || !proximity)
		return

	if(istype(O, /obj/machinery/computer/cargo))
		var/obj/machinery/computer/cargo/C = O
		if(!C.requestonly)
			cargo_console = C
			to_chat(user, "<span class='notice'>Сканер подключен к [C].</span>")
	else if(!istype(cargo_console))
		to_chat(user, "<span class='warning'>Вы должны подключить [src] к консоли снабжения сначала!</span>")
	else
		// Before you fix it:
		// yes, checking manifests is a part of intended functionality.

		var/datum/export_report/ex = export_item_and_contents(O, cargo_console.get_export_categories(), dry_run=TRUE)
		var/price = 0
		for(var/x in ex.total_amount)
			price += ex.total_value[x]

		if(price)
			to_chat(user, "<span class='notice'>Сканировано [O], цена: <b>[price]</b> кредитов[O.contents.len ? " (contents included)" : ""].</span>")
		else
			to_chat(user, "<span class='warning'>Сканировано [O], нет цены.</span>")
		if(bounty_ship_item_and_contents(O, dry_run=TRUE))
			to_chat(user, "<span class='notice'>Отсканированный объект является заказом ЦК.</span>")
