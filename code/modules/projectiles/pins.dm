/obj/item/firing_pin
	name = "электронный ударник"
	desc = "Небольшое устройство аутентификации, которое должно быть вставлено в приемник огнестрельного оружия, чтобы позволить сделать выстрел. Правила безопасности NT требуют, чтобы все новые конструкции включали это."
	icon = 'icons/obj/device.dmi'
	icon_state = "firing_pin"
	inhand_icon_state = "pen"
	worn_icon_state = "pen"
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("тычет")
	var/fail_message = "<span class='warning'>НЕПРАВИЛЬНЫЙ ПОЛЬЗОВАТЕЛЬ.</span>"
	var/selfdestruct = 0 // Explode when user check is failed.
	var/force_replace = 0 // Can forcefully replace other pins.
	var/pin_removeable = 0 // Can be replaced by any pin.
	var/obj/item/gun/gun

/obj/item/firing_pin/New(newloc)
	..()
	if(istype(newloc, /obj/item/gun))
		gun = newloc

/obj/item/firing_pin/afterattack(atom/target, mob/user, proximity_flag)
	. = ..()
	if(proximity_flag)
		if(istype(target, /obj/item/gun))
			var/obj/item/gun/G = target
			var/obj/item/firing_pin/old_pin = G.pin
			if(old_pin && (force_replace || old_pin.pin_removeable))
				to_chat(user, "<span class='notice'>Вы убрали [old_pin] из [G].</span>")
				if(Adjacent(user))
					user.put_in_hands(old_pin)
				else
					old_pin.forceMove(G.drop_location())
				old_pin.gun_remove(user)

			if(!G.pin)
				if(!user.temporarilyRemoveItemFromInventory(src))
					return
				gun_insert(user, G)
				to_chat(user, "<span class='notice'>Вы вставили [src] в [G].</span>")
			else
				to_chat(user, "<span class='notice'>Это оружие уже имеет ударник.</span>")

/obj/item/firing_pin/emag_act(mob/user)
	if(obj_flags & EMAGGED)
		return
	obj_flags |= EMAGGED
	to_chat(user, "<span class='notice'>Вы перезаписали механизм авторизации.</span>")

/obj/item/firing_pin/proc/gun_insert(mob/living/user, obj/item/gun/G)
	gun = G
	forceMove(gun)
	gun.pin = src
	return

/obj/item/firing_pin/proc/gun_remove(mob/living/user)
	gun.pin = null
	gun = null
	return

/obj/item/firing_pin/proc/pin_auth(mob/living/user)
	return TRUE

/obj/item/firing_pin/proc/auth_fail(mob/living/user)
	if(user)
		user.show_message(fail_message, MSG_VISUAL)
	if(selfdestruct)
		if(user)
			user.show_message("<span class='danger'>Запуск механизма самоуничтожения...</span><br>", MSG_VISUAL)
			to_chat(user, "<span class='userdanger'>[gun] взорвался!</span>")
		explosion(get_turf(gun), -1, 0, 2, 3)
		if(gun)
			qdel(gun)


/obj/item/firing_pin/magic
	name = "магический осколок кристалла"
	desc = "Маленький вставленый осколок позволяет магичексому оружию стрелять."


// Test pin, works only near firing range.
/obj/item/firing_pin/test_range
	name = "ударник для тестовой площадки"
	desc = "Данный ударник позволяет протестировать оружие на тестовой площадке. В ином месте это не будет работать."
	fail_message = "<span class='warning'>ВЫ НЕ НА ТЕСТОВОЙ ПЛОЩАДКЕ.</span>"
	pin_removeable = TRUE

/obj/item/firing_pin/test_range/pin_auth(mob/living/user)
	if(!istype(user))
		return FALSE
	for(var/obj/machinery/magnetic_controller/M in range(user, 3))
		return TRUE
	return FALSE


// Implant pin, checks for implant
/obj/item/firing_pin/implant
	name = "иплантозависимый ударник"
	desc = "Этот ударник позволяет только авторизованным пользователям делать выстрел, причем пользователь должен быть имплантирован определенным устройством."
	fail_message = "<span class='warning'>НЕТ ИМПЛАНТА. В ДОСТУПЕ ОТКАЗАНО.</span>"
	var/obj/item/implant/req_implant = null

