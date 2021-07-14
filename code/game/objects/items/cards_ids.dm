/* Cards
 * Contains:
 *		DATA CARD
 *		ID CARD
 *		FINGERPRINT CARD HOLDER
 *		FINGERPRINT CARD
 */



/*
 * DATA CARDS - Used for the IC data card reader
 */

/obj/item/card
	name = "карта"
	desc = "Картует."
	icon = 'icons/obj/card.dmi'
	w_class = WEIGHT_CLASS_TINY

	var/list/files = list()

/obj/item/card/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] begins to swipe [user.ru_ego()] neck with <b>[src.name]</b>! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return BRUTELOSS

/obj/item/card/data
	name = "карта с данными"
	desc = "Пластиковая магнитная карта для простого и быстрого хранения и передачи данных. У этой есть полоса, бегущая по середине."
	icon_state = "data_1"
	obj_flags = UNIQUE_RENAME
	var/function = "storage"
	var/data = "null"
	var/special = null
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	var/detail_color = COLOR_ASSEMBLY_ORANGE

/obj/item/card/data/Initialize()
	.=..()
	update_icon()

/obj/item/card/data/update_overlays()
	. = ..()
	if(detail_color == COLOR_FLOORTILE_GRAY)
		return
	var/mutable_appearance/detail_overlay = mutable_appearance('icons/obj/card.dmi', "[icon_state]-color")
	detail_overlay.color = detail_color
	. += detail_overlay

/obj/item/proc/GetCard()

/obj/item/card/data/GetCard()
	return src

/obj/item/card/data/full_color
	desc = "Пластиковая магнитная карта для простого и быстрого хранения и передачи данных. Эта полностью цветная."
	icon_state = "data_2"

/obj/item/card/data/disk
	desc = "Пластиковая магнитная карта для простого и быстрого хранения и передачи данных. Эта необъяснимо похожа на дискету."
	icon_state = "data_3"

/*
 * ID CARDS
 */

/// "Retro" ID card that renders itself as the icon state with no overlays.
/obj/item/card/id
	name = "идентификационная карта"
	desc = "Карта, используемая для предоставления ID и определения доступа на станции."
	icon_state = "card_grey"
	worn_icon_state = "card_retro"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	slot_flags = ITEM_SLOT_ID
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF

	/// How many magical mining Disney Dollars this card has for spending at the mining equipment vendors.
	var/mining_points = 0
	/// The name registered on the card (for example: Dr Bryan See)
	var/registered_name = null
	/// Linked bank account.
	var/datum/bank_account/registered_account
	/// Linked paystand.
	var/obj/machinery/paystand/my_store
	/// Registered owner's age.
	var/registered_age = 13

	/// The job name registered on the card (for example: Assistant).
	var/assignment

	/// Trim datum associated with the card. Controls which job icon is displayed on the card and which accesses do not require wildcards.
	var/datum/id_trim/trim

	/// Access levels held by this card.
	var/list/access = list()

	/// List of wildcard slot names as keys with lists of wildcard data as values.
	var/list/wildcard_slots = list()

/obj/item/card/id/Initialize(mapload)
	. = ..()

	// Applying the trim updates the label and icon, so don't do this twice.
	if(ispath(trim))
		SSid_access.apply_trim_to_card(src, trim)
	else
		update_label()
		update_icon()

	RegisterSignal(src, COMSIG_ATOM_UPDATED_ICON, .proc/update_in_wallet)

/obj/item/card/id/Destroy()
	if (registered_account)
		registered_account.bank_cards -= src
	if (my_store && my_store.my_card == src)
		my_store.my_card = null
	return ..()

/obj/item/card/id/get_id_examine_strings(mob/user)
	. = ..()
	. += list("[icon2html(get_icon_source(), user, extra_classes = "bigicon")]")

/// Simple helper proc. Returns the source of the icon for this card. Advanced cards can override this to return their icon that has been cached due to using overlays.
/obj/item/card/id/proc/get_icon_source()
	return src

/**
 * Helper proc, checks whether the ID card can hold any given set of wildcards.
 *
 * Returns TRUE if the card can hold the wildcards, FALSE otherwise.
 * Arguments:
 * * wildcard_list - List of accesses to check.
 * * try_wildcard - If not null, will attempt to add wildcards for this wildcard specifically and will return FALSE if the card cannot hold all wildcards in this slot.
 */
/obj/item/card/id/proc/can_add_wildcards(list/wildcard_list, try_wildcard = null)
	if(!length(wildcard_list))
		return TRUE

	var/list/new_wildcard_limits = list()

	for(var/flag_name in wildcard_slots)
		if(try_wildcard && !(flag_name == try_wildcard))
			continue
		var/list/wildcard_info = wildcard_slots[flag_name]
		new_wildcard_limits[flag_name] = wildcard_info["limit"] - length(wildcard_info["usage"])

	if(!length(new_wildcard_limits))
		return FALSE

	var/wildcard_allocated
	for(var/wildcard in wildcard_list)
		var/wildcard_flag = SSid_access.get_access_flag(wildcard)
		wildcard_allocated = FALSE
		for(var/flag_name in new_wildcard_limits)
			var/limit_flags = SSid_access.wildcard_flags_by_wildcard[flag_name]
			if(!(wildcard_flag & limit_flags))
				continue
			// Negative limits mean infinite slots. Positive limits mean limited slots still available. 0 slots means no slots.
			if(new_wildcard_limits[flag_name] == 0)
				continue
			new_wildcard_limits[flag_name]--
			wildcard_allocated = TRUE
			break
		if(!wildcard_allocated)
			return FALSE

	return TRUE

/**
 * Attempts to add the given wildcards to the ID card.
 *
 * Arguments:
 * * wildcard_list - List of accesses to add.
 * * try_wildcard - If not null, will attempt to add all wildcards to this wildcard slot only.
 * * mode - The method to use when adding wildcards. See define for ERROR_ON_FAIL
 */
