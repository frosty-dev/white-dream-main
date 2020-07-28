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
	user.visible_message("<span class='suicide'>[user] begins to swipe [user.p_their()] neck with \the [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
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

/obj/item/card/id
	name = "идентификационная карта"
	desc = "Карта, используемая для предоставления ID и определения доступа на станции."
	icon_state = "id"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	slot_flags = ITEM_SLOT_ID
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	var/id_type_name = "identification card"
	var/mining_points = 0 //For redeeming at mining equipment vendors
	var/list/access = list()
	var/registered_name = null // The name registered_name on the card
	var/assignment = null
	var/access_txt // mapping aid
	var/datum/bank_account/registered_account
	var/obj/machinery/paystand/my_store
	var/uses_overlays = TRUE
	var/icon/cached_flat_icon
	var/registered_age = 13 // default age for ss13 players

/obj/item/card/id/Initialize(mapload)
	. = ..()
	if(mapload && access_txt)
		access = text2access(access_txt)
	RegisterSignal(src, COMSIG_ATOM_UPDATED_ICON, .proc/update_in_wallet)

/obj/item/card/id/Destroy()
	if (registered_account)
		registered_account.bank_cards -= src
	if (my_store && my_store.my_card == src)
		my_store.my_card = null
	return ..()

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
			if(NAMEOF(src, assignment),NAMEOF(src, registered_name),NAMEOF(src, registered_age))
				update_label()

/obj/item/card/id/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/holochip))
		insert_money(W, user)
		return
	else if(istype(W, /obj/item/stack/spacecash))
		insert_money(W, user, TRUE)
		return
	else if(istype(W, /obj/item/coin))
		insert_money(W, user, TRUE)
		return
	else if(istype(W, /obj/item/storage/bag/money))
		var/obj/item/storage/bag/money/money_bag = W
		var/list/money_contained = money_bag.contents

		var/money_added = mass_insert_money(money_contained, user)

		if (money_added)
			to_chat(user, "<span class='notice'>Прикладываю деньги к карте. Они исчезают в клубах дыма, добавляя [money_added] кредитов на мой аккаунт.</span>")
		return
	else
		return ..()

/obj/item/card/id/proc/insert_money(obj/item/I, mob/user, physical_currency)
	if(!registered_account)
		to_chat(user, "<span class='warning'>[src] doesn't have a linked account to deposit [I] into!</span>")
		return
	var/cash_money = I.get_item_credit_value()
	if(!cash_money)
		to_chat(user, "<span class='warning'><b>[capitalize(I.name)]</b> не очень похоже на деньги!</span>")
		return
	registered_account.adjust_money(cash_money)
	SSblackbox.record_feedback("amount", "credits_inserted", cash_money)
	log_econ("[cash_money] credits were inserted into [src] owned by [src.registered_name]")
	if(physical_currency)
		to_chat(user, "<span class='notice'>Вставляю <b>[I.name]</b> в <b>[src.name]</b>. Они исчезают в клубах дыма, добавляя [cash_money] кредитов на мой аккаунт.</span>")
	else
		to_chat(user, "<span class='notice'>Вставляю <b>[I.name]</b> в <b>[src.name]</b> добавляя [cash_money] кредитов на мой аккаунт.</span>")

	to_chat(user, "<span class='notice'>Привязанный аккаунт сообщает о балансе в размере [registered_account.account_balance] кредитов.</span>")
	qdel(I)

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

/obj/item/card/id/proc/alt_click_can_use_id(mob/living/user)
	if(!isliving(user))
		return
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return

	return TRUE

// Returns true if new account was set.
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

	for(var/A in SSeconomy.bank_accounts)
		var/datum/bank_account/B = A
		if(B.account_id == new_bank_id)
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
		registered_account.bank_card_talk("<span class='warning'>内部服务器错误</span>", TRUE)
		return

	var/amount_to_remove =  FLOOR(input(user, "Сколько извлекаем? Баланс: [registered_account.account_balance]", "Вывод бабла", 5) as num|null, 1)

	if(!amount_to_remove || amount_to_remove < 0)
		return
	if(!alt_click_can_use_id(user))
		return
	if(registered_account.adjust_money(-amount_to_remove))
		var/obj/item/holochip/holochip = new (user.drop_location()[1], amount_to_remove)
		user.put_in_hands(holochip)
		to_chat(user, "<span class='notice'>Снимаю [amount_to_remove] кредитов формируя голо-чип.</span>")
		SSblackbox.record_feedback("amount", "credits_removed", amount_to_remove)
		log_econ("[amount_to_remove] credits were removed from [src] owned by [src.registered_name]")
		return
	else
		var/difference = amount_to_remove - registered_account.account_balance
		registered_account.bank_card_talk("<span class='warning'>ОШИБКА: Привязанный аккаунт имеет недостаток в размере [difference] кредитов для снятия суммы.</span>", TRUE)

