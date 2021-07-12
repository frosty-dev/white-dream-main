/obj/item/clothing/under/syndicate/yohei
	name = "униформа йохея"
	desc = "Удобная и практичная одежда для самой грязной работы."
	icon_state = "yohei"
	worn_icon = 'white/valtos/icons/clothing/mob/uniform.dmi'
	icon = 'white/valtos/icons/clothing/uniforms.dmi'
	inhand_icon_state = "bl_suit"
	can_adjust = FALSE
	armor = list(MELEE = 20, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 10, BIO = 10, RAD = 10, FIRE = 50, ACID = 50)

/obj/item/clothing/under/syndicate/yohei/blue
	desc = "Удобная и практичная одежда для самой грязной работы. Эта синяя."
	icon_state = "yohei_blue"
	armor = list(MELEE = 20, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 10, BIO = 25, RAD = 10, FIRE = 75, ACID = 90)

/obj/item/clothing/under/syndicate/yohei/red
	desc = "Удобная и практичная одежда для самой грязной работы. Эта красная."
	icon_state = "yohei_red"
	armor = list(MELEE = 25, BULLET = 15, LASER = 15, ENERGY = 15, BOMB = 15, BIO = 10, RAD = 10, FIRE = 60, ACID = 50)

/obj/item/clothing/under/syndicate/yohei/yellow
	desc = "Удобная и практичная одежда для самой грязной работы. Эта жёлтая."
	icon_state = "yohei_yellow"
	armor = list(MELEE = 20, BULLET = 10, LASER = 10, ENERGY = 25, BOMB = 25, BIO = 10, RAD = 25, FIRE = 75, ACID = 75)

/obj/item/clothing/under/syndicate/yohei/green
	desc = "Удобная и практичная одежда для самой грязной работы. Эта зелёная."
	icon_state = "yohei_green"
	armor = list(MELEE = 20, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 50, BIO = 10, RAD = 10, FIRE = 90, ACID = 50)

/obj/item/clothing/mask/breath/yohei
	name = "маска йохея"
	desc = "Обтягивающая и плотно сидящая маска, которая может быть подключена к источнику воздуха."
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL
	visor_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	visor_flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	visor_flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	icon_state = "yohei"
	worn_icon = 'white/valtos/icons/clothing/mob/mask.dmi'
	icon = 'white/valtos/icons/clothing/masks.dmi'
	inhand_icon_state = "sechailer"
	equip_delay_other = 50
	armor = list(MELEE = 20, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 10, BIO = 10, RAD = 10, FIRE = 50, ACID = 50)

/obj/item/clothing/shoes/jackboots/yohei
	name = "сапоги йохея"
	desc = "Модные ботинки, которые обычно носят наёмники."
	icon_state = "yohei"
	worn_icon = 'white/valtos/icons/clothing/mob/shoe.dmi'
	icon = 'white/valtos/icons/clothing/shoes.dmi'
	equip_delay_other = 60
	armor = list(MELEE = 20, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 10, BIO = 10, RAD = 10, FIRE = 50, ACID = 50)

/obj/item/clothing/gloves/combat/yohei
	name = "перчатки йохея"
	desc = "Образец того как Нанотрейзен не доверяет своим работникам. Защищают неплохо от всего"
	icon_state = "yohei"
	worn_icon = 'white/valtos/icons/clothing/mob/glove.dmi'
	icon = 'white/valtos/icons/clothing/gloves.dmi'
	inhand_icon_state = "blackgloves"
	armor = list(MELEE = 20, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 10, BIO = 10, RAD = 10, FIRE = 50, ACID = 50)

/obj/item/clothing/suit/hooded/yohei
	name = "плащ йохея"
	desc = "Весьма дорогостоящее многофункциональное оборудование... А вот это просто плащ."
	icon_state = "yohei"
	worn_icon = 'white/valtos/icons/clothing/mob/suit.dmi'
	icon = 'white/valtos/icons/clothing/suits.dmi'
	inhand_icon_state = "coatwinter"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	cold_protection = CHEST|GROIN|ARMS|LEGS
	heat_protection = CHEST|GROIN|ARMS|LEGS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	armor = list(MELEE = 25, BULLET = 25, LASER = 25,ENERGY = 25, BOMB = 40, BIO = 10, RAD = 10, FIRE = 50, ACID = 50)
	hoodtype = /obj/item/clothing/head/hooded/yohei
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/gun)

