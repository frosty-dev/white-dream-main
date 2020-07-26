/area/awaymission/vietnam
	name = "Дикие джунгли"
	icon_state = "unexplored"
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	ambientsounds = AWAY_MISSION
	enabled_area_tension = FALSE

/area/awaymission/vietnam/dark
	name = "Тёмное джунглевое место"
	icon_state = "unexplored"
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	ambientsounds = AWAY_MISSION
	requires_power = FALSE

/datum/outfit/vietcong
	name = "Вьетконговец"
	uniform = /obj/item/clothing/under/pants/khaki
	implants = list(/obj/item/implant/exile)

/obj/effect/mob_spawn/human/vietcong
	name = "шконка"
	desc = "Джонни... Тут кто-то затаился под шконкой..."
	icon = 'white/valtos/icons/prison/prison.dmi'
	icon_state = "spwn"
	roundstart = FALSE
	death = FALSE
	short_desc = "Я житель провинции Хаостан."
	flavour_text = "Проснуться, работать в рисовом поле, лечь спать, повторить."
	outfit = /datum/outfit/vietcong
	assignedrole = "Vietcong"

/obj/effect/mob_spawn/human/vietcong/special(mob/living/L)
	var/list/fn = list("Сунь", "Хунь", "Дунь", "Пунь", "Ляо", "Хуао", "Мао", "Жень", "Пам")
	var/list/ln = list("Хуй", "Дуй", "Дзинь", "Минь", "Кинь", "Пинь", "Вынь", "Синь", "Жунь", "Вунь")
	L.real_name = "[pick(fn)] [pick(ln)]"
	L.name = L.real_name
	ADD_TRAIT(L, TRAIT_ASIAT, type)

/mob/living/simple_animal/hostile/russian/bydlo
	name = "Гопник"
	desc = "Ку-ку, ёпта!"
	icon = 'white/valtos/icons/rospilovo/sh.dmi'
	icon_state = "gopnik"
	icon_living = "gopnik"
	icon_dead = "gopnik_dead"
	icon_gib = "gopnik_bottle_dead"
	attack_verb_continuous = "ебошит"
	attack_verb_simple = "прописывает двоечку"
	loot = list(/obj/item/clothing/under/switer/tracksuit)

/obj/structure/barricade/wooden/stockade
	name = "частокол"
	desc = "Дешево и сердито."
	icon = 'white/valtos/icons/objects.dmi'
	icon_state = "stockade"
	drop_amount = 1
	pixel_y = 16
	layer = ABOVE_MOB_LAYER

/turf/open/floor/grass/gensgrass/dirty/stone
	name = "каменный пол"
	icon = 'white/valtos/icons/gensokyo/turfs.dmi'
	icon_state = "stone"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	stoned = TRUE

/turf/open/floor/grass/gensgrass/dirty/stone/raw
	name = "уродливый камень"
	icon = 'white/valtos/icons/gensokyo/turfs.dmi'
	icon_state = "stone_raw"
	stoned = FALSE
	color = "#aaaaaa"
	var/digged_up = FALSE

/turf/open/floor/grass/gensgrass/dirty/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(istype(I, /obj/item/raw_stone))
		if(!stoned)
			ChangeTurf(/turf/open/floor/grass/gensgrass/dirty/stone, flags = CHANGETURF_INHERIT_AIR)
			stoned = TRUE
			qdel(I)
			user.visible_message("<span class='notice'><b>[user]</b> покрывает пол камнем.</span>", \
								"<span class='notice'>Делаю каменный пол.</span>")
		else
			to_chat(user, "<span class='warning'>Здесь уже есть каменный пол!</span>")

/turf/open/floor/grass/gensgrass/dirty/stone/raw/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(istype(I, /obj/item/pickaxe))
		if(!digged_up)
			playsound(src, pick(I.usesound), 100)
			if(do_after(user, 5 SECONDS, target = src))
				if(digged_up)
					return
				new /obj/item/raw_stone(src)
				if(prob(50))
					new /obj/item/raw_stone(src)
				digged_up = TRUE
				user.visible_message("<span class='notice'><b>[user]</b> выкапывает немного камней.</span>", \
									"<span class='notice'>Выкапываю немного камней.</span>")
		else
			to_chat(user, "<span class='warning'>Здесь уже всё раскопано!</span>")