/obj/item/card/id/examine(mob/user)
	. = ..()
	if(registered_account)
		. += "Привязанный аккаунт принадлежит '<b>[registered_account.account_holder]</b>' и сообщает о балансе <b>[registered_account.account_balance]</b> кредитов."
	. += "<span class='notice'><i>Здесь ещё какая-то информация, стоит всмотреться...</i></span>"

/obj/item/card/id/examine_more(mob/user)
	var/list/msg = list("<span class='notice'><i>Осматриваю <b>[src]</b> ближе и вижу следующее...</i></span>")

	if(registered_age)
		msg += "Владелец карты возрастом <b>[registered_age]</b>. [(registered_age < AGE_MINOR) ? "Тут есть голографическая полоса, которая гласит <b><span class='danger'>'СТАЖИРОВКА: НЕ ПРОДАВАТЬ АЛКОГОЛЬ ИЛИ ТАБАК'</span></b> в самом низу карты." : ""]"
	if(mining_points)
		msg += "Вау, здесь же есть [mining_points] шахтёрских очков на разные штуки из шахтёрского инвентаря."
	if(registered_account)
		msg += "Привязанный аккаунт принадлежит '[registered_account.account_holder]' и сообщает о балансе в размере <b>[registered_account.account_balance] кредитов</b>."
		if(registered_account.account_job)
			var/datum/bank_account/D = SSeconomy.get_dep_account(registered_account.account_job.paycheck_department)
			if(D)
				msg += "Баланс [D.account_holder] составляет <b>[D.account_balance] кредитов."
		msg += "<span class='info'>Alt-клик на ID-карте для снятия денег.</span>"
		msg += "<span class='info'>Похоже сюда можно вставлять голо-чипы, монетки и прочую валюту.</span>"
		if(registered_account.civilian_bounty)
			msg += "<span class='info'><b>Есть активный гражданский заказ.</b>"
			msg += "<span class='info'><i>[registered_account.bounty_text()]</i></span>"
			msg += "<span class='info'>Количество: [registered_account.bounty_num()]</span>"
			msg += "<span class='info'>Награда: [registered_account.bounty_value()]</span>"
		if(registered_account.account_holder == user.real_name)
			msg += "<span class='boldnotice'>Если ты потеряешь эту ID-карту, ты можешь запросто переподключить свой счёт используя Alt-клик на своей новой карте.</span>"
	else
		msg += "<span class='info'>Похоже здесь не привязан аккаунт. Alt-клик для привязки аккаунта поможет.</span>"

	return msg

/obj/item/card/id/GetAccess()
	return access

/obj/item/card/id/GetID()
	return src

/obj/item/card/id/RemoveID()
	return src

/obj/item/card/id/update_overlays()
	. = ..()
	if(!uses_overlays)
		return
	cached_flat_icon = null
	var/job = assignment ? ckey(GetJobName()) : null
	if(registered_name && registered_name != "Captain")
		. += mutable_appearance(icon, "assigned")
	if(job)
		if(job == "russianofficer" || job == "veteran" || job == "internationalofficer" || job == "trader" || job == "hacker")
			. += mutable_appearance('white/valtos/icons/card.dmi', "id[job]")
		else
			. += mutable_appearance(icon, "id[job]")

/obj/item/card/id/proc/update_in_wallet()
	if(istype(loc, /obj/item/storage/wallet))
		var/obj/item/storage/wallet/powergaming = loc
		if(powergaming.front_id == src)
			powergaming.update_label()
			powergaming.update_icon()

/obj/item/card/id/proc/get_cached_flat_icon()
	if(!cached_flat_icon)
		cached_flat_icon = getFlatIcon(src)
	return cached_flat_icon