/obj/item/card/id/proc/add_wildcards(list/wildcard_list, try_wildcard = null, mode = ERROR_ON_FAIL)
	var/wildcard_allocated
	// Iterate through each wildcard in our list. Get its access flag. Then iterate over wildcard slots and try to fit it in.
	for(var/wildcard in wildcard_list)
		var/wildcard_flag = SSid_access.get_access_flag(wildcard)
		wildcard_allocated = FALSE
		for(var/flag_name in wildcard_slots)
			if(flag_name == WILDCARD_NAME_FORCED)
				continue

			if(try_wildcard && !(flag_name == try_wildcard))
				continue

			var/limit_flags = SSid_access.wildcard_flags_by_wildcard[flag_name]

			if(!(wildcard_flag & limit_flags))
				continue

			var/list/wildcard_info = wildcard_slots[flag_name]
			var/wildcard_limit = wildcard_info["limit"]
			var/list/wildcard_usage = wildcard_info["usage"]

			var/wildcard_count = wildcard_limit - length(wildcard_usage)

			// Negative limits mean infinite slots. Positive limits mean limited slots still available. 0 slots means no slots.
			if(wildcard_count == 0)
				continue

			wildcard_usage |= wildcard
			access |= wildcard
			wildcard_allocated = TRUE
			break
		// Fallback for if we couldn't allocate the wildcard for some reason.
		if(!wildcard_allocated)
			if(mode == ERROR_ON_FAIL)
				CRASH("Wildcard ([wildcard]) could not be added to [src].")

			if(mode == TRY_ADD_ALL)
				continue

			// If the card has no info for historic forced wildcards, create the list.
			if(!wildcard_slots[WILDCARD_NAME_FORCED])
				wildcard_slots[WILDCARD_NAME_FORCED] = list(limit = 0, usage = list())

			var/list/wildcard_info = wildcard_slots[WILDCARD_NAME_FORCED]
			var/list/wildcard_usage = wildcard_info["usage"]
			wildcard_usage |= wildcard
			access |= wildcard
			wildcard_info["limit"] = length(wildcard_usage)

/**
 * Removes wildcards from the ID card.
 *
 * Arguments:
 * * wildcard_list - List of accesses to remove.
 */
/obj/item/card/id/proc/remove_wildcards(list/wildcard_list)
	var/wildcard_removed
	// Iterate through each wildcard in our list. Get its access flag. Then iterate over wildcard slots and try to remove it.
	for(var/wildcard in wildcard_list)
		wildcard_removed = FALSE
		for(var/flag_name in wildcard_slots)
			if(flag_name == WILDCARD_NAME_FORCED)
				continue

			var/list/wildcard_info = wildcard_slots[flag_name]
			var/wildcard_usage = wildcard_info["usage"]

			if(!(wildcard in wildcard_usage))
				continue

			wildcard_usage -= wildcard
			access -= wildcard
			wildcard_removed = TRUE
			break
		// Fallback to see if this was a force-added wildcard.
		if(!wildcard_removed)
			// If the card has no info for historic forced wildcards, that's an error state.
			if(!wildcard_slots[WILDCARD_NAME_FORCED])
				stack_trace("Wildcard ([wildcard]) could not be removed from [src]. This card has no forced wildcard data and the wildcard is not in this card's wildcard lists.")

			var/list/wildcard_info = wildcard_slots[WILDCARD_NAME_FORCED]
			var/wildcard_usage = wildcard_info["usage"]

			if(!(wildcard in wildcard_usage))
				stack_trace("Wildcard ([wildcard]) could not be removed from [src]. This access is not a wildcard on this card.")

			wildcard_usage -= wildcard
			access -= wildcard
			wildcard_info["limit"] = length(wildcard_usage)

			if(!wildcard_info["limit"])
				wildcard_slots -= WILDCARD_NAME_FORCED

/**
 * Attempts to add the given accesses to the ID card as non-wildcards.
 *
 * Depending on the mode, may add accesses as wildcards or error if it can't add them as non-wildcards.
 * Arguments:
 * * add_accesses - List of accesses to check.
 * * try_wildcard - If not null, will attempt to add all accesses that require wildcard slots to this wildcard slot only.
 * * mode - The method to use when adding accesses. See define for ERROR_ON_FAIL
 */
/obj/item/card/id/proc/add_access(list/add_accesses, try_wildcard = null, mode = ERROR_ON_FAIL)
	var/list/wildcard_access = list()
	var/list/normal_access = list()

	build_access_lists(add_accesses, normal_access, wildcard_access)

	// Check if we can add the wildcards.
	if(mode == ERROR_ON_FAIL)
		if(!can_add_wildcards(wildcard_access, try_wildcard))
			CRASH("Cannot add wildcards from \[[add_accesses.Join(",")]\] to [src]")

	// All clear to add the accesses.
	access |= normal_access
	if(mode != TRY_ADD_ALL_NO_WILDCARD)
		add_wildcards(wildcard_access, try_wildcard, mode = mode)

	return TRUE

/**
 * Removes the given accesses from the ID Card.
 *
 * Will remove the wildcards if the accesses given are on the card as wildcard accesses.
 * Arguments:
 * * rem_accesses - List of accesses to remove.
 */
/obj/item/card/id/proc/remove_access(list/rem_accesses)
	var/list/wildcard_access = list()
	var/list/normal_access = list()

	build_access_lists(rem_accesses, normal_access, wildcard_access)

	access -= normal_access
	remove_wildcards(wildcard_access)

/**
 * Attempts to set the card's accesses to the given accesses, clearing all accesses not in the given list.
 *
 * Depending on the mode, may add accesses as wildcards or error if it can't add them as non-wildcards.
 * Arguments:
 * * new_access_list - List of all accesses that this card should hold exclusively.
 * * mode - The method to use when setting accesses. See define for ERROR_ON_FAIL
 */
/obj/item/card/id/proc/set_access(list/new_access_list, mode = ERROR_ON_FAIL)
	var/list/wildcard_access = list()
	var/list/normal_access = list()

	build_access_lists(new_access_list, normal_access, wildcard_access)

	// Check if we can add the wildcards.
	if(mode == ERROR_ON_FAIL)
		if(!can_add_wildcards(wildcard_access))
			CRASH("Cannot add wildcards from \[[new_access_list.Join(",")]\] to [src]")

	clear_access()

	access = normal_access.Copy()

	if(mode != TRY_ADD_ALL_NO_WILDCARD)
		add_wildcards(wildcard_access, mode = mode)

	return TRUE

/// Clears all accesses from the ID card - both wildcard and normal.
/obj/item/card/id/proc/clear_access()
	// Go through the wildcards and reset them.
	for(var/flag_name in wildcard_slots)
		var/list/wildcard_info = wildcard_slots[flag_name]
		var/list/wildcard_usage = wildcard_info["usage"]
		wildcard_usage.Cut()

	// Hard reset access
	access.Cut()