/turf/closed/mineral/random/vietnam
	icon = 'white/valtos/icons/rocks.dmi'
	icon_state = "rock"
	smooth_icon = 'white/valtos/icons/rocks_smooth.dmi'
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	environment_type = "stone_raw"
	turf_type = /turf/open/floor/grass/gensgrass/dirty/stone/raw
	baseturfs = /turf/open/floor/grass/gensgrass/dirty/stone/raw
	mineralSpawnChanceList = list(/obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/gold = 3, /obj/item/stack/ore/iron = 40)

/turf/closed/mineral/random/vietnam/Initialize()
	. = ..()
	transform = null // backdoor

/obj/item/smithing_hammer
	name = "молот"
	desc = "Используется для ковки. По идее."
	icon = 'white/valtos/icons/objects.dmi'
	lefthand_file = 'white/valtos/icons/lefthand.dmi'
	righthand_file = 'white/valtos/icons/righthand.dmi'
	icon_state = "molotochek"
	w_class = WEIGHT_CLASS_HUGE
	force = 20
	throwforce = 25
	throw_range = 4

/obj/item/smithing_hammer/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands=TRUE, force_unwielded=20, force_wielded=20)

/obj/item/anvil_free
	name = "наковальня"
	desc = "На ней неудобно ковать. Стоит поставить её на что-то крепкое."
	icon = 'white/valtos/icons/objects.dmi'
	lefthand_file = 'white/valtos/icons/lefthand.dmi'
	righthand_file = 'white/valtos/icons/righthand.dmi'
	icon_state = "anvil_free"
	w_class = WEIGHT_CLASS_HUGE
	force = 10
	throwforce = 20
	throw_range = 2

/obj/item/anvil_free/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands=TRUE, force_unwielded=10, force_wielded=10)

/obj/item/srub
	name = "полено"
	desc = "Достаточно крепкое, чтобы удерживать на себе наковальню."
	icon = 'white/valtos/icons/objects.dmi'
	lefthand_file = 'white/valtos/icons/lefthand.dmi'
	righthand_file = 'white/valtos/icons/righthand.dmi'
	icon_state = "srub"
	w_class = WEIGHT_CLASS_HUGE
	force = 7
	throwforce = 10
	throw_range = 3

/obj/item/srub/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands=TRUE, force_unwielded=7, force_wielded=7)

/obj/item/tongs
	name = "клещи"
	desc = "Для ковки. Не для анальных утех."
	icon = 'white/valtos/icons/objects.dmi'
	icon_state = "tongs"
	w_class = WEIGHT_CLASS_SMALL
	force = 4
	throwforce = 6
	throw_range = 7

/obj/item/tongs/attack(mob/living/carbon/C, mob/user)
	if(tearoutteeth(C, user))
		return FALSE
	else
		..()

/obj/item/tongs/attack_self(mob/user)
	. = ..()
	if(contents.len)
		if(istype(contents[contents.len], /obj/item/ingot))
			var/obj/item/ingot/N = contents[contents.len]
			if(N.progress_current == N.progress_need + 1)
				var/obj/item/O = new N.recipe.result(drop_location())
				if(istype(O, /obj/item/katanus))
					O.force = round((O.force / 1.25) * N.mod_grade)
				if(istype(O, /obj/item/pickaxe))
					O.force = round((O.force / 2) * N.mod_grade)
					O.toolspeed = round(1 / N.mod_grade, 0.1)
				if(istype(O, /obj/item/clothing))
					O.armor = O.armor.modifyAllRatings(5 * N.mod_grade)
				switch(N.mod_grade)
					if(5 to INFINITY)
						O.name = "☼[O.name]☼"
					if(4)
						O.name = "≡[O.name]≡"
					if(3)
						O.name = "+[O.name]+"
					if(2)
						O.name = "-[O.name]-"
					if(1)
						O.name = "*[O.name]*"
				qdel(N)
				LAZYCLEARLIST(contents)
				playsound(src, 'white/valtos/sounds/vaper.ogg', 100)
			else
				N.forceMove(drop_location())
		icon_state = "tongs"

/obj/item/ingot
	name = "слиток"
	desc = "Из него можно сделать что-то."
	icon = 'white/valtos/icons/objects.dmi'
	icon_state = "iron_ingot"
	w_class = WEIGHT_CLASS_NORMAL
	force = 2
	throwforce = 5
	throw_range = 7
	custom_materials = list(/datum/material/iron = 10000)
	var/datum/smithing_recipe/recipe = null
	var/mod_grade = 1
	var/fail_chance = 2
	var/durability = 5
	var/progress_current = 0
	var/progress_need = 10
	var/heattemp = 0

