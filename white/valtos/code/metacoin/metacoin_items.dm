
/datum/metacoin_shop_item
	var/name = ""
	var/cost = 0
	var/id = ""
	var/enabled = FALSE

	//shat for icons
	var/icon = 'white/valtos/icons/metacoin/items.dmi'
	var/icon_state
	var/icon_dir = 2

/datum/metacoin_shop_item/proc/buy(client/C)
	if (!SSdbcore.IsConnected())
		to_chat(C, "<span class='rose bold'>ОШИБОЧКА! Попробуй ещё раз!</span>")
		return FALSE
	var/metacoins = C.get_metabalance()
	if (metacoins < cost)
		to_chat(C, "<span class='rose bold'>Не хватает средств для покупки [name]!</span>")
		return FALSE
	inc_metabalance(C.mob, -cost, reason="Покупка.")
	after_buy(C)
	to_chat(C, "<span class='rose bold'>Покупаю [name] за [cost] метакэша!</span>")

/datum/metacoin_shop_item/proc/after_buy(client/C)
	//giving them the item they bought

/datum/metacoin_shop_item/proc/get_icon(client/C) //getting the icon for the shop
	return icon2html(icon, C, icon_state, icon_dir)

/datum/metacoin_shop_item/mc_to_credits
	name = "Кредиты"
	icon_state = "cr"
	cost = 0
	id = "cr"
	enabled = TRUE
	var/amount_to_give = 0

/datum/metacoin_shop_item/mc_to_credits/buy(client/C)
	if(!SSticker.current_state == GAME_STATE_PLAYING)
		to_chat(C, "<span class='rose bold'>Слишком рано! Доступно только во время игры.</span>")
		return FALSE
	if(!ishuman(C.mob))
		to_chat(C, "<span class='rose bold'>А ты не человек.</span>")
		return FALSE
	amount_to_give = input("Конвертирование 1 к 50.","Введите число.") as null|num
	if(!isnum(amount_to_give) || amount_to_give < 0)
		to_chat(C, "<span class='rose bold'>Неправильное число. Должно быть положительным.</span>")
		return FALSE
	cost = amount_to_give
	..()
	cost = 0

/datum/metacoin_shop_item/mc_to_credits/after_buy(client/C)
	var/mob/living/carbon/human/H = C.mob
	var/obj/item/holochip/HC = new(get_turf(H), 50*amount_to_give)
	H.put_in_hands(HC)

/datum/metacoin_shop_item/rjaka
	name = "Ржака"
	icon_state = "lul"
	cost = 5
	id = "rjaka"
	enabled = FALSE

/datum/metacoin_shop_item/rjaka/after_buy(client/C)
	to_chat(C, "<span class='notice'>Произошла ржака!</span>")
	playsound(C.mob.loc,'white/hule/SFX/rjach.ogg', 200, 7, pressure_affected = FALSE)

/datum/metacoin_shop_item/force_aspect
	name = "Выбрать аспект"
	icon_state = "aspect"
	cost = 25
	id = "force_aspect"
	enabled = TRUE

/datum/metacoin_shop_item/force_aspect/after_buy(client/C)
	return

/datum/metacoin_shop_item/force_aspect/buy(client/C)
	if (SSticker.current_state == GAME_STATE_SETTING_UP || SSticker.current_state == GAME_STATE_PLAYING || SSticker.current_state == GAME_STATE_FINISHED)
		to_chat(C, "<span class='rose bold'>Невозможно! Доступно только перед началом раунда (когда игра прогрузилась, но ещё в лобби).</span>")
		return
	var/datum/round_aspect/sel_aspect = input("Аспекты:", "Выбирайте!", null, null) as null|anything in SSaspects.aspects
	if(!sel_aspect)
		to_chat(C, "<span class='notice'>Не выбран аспект.</span>")
		return
	else
		if(..())
			to_chat(C, "<span class='notice'>Выбрано <b>[sel_aspect]</b>! Другие игроки могут добавить ещё аспекты.</span>")
			SSaspects.forced_aspects[sel_aspect] = sel_aspect.weight

/datum/metacoin_shop_item/purge_this_shit
	name = "Фатальный сброс"
	icon_state = "purge"
	cost = 5000
	id = "purge_this_shit"
	enabled = TRUE

/datum/metacoin_shop_item/purge_this_shit/buy(client/C)
	var/fuck_everyone = alert(src,"Это действие приведёт обнулению ВСЕГО метакэша. Ты уверен?","Очищение","Да","Нет")
	if (fuck_everyone == "Да")
		return ..()

/datum/metacoin_shop_item/purge_this_shit/after_buy(client/C)
	var/datum/db_query/purge_shit = SSdbcore.NewQuery("UPDATE [format_table_name("player")] SET metacoins = '0'")
	purge_shit.warn_execute()
	for(var/client/AAA in GLOB.clients)
		AAA.update_metabalance_cache()

	if(isliving(C.mob) && C.mob.stat == CONSCIOUS)
		explosion(get_turf(C.mob), 14, 28, 56)

	to_chat(world, "<BR><BR><BR><center><span class='big bold'>[C.ckey] уничтожает банк метакэша.</span></center><BR><BR><BR>")

/datum/metacoin_shop_item/respawn_me
	name = "Перерождение"
	icon_state = "rjaka"
	cost = 50
	id = "respawn_me"
	enabled = TRUE

/datum/metacoin_shop_item/respawn_me/after_buy(client/C)
	to_chat(C, "<span class='notice'>Теперь ты можешь переродиться один раз в этом раунде. Не забудь поменять имя и забыть старые обиды.</span>")
	C.is_respawned = FALSE
	return

/datum/metacoin_shop_item/only_one //you can only buy this item once
	name = "only one"
	cost = 0 //gl with that one
	enabled = FALSE
	var/class //used for classifying different types of items, like wings, hair, undershirts, etc

/datum/metacoin_shop_item/only_one/buy(client/C)
	C.update_metacoin_items()
	if(id in C.metacoin_items)
		return
	..()

/datum/metacoin_shop_item/only_one/after_buy(client/C)
	var/datum/db_query/query_metacoin_item_purchase = SSdbcore.NewQuery({"
		INSERT INTO [format_table_name("metacoin_item_purchases")] (ckey, purchase_date, item_id, item_class)
		VALUES (:ckey, Now(), :id, :class)")
	"}, list("ckey" = C.key, "id" = id, "class" = class))
	query_metacoin_item_purchase.warn_execute()
	qdel(query_metacoin_item_purchase)
	C.update_metacoin_items()
