/obj/machinery/vending/terminal
	name = "Trading Terminal MK1"
	desc = "Вещи возврату не подлежат."
	icon = 'code/shitcode/valtos/icons/vending.dmi'
	icon_state = "trading"
	product_ads = "Лучшее только у нас!;Купи-купи-купи!"
	default_price = 500
	extra_price = 5000
	max_integrity = 300000
	var/last_rebuild = 0
	payment_department = NO_FREEBIES

/obj/machinery/vending/terminal/Initialize(mapload)
	. = ..()
	if (prob(25))
		qdel(src)
	last_rebuild = world.time + rand(300, 1000)
	rebuild_inventory(GLOB.terminal_products, product_records)

/obj/machinery/vending/terminal/proc/rebuild_inventory(list/productlist, list/recordlist)
	for(var/typepath in productlist)
		if (prob(80))
			if (prob(95))
				typepath = pick(subtypesof(/obj/item))
			var/amount = rand(1, 5)
			var/atom/temp = typepath
			if (initial(temp.icon_state) == null || initial(temp.icon) == null)
				continue
			var/datum/data/vending_product/R = new /datum/data/vending_product()
			GLOB.vending_products[typepath] = 1
			R.name = initial(temp.name)
			R.product_path = typepath
			R.amount = amount
			R.max_amount = amount
			R.custom_price = rand(100, 90000) //best prices
			R.custom_premium_price = rand(100, 90000) //best prices
			recordlist += R

/obj/machinery/vending/terminal/process()
	. = ..()
	if(last_rebuild + 2000 <= world.time && prob(99))
		product_records = list()
		last_rebuild = world.time
		speak("Новые продукты в наличии!")
		rebuild_inventory(GLOB.terminal_products, product_records)

/obj/machinery/vending/terminal/emag_act(mob/user)
	if(shock(user, 100))
		return

/obj/machinery/vending/terminal/attackby(obj/item/I, mob/user, params)
	if(shock(user, 100))
		return

/obj/machinery/vending/terminal/crowbar_act(mob/living/user, obj/item/I)
	if(shock(user, 100))
		return FALSE

/obj/machinery/vending/terminal/wrench_act(mob/living/user, obj/item/I)
	if(shock(user, 100))
		return FALSE

/obj/machinery/vending/terminal/screwdriver_act(mob/living/user, obj/item/I)
	if(shock(user, 100))
		return FALSE

/obj/machinery/vending/terminal/ui_interact(mob/user)
	var/list/dat = list()
	var/datum/bank_account/account
	var/mob/living/carbon/human/H
	var/obj/item/card/id/C
	if(ishuman(user))
		H = user
		C = H.get_idcard(TRUE)

	if(!C)
		dat += "<font color = 'red'><h3>No ID Card detected!</h3></font>"
	else if (!C.registered_account)
		dat += "<font color = 'red'><h3>No account on registered ID card!</h3></font>"
	if(onstation && C && C.registered_account)
		account = C.registered_account
	if(vending_machine_input.len)
		dat += "<h3>[input_display_header]</h3>"
		dat += "<div class='statusDisplay'>"
		for (var/O in vending_machine_input)
			if(vending_machine_input[O] > 0)
				var/N = vending_machine_input[O]
				dat += "<a href='byond://?src=[REF(src)];dispense=[sanitize(O)]'>Dispense</A> "
				dat += "<B>[capitalize(O)] ($[default_price]): [N]</B><br>"
		dat += "</div>"

	dat += {"<h3>Select an item</h3>
					<div class='statusDisplay'>"}

	if(!product_records.len)
		dat += "<font color = 'red'>Кто-то украл все наши товары!</font>"
	else
		var/list/display_records = product_records + coin_records
		if(extended_inventory)
			display_records = product_records + coin_records + hidden_records
		dat += "<table>"
		for (var/datum/data/vending_product/R in display_records)
			var/price_listed = "$[default_price]"
			var/is_hidden = hidden_records.Find(R)
			if(is_hidden && !extended_inventory)
				continue
			if(R.custom_price)
				price_listed = "$[R.custom_price]"
			dat += {"<tr><td><img src='data:image/jpeg;base64,[GetIconForProduct(R)]'/></td>
							<td style=\"width: 100%\"><b>[sanitize(R.name)]  ([price_listed])</b></td>"}
			if(R.amount > 0 && ((C && C.registered_account && onstation && account.account_balance > R.custom_price) || (!onstation && isliving(user))))
				dat += "<td align='right'><b>[R.amount]&nbsp;</b><a href='byond://?src=[REF(src)];vend=[REF(R)]'>Купить</a></td>"
			else
				dat += "<td align='right'><span class='linkOff'>Недоступно</span></td>"
			dat += "</tr>"
		dat += "</table>"
	dat += "</div>"
	if(onstation && C && C.registered_account)
		dat += "<b>Баланс: $[account.account_balance]</b>"

	var/datum/browser/popup = new(user, "vending", (name))
	popup.add_stylesheet(get_asset_datum(/datum/asset/spritesheet/vending))
	popup.set_content(dat.Join(""))
	popup.set_title_image(user.browse_rsc_icon(icon, icon_state))
	popup.open()

/obj/machinery/vending/terminal/proc/GetIconForProduct(datum/data/vending_product/P)
	if(GLOB.terminal_icon_cache[P.product_path])
		return GLOB.terminal_icon_cache[P.product_path]

	var/product = new P.product_path()
	GLOB.terminal_icon_cache[P.product_path] = icon2base64(getFlatIcon(product, no_anim = TRUE))
	qdel(product)
	return GLOB.terminal_icon_cache[P.product_path]