/// Clears the economy account from the ID card.
/obj/item/card/id/proc/clear_account()
	registered_account = null

/**
 * Helper proc. Creates access lists for the access procs.
 *
 * Takes the accesses list and compares it with the trim. Any basic accesses that match the trim are
 * added to basic_access_list and the rest are added to wildcard_access_list.

 * This proc directly modifies the lists passed in as args. It expects these lists to be instantiated.
 * There is no return value.
 * Arguments:
 */
/obj/item/card/id/proc/build_access_lists(list/accesses, list/basic_access_list, list/wildcard_access_list)
	if(!length(accesses) || isnull(basic_access_list) || isnull(wildcard_access_list))
		CRASH("Invalid parameters passed to build_access_lists")

	var/list/trim_accesses = trim?.access

	// Populate the lists.
	for(var/new_access in accesses)
		if(new_access in trim_accesses)
			basic_access_list |= new_access
			continue

		wildcard_access_list |= new_access

/obj/item/card/id/attack_self(mob/user)
	if(Adjacent(user))
		var/minor
		if(registered_name && registered_age && registered_age < AGE_MINOR)
			minor = " <b>(СТАЖИРОВКА)</b>"
		user.visible_message("<span class='notice'><b>[user]</b> показывает мне: [icon2html(src, viewers(user))] <b>[src.name][minor]</b>.</span>", "<span class='notice'>Показываю <b>[src.name][minor]</b>.</span>")
	add_fingerprint(user)

/obj/item/card/id/vv_edit_var(var_name, var_value)
	. = ..()
	if(.)
		switch(var_name)
			if(NAMEOF(src, assignment), NAMEOF(src, registered_name), NAMEOF(src, registered_age))
				update_label()
				update_icon()
			if(NAMEOF(src, trim))
				if(ispath(trim))
					SSid_access.apply_trim_to_card(src, trim)

/obj/item/card/id/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/rupee))
		to_chat(user, "<span class='warning'>Your ID smartly rejects the strange shard of glass. Who knew, apparently it's not ACTUALLY valuable!</span>")
		return
	else if(iscash(W))
		insert_money(W, user)
		return
	else if(istype(W, /obj/item/storage/bag/money))
		var/obj/item/storage/bag/money/money_bag = W
		var/list/money_contained = money_bag.contents

		var/money_added = mass_insert_money(money_contained, user)

		if (money_added)
			to_chat(user, "<span class='notice'>Прикладываю деньги к карте. Они исчезают в клубах дыма, добавляя [money_added] кредит[get_num_string(money_added)] на мой аккаунт.</span>")
		return
	else
		return ..()

/**
 * Insert credits or coins into the ID card and add their value to the associated bank account.
 *
 * Arguments:
 * money - The item to attempt to convert to credits and insert into the card.
 * user - The user inserting the item.
 * physical_currency - Boolean, whether this is a physical currency such as a coin and not a holochip.
 */
/obj/item/card/id/proc/insert_money(obj/item/money, mob/user)
	var/physical_currency
	if(istype(money, /obj/item/stack/spacecash) || istype(money, /obj/item/coin))
		physical_currency = TRUE

	if(!registered_account)
		to_chat(user, "<span class='warning'>[capitalize(src.name)] не имеет аккаунта в себе!</span>")
		return
	var/cash_money = money.get_item_credit_value()
	if(!cash_money)
		to_chat(user, "<span class='warning'><b>[capitalize(money.name)]</b> не очень похоже на деньги!</span>")
		return
	registered_account.adjust_money(cash_money)
	SSblackbox.record_feedback("amount", "credits_inserted", cash_money)
	log_econ("[cash_money] credits were inserted into [src] owned by [src.registered_name]")
	if(physical_currency)
		to_chat(user, "<span class='notice'>Вставляю <b>[money.name]</b> в <b>[src.name]</b>. Они исчезают в клубах дыма, добавляя [cash_money] кредит[get_num_string(cash_money)] на мой аккаунт.</span>")
	else
		to_chat(user, "<span class='notice'>Вставляю <b>[money.name]</b> в <b>[src.name]</b> добавляя [cash_money] кредит[get_num_string(cash_money)] на мой аккаунт.</span>")

	to_chat(user, "<span class='notice'>Привязанный аккаунт сообщает о балансе в размере [registered_account.account_balance] кредит[get_num_string(registered_account.account_balance)].</span>")
	qdel(money)

/obj/item/card/id/proc/mass_insert_money(list/money, mob/user)
	if(!registered_account)
		to_chat(user, "<span class='warning'><b>[capitalize(src.name)]</b> не имеет привязанного аккаунта, чтобы вкладывать туда что-то!</span>")
		return FALSE

	if (!money || !money.len)
		return FALSE

	var/total = 0

	for (var/obj/item/physical_money in money)
		total += physical_money.get_item_credit_value()
		CHECK_TICK

	registered_account.adjust_money(total)
	SSblackbox.record_feedback("amount", "credits_inserted", total)
	log_econ("[total] credits were inserted into [src] owned by [src.registered_name]")
	QDEL_LIST(money)

	return total

/// Helper proc. Can the user alt-click the ID?
/obj/item/card/id/proc/alt_click_can_use_id(mob/living/user)
	if(!isliving(user))
		return
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return

	return TRUE

/// Attempts to set a new bank account on the ID card.
/obj/item/card/id/proc/set_new_account(mob/living/user)
	. = FALSE
	var/datum/bank_account/old_account = registered_account

	var/new_bank_id = input(user, "Введите ID-номер аккуанта.", "Возвращение аккаунта", 111111) as num | null

	if (isnull(new_bank_id))
		return

	if(!alt_click_can_use_id(user))
		return
	if(!new_bank_id || new_bank_id < 111111 || new_bank_id > 999999)
		to_chat(user, "<span class='warning'>ID-номер аккаунта может быть от 111111 до 999999.</span>")
		return
	if (registered_account && registered_account.account_id == new_bank_id)
		to_chat(user, "<span class='warning'>ID-номер уже привязан к этой карте.</span>")
		return

	var/datum/bank_account/B = SSeconomy.bank_accounts_by_id["[new_bank_id]"]
	if(B)
		if (old_account)
			old_account.bank_cards -= src

		B.bank_cards += src
		registered_account = B
		to_chat(user, "<span class='notice'>ID-номер теперь привязан к этой карте.</span>")

		return TRUE

	to_chat(user, "<span class='warning'>ID-номер аккаунта неверный.</span>")
	return

