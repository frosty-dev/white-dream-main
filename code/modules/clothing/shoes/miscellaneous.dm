/obj/item/clothing/proc/step_action() //this was made to rewrite clown shoes squeaking
	SEND_SIGNAL(src, COMSIG_SHOES_STEP_ACTION)

/obj/item/clothing/shoes/sneakers/mime
	name = "обувь мима"
	icon_state = "mime"

/obj/item/clothing/shoes/combat //basic syndicate combat boots for nuke ops and mob corpses
	name = "боевые ботинки"
	desc = "Высокоскоростные ботинки с низким сопротивлением."
	icon_state = "jackboots"
	inhand_icon_state = "jackboots"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	armor = list("melee" = 25, "bullet" = 25, "laser" = 25, "energy" = 25, "bomb" = 50, "bio" = 10, "rad" = 0, "fire" = 70, "acid" = 50)
	strip_delay = 40
	resistance_flags = NONE
	permeability_coefficient = 0.05 //Thick soles, and covers the ankle
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes
	lace_time = 12 SECONDS

/obj/item/clothing/shoes/combat/sneakboots
	name = "sneakboots"
	desc = "These boots have special noise cancelling soles. Perfect for stealth, if it wasn't for the color scheme."
	icon_state = "sneakboots"
	inhand_icon_state = "sneakboots"
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FIRE_PROOF |  ACID_PROOF

/obj/item/clothing/shoes/combat/sneakboots/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_FEET)
		ADD_TRAIT(user, TRAIT_SILENT_FOOTSTEPS, SHOES_TRAIT)

/obj/item/clothing/shoes/combat/sneakboots/dropped(mob/living/carbon/human/user)
	REMOVE_TRAIT(user, TRAIT_SILENT_FOOTSTEPS, SHOES_TRAIT)
	return ..()

/obj/item/clothing/shoes/combat/swat //overpowered boots for death squads
	name = "\improper SWAT-буты"
	desc = "Высокоскоростные ботинки без сопротивления."
	permeability_coefficient = 0.01
	clothing_flags = NOSLIP
	armor = list("melee" = 40, "bullet" = 30, "laser" = 25, "energy" = 25, "bomb" = 50, "bio" = 30, "rad" = 30, "fire" = 90, "acid" = 50)

/obj/item/clothing/shoes/sandal
	desc = "Пара довольно простых деревянных сандалий."
	name = "тапочки"
	icon_state = "wizard"
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT * 0.5)
	strip_delay = 5
	equip_delay_other = 50
	permeability_coefficient = 0.9
	can_be_tied = FALSE

/obj/item/clothing/shoes/sandal/marisa
	desc = "Пара волшебных чёрных туфель."
	name = "магические туфли"
	icon_state = "black"
	resistance_flags = FIRE_PROOF |  ACID_PROOF

/obj/item/clothing/shoes/sandal/magic
	name = "магические тапочки"
	desc = "Пара тапочек, наполненных магией."
	resistance_flags = FIRE_PROOF |  ACID_PROOF

/obj/item/clothing/shoes/galoshes
	desc = "Пара желтых резиновых ботинок, предназначенных для предотвращения соскальзывания на влажных поверхностях."
	name = "галоши"
	icon_state = "galoshes"
	permeability_coefficient = 0.01
	clothing_flags = NOSLIP
	slowdown = SHOES_SLOWDOWN+1
	strip_delay = 30
	equip_delay_other = 50
	resistance_flags = NONE
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 40, "acid" = 75)
	can_be_bloody = FALSE
	custom_price = 600
	can_be_tied = FALSE

/obj/item/clothing/shoes/galoshes/dry
	name = "абсорбирующие галоши"
	desc = "Пара оранжевых резиновых ботинок, предназначенных для предотвращения соскальзывания на влажных поверхностях, а также для их сушки."
	icon_state = "galoshes_dry"

/obj/item/clothing/shoes/galoshes/dry/step_action()
	var/turf/open/t_loc = get_turf(src)
	SEND_SIGNAL(t_loc, COMSIG_TURF_MAKE_DRY, TURF_WET_WATER, TRUE, INFINITY)