/obj/item/card/id/get_examine_string(mob/user, thats = FALSE)
	if(uses_overlays)
		return "[icon2html(get_cached_flat_icon(), user)] [get_examine_name(user)]" //displays all overlays in chat
	return ..()

/*
Usage:
update_label()
	Sets the id name to whatever registered_name and assignment is
*/

/obj/item/card/id/proc/update_label()
	var/blank = !registered_name
	name = "[blank ? id_type_name : "ID-карта [registered_name]"][(!assignment) ? "" : " ([assignment])"]"
	update_icon()

/obj/item/card/id/silver
	name = "серебрянная ID-карта"
	id_type_name = "серебрянная ID-карта"
	desc = "Серебряная карта, которая показывает честь и преданность делу."
	icon_state = "silver"
	inhand_icon_state = "silver_id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'

/obj/item/card/id/silver/reaper
	name = "Thirteen's ID-карта (ЖОПОТРАХЕР)"
	access = list(ACCESS_MAINT_TUNNELS)
	assignment = "Reaper"
	registered_name = "Thirteen"

/obj/item/card/id/gold
	name = "золотая ID-карта"
	id_type_name = "золотая ID-карта"
	desc = "Золотая карта, которая показывает силу и мощь."
	icon_state = "gold"
	inhand_icon_state = "gold_id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'

/obj/item/card/id/syndicate
	name = "ID-карта агента"
	access = list(ACCESS_MAINT_TUNNELS, ACCESS_SYNDICATE)
	var/anyone = FALSE //Can anyone forge the ID or just syndicate?
	var/forged = FALSE //have we set a custom name and job assignment, or will we use what we're given when we chameleon change?

/obj/item/card/id/syndicate/Initialize()
	. = ..()
	var/datum/action/item_action/chameleon/change/id/chameleon_action = new(src)
	chameleon_action.chameleon_type = /obj/item/card/id
	chameleon_action.chameleon_name = "ID Card"
	chameleon_action.initialize_disguises()

/obj/item/card/id/syndicate/afterattack(obj/item/O, mob/user, proximity)
	if(!proximity)
		return
	if(istype(O, /obj/item/card/id))
		var/obj/item/card/id/I = O
		src.access |= I.access
		if(isliving(user) && user.mind)
			if(user.mind.special_role || anyone)
				to_chat(usr, "<span class='notice'>Микросканеры карты активируются, когда ею проводят по другой карте, копируя её доступ.</span>")

/obj/item/card/id/syndicate/attack_self(mob/user)
	if(isliving(user) && user.mind)
		var/first_use = registered_name ? FALSE : TRUE
		if(!(user.mind.special_role || anyone)) //Unless anyone is allowed, only syndies can use the card, to stop metagaming.
			if(first_use) //If a non-syndie is the first to forge an unassigned agent ID, then anyone can forge it.
				anyone = TRUE
			else
				return ..()

		var/popup_input = alert(user, "Выбрать бы действие", "ID-карта агента", "Показать", "СБРОСИТЬ", "Изменить ID-номер")
		if(user.incapacitated())
			return
		if(popup_input == "СБРОСИТЬ" && !forged)
			var/input_name = stripped_input(user, "Какое имя на этот раз? Можно оставить поле пустым для случая.", "Имя агента", registered_name ? registered_name : (ishuman(user) ? user.real_name : user.name), MAX_NAME_LEN)
			input_name = sanitize_name(input_name)
			if(!input_name)
				// Invalid/blank names give a randomly generated one.
				if(user.gender == MALE)
					input_name = "[pick(GLOB.first_names_male)] [pick(GLOB.last_names)]"
				else if(user.gender == FEMALE)
					input_name = "[pick(GLOB.first_names_female)] [pick(GLOB.last_names)]а"
				else
					input_name = "[pick(GLOB.first_names)] [pick(GLOB.last_names)]"

			var/target_occupation = stripped_input(user, "Какую должность мы выберем?\nЗаметка: это не добавит доступа, просто изменит видимую должность.", "Выбираем работу", assignment ? assignment : "Assistant", MAX_MESSAGE_LEN)
			if(!target_occupation)
				return

			var/newAge = input(user, "Выбираем возраст:\n([AGE_MIN]-[AGE_MAX])", "Возраст") as num|null
			if(newAge)
				registered_age = max(round(text2num(newAge)), 0)

			registered_name = input_name
			assignment = target_occupation
			update_label()
			forged = TRUE
			to_chat(user, "<span class='notice'>ID-карта обновлена.</span>")
			log_game("[key_name(user)] has forged \the [initial(name)] with name \"[registered_name]\" and occupation \"[assignment]\".")

			// First time use automatically sets the account id to the user.
			if (first_use && !registered_account)
				if(ishuman(user))
					var/mob/living/carbon/human/accountowner = user

					for(var/bank_account in SSeconomy.bank_accounts)
						var/datum/bank_account/account = bank_account
						if(account.account_id == accountowner.account_id)
							account.bank_cards += src
							registered_account = account
							to_chat(user, "<span class='notice'>Номер банковского аккаунта автоматически переназначен.</span>")
			return
		else if (popup_input == "СБРОСИТЬ" && forged)
			registered_name = initial(registered_name)
			assignment = initial(assignment)
			log_game("[key_name(user)] has reset \the [initial(name)] named \"[src]\" to default.")
			update_label()
			forged = FALSE
			to_chat(user, "<span class='notice'>Успешно сбрасываю данные карточки.</span>")
			return
		else if (popup_input == "Изменить ID-номер")
			set_new_account(user)
			return
	return ..()