/obj/item/clothing/head/hooded/yohei
	name = "капюшон йохея"
	desc = "Не даст башке замёрзнуть и защитит от огня."
	icon_state = "yohei"
	worn_icon = 'white/valtos/icons/clothing/mob/hat.dmi'
	icon = 'white/valtos/icons/clothing/hats.dmi'
	body_parts_covered = HEAD
	cold_protection = HEAD
	heat_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEEARS|HIDEEYES
	armor = list(MELEE = 25, BULLET = 25, LASER = 25,ENERGY = 25, BOMB = 40, BIO = 10, RAD = 10, FIRE = 50, ACID = 50)

/obj/item/shadowcloak/yohei
	name = "генератор маскировки"
	desc = "Делает невидимым на продолжительное время. Заряжается в темноте."
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "cloak"
	worn_icon = 'white/valtos/icons/clothing/mob/belt.dmi'
	icon = 'white/valtos/icons/clothing/belts.dmi'
	inhand_icon_state = "assaultbelt"
	worn_icon_state = "cloak"

/obj/item/gun/ballistic/automatic/pistol/fallout/yohei9mm
	name = "пистолет Тиберия"
	desc = "Пистолет малой мощности и не сбывшихся надежд. Возможно последний экземпляр."
	icon_state = "gosling"
	inhand_icon_state = "devil"
	mag_type = /obj/item/ammo_box/magazine/fallout/m9mm
	fire_sound = 'white/valtos/sounds/fallout/gunsounds/9mm/9mm2.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	fire_delay = 8
	extra_damage = 25
	extra_penetration = 20

#define MODE_PAINKILLER "общее лечение"
#define MODE_OXYLOSS "кислородное голодание"
#define MODE_FRACTURE "травмы"
#define MODE_BLOOD_INJECTOR "вливание крови"

/obj/item/pamk
	name = "ПАМК"
	desc = "Полевой Автоматический Медицинский Комплект. Инструкция сообщает: воткните в конечность и она исцелится."
	icon = 'white/valtos/icons/objects.dmi'
	icon_state = "pamk_100"
	w_class = WEIGHT_CLASS_SMALL
	var/charge_left = 100
	var/current_mode = MODE_PAINKILLER

/obj/item/pamk/update_icon()
	. = ..()
	switch(charge_left)
		if(0)
			icon_state = "pamk_0"
		if(1 to 25)
			icon_state = "pamk_25"
		if(26 to 50)
			icon_state = "pamk_50"
		if(51 to 75)
			icon_state = "pamk_75"
		if(76 to 100)
			icon_state = "pamk_100"

/obj/item/pamk/proc/use_charge(amount)
	if(amount > charge_left)
		return FALSE
	charge_left -= amount
	playsound(get_turf(src), 'white/valtos/sounds/pamk_use.ogg', 80)
	update_icon()
	return TRUE

/obj/item/pamk/examine(mob/user)
	. = ..()
	. += "<hr><span class='notice'><b>ЗАРЯД:</b></span> [charge_left]/100.</span>"
	. += "\n<span class='notice'><b>РЕЖИМ:</b></span> [uppertext(current_mode)].</span>"

/obj/item/pamk/attack_self(mob/user)
	. = ..()
	var/new_mode
	switch(current_mode)
		if(MODE_PAINKILLER)
			new_mode = MODE_OXYLOSS
		if(MODE_OXYLOSS)
			new_mode = MODE_FRACTURE
		if(MODE_FRACTURE)
			new_mode = MODE_BLOOD_INJECTOR
		if(MODE_BLOOD_INJECTOR)
			new_mode = MODE_PAINKILLER
	current_mode = new_mode
	playsound(get_turf(src), 'white/valtos/sounds/pamk_mode.ogg', 80)
	to_chat(user, "<span class='notice'><b>РЕЖИМ:</b></span> [uppertext(current_mode)].</span>")