/obj/item/card/id/AltClick(mob/living/user)
	if(!alt_click_can_use_id(user))
		return

	if(!registered_account)
		set_new_account(user)
		return

	if (registered_account.being_dumped)
		registered_account.bank_card_talk("<span class='warning'>е†…йѓЁжњЌеЉЎе™Ёй”™иЇЇ</span>", TRUE)
		return

	var/amount_to_remove =  FLOOR(input(user, "Сколько извлекаем? Баланс: [registered_account.account_balance]", "Вывод бабла", 5) as num|null, 1)

	if(!amount_to_remove || amount_to_remove < 0)
		return
	if(!alt_click_can_use_id(user))
		return
	if(registered_account.adjust_money(-amount_to_remove))
		var/obj/item/holochip/holochip = new (user.drop_location(), amount_to_remove)
		user.put_in_hands(holochip)
		to_chat(user, "<span class='notice'>Снимаю [amount_to_remove] кредит[get_num_string(amount_to_remove)] формируя голо-чип.</span>")
		SSblackbox.record_feedback("amount", "credits_removed", amount_to_remove)
		log_econ("[amount_to_remove] credits were removed from [src] owned by [src.registered_name]")
		return
	else
		var/difference = amount_to_remove - registered_account.account_balance
		registered_account.bank_card_talk("<span class='warning'>ОШИБКА: Привязанный аккаунт имеет недостаток в размере [difference] кредит[get_num_string(difference)] для снятия суммы.</span>", TRUE)

/obj/item/card/id/examine(mob/user)
	. = ..()
	if(registered_account)
		. += "<hr>Привязанный аккаунт принадлежит '<b>[registered_account.account_holder]</b>' и сообщает о балансе <b>[registered_account.account_balance]</b> кредит[get_num_string(registered_account.account_balance)]."
	. += "<hr><span class='notice'><i>Здесь ещё какая-то информация, стоит всмотреться...</i></span>"

/obj/item/card/id/examine_more(mob/user)
	var/list/msg = list("<span class='notice'><i>Осматриваю <b>[src]</b> ближе и вижу следующее...</i></span>")

	if(registered_age)
		msg += "\nВладелец карты в возрасте <b>[registered_age]</b> лет. [(registered_age < AGE_MINOR) ? "Тут есть голографическая полоса, которая гласит <b><span class='danger'>'СТАЖИРОВКА: НЕ ПРОДАВАТЬ АЛКОГОЛЬ ИЛИ ТАБАК'</span></b> в самом низу карты." : ""]"
	if(mining_points)
		msg += "\nВау, здесь же есть [mining_points] шахтёрских очков на разные штуки из шахтёрского инвентаря."
	if(registered_account)
		msg += "\nПривязанный аккаунт принадлежит '[registered_account.account_holder]' и сообщает о балансе в размере <b>[registered_account.account_balance] кредит[get_num_string(registered_account.account_balance)]</b>."
		if(registered_account.account_job)
			var/datum/bank_account/D = SSeconomy.get_dep_account(registered_account.account_job.paycheck_department)
			if(D)
				msg += "\nБаланс [D.account_holder] составляет <b>[D.account_balance] кредит[get_num_string(D.account_balance)]."
		msg += "\n<span class='info'>Alt-клик на ID-карте для снятия денег.</span>"
		msg += "\n<span class='info'>Похоже сюда можно вставлять голо-чипы, монетки и прочую валюту.</span>"
		if(registered_account.civilian_bounty)
			msg += "\n<span class='info'><b>Есть активный гражданский заказ.</b>"
			msg += "\n<span class='info'><i>[registered_account.bounty_text()]</i></span>"
			msg += "\n<span class='info'>Количество: [registered_account.bounty_num()]</span>"
			msg += "\n<span class='info'>Награда: [registered_account.bounty_value()]</span>"
		if(registered_account.account_holder == user.real_name)
			msg += "\n<span class='boldnotice'>Если ты потеряешь эту ID-карту, ты можешь запросто переподключить свой счёт используя Alt-клик на своей новой карте.</span>"
	else
		msg += "\n<span class='info'>Похоже здесь не привязан аккаунт. Alt-клик для привязки аккаунта поможет.</span>"

	return msg

/obj/item/card/id/GetAccess()
	return access

/obj/item/card/id/GetID()
	return src

/obj/item/card/id/RemoveID()
	return src

/// Called on COMSIG_ATOM_UPDATED_ICON. Updates the visuals of the wallet this card is in.
/obj/item/card/id/proc/update_in_wallet()
	SIGNAL_HANDLER

	if(istype(loc, /obj/item/storage/wallet))
		var/obj/item/storage/wallet/powergaming = loc
		if(powergaming.front_id == src)
			powergaming.update_label()
			powergaming.update_icon()

/// Updates the name based on the card's vars and state.
/obj/item/card/id/proc/update_label()
	var/blank = !registered_name
	name = "[blank ? initial(name) : "ID-карта [registered_name]"][(!assignment) ? "" : " ([ru_job_parse(assignment)])"]"

/obj/item/card/id/away
	name = "ID-карта"
	desc = "ID персонала используется для доступа к дверям."
	trim = /datum/id_trim/away
	icon_state = "retro"
	registered_age = null

/obj/item/card/id/away/hotel
	name = "ID-карта отельщика"
	desc = "ID персонала используется для доступа к дверям отеля."
	trim = /datum/id_trim/away/hotel

/obj/item/card/id/away/hotel/securty
	name = "ID-карта офицера"
	trim = /datum/id_trim/away/hotel/security

/obj/item/card/id/away/old
	name = "достаточно простая ID-карта"
	desc = "Совершенно обычная карта. Безвкусица."

/obj/item/card/id/away/old/sec
	name = "ID-карта офицера станции Чарли"
	desc = "Выцветшая идентификационная карта Чарли. Можно разобрать должность \"Security Officer\"."
	trim = /datum/id_trim/away/old/sec

/obj/item/card/id/away/old/sci
	name = "ID-карта учёного станции Чарли"
	desc = "Выцветшая идентификационная карта Чарли. Можно разобрать должность \"Scientist\"."
	trim = /datum/id_trim/away/old/sci