/obj/item/ingot/examine(mob/user)
	. = ..()
	var/ct = ""
	switch(heattemp)
		if(200 to INFINITY)
			ct = "раскалена до бела"
		if(100 to 199)
			ct = "очень горячая"
		if(1 to 99)
			ct = "достаточно тёплая"
		else
			ct = "холодная"

	. += "Болванка [ct]."

/obj/item/ingot/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/ingot/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/ingot/process()
	if(heattemp >= 25)
		heattemp -= 25
		if(!overlays.len)
			add_overlay("ingot_hot")
	else if(overlays.len)
		cut_overlays()


/obj/item/ingot/attackby(obj/item/I, mob/living/user, params)

	if(user.a_intent == INTENT_HARM)
		return ..()

	if(istype(I, /obj/item/tongs))
		if(I.contents.len)
			to_chat(user, "<span class='warning'>Некуда!</span>")
			return
		else
			src.forceMove(I)
			if(heattemp > 0)
				I.icon_state = "tongs_hot"
			else
				I.icon_state = "tongs_cold"
			to_chat(user, "<span class='notice'>Беру слиток клещами.</span>")
			return

/obj/item/raw_stone
	name = "камень"
	desc = "Олдфаг."
	icon = 'white/valtos/icons/objects.dmi'
	icon_state = "stone"
	w_class = WEIGHT_CLASS_TINY
	force = 3
	throwforce = 7
	throw_range = 14

/obj/item/katanus
	name = "катанус"
	desc = "Не путать с катаной."
	icon_state = "katanus"
	inhand_icon_state = "katanus"
	worn_icon_state = "katanus"
	icon = 'white/valtos/icons/objects.dmi'
	worn_icon = 'white/valtos/icons/back.dmi'
	lefthand_file = 'white/valtos/icons/lefthand.dmi'
	righthand_file = 'white/valtos/icons/righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	force = 20
	throwforce = 10
	w_class = WEIGHT_CLASS_HUGE
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("атакует", "рубит", "втыкает", "разрубает", "кромсает", "разрывает", "нарезает", "режет")
	block_chance = 25
	sharpness = IS_SHARP
	max_integrity = 50
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	custom_materials = list(/datum/material/iron = 10000)

/obj/item/clothing/suit/armor/light_plate
	name = "нагрудная пластина"
	desc = "Защищает только грудь, плохо останавливает пули."
	body_parts_covered = CHEST|GROIN
	icon_state = "light_plate"
	inhand_icon_state = "light_plate"
	worn_icon = 'white/valtos/icons/clothing/mob/suit.dmi'
	icon = 'white/valtos/icons/clothing/suits.dmi'
	armor = list("melee" = 55, "bullet" = 20, "laser" = 20, "energy" = 0, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 10, "wound" = 35)
	custom_materials = list(/datum/material/iron = 10000)

/obj/item/clothing/suit/armor/heavy_plate
	name = "латный доспех"
	desc = "Останавливает иногда и пули. Замедляет скорость передвижения."
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	w_class = WEIGHT_CLASS_GIGANTIC
	slowdown = 1
	icon_state = "heavy_plate"
	inhand_icon_state = "heavy_plate"
	worn_icon = 'white/valtos/icons/clothing/mob/suit.dmi'
	icon = 'white/valtos/icons/clothing/suits.dmi'
	armor = list("melee" = 85, "bullet" = 60, "laser" = 40, "energy" = 10, "bomb" = 50, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 20, "wound" = 65)
	custom_materials = list(/datum/material/iron = 10000)
	var/footstep = 1
	var/mob/listeningTo
	var/list/random_step_sound = list('white/valtos/sounds/armorstep/heavystep1.ogg'=1,\
									  'white/valtos/sounds/armorstep/heavystep2.ogg'=1,\
									  'white/valtos/sounds/armorstep/heavystep3.ogg'=1,\
									  'white/valtos/sounds/armorstep/heavystep4.ogg'=1,\
									  'white/valtos/sounds/armorstep/heavystep5.ogg'=1,\
									  'white/valtos/sounds/armorstep/heavystep6.ogg'=1,\
									  'white/valtos/sounds/armorstep/heavystep7.ogg'=1)

