/obj/machinery/vending/terminal
	name = "Trading Terminal MK2"
	desc = "Вещи возврату не подлежат."
	icon = 'white/valtos/icons/vending.dmi'
	icon_state = "trading"
	product_ads = "Лучшее только у нас!;Купи-купи-купи!"
	default_price = 500
	extra_price = 5000
	max_integrity = 300000
	var/last_rebuild = 0
	payment_department = NO_FREEBIES
	req_access = list(ACCESS_TRADER)

/obj/machinery/vending/terminal/Initialize(mapload)
	. = ..()
	last_rebuild = world.time + rand(300, 1000)
	rebuild_inventory(GLOB.terminal_products, product_records)

/obj/machinery/vending/terminal/proc/rebuild_inventory(list/productlist, list/recordlist)
	for(var/typepath in productlist)
		if (prob(80))
			if (prob(95))
				typepath = pick(subtypesof(/obj/item))
			var/amount = rand(1, 2)
			var/atom/temp = typepath
			if (!initial(temp.icon_state) || !initial(temp.icon))
				continue
			var/datum/data/vending_product/R = new /datum/data/vending_product()
			GLOB.vending_products[typepath] = 1
			R.name = initial(temp.name)
			R.product_path = typepath
			R.amount = amount
			R.max_amount = amount
			R.custom_price = rand(100000, 120000) //best prices
			R.custom_premium_price = rand(100000, 120000) //best prices
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
		dat += "<font color = 'red'><h3>Не вижу карту!</h3></font>"
	else if (!C.registered_account)
		dat += "<font color = 'red'><h3>У вас нет банковского аккаунта на текущей карте!</h3></font>"
	if(C && C.registered_account)
		account = C.registered_account
	dat += {"<h3>Выберите предмет</h3>
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
			if(R.amount > 0 && ((C && C.registered_account && account.account_balance > R.custom_price)))
				dat += "<td align='right'><b>[R.amount]&nbsp;</b><a href='byond://?src=[REF(src)];buy_term=[REF(R)]'>Купить</a></td>"
			else
				dat += "<td align='right'><span class='linkOff'>Недоступно</span></td>"
			dat += "</tr>"
		dat += "</table>"
	dat += "</div>"
	if(C && C.registered_account)
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

/obj/machinery/vending/terminal/Topic(href, href_list)
	if(..())
		return
	usr.set_machine(src)
	if((href_list["buy_term"]) && (vend_ready))
		if(panel_open)
			to_chat(usr, "<span class='warning'>The vending machine cannot dispense products while its service panel is open!</span>")
			return
		vend_ready = FALSE //One thing at a time!!

		var/datum/data/vending_product/R = locate(href_list["buy_term"])
		var/list/record_to_check = product_records + coin_records
		if(extended_inventory)
			record_to_check = product_records + coin_records + hidden_records
		if(!R || !istype(R) || !R.product_path)
			vend_ready = TRUE
			return
		var/price_to_use = default_price
		if(R.custom_price)
			price_to_use = R.custom_price
		if(R in hidden_records)
			if(!extended_inventory)
				vend_ready = TRUE
				return

		else if (!(R in record_to_check))
			vend_ready = TRUE
			message_admins("Vending machine exploit attempted by [ADMIN_LOOKUPFLW(usr)]!")
			return
		if (R.amount <= 0)
			say("Sold out of [R.name].")
			flick(icon_deny,src)
			vend_ready = TRUE
			return
		if(ishuman(usr))
			var/mob/living/carbon/human/H = usr
			var/obj/item/card/id/C = H.get_idcard(TRUE)

			if(!C)
				say("Нет карты.")
				flick(icon_deny,src)
				vend_ready = TRUE
				return
			else if (!C.registered_account)
				say("Нет аккаунта.")
				flick(icon_deny,src)
				vend_ready = TRUE
				return
			var/datum/bank_account/account = C.registered_account
			if(account?.account_job?.paycheck_department == payment_department)
				price_to_use = 0
			if(coin_records.Find(R) || hidden_records.Find(R))
				price_to_use = R.custom_premium_price ? R.custom_premium_price : extra_price
			if(price_to_use && !account.adjust_money(-price_to_use))
				say("У тебя не хватает кредитов на [R.name].")
				flick(icon_deny,src)
				vend_ready = TRUE
				return
			var/datum/bank_account/D = SSeconomy.get_dep_account(payment_department)
			if(D)
				D.adjust_money(price_to_use)
		if(last_shopper != usr || purchase_message_cooldown < world.time)
			say("[src] благодарит тебя за твои деньги!")
			purchase_message_cooldown = world.time + 5 SECONDS
			last_shopper = usr
		use_power(5)
		if(icon_vend) //Show the vending animation if needed
			flick(icon_vend,src)
		playsound(src, 'sound/machines/machine_vend.ogg', 50, TRUE, extrarange = -3)
		new R.product_path(get_turf(src))
		R.amount--
		SSblackbox.record_feedback("nested tally", "vending_machine_usage", 1, list("[type]", "[R.product_path]"))
		vend_ready = TRUE
	updateUsrDialog()