/obj/item/card/id/away/old/eng
	name = "ID-карта инженера станции Чарли"
	desc = "Выцветшая идентификационная карта Чарли. Можно разобрать должность \"Station Engineer\"."
	trim = /datum/id_trim/away/old/eng

/obj/item/card/id/away/old/apc
	name = "ID-карта доступа к APC"
	desc = "Специальная идентификационная карта, которая позволяет получить доступ к терминалам APC."
	trim = /datum/id_trim/away/old/apc

/obj/item/card/id/away/deep_storage //deepstorage.dmm space ruin
	name = "ID-карта бункера"

/obj/item/card/id/departmental_budget
	name = "ведомственная карточка (ERROR)"
	desc = "Предоставляет доступ к бюджету отдела."
	icon_state = "budgetcard"
	var/department_ID = ACCOUNT_CIV
	var/department_name = ACCOUNT_CIV_NAME
	registered_age = null

/obj/item/card/id/departmental_budget/Initialize()
	. = ..()
	var/datum/bank_account/B = SSeconomy.get_dep_account(department_ID)
	if(B)
		registered_account = B
		if(!B.bank_cards.Find(src))
			B.bank_cards += src
		name = "ведомственная карточка ([department_name])"
		desc = "Предоставляет доступ к бюджету [department_name]."
	SSeconomy.dep_cards += src

/obj/item/card/id/departmental_budget/Destroy()
	SSeconomy.dep_cards -= src
	return ..()

/obj/item/card/id/departmental_budget/update_label()
	return

/obj/item/card/id/departmental_budget/car
	department_ID = ACCOUNT_CAR
	department_name = ACCOUNT_CAR_NAME
	icon_state = "car_budget" //saving up for a new tesla

/obj/item/card/id/departmental_budget/AltClick(mob/living/user)
	registered_account.bank_card_talk("<span class='warning'>Снимать с этой карты запрещено картой. Может потому что она не умеет печатать голочипы?</span>", TRUE) //prevents the vault bank machine being useless and putting money from the budget to your card to go over personal crates

/obj/item/card/id/advanced
	name = "ID-карта"
	desc = "Используется для предоставления доступа к различным штукам на станции. Имеет дисплей и продвинутые внутренности в себе."
	icon_state = "card_grey"
	worn_icon_state = "card_grey"

	wildcard_slots = WILDCARD_LIMIT_GREY

	/// An overlay icon state for when the card is assigned to a name. Usually manifests itself as a little scribble to the right of the job icon.
	var/assigned_icon_state = "assigned"
	/// Cached icon that has been built for this card.
	var/icon/cached_flat_icon

	/// If this is set, will manually override the icon file for the trim. Intended for admins to VV edit and chameleon ID cards.
	var/trim_icon_override
	/// If this is set, will manually override the icon state for the trim. Intended for admins to VV edit and chameleon ID cards.
	var/trim_state_override
	/// If this is set, will manually override the trim's assignmment for SecHUDs. Intended for admins to VV edit and chameleon ID cards.
	var/trim_assignment_override

/obj/item/card/id/advanced/get_icon_source()
	return get_cached_flat_icon()

/// If no cached_flat_icon exists, this proc creates it. This proc then returns the cached_flat_icon.
/obj/item/card/id/advanced/proc/get_cached_flat_icon()
	if(!cached_flat_icon)
		cached_flat_icon = getFlatIcon(src)
	return cached_flat_icon

/obj/item/card/id/advanced/get_examine_string(mob/user, thats = FALSE)
	return "[icon2html(get_cached_flat_icon(), user)] [get_examine_name(user)]" //displays all overlays in chat

/obj/item/card/id/advanced/update_overlays()
	. = ..()

	cached_flat_icon = null

	if(registered_name && registered_name != "Captain")
		. += mutable_appearance(icon, assigned_icon_state)

	var/trim_icon_file = trim_icon_override ? trim_icon_override : trim?.trim_icon
	var/trim_icon_state = trim_state_override ? trim_state_override : trim?.trim_state

	if(!trim_icon_file || !trim_icon_state)
		return

	. += mutable_appearance(trim_icon_file, trim_icon_state)

/obj/item/card/id/advanced/silver
	name = "серебрянная ID-карта"
	desc = "Серебряная карта, которая показывает честь и преданность делу."
	icon_state = "card_silver"
	worn_icon_state = "card_silver"
	inhand_icon_state = "silver_id"
	wildcard_slots = WILDCARD_LIMIT_SILVER

/datum/id_trim/maint_reaper
	access = list(ACCESS_MAINT_TUNNELS)
	trim_state = "trim_janitor"
	assignment = "Reaper"

/obj/item/card/id/advanced/silver/reaper
	name = "Thirteen's ID Card (Reaper)"
	trim = /datum/id_trim/maint_reaper
	registered_name = "Thirteen"

/obj/item/card/id/advanced/gold
	name = "золотая ID-карта"
	desc = "Золотая карта, которая показывает силу и мощь."
	icon_state = "card_gold"
	worn_icon_state = "card_gold"
	inhand_icon_state = "gold_id"
	wildcard_slots = WILDCARD_LIMIT_GOLD

/obj/item/card/id/advanced/gold/captains_spare
	name = "запасная ID-карта капитана"
	desc = "Запасная ID-карта самого Верховного Лорда."
	registered_name = "Captain"
	trim = /datum/id_trim/job/captain
	registered_age = null

/obj/item/card/id/advanced/gold/captains_spare/trap
	desc = "Запасная ID-карта самого Верховного Лорда. К ней привязана какая-то микросхема..."
	anchored = TRUE
	var/first_try = TRUE

/obj/item/card/id/advanced/gold/captains_spare/trap/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WIRECUTTER && first_try)
		to_chat(user, "<span class='notice'>Начинаю обезвреживать карту. (это займёт примерно одну минуту и нужно не шевелиться)</span>")
		if(do_after(user, 30 SECONDS, target = src) && first_try)
			to_chat(user, "<span class='notice'>Карта разминирована.</span>")
			first_try = FALSE
			anchored = FALSE
			if(prob(10))
				priority_announce("Кто-то пытается украсть капитанскую карту. Остановите [user.ru_ego()]!", title = "Кража", sound = 'white/valtos/sounds/che.ogg')
	else
		return ..()