/obj/item/clothing/shoes/clown_shoes
	desc = "Стандартные шутничающие ботинки клоунады для клоунады. Черт, они огромные! Удерживая нажатой клавишу Ctrl, переключайте воздушные демпферы."
	name = "обутки клоуна"
	icon_state = "clown"
	inhand_icon_state = "clown_shoes"
	slowdown = SHOES_SLOWDOWN+1
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes/clown
	var/enabled_waddle = TRUE
	lace_time = 20 SECONDS // how the hell do these laces even work??

/obj/item/clothing/shoes/clown_shoes/Initialize()
	. = ..()
	AddComponent(/datum/component/squeak, list('sound/effects/clownstep1.ogg'=1,'sound/effects/clownstep2.ogg'=1), 50)

/obj/item/clothing/shoes/clown_shoes/equipped(mob/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_FEET)
		if(enabled_waddle)
			user.AddElement(/datum/element/waddling)
		if(user.mind && user.mind.assigned_role == "Clown")
			SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "clownshoes", /datum/mood_event/clownshoes)

/obj/item/clothing/shoes/clown_shoes/dropped(mob/user)
	. = ..()
	user.RemoveElement(/datum/element/waddling)
	if(user.mind && user.mind.assigned_role == "Clown")
		SEND_SIGNAL(user, COMSIG_CLEAR_MOOD_EVENT, "clownshoes")

/obj/item/clothing/shoes/clown_shoes/CtrlClick(mob/living/user)
	if(!isliving(user))
		return
	if(user.get_active_held_item() != src)
		to_chat(user, "<span class='warning'>You must hold the [src] in your hand to do this!</span>")
		return
	if (!enabled_waddle)
		to_chat(user, "<span class='notice'>You switch off the waddle dampeners!</span>")
		enabled_waddle = TRUE
	else
		to_chat(user, "<span class='notice'>You switch on the waddle dampeners!</span>")
		enabled_waddle = FALSE

/obj/item/clothing/shoes/clown_shoes/jester
	name = "обутки шута"
	desc = "Обувь придворного шута, дополненная современными скрипучими технологиями."
	icon_state = "jester_shoes"

/obj/item/clothing/shoes/jackboots
	name = "сапоги"
	desc = "Боевые ботинки Нанотрейзен для боевых сценариев или боевых ситуаций. Все время в бою."
	icon_state = "jackboots"
	inhand_icon_state = "jackboots"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	strip_delay = 30
	equip_delay_other = 50
	resistance_flags = NONE
	permeability_coefficient = 0.05 //Thick soles, and covers the ankle
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes
	can_be_tied = FALSE

/obj/item/clothing/shoes/jackboots/fast
	slowdown = -1

/obj/item/clothing/shoes/winterboots
	name = "зимняя обувь"
	desc = "Сапоги, обшитые \"синтетическим\" мехом животных."
	icon_state = "winterboots"
	inhand_icon_state = "winterboots"
	permeability_coefficient = 0.15
	cold_protection = FEET|LEGS
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT
	heat_protection = FEET|LEGS
	max_heat_protection_temperature = SHOES_MAX_TEMP_PROTECT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes
	lace_time = 8 SECONDS

/obj/item/clothing/shoes/winterboots/ice_boots
	name = "ice hiking boots"
	desc = "A pair of winter boots with special grips on the bottom, designed to prevent slipping on frozen surfaces."
	icon_state = "iceboots"
	inhand_icon_state = "iceboots"
	clothing_flags = NOSLIP_ICE

/obj/item/clothing/shoes/workboots
	name = "рабочие ботинки"
	desc = "Нанотрасен выпускает инженерные шнуровочные рабочие ботинки для особо рабочих воротничков."
	icon_state = "workboots"
	inhand_icon_state = "jackboots"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	permeability_coefficient = 0.15
	strip_delay = 20
	equip_delay_other = 40
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes
	lace_time = 8 SECONDS

/obj/item/clothing/shoes/workboots/mining
	name = "шахтёрские ботинки"
	desc = "Стальные горно-шахтные ботинки для горнодобывающей промышленности во взрывоопасных условиях. Отлично держит пальцы ног не раздавленными."
	icon_state = "explorer"
	resistance_flags = FIRE_PROOF

