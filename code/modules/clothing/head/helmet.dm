/obj/item/clothing/head/helmet
	name = "шлем"
	desc = "Стандартное снаряжение безопасности. Защищает голову от ударов."
	icon_state = "helmet"
	item_state = "helmet"
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30,"energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT
	strip_delay = 60
	clothing_flags = SNUG_FIT
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEHAIR

	dog_fashion = /datum/dog_fashion/head/helmet

	var/can_flashlight = FALSE //if a flashlight can be mounted. if it has a flashlight and this is false, it is permanently attached.
	var/obj/item/flashlight/seclite/attached_light
	var/datum/action/item_action/toggle_helmet_flashlight/alight

/obj/item/clothing/head/helmet/Initialize()
	. = ..()
	if(attached_light)
		alight = new(src)

/obj/item/clothing/head/helmet/examine(mob/user)
	. = ..()
	if(attached_light)
		. += "Имеет [attached_light] [can_flashlight ? "" : "намертво "] прикрученый к нему."
		if(can_flashlight)
			. += "<span class='info'>Похоже, что [attached_light] может быть <b>откручен</b> от [src].</span>"
	else if(can_flashlight)
		. += "Имеет точку для монтирования <b>фонарика</b>."

/obj/item/clothing/head/helmet/Destroy()
	QDEL_NULL(attached_light)
	return ..()

/obj/item/clothing/head/helmet/handle_atom_del(atom/A)
	if(A == attached_light)
		attached_light = null
		update_helmlight()
		update_icon()
		QDEL_NULL(alight)
	return ..()

/obj/item/clothing/head/helmet/sec
	can_flashlight = TRUE

/obj/item/clothing/head/helmet/sec/attackby(obj/item/I, mob/user, params)
	if(issignaler(I))
		var/obj/item/assembly/signaler/S = I
		if(attached_light) //Has a flashlight. Player must remove it, else it will be lost forever.
			to_chat(user, "<span class='warning'>Установленный фонарик мешает, сначала снять бы его!</span>")
			return

		if(S.secured)
			qdel(S)
			var/obj/item/bot_assembly/secbot/A = new
			user.put_in_hands(A)
			to_chat(user, "<span class='notice'>Добавляю сигналлер к шлему.</span>")
			qdel(src)
			return
	return ..()

/obj/item/clothing/head/helmet/alt
	name = "пуленепробиваемый шлем"
	desc = "Боевой пуленепробиваемый шлем, который в незначительной степени защищает владельца от традиционного стрелкового оружия и взрывчатых веществ."
	icon_state = "helmetalt"
	item_state = "helmetalt"
	armor = list("melee" = 15, "bullet" = 60, "laser" = 10, "energy" = 10, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	can_flashlight = TRUE
	dog_fashion = null

/obj/item/clothing/head/helmet/old
	name = "изношенный шлем"
	desc = "Стандартный защитный шлем. Из-за изношенности козырек шлема препятствует обзору на большие расстояния."
	tint = 2

/obj/item/clothing/head/helmet/blueshirt
	name = "синий шлем"
	desc = "Надежный шлем синего цвета, напоминающий вам, что вы все еще должны инженеру пиво."
	icon_state = "blueshift"
	item_state = "blueshift"
	custom_premium_price = 750

/obj/item/clothing/head/helmet/riot
	name = "анти-мятежный шлем"
	desc = "Это шлем, специально разработанный для защиты от атак с близкого расстояния."
	icon_state = "riot"
	item_state = "helmet"
	toggle_message = "Опускаю козырёк вниз"
	alt_toggle_message = "Поднимаю козырёк вверх"
	can_toggle = 1
	armor = list("melee" = 50, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 80)
	flags_inv = HIDEEARS|HIDEFACE
	strip_delay = 80
	actions_types = list(/datum/action/item_action/toggle)
	visor_flags_inv = HIDEFACE
	toggle_cooldown = 0
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	dog_fashion = null

/obj/item/clothing/head/helmet/attack_self(mob/user)
	if(can_toggle && !user.incapacitated())
		if(world.time > cooldown + toggle_cooldown)
			cooldown = world.time
			up = !up
			flags_1 ^= visor_flags
			flags_inv ^= visor_flags_inv
			flags_cover ^= visor_flags_cover
			icon_state = "[initial(icon_state)][up ? "up" : ""]"
			to_chat(user, "<span class='notice'>[up ? alt_toggle_message : toggle_message] [src].</span>")

			user.update_inv_head()
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				C.head_update(src, forced = 1)

			if(active_sound)
				while(up)
					playsound(src, "[active_sound]", 100, FALSE, 4)
					sleep(15)

/obj/item/clothing/head/helmet/justice
	name = "шлем правосудия"
	desc = "WEEEEOOO. WEEEEEOOO. WEEEEOOOO."
	icon_state = "justice"
	toggle_message = "Выключаю свет"
	alt_toggle_message = "Включаю свет"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	can_toggle = 1
	toggle_cooldown = 20
	active_sound = 'sound/items/weeoo1.ogg'
	dog_fashion = null

/obj/item/clothing/head/helmet/justice/escape
	name = "тревожный шлем"
	desc = "WEEEEOOO. WEEEEEOOO. STOP THAT MONKEY. WEEEOOOO."
	icon_state = "justice2"
	toggle_message = "You turn off the light on"
	alt_toggle_message = "You turn on the light on"

/obj/item/clothing/head/helmet/swat
	name = "шлем спецназа"
	desc = "Чрезвычайно прочный, компактный шлем в мерзкой красной и черной полосе."
	icon_state = "swatsyndie"
	item_state = "swatsyndie"
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30,"energy" = 40, "bomb" = 50, "bio" = 90, "rad" = 20, "fire" = 50, "acid" = 50)
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	clothing_flags = STOPSPRESSUREDAMAGE
	strip_delay = 80
	dog_fashion = null