/obj/item/pamk/attack(mob/living/M, mob/user)
	. = ..()
	try_heal(M, user)

/obj/item/pamk/proc/try_heal(mob/living/M, mob/user)
	var/obj/item/bodypart/limb = M.get_bodypart(check_zone(user.zone_selected))
	if(!limb)
		to_chat(user, "<span class='notice'>А куда колоть то?!</span>")
		return
	switch(current_mode)
		if(MODE_PAINKILLER)
			if(M.getBruteLoss() > 10 || M.getFireLoss() > 10)
				if(use_charge(25))
					M.heal_overall_damage(25, 25)
				else
					to_chat(user, "<span class='warning'>Недостаточно заряда, требуется 25 единиц.</span>")
			else
				to_chat(user, "<span class='warning'>Не обнаружено повреждений, либо они незначительны.</span>")
		if(MODE_OXYLOSS)
			if(M.getOxyLoss() > 5)
				if(use_charge(25))
					M.setOxyLoss(0)
				else
					to_chat(user, "<span class='warning'>Недостаточно заряда, требуется 10 единиц.</span>")
			else
				to_chat(user, "<span class='warning'>Уровень кислорода в норме.</span>")
		if(MODE_FRACTURE)
			if(limb.wounds.len)
				if(use_charge(25))
					for(var/thing in limb.wounds)
						var/datum/wound/W = thing
						W.remove_wound()
					to_chat(user, "<span class='notice'>Успешно исправили все переломы и вывихи в этой конечности.</span>")
				else
					to_chat(user, "<span class='warning'>Недостаточно заряда, требуется 25 единиц.</span>")
			else
				to_chat(user, "<span class='warning'>Не обнаружено травм в этой конечности.</span>")
		if(MODE_BLOOD_INJECTOR)
			if(M.blood_volume <= initial(M.blood_volume) - 50)
				if(use_charge(25))
					M.restore_blood()
					to_chat(user, "<span class='notice'>Кровь восстановлена.</span>")
				else
					to_chat(user, "<span class='warning'>Недостаточно заряда, требуется 25 единиц.</span>")
			else
				to_chat(user, "<span class='warning'>Уровень крови в пределах нормы.</span>")

#undef MODE_PAINKILLER
#undef MODE_OXYLOSS
#undef MODE_FRACTURE
#undef MODE_BLOOD_INJECTOR

/datum/outfit/yohei
	name = "Йохей: Дженерик"

	uniform = /obj/item/clothing/under/syndicate/yohei
	mask = /obj/item/clothing/mask/breath/yohei
	shoes = /obj/item/clothing/shoes/jackboots/yohei
	gloves = /obj/item/clothing/gloves/combat/yohei
	suit = /obj/item/clothing/suit/hooded/yohei
	id = /obj/item/card/id/yohei

	r_pocket = /obj/item/flashlight/seclite
	l_pocket = /obj/item/pamk

	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list()

/datum/outfit/yohei/medic
	name = "Йохей: Медик"

	glasses = /obj/item/clothing/glasses/hud/health/sunglasses
	belt = /obj/item/defibrillator/compact/combat/loaded
	uniform = /obj/item/clothing/under/syndicate/yohei/blue

	backpack_contents = list(/obj/item/pamk = 3, /obj/item/storage/firstaid/medical = 1, /obj/item/optable = 1)

/datum/outfit/yohei/combatant
	name = "Йохей: Боевик"

	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	belt = /obj/item/shadowcloak/yohei
	suit_store = /obj/item/gun/ballistic/automatic/pistol/fallout/yohei9mm
	uniform = /obj/item/clothing/under/syndicate/yohei/red
	r_pocket = /obj/item/ammo_box/magazine/fallout/m9mm

	backpack_contents = list(/obj/item/ammo_box/magazine/fallout/m9mm = 4)

/datum/outfit/yohei/breaker
	name = "Йохей: Взломщик"

	glasses = /obj/item/clothing/glasses/hud/diagnostic/sunglasses
	belt = /obj/item/storage/belt/military/abductor
	suit_store = /obj/item/gun/ballistic/automatic/pistol/fallout/yohei9mm
	uniform = /obj/item/clothing/under/syndicate/yohei/yellow

	backpack_contents = list(/obj/item/construction/rcd = 1)