/obj/item/clothing/shoes/cult
	name = "ботинки служителя Нар'Си"
	desc = "Пара ботинок, которые носят служители Нар'Си."
	icon_state = "cult"
	inhand_icon_state = "cult"
	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT
	heat_protection = FEET
	max_heat_protection_temperature = SHOES_MAX_TEMP_PROTECT
	lace_time = 10 SECONDS

/obj/item/clothing/shoes/cult/alt
	name = "обутки культиста"
	icon_state = "cultalt"

/obj/item/clothing/shoes/cult/alt/ghost
	item_flags = DROPDEL

/obj/item/clothing/shoes/cult/alt/ghost/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CULT_TRAIT)

/obj/item/clothing/shoes/cyborg
	name = "обутки киборка"
	desc = "Обувь для киборгского костюма."
	icon_state = "boots"

/obj/item/clothing/shoes/laceup
	name = "шнуровочные туфли"
	desc = "Высота моды, и они предварительно отполированы!"
	icon_state = "laceups"
	equip_delay_other = 50

/obj/item/clothing/shoes/roman
	name = "римские сандалии"
	desc = "Сандалии с кожаными ремнями с пряжками на них"
	icon_state = "roman"
	inhand_icon_state = "roman"
	strip_delay = 100
	equip_delay_other = 100
	permeability_coefficient = 0.9
	can_be_tied = FALSE

/obj/item/clothing/shoes/griffin
	name = "обувь гриффона"
	desc = "Пара костюмированных ботинок, сделанных по мотивам птичьих когтей."
	icon_state = "griffinboots"
	inhand_icon_state = "griffinboots"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes
	lace_time = 8 SECONDS

/obj/item/clothing/shoes/bhop
	name = "прыжковые ботинки"
	desc = "Специализированная пара боевых ботинок со встроенной двигательной установкой для быстрого передвижения."
	icon_state = "jetboots"
	inhand_icon_state = "jetboots"
	resistance_flags = FIRE_PROOF
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes
	actions_types = list(/datum/action/item_action/bhop)
	permeability_coefficient = 0.05
	strip_delay = 30
	var/jumpdistance = 5 //-1 from to see the actual distance, e.g 4 goes over 3 tiles
	var/jumpspeed = 3
	var/recharging_rate = 60 //default 6 seconds between each dash
	var/recharging_time = 0 //time until next dash

/obj/item/clothing/shoes/bhop/ui_action_click(mob/user, action)
	if(!isliving(user))
		return

	if(recharging_time > world.time)
		to_chat(user, "<span class='warning'>The boot's internal propulsion needs to recharge still!</span>")
		return

	var/atom/target = get_edge_target_turf(user, user.dir) //gets the user's direction

	if (user.throw_at(target, jumpdistance, jumpspeed, spin = FALSE, diagonals_first = TRUE))
		playsound(src, 'sound/effects/stealthoff.ogg', 50, TRUE, TRUE)
		user.visible_message("<span class='warning'>[usr] dashes forward into the air!</span>")
		recharging_time = world.time + recharging_rate
	else
		to_chat(user, "<span class='warning'>Something prevents you from dashing forward!</span>")

/obj/item/clothing/shoes/singery
	name = "желтые ботинки артиста"
	desc = "Эти сапоги были сделаны для танцев."
	icon_state = "ysing"
	equip_delay_other = 50

/obj/item/clothing/shoes/singerb
	name = "синие ботинки артиста"
	desc = "Эти сапоги были сделаны для танцев."
	icon_state = "bsing"
	equip_delay_other = 50

/obj/item/clothing/shoes/bronze
	name = "бронзовые ботинки"
	desc = "Гигантская, неуклюжая пара туфель, грубо сделанных из бронзы. Зачем кому-то их носить?"
	icon = 'icons/obj/clothing/clockwork_garb.dmi'
	icon_state = "clockwork_treads"
	lace_time = 8 SECONDS