/obj/item/clothing/head/helmet/police
	name = "полицейская шляпа"
	desc = "Шляпа офицера полиции. Эта шляпа подчеркивает, что ты - ЗАКОН."
	icon_state = "policehelm"
	dynamic_hair_suffix = ""

/obj/item/clothing/head/helmet/swat/nanotrasen
	name = "шлем спецназа"
	desc = "Чрезвычайно прочный, космический шлем с логотипом Нанотрейзен, украшенный сверху."
	icon_state = "swat"
	item_state = "swat"

/obj/item/clothing/head/helmet/thunderdome
	name = "Thunderdome шлем"
	desc = "<i>'Let the battle commence!'</i>"
	flags_inv = HIDEEARS|HIDEHAIR
	icon_state = "thunderdome"
	item_state = "thunderdome"
	armor = list("melee" = 80, "bullet" = 80, "laser" = 50, "energy" = 50, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 90)
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	strip_delay = 80
	dog_fashion = null

/obj/item/clothing/head/helmet/roman
	name = "римский шлем"
	desc = "Древний шлем из бронзы и кожи."
	flags_inv = HIDEEARS|HIDEHAIR
	flags_cover = HEADCOVERSEYES
	armor = list("melee" = 25, "bullet" = 0, "laser" = 25, "energy" = 10, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	icon_state = "roman"
	item_state = "roman"
	strip_delay = 100
	dog_fashion = null

/obj/item/clothing/head/helmet/roman/fake
	desc = "Древний шлем из пластика и кожи."
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/head/helmet/roman/legionnaire
	name = "шлем римского легионера"
	desc = "Древний шлем из бронзы и кожи. На нем красный гребень."
	icon_state = "roman_c"
	item_state = "roman_c"

/obj/item/clothing/head/helmet/roman/legionnaire/fake
	desc = "Древний шлем из бронзы и кожи. На нем красный гребень."
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/head/helmet/gladiator
	name = "шлем гладиатора"
	desc = "Ave, Imperator, morituri te salutant."
	icon_state = "gladiator"
	item_state = "gladiator"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR
	flags_cover = HEADCOVERSEYES
	dog_fashion = null

/obj/item/clothing/head/helmet/redtaghelm
	name = "красный шлем лазер-тэга"
	desc = "Они выбрали свою цель."
	icon_state = "redtaghelm"
	flags_cover = HEADCOVERSEYES
	item_state = "redtaghelm"
	armor = list("melee" = 15, "bullet" = 10, "laser" = 20,"energy" = 10, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 50)
	// Offer about the same protection as a hardhat.
	dog_fashion = null

/obj/item/clothing/head/helmet/bluetaghelm
	name = "синий шлем лазер-тэга"
	desc = "Им понадобится больше людей."
	icon_state = "bluetaghelm"
	flags_cover = HEADCOVERSEYES
	item_state = "bluetaghelm"
	armor = list("melee" = 15, "bullet" = 10, "laser" = 20,"energy" = 10, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 50)
	// Offer about the same protection as a hardhat.
	dog_fashion = null

/obj/item/clothing/head/helmet/knight
	name = "средневековый шлем"
	desc = "Классический металлический шлем."
	icon_state = "knight_green"
	item_state = "knight_green"
	armor = list("melee" = 50, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 80)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	strip_delay = 80
	dog_fashion = null


/obj/item/clothing/head/helmet/knight/Initialize(mapload)
	. = ..()
	var/datum/component = GetComponent(/datum/component/wearertargeting/earprotection)
	qdel(component)

/obj/item/clothing/head/helmet/knight/blue
	icon_state = "knight_blue"
	item_state = "knight_blue"

/obj/item/clothing/head/helmet/knight/yellow
	icon_state = "knight_yellow"
	item_state = "knight_yellow"

/obj/item/clothing/head/helmet/knight/red
	icon_state = "knight_red"
	item_state = "knight_red"

/obj/item/clothing/head/helmet/knight/greyscale
	name = "рыцарский шлем"
	desc = "Классический средневековый шлем, если держать его вверх ногами, то можно увидеть, что на самом деле это ведро."
	icon_state = "knight_greyscale"
	item_state = "knight_greyscale"
	armor = list("melee" = 35, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 10, "bio" = 10, "rad" = 10, "fire" = 40, "acid" = 40)
	material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS //Can change color and add prefix

/obj/item/clothing/head/helmet/skull
	name = "черепной шлем"
	desc = "Страшный племенной шлем, он выглядит не очень удобно."
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE
	flags_cover = HEADCOVERSEYES
	armor = list("melee" = 35, "bullet" = 25, "laser" = 25, "energy" = 35, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	icon_state = "skull"
	item_state = "skull"
	strip_delay = 100

/obj/item/clothing/head/helmet/durathread
	name = "дюратканевый шлем"
	desc = "Шлем из черного хлеба и кожи."
	icon_state = "durathread"
	item_state = "durathread"
	resistance_flags = FLAMMABLE
	armor = list("melee" = 20, "bullet" = 10, "laser" = 30, "energy" = 40, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 40, "acid" = 50)
	strip_delay = 60

/obj/item/clothing/head/helmet/rus_helmet
	name = "русский шлем"
	desc = "Он может вместить бутылку водки."
	icon_state = "rus_helmet"
	item_state = "rus_helmet"
	armor = list("melee" = 25, "bullet" = 30, "laser" = 0, "energy" = 10, "bomb" = 10, "bio" = 0, "rad" = 20, "fire" = 20, "acid" = 50)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/helmet

/obj/item/clothing/head/helmet/rus_ushanka
	name = "боевая ушанка"
	desc = "100% медвежья."
	icon_state = "rus_ushanka"
	item_state = "rus_ushanka"
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	armor = list("melee" = 25, "bullet" = 20, "laser" = 20, "energy" = 30, "bomb" = 20, "bio" = 50, "rad" = 20, "fire" = -10, "acid" = 50)

//LightToggle

/obj/item/clothing/head/helment/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/head/helmet/update_icon_state()
	var/state = "[initial(icon_state)]"
	if(attached_light)
		if(attached_light.on)
			state += "-flight-on" //"helmet-flight-on" // "helmet-cam-flight-on"
		else
			state += "-flight" //etc.

	icon_state = state

/obj/item/clothing/head/helmet/ui_action_click(mob/user, action)
	if(istype(action, alight))
		toggle_helmlight()
	else
		..()

/obj/item/clothing/head/helmet/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/flashlight/seclite))
		var/obj/item/flashlight/seclite/S = I
		if(can_flashlight && !attached_light)
			if(!user.transferItemToLoc(S, src))
				return
			to_chat(user, "<span class='notice'>Прикрепляю [S] к [src].</span>")
			if(S.on)
				set_light(0)
			attached_light = S
			update_icon()
			update_helmlight()
			alight = new(src)
			if(loc == user)
				alight.Grant(user)
		return
	return ..()