/datum/outfit/yohei/breaker/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	H.add_client_colour(/datum/client_colour/hacker)
	H.hud_list[HACKER_HUD].icon = null

	spawn(5 SECONDS)
		ADD_TRAIT(H, TRAIT_HACKER, JOB_TRAIT)
		var/datum/component/battletension/BT = H.GetComponent(/datum/component/battletension)
		if(BT)
			BT.pick_sound('white/valtos/sounds/snidleyWhiplash.ogg')
		to_chat(H, "<span class='revenbignotice'>Давно не виделись, а?</span>")
		if(H?.hud_used)
			H.hud_used.update_parallax_pref(H, TRUE)

		H.mind.teach_crafting_recipe(/datum/crafting_recipe/hacker/head)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/hacker/suit)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/hacker/gloves)

/datum/outfit/yohei/prospector
	name = "Йохей: Разведчик"

	glasses = /obj/item/clothing/glasses/night
	belt = /obj/item/shadowcloak/yohei
	suit_store = /obj/item/gun/ballistic/automatic/pistol/fallout/yohei9mm
	uniform = /obj/item/clothing/under/syndicate/yohei/green
	r_pocket = /obj/item/ammo_box/magazine/fallout/m9mm

	backpack_contents = list(/obj/item/pickaxe/mini = 1, /obj/item/grenade/c4 = 3, /obj/item/grenade/smokebomb = 3)

/obj/lab_monitor/yohei
	name = "Монитор исполнения"
	desc = "Здесь выводятся задания. Стекло всё ещё выглядит не очень крепким..."
	var/datum/yohei_task/current_task = null
	var/list/possible_tasks = list()
	var/balance = 0

/obj/lab_monitor/yohei/attack_hand(mob/living/user)
	. = ..()

	if(!current_task)
		say("Загружаю новое задание...")
		var/datum/yohei_task/new_task = pick(possible_tasks)
		current_task = new new_task()
		return

	if(current_task && current_task.check_task())
		say("Задание выполнено. Награда в размере [current_task.prize] выдана. Получение следующего задания...")
		balance += current_task.prize
		qdel(current_task)

		var/datum/yohei_task/new_task = pick(possible_tasks)
		current_task = new new_task()

/obj/lab_monitor/yohei/examine(mob/user)
	. = ..()
	if(current_task)
		. += "<hr>"
		. += "<span class='notice'><b>Задание:</b> [current_task.desc]</span>"
		. += "\n<span class='notice'><b>Награда:</b> [current_task.prize]</span>"
		. += "\n\n<span class='notice'><b>Баланс:</b> [balance]</span>"

/obj/lab_monitor/yohei/Initialize()
	. = ..()
	for(var/path in subtypesof(/datum/yohei_task))
		var/datum/yohei_task/T = path
		possible_tasks += T

/datum/yohei_task
	var/desc = null
	var/prize = 0

/datum/yohei_task/proc/generate_task()
	return

/datum/yohei_task/proc/check_task()
	return FALSE

/datum/yohei_task/New()
	generate_task()

/datum/yohei_task/proc/get_crewmember_minds()
	. = list()
	for(var/V in GLOB.data_core.locked)
		var/datum/data/record/R = V
		var/datum/mind/M = R.fields["mindref"]
		if(M)
			. += M

/datum/yohei_task/proc/find_target()
	var/list/possible_targets = list()
	for(var/datum/mind/possible_target in get_crewmember_minds())
		if(ishuman(possible_target.current) && (possible_target.current.stat != DEAD))
			possible_targets += possible_target.current
	if(possible_targets.len > 0)
		return pick(possible_targets)
	return FALSE

/datum/yohei_task/kill
	desc = "Убить цель."
	prize = 5
	var/mob/living/target

/datum/yohei_task/kill/generate_task()
	target = find_target()
	desc = "Убить [target.name]."
	prize = max(rand(prize - 3, prize + 3), 1)