/obj/item/clothing/shoes/bronze/Initialize()
	. = ..()
	AddComponent(/datum/component/squeak, list('sound/machines/clockcult/integration_cog_install.ogg' = 1, 'sound/magic/clockwork/fellowship_armory.ogg' = 1), 50)

/obj/item/clothing/shoes/wheelys
	name = "Вилли-Хилс"
	desc = "Использует запатентованную технологию выдвижных колес. Никогда не жертвуйте скоростью ради стиля - не то, чтобы это давало много и того, и другого." //Thanks Fel
	icon_state = "wheelys"
	inhand_icon_state = "wheelys"
	actions_types = list(/datum/action/item_action/wheelys)
	var/wheelToggle = FALSE //False means wheels are not popped out
	var/obj/vehicle/ridden/scooter/wheelys/W

/obj/item/clothing/shoes/wheelys/Initialize()
	. = ..()
	W = new /obj/vehicle/ridden/scooter/wheelys(null)

/obj/item/clothing/shoes/wheelys/ui_action_click(mob/user, action)
	if(!isliving(user))
		return
	if(!istype(user.get_item_by_slot(ITEM_SLOT_FEET), /obj/item/clothing/shoes/wheelys))
		to_chat(user, "<span class='warning'>You must be wearing the wheely-heels to use them!</span>")
		return
	if(!(W.is_occupant(user)))
		wheelToggle = FALSE
	if(wheelToggle)
		W.unbuckle_mob(user)
		wheelToggle = FALSE
		return
	W.forceMove(get_turf(user))
	W.buckle_mob(user)
	wheelToggle = TRUE

/obj/item/clothing/shoes/wheelys/dropped(mob/user)
	if(wheelToggle)
		W.unbuckle_mob(user)
		wheelToggle = FALSE
	..()

/obj/item/clothing/shoes/wheelys/Destroy()
	QDEL_NULL(W)
	. = ..()

/obj/item/clothing/shoes/kindle_kicks
	name = "Kindle Kicks"
	desc = "Они обязательно зажгут в тебе что-нибудь, и это не детская ностальгия..."
	icon_state = "kindleKicks"
	inhand_icon_state = "kindleKicks"
	actions_types = list(/datum/action/item_action/kindle_kicks)
	var/lightCycle = 0
	var/active = FALSE

/obj/item/clothing/shoes/kindle_kicks/ui_action_click(mob/user, action)
	if(active)
		return
	active = TRUE
	set_light(2, 3, rgb(rand(0,255),rand(0,255),rand(0,255)))
	addtimer(CALLBACK(src, .proc/lightUp), 5)

/obj/item/clothing/shoes/kindle_kicks/proc/lightUp(mob/user)
	if(lightCycle < 15)
		set_light(2, 3, rgb(rand(0,255),rand(0,255),rand(0,255)))
		lightCycle += 1
		addtimer(CALLBACK(src, .proc/lightUp), 5)
	else
		set_light(0)
		lightCycle = 0
		active = FALSE

/obj/item/clothing/shoes/russian
	name = "кирзачи"
	desc = "Заебись."
	icon_state = "rus_shoes"
	inhand_icon_state = "rus_shoes"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes
	lace_time = 8 SECONDS

/obj/item/clothing/shoes/cowboy
	name = "ковбойские ботинки"
	desc = "Небольшая наклейка дает вам знать, что они были проверены на наличие змей. Неясно, как давно проводилась проверка..."
	icon_state = "cowboy_brown"
	permeability_coefficient = 0.05 //these are quite tall
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes
	custom_price = 60
	var/list/occupants = list()
	var/max_occupants = 4
	can_be_tied = FALSE

/obj/item/clothing/shoes/cowboy/Initialize()
	. = ..()
	if(prob(2))
		var/mob/living/simple_animal/hostile/retaliate/poison/snake/bootsnake = new/mob/living/simple_animal/hostile/retaliate/poison/snake(src)
		occupants += bootsnake