/obj/item/card/id/syndicate/anyone
	anyone = TRUE

/obj/item/card/id/syndicate/nuke_leader
	name = "ID-карта лидера"
	access = list(ACCESS_MAINT_TUNNELS, ACCESS_SYNDICATE, ACCESS_SYNDICATE_LEADER)

/obj/item/card/id/syndicate_command
	name = "ID-карта синдиката"
	id_type_name = "ID-карта синдиката"
	desc = "Настоящая. Синдикатовская."
	registered_name = "Syndicate"
	assignment = "Syndicate Overlord"
	icon_state = "syndie"
	access = list(ACCESS_SYNDICATE)
	uses_overlays = FALSE
	registered_age = null

/obj/item/card/id/syndicate_command/crew_id
	name = "ID-карта синдиката"
	id_type_name = "ID-карта синдиката"
	desc = "Настоящая. Синдикатовская."
	registered_name = "Syndicate"
	assignment = "Syndicate Operative"
	icon_state = "syndie"
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS)
	uses_overlays = FALSE

/obj/item/card/id/syndicate_command/captain_id
	name = "ID-карта капитана синдиката"
	id_type_name = "ID-карта капитана синдиката"
	desc = "Настоящая. Синдикатовская."
	registered_name = "Syndicate"
	assignment = "Syndicate Ship Captain"
	icon_state = "syndie"
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS)
	uses_overlays = FALSE

/obj/item/card/id/captains_spare
	name = "запасная ID-карта капитана"
	id_type_name = "запасная ID-карта капитана"
	desc = "Запасная ID-карта самого Верховного Лорда."
	icon_state = "gold"
	inhand_icon_state = "gold_id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	registered_name = "Captain"
	assignment = "Captain"
	registered_age = null

/obj/item/card/id/captains_spare/trap
	desc = "Запасная ID-карта самого Верховного Лорда. К ней привязана какая-то микросхема..."
	anchored = TRUE
	var/first_try = TRUE

/obj/item/card/id/captains_spare/Initialize()
	var/datum/job/captain/J = new/datum/job/captain
	access = J.get_access()
	. = ..()
	update_label()

/obj/item/card/id/captains_spare/trap/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WIRECUTTER && first_try)
		to_chat(user, "<span class='notice'>Начинаю обезвреживать карту. (это займёт примерно одну минуту и нужно не шевелиться)</span>")
		if(do_after(user, 1 MINUTES, target = src))
			to_chat(user, "<span class='notice'>Карта разминирована.</span>")
			first_try = FALSE
			anchored = FALSE
			priority_announce("[user.real_name] пытается украсть капитанскую карту. Остановите [user.ru_ego()]!", title = "Кража", sound = 'sound/machines/alarm.ogg')
	else
		return ..()