/obj/item/clothing/suit/armor/heavy_plate/proc/on_mob_move()
	var/mob/living/carbon/human/H = loc
	if(!istype(H) || H.wear_suit != src)
		return
	if(footstep > 1)
		playsound(src, pick(random_step_sound), 100, TRUE)
		footstep = 0
	else
		footstep++

/obj/item/clothing/suit/armor/heavy_plate/equipped(mob/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_OCLOTHING)
		if(listeningTo)
			UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
		return
	if(listeningTo == user)
		return
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, .proc/on_mob_move)
	listeningTo = user

/obj/item/clothing/suit/armor/heavy_plate/dropped()
	. = ..()
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)

/obj/item/clothing/suit/armor/heavy_plate/Destroy()
	listeningTo = null
	return ..()

/obj/item/clothing/under/chainmail
	name = "кольчуга"
	desc = "Неплохо защищает от всех видов колющего и режущего оружия. Немного стесняет движения."
	worn_icon = 'white/valtos/icons/clothing/mob/uniform.dmi'
	icon = 'white/valtos/icons/clothing/uniforms.dmi'
	icon_state = "chainmail"
	inhand_icon_state = "chainmail"
	armor = list("melee" = 35, "bullet" = 15, "laser" = 0, "energy" = 0, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0, "wound" = 55)
	custom_materials = list(/datum/material/iron = 10000)

/obj/item/clothing/head/helmet/plate_helmet
	name = "железный шлем"
	desc = "Спасёт голову от внезапного удара по ней."
	worn_icon = 'white/valtos/icons/clothing/mob/hat.dmi'
	icon = 'white/valtos/icons/clothing/hats.dmi'
	icon_state = "plate_helmet"
	flags_inv = HIDEMASK|HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	armor = list("melee" = 75, "bullet" = 35, "laser" = 10,"energy" = 0, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 5, "acid" = 5, "wound" = 55)
	custom_materials = list(/datum/material/iron = 10000)

/obj/item/clothing/gloves/plate_gloves
	name = "железные перчатки"
	desc = "Уберегут ваши руки от внезапных потерь."
	worn_icon = 'white/valtos/icons/clothing/mob/glove.dmi'
	icon = 'white/valtos/icons/clothing/gloves.dmi'
	icon_state = "plate_gloves"
	armor = list("melee" = 65, "bullet" = 30, "laser" = 5,"energy" = 0, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 25, "acid" = 25, "wound" = 55)
	custom_materials = list(/datum/material/iron = 10000)

/obj/item/clothing/shoes/jackboots/plate_boots
	name = "железные сапоги"
	desc = "Спасут ваши ноги от внезапных переломов и других страшных штук."
	worn_icon = 'white/valtos/icons/clothing/mob/shoe.dmi'
	icon = 'white/valtos/icons/clothing/shoes.dmi'
	icon_state = "plate_boots"
	armor = list("melee" = 75, "bullet" = 35, "laser" = 10,"energy" = 0, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 15, "acid" = 15, "wound" = 55)
	custom_materials = list(/datum/material/iron = 10000)

/datum/outfit/huev_latnik
	name = "СУКА ЛАБЕБ"
	uniform = /obj/item/clothing/under/chainmail
	gloves = /obj/item/clothing/gloves/plate_gloves
	head = /obj/item/clothing/head/helmet/plate_helmet
	suit = /obj/item/clothing/suit/armor/light_plate
	shoes = /obj/item/clothing/shoes/jackboots/plate_boots
	back = /obj/item/katanus

/obj/anvil
	name = "наковальня"
	desc = "Вот на этом удобно ковать, да?"
	icon = 'white/valtos/icons/objects.dmi'
	icon_state = "anvil"
	density = TRUE
	var/acd = FALSE
	var/obj/item/ingot/current_ingot = null
	var/list/allowed_things = list()

/obj/anvil/Initialize()
	. = ..()
	for(var/item in subtypesof(/datum/smithing_recipe))
		var/datum/smithing_recipe/SR = new item()
		allowed_things += SR