/datum/yohei_task/kill/check_task()
	if(target && target.stat != DEAD)
		return FALSE
	return TRUE

/datum/yohei_task/capture
	desc = "Захватить цель."
	prize = 10
	var/mob/living/target

/datum/yohei_task/kill/generate_task()
	target = find_target()
	desc = "Захватить [target.name] и доставить живьём в логово."
	prize = max(rand(prize - 3, prize + 3), 1)

/datum/yohei_task/kill/check_task()
	if(target && target.stat != DEAD)
		var/area/A = get_area(target)
		if(A.type != /area/ruin/powered/yohei_base)
			return FALSE
		target.Knockdown(5 SECONDS)
		if(prob(80))
			if(prob(10))
				target.gib()
				return TRUE
			target?.mind?.make_Traitor()
			return TRUE
		else
			target?.mind?.make_Wizard()
			return TRUE
	else
		qdel(src)
		return FALSE

/datum/map_template/ruin/lavaland/yohei_base
	name = "База Йохеев"
	id = "yohei_base"
	description = "Мяу..."
	suffix = "lavaland_yohei_base.dmm"
	allow_duplicates = FALSE
	always_place = TRUE

/area/ruin/powered/yohei_base
	name = "Лаваленд: База Йохеев"
	icon_state = "dk_yellow"
	area_flags = BLOBS_ALLOWED | UNIQUE_AREA | BLOCK_SUICIDE | NOTELEPORT
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED

/obj/item/card/id/yohei
	name = "странная карточка"
	desc = "Очень. Откуда это вообще взялось?"
	icon_state = "yohei"
	icon = 'white/valtos/icons/card.dmi'
	access = list(ACCESS_YOHEI, ACCESS_MAINT_TUNNELS)

/obj/effect/mob_spawn/human/donate
	name = "платно"
	desc = "ПЛАТНО ОЗНАЧАЕТ, ЧТО НУЖНО ПЛАТИТЬ!"
	icon = 'white/valtos/icons/objects.dmi'
	icon_state = "shiz"
	var/req_sum = 500

/obj/effect/mob_spawn/human/donate/attack_ghost(mob/user)
	if(user?.client?.holder || check_donations(user?.ckey) >= req_sum)
		. = ..()
	else
		to_chat(user, "<span class='warning'>Эта роль требует <b>[req_sum]</b> донат-поинтов для доступа.</span>")
		return

/obj/effect/mob_spawn/human/donate/yohei
	name = "Точка входа Йохеев"
	desc = "Чудесные технологии!"
	invisibility = 60
	density = FALSE
	icon_state = "yohei_spawn"
	short_desc = "Что-то интересное?"
	flavour_text = "Наёмник посреди пустошей Лаваленда, до чего жизнь довела!"
	outfit = /datum/outfit/yohei
	assignedrole = "Yohei"
	req_sum = 1000
	uses = 4

/obj/effect/mob_spawn/human/donate/attack_ghost(mob/user)
	var/static/list/choices = list(
		"Медик" 	= image(icon = 'white/valtos/icons/objects.dmi', icon_state = "ymedic"),
		"Боевик" 	= image(icon = 'white/valtos/icons/objects.dmi', icon_state = "ycombatant"),
		"Взломщик" 	= image(icon = 'white/valtos/icons/objects.dmi', icon_state = "ybreaker"),
		"Разведчик" = image(icon = 'white/valtos/icons/objects.dmi', icon_state = "yprospector")
		)
	var/choice = show_radial_menu(user, src, choices, tooltips = TRUE)
	if(!choice)
		return
	switch(choice)
		if("Медик")
			outfit = /datum/outfit/yohei/medic
		if("Боевик")
			outfit = /datum/outfit/yohei/combatant
		if("Взломщик")
			outfit = /datum/outfit/yohei/breaker
		if("Разведчик")
			outfit = /datum/outfit/yohei/prospector
	if(user.ckey)
		var/client/C = GLOB.directory[user.ckey]
		if(C?.prefs)
			hairstyle =  C.prefs.hairstyle
			facial_hairstyle = C.prefs.facial_hairstyle
			skin_tone = C.prefs.skin_tone
	. = ..()