/obj/item/card/id/captains_spare/trap/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(iscarbon(user) && first_try && !HAS_TRAIT(user.mind, TRAIT_DISK_VERIFIER))
		var/mob/living/carbon/C = user
		to_chat(C, "<span class='warning'>Пытаюсь подобрать карту... Что может пойти не тка~</span>")
		if(do_after(C, 10, target = src))
			to_chat(C, "<span class='userdanger'>КАРТА БЫЛА ЗАМИНИРОВАНА! СУКА!</span>")
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
	else if (HAS_TRAIT(user.mind, TRAIT_DISK_VERIFIER))
		to_chat(user, "<span class='notice'>Карта разминирована.</span>")
		first_try = FALSE
		anchored = FALSE

/obj/item/card/id/captains_spare/update_label() //so it doesn't change to Captain's ID card (Captain) on a sneeze
	if(registered_name == "Captain")
		name = "[id_type_name][(!assignment || assignment == "Captain") ? "" : " ([assignment])"]"
		update_icon()
	else
		..()

/obj/item/card/id/centcom
	name = "\improper CentCom ID"
	id_type_name = "\improper CentCom ID"
	desc = "Карта прямо из Центрального командования."
	icon_state = "centcom"
	registered_name = "Central Command"
	assignment = "Central Command"
	uses_overlays = FALSE
	registered_age = null

/obj/item/card/id/centcom/Initialize()
	access = get_all_centcom_access()
	. = ..()

/obj/item/card/id/ert
	name = "\improper CentCom ID"
	id_type_name = "\improper CentCom ID"
	desc = "Карта офицера отряда быстрого реагирования."
	icon_state = "ert_commander"
	registered_name = "Emergency Response Team Commander"
	assignment = "Emergency Response Team Commander"
	uses_overlays = FALSE
	registered_age = null

/obj/item/card/id/ert/Initialize()
	access = get_all_accesses()+get_ert_access("commander")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/security
	registered_name = "Security Response Officer"
	assignment = "Security Response Officer"
	icon_state = "ert_security"

/obj/item/card/id/ert/security/Initialize()
	access = get_all_accesses()+get_ert_access("sec")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/engineer
	registered_name = "Engineering Response Officer"
	assignment = "Engineering Response Officer"
	icon_state = "ert_engineer"

/obj/item/card/id/ert/engineer/Initialize()
	access = get_all_accesses()+get_ert_access("eng")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/medical
	registered_name = "Medical Response Officer"
	assignment = "Medical Response Officer"
	icon_state = "ert_medic"

/obj/item/card/id/ert/medical/Initialize()
	access = get_all_accesses()+get_ert_access("med")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/chaplain
	registered_name = "Religious Response Officer"
	assignment = "Religious Response Officer"
	icon_state = "ert_chaplain"

/obj/item/card/id/ert/chaplain/Initialize()
	access = get_all_accesses()+get_ert_access("sec")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/janitor
	registered_name = "Janitorial Response Officer"
	assignment = "Janitorial Response Officer"
	icon_state = "ert_janitor"

/obj/item/card/id/ert/janitor/Initialize()
	access = get_all_accesses()
	. = ..()

/obj/item/card/id/ert/clown
	registered_name = "Entertainment Response Officer"
	assignment = "Entertainment Response Officer"
	icon_state = "ert_clown"

/obj/item/card/id/ert/clown/Initialize()
	access = get_all_accesses()
	. = ..()

/obj/item/card/id/ert/deathsquad
	name = "\improper Death Squad ID"
	id_type_name = "\improper Death Squad ID"
	desc = "Карта офицера отряда смерти?"
	icon_state = "deathsquad" //NO NO SIR DEATH SQUADS ARENT A PART OF NANOTRASEN AT ALL
	registered_name = "Death Commando"
	assignment = "Death Commando"
	uses_overlays = FALSE

/obj/item/card/id/debug
	name = "\improper Debug ID"
	desc = "A debug ID card. Has ALL the all access, you really shouldn't have this."
	icon_state = "ert_janitor"
	assignment = "Jannie"
	uses_overlays = FALSE

/obj/item/card/id/debug/Initialize()
	access = get_all_accesses()+get_all_centcom_access()+get_all_syndicate_access()
	registered_account = SSeconomy.get_dep_account(ACCOUNT_CAR)
	. = ..()