/obj/item/card/id/advanced/gold/captains_spare/trap/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(iscarbon(user) && first_try && !HAS_TRAIT(user, TRAIT_DISK_VERIFIER))
		var/mob/living/carbon/C = user
		to_chat(C, "<span class='warning'>Пытаюсь подобрать карту... Что может пойти не тка~</span>")
		if(do_after(C, 10, target = src) && first_try)
			to_chat(C, "<span class='userdanger'>КАРТА БЫЛА ЗАМИНИРОВАНА!</span>")
			electrocute_mob(user, get_area(src))
			playsound(loc, 'sound/weapons/slice.ogg', 25, TRUE, -1)
			var/which_hand = BODY_ZONE_L_ARM
			if(!(C.active_hand_index % 2))
				which_hand = BODY_ZONE_R_ARM
			var/obj/item/bodypart/chopchop = C.get_bodypart(which_hand)
			chopchop.dismember()
			C.gain_trauma(/datum/brain_trauma/magic/stalker)
			first_try = FALSE
			anchored = FALSE
	else if (HAS_TRAIT(user, TRAIT_DISK_VERIFIER))
		to_chat(user, "<span class='notice'>Карта разминирована.</span>")
		first_try = FALSE
		anchored = FALSE

/obj/item/card/id/advanced/gold/captains_spare/update_label() //so it doesn't change to Captain's ID card (Captain) on a sneeze
	if(registered_name == "Captain")
		name = "[initial(name)][(!assignment || assignment == "Captain") ? "" : " ([ru_job_parse(assignment)])"]"
		update_icon()
	else
		..()

/obj/item/card/id/advanced/centcom
	name = "ID-карта ЦК"
	desc = "Карта прямо из Центрального командования."
	icon_state = "card_centcom"
	worn_icon_state = "card_centcom"
	assigned_icon_state = "assigned_centcom"
	registered_name = "Центральное Командование"
	registered_age = null
	trim = /datum/id_trim/centcom
	wildcard_slots = WILDCARD_LIMIT_CENTCOM

/obj/item/card/id/advanced/centcom/ert
	name = "ID-карта ЦК"
	desc = "Карта офицера отряда быстрого реагирования."
	registered_age = null
	registered_name = "Интерн"
	trim = /datum/id_trim/centcom/ert

/obj/item/card/id/advanced/centcom/ert
	registered_name = "Emergency Response Team Commander"
	trim = /datum/id_trim/centcom/ert/commander

/obj/item/card/id/advanced/centcom/ert/security
	registered_name = "Офицер службы безопасности"
	trim = /datum/id_trim/centcom/ert/security

/obj/item/card/id/advanced/centcom/ert/engineer
	registered_name = "Офицер инженерного реагирования"
	trim = /datum/id_trim/centcom/ert/engineer

/obj/item/card/id/advanced/centcom/ert/medical
	registered_name = "Офицер службы медицинской помощи"
	trim = /datum/id_trim/centcom/ert/medical

/obj/item/card/id/advanced/centcom/ert/chaplain
	registered_name = "Офицер религиозного реагирования"
	trim = /datum/id_trim/centcom/ert/chaplain

/obj/item/card/id/advanced/centcom/ert/janitor
	registered_name = "Офицер уборочного реагирования"
	trim = /datum/id_trim/centcom/ert/janitor

/obj/item/card/id/advanced/centcom/ert/clown
	registered_name = "Офицер службы поддержки развлечений"
	trim = /datum/id_trim/centcom/ert/clown

/obj/item/card/id/advanced/black
	name = "чёрная ID-карта"
	desc = "Эта карта явно принадлежит тому, кто может запросто творить военные преступления и называть их троллингом без последствий для себя."
	icon_state = "card_black"
	worn_icon_state = "card_black"
	assigned_icon_state = "assigned_syndicate"
	wildcard_slots = WILDCARD_LIMIT_GOLD

/obj/item/card/id/advanced/centcom/spetsnaz
	icon_state = "card_black"
	worn_icon_state = "card_black"
	assigned_icon_state = "assigned_syndicate"
	desc = "Эта карта явно принадлежит тому, кто может запросто творить военные преступления без последствий для себя."
	trim = /datum/id_trim/centcom/spetsnaz

/obj/item/card/id/advanced/centcom/spetsnaz/leader
	trim = /datum/id_trim/centcom/spetsnaz/leader

/obj/item/card/id/advanced/black/deathsquad
	name = "ОТРЯД СМЕРТИ"
	desc = "Карта офицера отряда смерти?"
	registered_name = "Death Commando"
	trim = /datum/id_trim/centcom/deathsquad
	wildcard_slots = WILDCARD_LIMIT_DEATHSQUAD

/obj/item/card/id/advanced/black/syndicate_command
	name = "ID-карта синдиката"
	desc = "Настоящая. Синдикатовская."
	registered_name = "Syndicate"
	registered_age = null
	trim = /datum/id_trim/syndicom
	wildcard_slots = WILDCARD_LIMIT_SYNDICATE

/obj/item/card/id/advanced/black/syndicate_command/crew_id
	name = "ID-карта синдиката"
	desc = "Настоящая. Синдикатовская."
	registered_name = "Syndicate"
	trim = /datum/id_trim/syndicom/crew

/obj/item/card/id/advanced/black/syndicate_command/captain_id
	name = "ID-карта капитана синдиката"
	desc = "Настоящая. Синдикатовская."
	registered_name = "Syndicate"
	trim = /datum/id_trim/syndicom/captain

/obj/item/card/id/advanced/debug
	name = "Дебаг-ID"
	desc = "Ммм?"
	icon_state = "card_centcom"
	worn_icon_state = "card_centcom"
	assigned_icon_state = "assigned_centcom"
	trim = /datum/id_trim/admin
	wildcard_slots = WILDCARD_LIMIT_ADMIN

/obj/item/card/id/advanced/debug/Initialize()
	. = ..()
	registered_account = SSeconomy.get_dep_account(ACCOUNT_CAR)

/obj/item/card/id/advanced/prisoner
	name = "ID-карта заключённого"
	desc = "Ты номер, ты не свободный человек."
	icon_state = "card_prisoner"
	worn_icon_state = "card_prisoner"
	inhand_icon_state = "orange-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	registered_name = "Scum"
	registered_age = null
	trim = /datum/id_trim/job/prisoner

	wildcard_slots = WILDCARD_LIMIT_PRISONER

	/// Number of gulag points required to earn freedom.
	var/goal = 0
	/// Number of gulag points earned.
	var/points = 0