/obj/anvil/attackby(obj/item/I, mob/living/user, params)

	if(user.a_intent == INTENT_HARM)
		return ..()

	if(acd)
		return

	acd = TRUE
	addtimer(VARSET_CALLBACK(src, acd, FALSE), 0.7 SECONDS)

	if(istype(I, /obj/item/smithing_hammer))
		if(current_ingot)
			if(current_ingot.heattemp <= 0)
				icon_state = "anvil_cold"
				to_chat(user, "<span class='warning'>Болванка слишком холодная. Стоит разогреть её.</span>")
				return
			if(current_ingot.recipe)
				if(current_ingot.progress_current == current_ingot.progress_need)
					current_ingot.progress_current++
					to_chat(user, "<span class='notice'>Болванка готова. Ещё один удар для продолжения ковки, либо можно охлаждать.</span>")
					to_chat(user, "<span class='green'>> Активируй болванку в клещах для охлаждения.</span>")
					return
				if(current_ingot.progress_current > current_ingot.progress_need)
					current_ingot.progress_current = 0
					current_ingot.mod_grade++
					current_ingot.progress_need = round(current_ingot.progress_need * 1.5)
					to_chat(user, "<span class='notice'>Начинаем улучшать болванку...</span>")
					return
				if(prob(current_ingot.fail_chance * current_ingot.mod_grade))
					current_ingot.durability--
					if(current_ingot.durability == 0)
						to_chat(user, "<span class='warning'>Болванка раскалывается на множество бесполезных кусочков метала...</span>")
						current_ingot = null
						LAZYCLEARLIST(contents)
						icon_state = "anvil"
					user.visible_message("<span class='warning'><b>[user]</b> неправильно бьёт молотом по наковальне.</span>", \
										"<span class='warning'>Неправильно бью молотом по наковальне.</span>")
					return
				else
					playsound(src, 'white/valtos/sounds/anvil_hit.ogg', 70)
					user.visible_message("<span class='notice'><b>[user]</b> бьёт молотом по наковальне.</span>", \
										"<span class='notice'>Бью молотом по наковальне.</span>")
					current_ingot.progress_current++
					return
			else
				var/datum/smithing_recipe/sel_recipe = input("Выбор:", "Что куём?", null, null) as null|anything in allowed_things
				if(!sel_recipe)
					to_chat(user, "<span class='warning'>Не выбран рецепт.</span>")
					return
				if(current_ingot.recipe)
					to_chat(user, "<span class='warning'>УЖЕ ВЫБРАН РЕЦЕПТ!</span>")
					return
				current_ingot.recipe = new sel_recipe.type()
				to_chat(user, "<span class='notice'>Приступаем к ковке...</span>")
				return
		else
			to_chat(user, "<span class='warning'>Тут нечего ковать!</span>")
			return

	if(istype(I, /obj/item/tongs))
		if(current_ingot)
			if(I.contents.len)
				to_chat(user, "<span class='warning'>Клещи уже что-то держат!</span>")
				return
			else
				if(current_ingot.heattemp > 0)
					I.icon_state = "tongs_hot"
				else
					I.icon_state = "tongs_cold"
				current_ingot.forceMove(I)
				current_ingot = null
				icon_state = "anvil"
				to_chat(user, "<span class='notice'>Беру болванку в клещи.</span>")
				return
		else
			if(I.contents.len)
				if(current_ingot)
					to_chat(user, "<span class='warning'>Здесь уже есть болванка!</span>")
					return
				var/obj/item/ingot/N = I.contents[I.contents.len]
				if(N.heattemp > 0)
					icon_state = "anvil_hot"
				else
					icon_state = "anvil_cold"
				N.forceMove(src)
				current_ingot = N
				I.icon_state = "tongs"
				to_chat(user, "<span class='notice'>Располагаю болванку на наковальне.</span>")
				return
			else
				to_chat(user, "<span class='warning'>Наковальня совсем пуста!</span>")
				return
	return ..()

/datum/smithing_recipe
	var/name = ""
	var/result

/datum/smithing_recipe/katanus
	name = "Катанус"
	result = /obj/item/katanus

/datum/smithing_recipe/pickaxe
	name = "Кирка"
	result = /obj/item/pickaxe

/datum/smithing_recipe/shovel
	name = "Лопата"
	result = /obj/item/shovel

/datum/smithing_recipe/smithing_hammer
	name = "Молот"
	result = /obj/item/smithing_hammer

/datum/smithing_recipe/tongs
	name = "Клещи"
	result = /obj/item/tongs

/datum/smithing_recipe/light_plate
	name = "Нагрудник"
	result = /obj/item/clothing/suit/armor/light_plate

/datum/smithing_recipe/heavy_plate
	name = "Латный доспех"
	result = /obj/item/clothing/suit/armor/heavy_plate