/obj/item/card/id/prisoner
	name = "ID-карта заключённого"
	id_type_name = "ID-карта заключённого"
	desc = "Ты номер, ты не свободный человек."
	icon_state = "orange"
	inhand_icon_state = "orange-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	assignment = "Prisoner"
	registered_name = "Scum"
	uses_overlays = FALSE
	var/goal = 0 //How far from freedom?
	var/points = 0
	registered_age = null

/obj/item/card/id/prisoner/attack_self(mob/user)
	to_chat(usr, "<span class='notice'>Собрано [points] очков. Всего нужно собрать [goal] для выхода.</span>")

/obj/item/card/id/prisoner/one
	name = "Заключённый #13-001"
	registered_name = "Заключённый #13-001"
	icon_state = "prisoner_001"

/obj/item/card/id/prisoner/two
	name = "Заключённый #13-002"
	registered_name = "Заключённый #13-002"
	icon_state = "prisoner_002"

/obj/item/card/id/prisoner/three
	name = "Заключённый #13-003"
	registered_name = "Заключённый #13-003"
	icon_state = "prisoner_003"

/obj/item/card/id/prisoner/four
	name = "Заключённый #13-004"
	registered_name = "Заключённый #13-004"
	icon_state = "prisoner_004"

/obj/item/card/id/prisoner/five
	name = "Заключённый #13-005"
	registered_name = "Заключённый #13-005"
	icon_state = "prisoner_005"

/obj/item/card/id/prisoner/six
	name = "Заключённый #13-006"
	registered_name = "Заключённый #13-006"
	icon_state = "prisoner_006"

/obj/item/card/id/prisoner/seven
	name = "Заключённый #13-007"
	registered_name = "Заключённый #13-007"
	icon_state = "prisoner_007"

/obj/item/card/id/mining
	name = "шахтёрская ID-карта"
	access = list(ACCESS_MINING, ACCESS_MINING_STATION, ACCESS_MECH_MINING, ACCESS_MAILSORTING, ACCESS_MINERAL_STOREROOM)

/obj/item/card/id/away
	name = "достаточно простая ID-карта"
	desc = "Совершенно обычная карта. Безвкусица."
	access = list(ACCESS_AWAY_GENERAL)
	icon_state = "retro"
	uses_overlays = FALSE
	registered_age = null

/obj/item/card/id/away/hotel
	name = "ID-карта отельщика"
	desc = "ID персонала используется для доступа к дверям отеля."
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT)

/obj/item/card/id/away/hotel/securty
	name = "ID-карта офицера"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_AWAY_SEC)

/obj/item/card/id/away/old
	name = "достаточно простая серебрянная ID-карта"
	desc = "Совершенно обычная карта. Безвкусица."

/obj/item/card/id/away/old/sec
	name = "ID-карта офицера станции Чарли"
	desc = "Выцветшая идентификационная карта Чарли. Можно разобрать должность \"Security Officer\"."
	assignment = "Charlie Station Security Officer"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_SEC)

/obj/item/card/id/away/old/sci
	name = "ID-карта учёного станции Чарли"
	desc = "Выцветшая идентификационная карта Чарли. Можно разобрать должность \"Scientist\"."
	assignment = "Charlie Station Scientist"
	access = list(ACCESS_AWAY_GENERAL)

/obj/item/card/id/away/old/eng
	name = "ID-карта инженера станции Чарли"
	desc = "Выцветшая идентификационная карта Чарли. Можно разобрать должность \"Station Engineer\"."
	assignment = "Charlie Station Engineer"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_ENGINE)

/obj/item/card/id/away/old/apc
	name = "ID-карта доступа к APC"
	desc = "Специальная идентификационная карта, которая позволяет получить доступ к терминалам APC."
	access = list(ACCESS_ENGINE_EQUIP)

/obj/item/card/id/away/deep_storage //deepstorage.dmm space ruin
	name = "ID-карта бункера"

/obj/item/card/id/departmental_budget
	name = "ведомственная карточка (FUCK)"
	desc = "Предоставляет доступ к бюджету отдела."
	icon_state = "budgetcard"
	uses_overlays = FALSE
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
		desc = "Предоставляет доступ к [department_name]."
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
	registered_account.bank_card_talk("<span class='warning'>Снятие денег не подходит для этого типа карт.</span>", TRUE) //prevents the vault bank machine being useless and putting money from the budget to your card to go over personal crates