/obj/item/clothing/head/helmet/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(can_flashlight && attached_light) //if it has a light but can_flashlight is false, the light is permanently attached.
		I.play_tool_sound(src)
		to_chat(user, "<span class='notice'>Откручиваю [attached_light] от [src].</span>")
		attached_light.forceMove(drop_location())
		if(Adjacent(user) && !issilicon(user))
			user.put_in_hands(attached_light)

		var/obj/item/flashlight/removed_light = attached_light
		attached_light = null
		update_helmlight()
		removed_light.update_brightness(user)
		update_icon()
		user.update_inv_head()
		QDEL_NULL(alight)
		return TRUE

/obj/item/clothing/head/helmet/proc/toggle_helmlight()
	set name = "Toggle Helmetlight"
	set category = "ОБЪЕКТ"
	set desc = "Click to toggle your helmet's attached flashlight."

	if(!attached_light)
		return

	var/mob/user = usr
	if(user.incapacitated())
		return
	attached_light.on = !attached_light.on
	to_chat(user, "<span class='notice'>Я [attached_light.on ? "включаю":"выключаю"] фонарик на шлеме.</span>")

	playsound(user, 'sound/weapons/empty.ogg', 100, TRUE)
	update_helmlight()

/obj/item/clothing/head/helmet/proc/update_helmlight()
	if(attached_light)
		if(attached_light.on)
			set_light(attached_light.brightness_on)
		else
			set_light(0)
		update_icon()

	else
		set_light(0)
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()