/datum/smithing_recipe/chainmail
	name = "Кольчуга"
	result = /obj/item/clothing/under/chainmail

/datum/smithing_recipe/plate_helmet
	name = "Шлем"
	result = /obj/item/clothing/head/helmet/plate_helmet

/datum/smithing_recipe/plate_gloves
	name = "Перчатки"
	result = /obj/item/clothing/gloves/plate_gloves

/datum/smithing_recipe/plate_boots
	name = "Ботинки"
	result = /obj/item/clothing/shoes/jackboots/plate_boots

/obj/furnace
	name = "плавильня"
	desc = "Плавит."
	icon = 'white/valtos/icons/objects.dmi'
	icon_state = "furnace"
	density = TRUE
	light_range = 0
	light_color = "#BB661E"
	var/furnacing = FALSE

/obj/furnace/proc/furnaced_thing()
	icon_state = "furnace"
	furnacing = FALSE
	light_range = 0

	new /obj/item/ingot(drop_location())


/obj/furnace/attackby(obj/item/I, mob/living/user, params)

	if(user.a_intent == INTENT_HARM)
		return ..()

	if(furnacing)
		to_chat(user, "<span class=\"alert\">Плавильня занята работой!</span>")
		return

	if(istype(I, /obj/item/stack/ore/iron) || istype(I, /obj/item/stack/sheet/metal))
		var/obj/item/stack/S = I
		if(S.amount >= 5)
			S.use(5)
			furnacing = TRUE
			icon_state = "furnace_on"
			light_range = 3
			to_chat(user, "<span class='notice'>Плавильня начинает свою работу...</span>")
			addtimer(CALLBACK(src, .proc/furnaced_thing), 15 SECONDS)
		else
			to_chat(user, "<span class=\"alert\">Нужно примерно пять единиц руды для создания слитка.</span>")


/obj/forge
	name = "кузница"
	desc = "Нагревает различные штуки, но реже всего слитки."
	icon = 'white/valtos/icons/objects.dmi'
	icon_state = "forge_on"
	light_range = 4
	light_color = "#BB661E"
	density = TRUE

/obj/forge/attackby(obj/item/I, mob/living/user, params)

	if(user.a_intent == INTENT_HARM)
		return ..()

	if(istype(I, /obj/item/tongs))
		if(I.contents.len)
			if(istype(I.contents[I.contents.len], /obj/item/ingot))
				var/obj/item/ingot/N = I.contents[I.contents.len]
				N.heattemp = 350
				I.icon_state = "tongs_hot"
				to_chat(user, "<span class='notice'>Нагреваю болванку как могу.</span>")
				return
		else
			to_chat(user, "<span class='warning'>Ты ебанутый?</span>")
			return

/datum/crafting_recipe/smithman/anvil
	name = "Наковальня"
	result = /obj/item/anvil_free
	tools = list(/obj/item/smithing_hammer)
	reqs = list(/obj/item/ingot = 3,
				/obj/item/raw_stone = 5)
	time = 350
	category = CAT_STRUCTURE
	always_availible = TRUE

/datum/crafting_recipe/smithman/workplace
	name = "Наковальня на полене"
	result = /obj/anvil
	tools = list(/obj/item/smithing_hammer)
	reqs = list(/obj/item/srub = 1,
				/obj/item/anvil_free = 1)
	time = 350
	category = CAT_STRUCTURE
	always_availible = TRUE

/datum/crafting_recipe/smithman/srub
	name = "Полено"
	result = /obj/item/srub
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10)
	time = 100
	category = CAT_STRUCTURE
	always_availible = TRUE

/datum/crafting_recipe/smithman/furnace
	name = "Плавильня"
	result = /obj/furnace
	reqs = list(/obj/item/raw_stone = 10, /obj/item/stack/sheet/mineral/wood = 10)
	time = 300
	category = CAT_STRUCTURE
	always_availible = TRUE

/datum/crafting_recipe/smithman/forge
	name = "Кузница"
	result = /obj/forge
	reqs = list(/obj/item/raw_stone = 20, /obj/item/stack/sheet/mineral/wood = 20)
	time = 300
	category = CAT_STRUCTURE
	always_availible = TRUE

/obj/effect/baseturf_helper/beach/raw_stone
	name = "raw stone baseturf editor"
	baseturf = /turf/open/floor/grass/gensgrass/dirty/stone/raw