/obj/item/card/id/advanced/prisoner/attack_self(mob/user)
	to_chat(usr, "<span class='notice'>Собрано [points] очков. Всего нужно собрать [goal] для выхода.</span>")

/obj/item/card/id/advanced/prisoner/one
	name = "Заключённый #13-001"
	registered_name = "Заключённый #13-001"
	trim = /datum/id_trim/job/prisoner/one

/obj/item/card/id/advanced/prisoner/two
	name = "Заключённый #13-002"
	registered_name = "Заключённый #13-002"
	trim = /datum/id_trim/job/prisoner/two

/obj/item/card/id/advanced/prisoner/three
	name = "Заключённый #13-003"
	registered_name = "Заключённый #13-003"
	trim = /datum/id_trim/job/prisoner/three

/obj/item/card/id/advanced/prisoner/four
	name = "Заключённый #13-004"
	registered_name = "Заключённый #13-004"
	trim = /datum/id_trim/job/prisoner/four

/obj/item/card/id/advanced/prisoner/five
	name = "Заключённый #13-005"
	registered_name = "Заключённый #13-005"
	trim = /datum/id_trim/job/prisoner/five

/obj/item/card/id/advanced/prisoner/six
	name = "Заключённый #13-006"
	registered_name = "Заключённый #13-006"
	trim = /datum/id_trim/job/prisoner/six

/obj/item/card/id/advanced/prisoner/seven
	name = "Заключённый #13-007"
	registered_name = "Заключённый #13-007"
	trim = /datum/id_trim/job/prisoner/seven

/obj/item/card/id/advanced/mining
	name = "шахтёрская ID-карта"
	trim = /datum/id_trim/job/shaft_miner/spare

/obj/item/card/id/advanced/highlander
	name = "ID горца"
	registered_name = "Highlander"
	desc = "Останется только один!"
	icon_state = "card_black"
	worn_icon_state = "card_black"
	assigned_icon_state = "assigned_syndicate"
	trim = /datum/id_trim/highlander
	wildcard_slots = WILDCARD_LIMIT_ADMIN

/obj/item/card/id/advanced/chameleon
	name = "карта агента"
	desc = "Невероятно продвинутая ID-карта. Достаточно всего лишь дотронуться этой картой до другой и доступ будет скопирован."
	wildcard_slots = WILDCARD_LIMIT_CHAMELEON

	/// Have we set a custom name and job assignment, or will we use what we're given when we chameleon change?
	var/forged = FALSE
	/// Anti-metagaming protections. If TRUE, anyone can change the ID card's details. If FALSE, only syndicate agents can.
	var/anyone = FALSE
	/// Weak ref to the ID card we're currently attempting to steal access from.
	var/datum/weakref/theft_target

/obj/item/card/id/advanced/chameleon/Initialize()
	. = ..()
	var/datum/action/item_action/chameleon/change/id/chameleon_card_action = new(src)
	chameleon_card_action.chameleon_type = /obj/item/card/id/advanced
	chameleon_card_action.chameleon_name = "ID-карта"
	chameleon_card_action.initialize_disguises()

/obj/item/card/id/advanced/chameleon/Destroy()
	theft_target = null
	. = ..()

/obj/item/card/id/advanced/chameleon/afterattack(obj/item/O, mob/user, proximity)
	if(!proximity)
		return
	if(istype(O, /obj/item/card/id))
		theft_target = WEAKREF(O)
		ui_interact(user)
		return

	return ..()

/obj/item/card/id/advanced/chameleon/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ChameleonCard", name)
		ui.open()

/obj/item/card/id/advanced/chameleon/ui_static_data(mob/user)
	var/list/data = list()
	data["wildcardFlags"] = SSid_access.wildcard_flags_by_wildcard
	data["accessFlagNames"] = SSid_access.access_flag_string_by_flag
	data["accessFlags"] = SSid_access.flags_by_access
	return data

/obj/item/card/id/advanced/chameleon/ui_data(mob/user)
	var/list/data = list()

	data["showBasic"] = FALSE

	var/list/regions = list()

	var/obj/item/card/id/target_card = theft_target.resolve()
	if(target_card)
		var/list/tgui_region_data = SSid_access.all_region_access_tgui
		for(var/region in SSid_access.station_regions)
			regions += tgui_region_data[region]

	data["accesses"] = regions
	data["ourAccess"] = access
	data["ourTrimAccess"] = trim ? trim.access : list()
	data["theftAccess"] = target_card.access.Copy()
	data["wildcardSlots"] = wildcard_slots
	data["selectedList"] = access
	data["trimAccess"] = list()

	return data

/obj/item/card/id/advanced/chameleon/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	var/obj/item/card/id/target_card = theft_target?.resolve()
	if(QDELETED(target_card))
		to_chat(usr, "<span class='notice'>Карта слишком далеко.</span>")
		target_card = null
		return TRUE

	// Wireless ID theft!
	var/turf/our_turf = get_turf(src)
	var/turf/target_turf = get_turf(target_card)
	if(!our_turf.Adjacent(target_turf))
		to_chat(usr, "<span class='notice'>Карта слишком далеко.</span>")
		target_card = null
		return TRUE

	switch(action)
		if("mod_access")
			var/access_type = params["access_target"]
			var/try_wildcard = params["access_wildcard"]
			if(access_type in access)
				remove_access(list(access_type))
				LOG_ID_ACCESS_CHANGE(usr, src, "removed [SSid_access.get_access_desc(access_type)]")
				return TRUE

			if(!(access_type in target_card.access))
				to_chat(usr, "<span class='notice'>ОШИБКА-ID: ID-карта отвергает запрос на модификацию.</span>")
				LOG_ID_ACCESS_CHANGE(usr, src, "failed to add [SSid_access.get_access_desc(access_type)][try_wildcard ? " with wildcard [try_wildcard]" : ""]")
				return TRUE

			if(!can_add_wildcards(list(access_type), try_wildcard))
				to_chat(usr, "<span class='notice'>ОШИБКА-ID: ID-карта отвергает запрос на модификацию.</span>")
				LOG_ID_ACCESS_CHANGE(usr, src, "failed to add [SSid_access.get_access_desc(access_type)][try_wildcard ? " with wildcard [try_wildcard]" : ""]")
				return TRUE

			if(!add_access(list(access_type), try_wildcard))
				to_chat(usr, "<span class='notice'>ОШИБКА-ID: ID-карта отвергает запрос на модификацию.</span>")
				LOG_ID_ACCESS_CHANGE(usr, src, "failed to add [SSid_access.get_access_desc(access_type)][try_wildcard ? " with wildcard [try_wildcard]" : ""]")
				return TRUE

			if(access_type in ACCESS_ALERT_ADMINS)
				message_admins("[ADMIN_LOOKUPFLW(usr)] just added [SSid_access.get_access_desc(access_type)] to an ID card [ADMIN_VV(src)] [(registered_name) ? "belonging to [registered_name]." : "with no registered name."]")
			LOG_ID_ACCESS_CHANGE(usr, src, "added [SSid_access.get_access_desc(access_type)]")
			return TRUE