/obj/item/firing_pin/implant/pin_auth(mob/living/user)
	if(user)
		for(var/obj/item/implant/I in user.implants)
			if(req_implant && I.type == req_implant)
				return TRUE
	return FALSE

/obj/item/firing_pin/implant/mindshield
	name = "ударник под мозгозащиту"
	desc = "Этот ударник настроен на тех, кто имплантировал в себя мозгозащиту."
	icon_state = "firing_pin_loyalty"
	req_implant = /obj/item/implant/mindshield

/obj/item/firing_pin/implant/pindicate
	name = "синдикатский ударник"
	icon_state = "firing_pin_pindi"
	req_implant = /obj/item/implant/weapons_auth



// Honk pin, clown's joke item.
// Can replace other pins. Replace a pin in cap's laser for extra fun!
/obj/item/firing_pin/clown
	name = "веселый ударник"
	desc = "Усовершенствованый клованский ударник. Рекомендуется сунуть в капитанскую лазерную пушку для большей ржаки."
	color = "#FFFF00"
	fail_message = "<span class='warning'>ВОТ ЭТО ПРИКОЛ!</span>"
	force_replace = TRUE

/obj/item/firing_pin/clown/pin_auth(mob/living/user)
	playsound(src, 'sound/items/bikehorn.ogg', 50, TRUE)
	return FALSE

// Ultra-honk pin, clown's deadly joke item.
// A gun with ultra-honk pin is useful for clown and useless for everyone else.
/obj/item/firing_pin/clown/ultra
	name = "ultra hilarious firing pin"

/obj/item/firing_pin/clown/ultra/pin_auth(mob/living/user)
	playsound(src.loc, 'sound/items/bikehorn.ogg', 50, TRUE)
	if(QDELETED(user))  //how the hell...?
		stack_trace("/obj/item/firing_pin/clown/ultra/pin_auth called with a [isnull(user) ? "null" : "invalid"] user.")
		return TRUE
	if(HAS_TRAIT(user, TRAIT_CLUMSY)) //clumsy
		return TRUE
	if(user.mind)
		if(user.mind.assigned_role == "Clown") //traitor clowns can use this, even though they're technically not clumsy
			return TRUE
		if(user.mind.has_antag_datum(/datum/antagonist/nukeop/clownop)) //clown ops aren't clumsy by default and technically don't have an assigned role of "Clown", but come on, they're basically clowns
			return TRUE
		if(user.mind.has_antag_datum(/datum/antagonist/nukeop/leader/clownop)) //Wanna hear a funny joke?
			return TRUE //The clown op leader antag datum isn't a subtype of the normal clown op antag datum.
	return FALSE

/obj/item/firing_pin/clown/ultra/gun_insert(mob/living/user, obj/item/gun/G)
	..()
	G.clumsy_check = FALSE

/obj/item/firing_pin/clown/ultra/gun_remove(mob/living/user)
	gun.clumsy_check = initial(gun.clumsy_check)
	..()

// Now two times deadlier!
/obj/item/firing_pin/clown/ultra/selfdestruct
	desc = "Усовершенствованый клованский ударник. Содержит малый заряд бананиума."
	selfdestruct = TRUE


// DNA-keyed pin.
// When you want to keep your toys for yourself.
/obj/item/firing_pin/dna
	name = "генный ударник"
	desc = "Связывает вас и оружие на генном уровне. Никто, кроме вас, не сможет выстрелить."
	icon_state = "firing_pin_dna"
	fail_message = "<span class='warning'>ХРОМОСОМЫ НЕ СОВПАДАЮТ.</span>"
	var/unique_enzymes = null

/obj/item/firing_pin/dna/afterattack(atom/target, mob/user, proximity_flag)
	. = ..()
	if(proximity_flag && iscarbon(target))
		var/mob/living/carbon/M = target
		if(M.dna && M.dna.unique_enzymes)
			unique_enzymes = M.dna.unique_enzymes
			to_chat(user, "<span class='notice'>ДНК установлено.</span>")