/obj/item/clothing/shoes/cowboy/equipped(mob/living/carbon/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_FEET)
		for(var/mob/living/occupant in occupants)
			occupant.forceMove(user.drop_location())
			user.visible_message("<span class='warning'>[user] recoils as something slithers out of [src].</span>", "<span class='userdanger'>You feel a sudden stabbing pain in your [pick("foot", "toe", "ankle")]!</span>")
			user.Knockdown(20) //Is one second paralyze better here? I feel you would fall on your ass in some fashion.
			user.apply_damage(5, BRUTE, pick(BODY_ZONE_R_LEG, BODY_ZONE_L_LEG))
			if(istype(occupant, /mob/living/simple_animal/hostile/retaliate/poison))
				user.reagents.add_reagent(/datum/reagent/toxin, 7)
		occupants.Cut()

/obj/item/clothing/shoes/cowboy/MouseDrop_T(mob/living/target, mob/living/user)
	. = ..()
	if(user.stat || !(user.mobility_flags & MOBILITY_USE) || user.restrained() || !Adjacent(user) || !user.Adjacent(target) || target.stat == DEAD)
		return
	if(occupants.len >= max_occupants)
		to_chat(user, "<span class='warning'>[src] are full!</span>")
		return
	if(istype(target, /mob/living/simple_animal/hostile/retaliate/poison/snake) || istype(target, /mob/living/simple_animal/hostile/headcrab) || istype(target, /mob/living/carbon/alien/larva))
		occupants += target
		target.forceMove(src)
		to_chat(user, "<span class='notice'>[target] slithers into [src].</span>")

/obj/item/clothing/shoes/cowboy/container_resist(mob/living/user)
	if(!do_after(user, 10, target = user))
		return
	user.forceMove(user.drop_location())
	occupants -= user

/obj/item/clothing/shoes/cowboy/white
	name = "белые ковбойские сапоги"
	icon_state = "cowboy_white"

/obj/item/clothing/shoes/cowboy/black
	name = "чёрные ковбойские сапоги"
	desc = "У меня такое чувство, что кто-то мог быть повешен в этих ботинках."
	icon_state = "cowboy_black"

/obj/item/clothing/shoes/cowboy/fancy
	name = "сапоги Билтона Уэнглера"
	desc = "Пара аутентичных ботинок высокой моды из Японифорнии. Ты сомневаешься, что они когда-либо были близки со скотом."
	icon_state = "cowboy_fancy"
	permeability_coefficient = 0.08

/obj/item/clothing/shoes/cowboy/lizard
	name = "сапоги из кожи ящерицы"
	desc = "Изнутри ботинок можно услышать слабое шипение; надеешься, что это просто скорбный призрак."
	icon_state = "lizardboots_green"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 40, "acid" = 0) //lizards like to stay warm

/obj/item/clothing/shoes/cowboy/lizard/masterwork
	name = "\improper Hugs-The-Feet из кожи ящерицы"
	desc = "Пара мастерски изготовленных кожаных ботинок ящерицы. Наконец-то отличное приложение для самых беспокойных жителей станции."
	icon_state = "lizardboots_blue"

/obj/effect/spawner/lootdrop/lizardboots
	name = "random lizard boot quality"
	desc = "Which ever gets picked, the lizard race loses"
	icon = 'icons/obj/clothing/shoes.dmi'
	icon_state = "lizardboots_green"
	loot = list(
		/obj/item/clothing/shoes/cowboy/lizard = 7,
		/obj/item/clothing/shoes/cowboy/lizard/masterwork = 1)

/obj/item/clothing/shoes/cookflops
	desc = "Все эти разговоры об антагах, грейтайде и гриферах.... Я просто хочу жарить на гриле, ради Бога!"
	name = "тапочки грильмена"
	icon_state = "cookflops"
	can_be_tied = FALSE

/obj/item/clothing/shoes/yakuza
	name = "tojo clan shoes"
	desc = "Steel-toed and intimidating."
	icon_state = "MajimaShoes"
	inhand_icon_state = "MajimaShoes_worn"

/obj/item/clothing/shoes/jackbros
	name = "frosty boots"
	desc = "For when you're stepping on up to the plate."
	icon_state = "JackFrostShoes"
	inhand_icon_state = "JackFrostShoes_worn"