/obj/item/card/id/advanced/chameleon/attack_self(mob/user)
	if(isliving(user) && user.mind)
		var/popup_input = alert(user, "Выбрать бы действие", "ID-карта агента", "Показать", "СБРОСИТЬ", "Изменить ID-номер")
		if(user.incapacitated())
			return
		if(!user.is_holding(src))
			return
		if(popup_input == "СБРОСИТЬ")
			if(!forged)
				var/input_name = stripped_input(user, "Какое имя на этот раз? Можно оставить поле пустым для случая.", "Имя агента", registered_name ? registered_name : (ishuman(user) ? user.real_name : user.name), MAX_NAME_LEN)
				input_name = sanitize_name(input_name)
				if(!input_name)
					// Invalid/blank names give a randomly generated one.
					if(user.gender == MALE)
						input_name = "[pick(GLOB.first_names_male)] [pick(GLOB.last_names)]"
					else if(user.gender == FEMALE)
						input_name = "[pick(GLOB.first_names_female)] [pick(GLOB.last_names)]"
					else
						input_name = "[pick(GLOB.first_names)] [pick(GLOB.last_names)]"

				registered_name = input_name

				var/change_trim = alert(user, "Настроить карту?", "Модификация карты", "Да", "Нет")
				if(change_trim == "Да")
					var/list/blacklist = typecacheof(type) + typecacheof(/obj/item/card/id/advanced/simple_bot)
					var/list/trim_list = list()
					for(var/trim_path in typesof(/datum/id_trim))
						if(blacklist[trim_path])
							continue

						var/datum/id_trim/trim = SSid_access.trim_singletons_by_path[trim_path]

						if(trim && trim.trim_state && trim.assignment)
							var/fake_trim_name = "[trim.assignment] ([trim.trim_state])"
							trim_list[fake_trim_name] = trim_path

					var/selected_trim_path
					selected_trim_path = input("Какой же образ мы выберем.\nЗаметка: это не добавит доступа.", "Модификация карты", selected_trim_path) as null|anything in sortList(trim_list, /proc/cmp_typepaths_asc)
					if(selected_trim_path)
						SSid_access.apply_trim_to_chameleon_card(src, trim_list[selected_trim_path])

				var/target_occupation = stripped_input(user, "Какую должность мы выберем?\nЗаметка: это не добавит доступа, просто изменит видимую должность.", "Выбираем работу", assignment ? assignment : "Assistant", MAX_MESSAGE_LEN)
				if(target_occupation)
					assignment = target_occupation

				var/new_age = input(user, "Выберем же возраст:\n([AGE_MIN]-[AGE_MAX])", "Возраст агента") as num|null
				if(new_age)
					registered_age = max(round(text2num(new_age)), 0)

				update_label()
				update_icon()
				forged = TRUE
				to_chat(user, "<span class='notice'>Успешно модифицирую ID-карту.</span>")
				log_game("[key_name(user)] has forged [initial(name)] with name \"[registered_name]\", occupation \"[assignment]\" and trim \"[trim?.assignment]\".")

				if(!registered_account)
					if(ishuman(user))
						var/mob/living/carbon/human/accountowner = user

						var/datum/bank_account/account = SSeconomy.bank_accounts_by_id["[accountowner.account_id]"]
						if(account)
							account.bank_cards += src
							registered_account = account
							to_chat(user, "<span class='notice'>Номер аккаунта автоматически выбран.</span>")
				return
			if(forged)
				registered_name = initial(registered_name)
				assignment = initial(assignment)
				SSid_access.remove_trim_from_card(src)
				log_game("[key_name(user)] has reset [initial(name)] named \"[src]\" to default.")
				update_label()
				update_icon()
				forged = FALSE
				to_chat(user, "<span class='notice'>Успешно сбрасываю ID-карту.</span>")
				return
		if (popup_input == "Изменить ID-номер")
			set_new_account(user)
			return
	return ..()

/// A special variant of the classic chameleon ID card which accepts all access.
/obj/item/card/id/advanced/chameleon/black
	icon_state = "card_black"
	worn_icon_state = "card_black"
	assigned_icon_state = "assigned_syndicate"
	wildcard_slots = WILDCARD_LIMIT_GOLD

/obj/item/card/id/advanced/engioutpost
	registered_name = "Джордж 'Пластик' Миллер"
	desc = "Карта, используемая для удостоверения личности и определения доступа через станцию. Из угла капает кровь. Фу."
	trim = /datum/id_trim/engioutpost
	registered_age = 47

/obj/item/card/id/advanced/simple_bot
	name = "простая ID-карта робота"
	desc = "Внутренняя идентификационная карта, используемая неразумными машинами на станции. Вы должны сообщить об этом кодеру, если вы его держите."
	wildcard_slots = WILDCARD_LIMIT_ADMIN

/obj/item/card/id/red
	name = "Red Team identification card"
	desc = "A card used to identify members of the red team for CTF"
	icon_state = "ctf_red"

/obj/item/card/id/blue
	name = "Blue Team identification card"
	desc = "A card used to identify members of the blue team for CTF"
	icon_state = "ctf_blue"

/obj/item/card/id/yellow
	name = "Yellow Team identification card"
	desc = "A card used to identify members of the yellow team for CTF"
	icon_state = "ctf_yellow"

/obj/item/card/id/green
	name = "Green Team identification card"
	desc = "A card used to identify members of the green team for CTF"
	icon_state = "ctf_green"

/obj/item/card/id/advanced/ratvar
	name = "карта служителя"
	icon_state = "ratvar"
	access = list(ACCESS_CLOCKCULT, ACCESS_MAINT_TUNNELS)