/obj/item/firing_pin/dna/pin_auth(mob/living/carbon/user)
	if(user && user.dna && user.dna.unique_enzymes)
		if(user.dna.unique_enzymes == unique_enzymes)
			return TRUE
	return FALSE

/obj/item/firing_pin/dna/auth_fail(mob/living/carbon/user)
	if(!unique_enzymes)
		if(user && user.dna && user.dna.unique_enzymes)
			unique_enzymes = user.dna.unique_enzymes
			to_chat(user, "<span class='notice'>ДНК установлено.</span>")
	else
		..()

/obj/item/firing_pin/dna/dredd
	desc = "Связывает вас и оружие на генном уровне. Никто, кроме вас, не сможет выстрелить. А если попытаются, то взорвутся."
	selfdestruct = TRUE

// Paywall pin, brought to you by ARMA 3 DLC.
// Checks if the user has a valid bank account on an ID and if so attempts to extract a one-time payment to authorize use of the gun. Otherwise fails to shoot.
/obj/item/firing_pin/paywall
	name = "платный ударник"
	desc = "Ударник со встроенным купюроприемником."
	color = "#FFD700"
	fail_message = ""
	var/list/gun_owners = list() //list of people who've accepted the license prompt. If this is the multi-payment pin, then this means they accepted the waiver that each shot will cost them money
	var/payment_amount //how much gets paid out to license yourself to the gun
	var/obj/item/card/id/pin_owner
	var/multi_payment = FALSE //if true, user has to pay everytime they fire the gun
	var/owned = FALSE
	var/active_prompt = FALSE //purchase prompt to prevent spamming it

/obj/item/firing_pin/paywall/attack_self(mob/user)
	multi_payment = !multi_payment
	to_chat(user, "<span class='notice'>You set the pin to [( multi_payment ) ? "process payment for every shot" : "one-time license payment"].</span>")

/obj/item/firing_pin/paywall/examine(mob/user)
	. = ..()
	if(pin_owner)
		. += "<span class='notice'>This firing pin is currently authorized to pay into the account of [pin_owner.registered_name].</span>"

/obj/item/firing_pin/paywall/gun_insert(mob/living/user, obj/item/gun/G)
	if(!pin_owner)
		to_chat(user, "<span class='warning'>ERROR: Проведите картой по ударнику, прежде чем вставлять в оружие!</span>")
		return
	gun = G
	forceMove(gun)
	gun.pin = src
	if(multi_payment)
		gun.desc += "<span class='notice'> Этот [gun.name] имеет стоимость за выстрел [payment_amount] cr.[( payment_amount > 1 ) ? "s" : ""].</span>"
		return
	gun.desc += "<span class='notice'> Этот [gun.name] премиальный доступ за [payment_amount] cr.[( payment_amount > 1 ) ? "s" : ""].</span>"
	return


/obj/item/firing_pin/paywall/gun_remove(mob/living/user)
	gun.desc = initial(desc)
	..()

/obj/item/firing_pin/paywall/attackby(obj/item/M, mob/user, params)
	if(istype(M, /obj/item/card/id))
		var/obj/item/card/id/id = M
		if(!id.registered_account)
			to_chat(user, "<span class='warning'>ERROR: У карты отсутствует банковский счет!</span>")
			return
		if(id != pin_owner && owned)
			to_chat(user, "<span class='warning'>ERROR: Ударник уже авторизован!</span>")
			return
		if(id == pin_owner)
			to_chat(user, "<span class='notice'>Вы отвязали ударник от карты.</span>")
			gun_owners -= user
			pin_owner = null
			owned = FALSE
			return
		var/transaction_amount = input(user, "Введите действительную сумму депозита для покупки оружия", "Денежный депозит") as null|num
		if(transaction_amount < 1)
			to_chat(user, "<span class='warning'>ERROR: Указана неверная сумма.</span>")
			return
		if(!transaction_amount)
			return
		pin_owner = id
		owned = TRUE
		payment_amount = transaction_amount
		gun_owners += user
		to_chat(user, "<span class='notice'>Вы связываете карту с ударником.</span>")

/obj/item/firing_pin/paywall/pin_auth(mob/living/user)
	if(!istype(user))//nice try commie
		return FALSE
	if(ishuman(user))
		var/datum/bank_account/credit_card_details
		var/mob/living/carbon/human/H = user
		if(H.get_bank_account())
			credit_card_details = H.get_bank_account()
		if(H in gun_owners)
			if(multi_payment && credit_card_details)
				if(credit_card_details.adjust_money(-payment_amount))
					pin_owner.registered_account.adjust_money(payment_amount)
					return TRUE
				to_chat(user, "<span class='warning'>ERROR: Недостаточно баланса пользователя для успешной транзакции!</span>")
				return FALSE
			return TRUE
		if(credit_card_details && !active_prompt)
			var/license_request = alert(usr, "Желаете заплатить [payment_amount] cr.[( payment_amount > 1 ) ? "s" : ""] за [( multi_payment ) ? "каждый выстрел [gun.name]" : "лицензия на пользование [gun.name]"]?", "Покупка оружия", "Да", "Нет")
			active_prompt = TRUE
			if(!user.canUseTopic(src, BE_CLOSE))
				active_prompt = FALSE
				return FALSE
			switch(license_request)
				if("Yes")
					if(credit_card_details.adjust_money(-payment_amount))
						pin_owner.registered_account.adjust_money(payment_amount)
						gun_owners += H
						to_chat(user, "<span class='notice'>Куплена лицензия!</span>")
						active_prompt = FALSE
						return FALSE //we return false here so you don't click initially to fire, get the prompt, accept the prompt, and THEN the gun
					to_chat(user, "<span class='warning'>ERROR: Недостаточно баланса пользователя для успешной транзакции!</span>")
					return FALSE
				if("No")
					to_chat(user, "<span class='warning'>ERROR: Пользователь отказался от лицензии на покупку оружия!</span>")
					return FALSE
		to_chat(user, "<span class='warning'>ERROR: У пользователя нет действующего банковского счета!</span>")
		return FALSE

// Explorer Firing Pin- Prevents use on station Z-Level, so it's justifiable to give Explorers guns that don't suck.
/obj/item/firing_pin/explorer
	name = "малонаселенный ударник"
	desc = "Ударник, используемый австралийскими силами, переоборудован, чтобы предотвратить сброс оружия на станцию"
	icon_state = "firing_pin_explorer"
	fail_message = "<span class='warning'>CANNOT FIRE WHILE ON STATION, MATE!</span>"

// This checks that the user isn't on the station Z-level.
/obj/item/firing_pin/explorer/pin_auth(mob/living/user)
	var/turf/station_check = get_turf(user)
	if(!station_check||is_station_level(station_check.z))
		to_chat(user, "<span class='warning'>Вы не можете использовать оружие на станции!</span>")
		return FALSE
	return TRUE

// Laser tag pins
/obj/item/firing_pin/tag
	name = "ударник для лазертага"
	desc = "Работает когда одет костюм для лазертага."
	fail_message = "<span class='warning'>КОСТЮМ ОТСУТСТВУЕТ.</span>"
	var/obj/item/clothing/suit/suit_requirement = null
	var/tagcolor = ""

/obj/item/firing_pin/tag/pin_auth(mob/living/user)
	if(ishuman(user))
		var/mob/living/carbon/human/M = user
		if(istype(M.wear_suit, suit_requirement))
			return TRUE
	to_chat(user, "<span class='warning'>Вы должны одеть [tagcolor] броню для лазертага!</span>")
	return FALSE

/obj/item/firing_pin/tag/red
	name = "красный ударник лазертага"
	icon_state = "firing_pin_red"
	suit_requirement = /obj/item/clothing/suit/redtag
	tagcolor = "red"

/obj/item/firing_pin/tag/blue
	name = "синий ударник лазертага"
	icon_state = "firing_pin_blue"
	suit_requirement = /obj/item/clothing/suit/bluetag
	tagcolor = "blue"

/obj/item/firing_pin/Destroy()
	if(gun)
		gun.pin = null
	return ..()
