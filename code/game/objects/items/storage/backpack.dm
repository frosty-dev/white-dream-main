/* Backpacks
 * Contains:
 *		Backpack
 *		Backpack Types
 *		Satchel Types
 */

/*
 * Backpack
 */

/obj/item/storage/backpack
	name = "рюкзак"
	desc = "Ты носишь это на спине и кладешь туда вещи."
	icon_state = "backpack"
	inhand_icon_state = "backpack"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK	//ERROOOOO
	resistance_flags = NONE
	max_integrity = 300

/obj/item/storage/backpack/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 21
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_items = 21

/*
 * Backpack Types
 */

/obj/item/storage/backpack/old/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 12

/obj/item/bag_of_holding_inert
	name = "inert bag of holding"
	desc = "What is currently a just an unwieldly block of metal with a slot ready to accept a bluespace anomaly core."
	icon = 'icons/obj/storage.dmi'
	icon_state = "brokenpack"
	inhand_icon_state = "brokenpack"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FIRE_PROOF
	item_flags = NO_MAT_REDEMPTION

/obj/item/storage/backpack/holding
	name = "сумка хранения"
	desc = "Рюкзак, который открывает портал в локализованный карман блюспейс пространства."
	icon_state = "holdingpack"
	inhand_icon_state = "holdingpack"
	resistance_flags = FIRE_PROOF
	item_flags = NO_MAT_REDEMPTION
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 60, "acid" = 50)
	component_type = /datum/component/storage/concrete/bluespace/bag_of_holding

/obj/item/storage/backpack/holding/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.allow_big_nesting = TRUE
	STR.max_w_class = WEIGHT_CLASS_GIGANTIC
	STR.max_combined_w_class = 35

/obj/item/storage/backpack/holding/suicide_act(mob/living/user)
	user.visible_message("<span class='suicide'>[user] is jumping into [src]! It looks like [user.p_theyre()] trying to commit suicide.</span>")
	user.dropItemToGround(src, TRUE)
	user.Stun(100, ignore_canstun = TRUE)
	sleep(20)
	playsound(src, "rustle", 50, TRUE, -5)
	qdel(user)

/obj/item/storage/backpack/santabag
	name = "подарочный мешок Санты"
	desc = "Космический Санта использует это, чтобы доставить подарки всем хорошим детям в пространстве в Рождество! Вау, он довольно большой!"
	icon_state = "giftbag0"
	inhand_icon_state = "giftbag"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/backpack/santabag/Initialize()
	. = ..()
	regenerate_presents()

/obj/item/storage/backpack/santabag/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_combined_w_class = 60

/obj/item/storage/backpack/santabag/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] places [src] over [user.p_their()] head and pulls it tight! It looks like [user.p_they()] [user.p_are()]n't in the Christmas spirit...</span>")
	return (OXYLOSS)

/obj/item/storage/backpack/santabag/proc/regenerate_presents()
	addtimer(CALLBACK(src, .proc/regenerate_presents), 30 SECONDS)

	var/mob/M = get(loc, /mob)
	if(!istype(M))
		return
	if(M.mind && HAS_TRAIT(M.mind, TRAIT_CANNOT_OPEN_PRESENTS))
		var/datum/component/storage/STR = GetComponent(/datum/component/storage)
		var/turf/floor = get_turf(src)
		var/obj/item/I = new /obj/item/a_gift/anything(floor)
		if(STR.can_be_inserted(I, stop_messages=TRUE))
			STR.handle_item_insertion(I, prevent_warning=TRUE)
		else
			qdel(I)


/obj/item/storage/backpack/cultpack
	name = "рюкзак для трофеев"
	desc = "Он полезен как для переноски дополнительного снаряжения, так и для гордого декларирования вашего безумия."
	icon_state = "cultpack"
	inhand_icon_state = "backpack"

/obj/item/storage/backpack/clown
	name = "Giggles von Honkerton"
	desc = "Это рюкзак, сделанный Хонком!."
	icon_state = "clownpack"
	inhand_icon_state = "clownpack"

/obj/item/storage/backpack/explorer
	name = "рюкзак исследователя"
	desc = "Прочный рюкзак для хранения добытого имущества."
	icon_state = "explorerpack"
	inhand_icon_state = "explorerpack"

/obj/item/storage/backpack/mime
	name = "Parcel Parceaux"
	desc = "Безмолвный рюкзак, сделанный для тех безмолвных рабочих. Тишина Ко."
	icon_state = "mimepack"
	inhand_icon_state = "mimepack"

/obj/item/storage/backpack/medic
	name = "медицинский рюкзак"
	desc = "Это рюкзак, специально разработанный для использования в стерильных условиях."
	icon_state = "medicalpack"
	inhand_icon_state = "medicalpack"

/obj/item/storage/backpack/security
	name = "рюкзак офицера"
	desc = "Это очень прочный рюкзак."
	icon_state = "securitypack"
	inhand_icon_state = "securitypack"

/obj/item/storage/backpack/captain
	name = "капитанский рюкзак"
	desc = "Это специальный рюкзак, сделанный исключительно для офицеров Нанотрейзена."
	icon_state = "captainpack"
	inhand_icon_state = "captainpack"

/obj/item/storage/backpack/industrial
	name = "промышленный рюкзак"
	desc = "Это жесткий рюкзак для повседневной работы на станции."
	icon_state = "engiepack"
	inhand_icon_state = "engiepack"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/botany
	name = "ботанический рюкзак"
	desc = "Это рюкзак из натуральных волокон."
	icon_state = "botpack"
	inhand_icon_state = "botpack"

/obj/item/storage/backpack/chemistry
	name = "химический рюкзак"
	desc = "Рюкзак, специально разработанный для защиты от пятен и опасных жидкостей."
	icon_state = "chempack"
	inhand_icon_state = "chempack"

/obj/item/storage/backpack/genetics
	name = "генетический рюкзак"
	desc = "Сумка, разработанная для того, чтобы быть суперпрочной, на случай, если кто-нибудь на меня набросится."
	icon_state = "genepack"
	inhand_icon_state = "genepack"

/obj/item/storage/backpack/science
	name = "научный рюкзак"
	desc = "Специально разработанный рюкзак. Он огнестойкий и смутно пахнет плазмой."
	icon_state = "toxpack"
	inhand_icon_state = "toxpack"

/obj/item/storage/backpack/virology
	name = "вирусологический рюкзак"
	desc = "Рюкзак из гипоаллергенных волокон. Он разработан для предотвращения распространения болезней. Пахнет обезьяной."
	icon_state = "viropack"
	inhand_icon_state = "viropack"

/obj/item/storage/backpack/ert
	name = "рюкзак командира группы реагирования на чрезвычайные ситуации"
	desc = "Просторный рюкзак с большим количеством карманов, который носит командир группы быстрого реагирования."
	icon_state = "ert_commander"
	inhand_icon_state = "securitypack"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/ert/security
	name = "рюкзак службы безопасности группы реагирования на чрезвычайные ситуации"
	desc = "Просторный рюкзак с большим количеством карманов, который носят сотрудники службы безопасности Группы реагирования на чрезвычайные ситуации."
	icon_state = "ert_security"

/obj/item/storage/backpack/ert/medical
	name = "медицинский рюкзак группы экстренного реагирования"
	desc = "Просторный рюкзак с большим количеством карманов, который носят медицинские работники бригады быстрого реагирования."
	icon_state = "ert_medical"

/obj/item/storage/backpack/ert/engineer
	name = "рюкзак инженера группы реагирования на чрезвычайные ситуации"
	desc = "Просторный рюкзак с большим количеством карманов, который носят инженеры аварийно-спасательной службы."
	icon_state = "ert_engineering"

/obj/item/storage/backpack/ert/janitor
	name = "emergency response team janitor backpack"
	desc = "A spacious backpack with lots of pockets, worn by Janitors of an Emergency Response Team."
	icon_state = "ert_janitor"

/obj/item/storage/backpack/ert/clown
	name = "emergency response team clown backpack"
	desc = "A spacious backpack with lots of pockets, worn by Clowns of an Emergency Response Team."
	icon_state = "ert_clown"
/*
 * Satchel Types
 */

/obj/item/storage/backpack/satchel
	name = "сумка"
	desc = "Модная сумка."
	icon_state = "satchel-norm"
	inhand_icon_state = "satchel-norm"
	gender = FEMALE // прикол

/obj/item/storage/backpack/satchel/leather
	name = "кожаная сумка"
	desc = "Это очень модная сумка из тонкой кожи."
	icon_state = "satchel"
	inhand_icon_state = "satchel"

/obj/item/storage/backpack/satchel/leather/withwallet/PopulateContents()
	new /obj/item/storage/wallet/random(src)

/obj/item/storage/backpack/satchel/fireproof
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/satchel/eng
	name = "промышленная сумка"
	desc = "Прочный сумка с дополнительными карманами."
	icon_state = "satchel-eng"
	inhand_icon_state = "satchel-eng"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/satchel/med
	name = "медицинская сумка"
	desc = "Стерильный сумка, используемый в медицинских отделениях."
	icon_state = "satchel-med"
	inhand_icon_state = "satchel-med"

/obj/item/storage/backpack/satchel/vir
	name = "сумка вирусолога"
	desc = "Стерильная сумка цвета вирусолога."
	icon_state = "satchel-vir"
	inhand_icon_state = "satchel-vir"

/obj/item/storage/backpack/satchel/chem
	name = "аптекарская сумка"
	desc = "Стерильная сумка с цветами химика."
	icon_state = "satchel-chem"
	inhand_icon_state = "satchel-chem"

/obj/item/storage/backpack/satchel/gen
	name = "сумка генетика"
	desc = "Стерильная сумка генетического цвета."
	icon_state = "satchel-gen"
	inhand_icon_state = "satchel-gen"

/obj/item/storage/backpack/satchel/tox
	name = "сумка учёного"
	desc = "Полезно для хранения исследовательских материалов."
	icon_state = "satchel-tox"
	inhand_icon_state = "satchel-tox"

/obj/item/storage/backpack/satchel/hyd
	name = "сумка ботаника"
	desc = "Сумка из натуральных волокон."
	icon_state = "satchel-hyd"
	inhand_icon_state = "satchel-hyd"

/obj/item/storage/backpack/satchel/sec
	name = "сумка офицера"
	desc = "Надежная сумка для нужд, связанных с безопасностью."
	icon_state = "satchel-sec"
	inhand_icon_state = "satchel-sec"

/obj/item/storage/backpack/satchel/explorer
	name = "сумка исследователя"
	desc = "Надежная сумка для хранения награбленного."
	icon_state = "satchel-explorer"
	inhand_icon_state = "satchel-explorer"

/obj/item/storage/backpack/satchel/cap
	name = "сумка капитана"
	desc = "Эксклюзивная сумка для офицеров Нанотрейзена."
	icon_state = "satchel-cap"
	inhand_icon_state = "satchel-cap"

/obj/item/storage/backpack/satchel/flat
	name = "сумка контрабандиста"
	desc = "Очень тонкая сумка, которая легко помещается в ограниченном пространстве."
	icon_state = "satchel-flat"
	inhand_icon_state = "satchel-flat"
	w_class = WEIGHT_CLASS_NORMAL //Can fit in backpacks itself.

/obj/item/storage/backpack/satchel/flat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/undertile, TRAIT_T_RAY_VISIBLE, INVISIBILITY_OBSERVER, use_anchor = TRUE)

/obj/item/storage/backpack/satchel/flat/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 15
	STR.set_holdable(null, list(/obj/item/storage/backpack/satchel/flat)) //muh recursive backpacks)

/obj/item/storage/backpack/satchel/flat/PopulateContents()
	var/datum/supply_pack/costumes_toys/randomised/contraband/C = new
	for(var/i in 1 to 2)
		var/ctype = pick(C.contains)
		new ctype(src)

	qdel(C)

/obj/item/storage/backpack/satchel/flat/with_tools/PopulateContents()
	new /obj/item/stack/tile/plasteel(src)
	new /obj/item/crowbar(src)

	..()

/obj/item/storage/backpack/satchel/flat/empty/PopulateContents()
	return

/obj/item/storage/backpack/duffelbag
	name = "вещмешок"
	desc = "Большая сумка для хранения лишних вещей."
	icon_state = "duffel"
	inhand_icon_state = "duffel"
	slowdown = 1

/obj/item/storage/backpack/duffelbag/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 30

/obj/item/storage/backpack/duffelbag/captain
	name = "капитанский вещмешок"
	desc = "Большая сумка для хранения дополнительных капитанских вещей."
	icon_state = "duffel-captain"
	inhand_icon_state = "duffel-captain"

/obj/item/storage/backpack/duffelbag/med
	name = "медицинская сумка для вещей"
	desc = "Большая сумка для хранения дополнительных медицинских принадлежностей."
	icon_state = "duffel-med"
	inhand_icon_state = "duffel-med"

/obj/item/storage/backpack/duffelbag/med/surgery
	name = "хирургический вещмешок"
	desc = "Большая сумка для хранения дополнительных медицинских принадлежностей - похоже, она предназначена для хранения хирургических инструментов."

/obj/item/storage/backpack/duffelbag/med/surgery/PopulateContents()
	new /obj/item/scalpel(src)
	new /obj/item/hemostat(src)
	new /obj/item/retractor(src)
	new /obj/item/circular_saw(src)
	new /obj/item/surgicaldrill(src)
	new /obj/item/cautery(src)
	new /obj/item/bonesetter(src)
	new /obj/item/surgical_drapes(src)
	new /obj/item/clothing/mask/surgical(src)
	new /obj/item/razor(src)

/obj/item/storage/backpack/duffelbag/sec
	name = "вещмешок для офицера"
	desc = "Большая сумка для хранения дополнительных охранных принадлежностей и боеприпасов."
	icon_state = "duffel-sec"
	inhand_icon_state = "duffel-sec"

/obj/item/storage/backpack/duffelbag/sec/surgery
	name = "хирургический мешок для вещей"
	desc = "Большая сумка для хранения дополнительных принадлежностей - это сумка с материалом, в которой есть место для различных остроконечных инструментов."

/obj/item/storage/backpack/duffelbag/sec/surgery/PopulateContents()
	new /obj/item/scalpel(src)
	new /obj/item/hemostat(src)
	new /obj/item/retractor(src)
	new /obj/item/circular_saw(src)
	new /obj/item/bonesetter(src)
	new /obj/item/surgicaldrill(src)
	new /obj/item/cautery(src)
	new /obj/item/surgical_drapes(src)
	new /obj/item/clothing/mask/surgical(src)

/obj/item/storage/backpack/duffelbag/engineering
	name = "промышленный вещевой мешок"
	desc = "Большая сумка для хранения дополнительных инструментов и принадлежностей."
	icon_state = "duffel-eng"
	inhand_icon_state = "duffel-eng"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/duffelbag/drone
	name = "вещмешок дрона"
	desc = "Большая сумка для хранения инструментов и шляп."
	icon_state = "duffel-drone"
	inhand_icon_state = "duffel-drone"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/duffelbag/drone/PopulateContents()
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool(src)
	new /obj/item/crowbar(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/wirecutters(src)
	new /obj/item/multitool(src)

/obj/item/storage/backpack/duffelbag/clown
	name = "вещевой мешок клоуна"
	desc = "Большая сумка для хранения смешных шуток!"
	icon_state = "duffel-clown"
	inhand_icon_state = "duffel-clown"

/obj/item/storage/backpack/duffelbag/clown/cream_pie/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/reagent_containers/food/snacks/pie/cream(src)

/obj/item/storage/backpack/fireproof
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/duffelbag/syndie
	name = "подозрительно выглядящий вещевой мешок"
	desc = "Большая сумка для хранения дополнительных тактических принадлежностей."
	icon_state = "duffel-syndie"
	inhand_icon_state = "duffel-syndieammo"
	slowdown = 0
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/duffelbag/syndie/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.silent = TRUE

/obj/item/storage/backpack/duffelbag/syndie/hitman
	desc = "Большая сумка для хранения лишних вещей. Сзади логотип Nanotrasen."
	icon_state = "duffel-syndieammo"
	inhand_icon_state = "duffel-syndieammo"

/obj/item/storage/backpack/duffelbag/syndie/hitman/PopulateContents()
	new /obj/item/clothing/under/suit/black(src)
	new /obj/item/clothing/accessory/waistcoat(src)
	new /obj/item/clothing/suit/toggle/lawyer/black(src)
	new /obj/item/clothing/shoes/laceup(src)
	new /obj/item/clothing/gloves/color/black(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clothing/head/fedora(src)

/obj/item/storage/backpack/duffelbag/syndie/med
	name = "медицинская сумка для вещей"
	desc = "Большая сумка для хранения дополнительных тактических медицинских принадлежностей."
	icon_state = "duffel-syndiemed"
	inhand_icon_state = "duffel-syndiemed"

/obj/item/storage/backpack/duffelbag/syndie/surgery
	name = "сумка с хирургическим материалом"
	desc = "Подозрительно красивая сумка для хранения хирургических инструментов."
	icon_state = "duffel-syndiemed"
	inhand_icon_state = "duffel-syndiemed"

/obj/item/storage/backpack/duffelbag/syndie/surgery/PopulateContents()
	new /obj/item/scalpel(src)
	new /obj/item/hemostat(src)
	new /obj/item/retractor(src)
	new /obj/item/circular_saw(src)
	new /obj/item/bonesetter(src)
	new /obj/item/surgicaldrill(src)
	new /obj/item/cautery(src)
	new /obj/item/surgical_drapes(src)
	new /obj/item/clothing/suit/straight_jacket(src)
	new /obj/item/clothing/mask/muzzle(src)
	new /obj/item/mmi/syndie(src)

/obj/item/storage/backpack/duffelbag/syndie/ammo
	name = "вещевой мешок с аммуницией"
	desc = "Большая сумка для хранения дополнительных боеприпасов и принадлежностей для оружия."
	icon_state = "duffel-syndieammo"
	inhand_icon_state = "duffel-syndieammo"

/obj/item/storage/backpack/duffelbag/syndie/ammo/shotgun
	desc = "Большая сумка, упакованная до краев магазинами бульдогского дробовика."

/obj/item/storage/backpack/duffelbag/syndie/ammo/shotgun/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_box/magazine/m12g(src)
	new /obj/item/ammo_box/magazine/m12g/slug(src)
	new /obj/item/ammo_box/magazine/m12g/slug(src)
	new /obj/item/ammo_box/magazine/m12g/dragon(src)

/obj/item/storage/backpack/duffelbag/syndie/ammo/smg
	desc = "Большая сумка, упакованная до краев магазинами С-20r."

/obj/item/storage/backpack/duffelbag/syndie/ammo/smg/PopulateContents()
	for(var/i in 1 to 9)
		new /obj/item/ammo_box/magazine/smgm45(src)

/obj/item/storage/backpack/duffelbag/syndie/ammo/dark_gygax
	desc = "Большая сумка для вещей, упакованная до краев с различными экзотическими боеприпасами."

/obj/item/storage/backpack/duffelbag/syndie/ammo/mech/PopulateContents()
	new /obj/item/mecha_ammo/scattershot(src)
	new /obj/item/mecha_ammo/scattershot(src)
	new /obj/item/mecha_ammo/scattershot(src)
	new /obj/item/mecha_ammo/scattershot(src)
	new /obj/item/storage/belt/utility/syndicate(src)

/obj/item/storage/backpack/duffelbag/syndie/ammo/mauler
	desc = "Большая сумка для вещей, упакованная до краев с различными экзотическими боеприпасами."

/obj/item/storage/backpack/duffelbag/syndie/ammo/mauler/PopulateContents()
	new /obj/item/mecha_ammo/lmg(src)
	new /obj/item/mecha_ammo/lmg(src)
	new /obj/item/mecha_ammo/lmg(src)
	new /obj/item/mecha_ammo/scattershot(src)
	new /obj/item/mecha_ammo/scattershot(src)
	new /obj/item/mecha_ammo/scattershot(src)
	new /obj/item/mecha_ammo/missiles_he(src)
	new /obj/item/mecha_ammo/missiles_he(src)
	new /obj/item/mecha_ammo/missiles_he(src)

/obj/item/storage/backpack/duffelbag/syndie/c20rbundle
	desc = "Большая сумка, содержащая С-20r, журналы и дешевый глушитель."

/obj/item/storage/backpack/duffelbag/syndie/c20rbundle/PopulateContents()
	new /obj/item/ammo_box/magazine/smgm45(src)
	new /obj/item/ammo_box/magazine/smgm45(src)
	new /obj/item/gun/ballistic/automatic/c20r(src)
	new /obj/item/suppressor/specialoffer(src)

/obj/item/storage/backpack/duffelbag/syndie/bulldogbundle
	desc = "Большая сумка с бульдогом, несколькими барабанами и парой тепловизионных очков."

/obj/item/storage/backpack/duffelbag/syndie/bulldogbundle/PopulateContents()
	new /obj/item/gun/ballistic/shotgun/bulldog(src)
	new /obj/item/ammo_box/magazine/m12g(src)
	new /obj/item/ammo_box/magazine/m12g(src)
	new /obj/item/clothing/glasses/thermal/syndi(src)

/obj/item/storage/backpack/duffelbag/syndie/med/medicalbundle
	desc = "Большая сумка с медицинским оборудованием, газонокосилкой Donksoft LMG, большой гигантской коробкой с метательными дротиками и парой поддельных магбутсов."

/obj/item/storage/backpack/duffelbag/syndie/med/medicalbundle/PopulateContents()
	new /obj/item/clothing/shoes/magboots/syndie(src)
	new /obj/item/storage/firstaid/tactical(src)
	new /obj/item/gun/ballistic/automatic/l6_saw/toy(src)
	new /obj/item/ammo_box/foambox/riot(src)

/obj/item/storage/backpack/duffelbag/syndie/med/bioterrorbundle
	desc = "Большая сумка со смертоносными химикатами, ручной химический распылитель, пенная граната Bioterror, штурмовая винтовка Donksoft, коробка со стрелами, пистолет-пулемет и коробка со шприцами."

/obj/item/storage/backpack/duffelbag/syndie/med/bioterrorbundle/PopulateContents()
	new /obj/item/reagent_containers/spray/chemsprayer/bioterror(src)
	new /obj/item/storage/box/syndie_kit/chemical(src)
	new /obj/item/gun/syringe/syndicate(src)
	new /obj/item/gun/ballistic/automatic/c20r/toy(src)
	new /obj/item/storage/box/syringes(src)
	new /obj/item/ammo_box/foambox/riot(src)
	new /obj/item/grenade/chem_grenade/bioterrorfoam(src)
	if(prob(5))
		new /obj/item/reagent_containers/food/snacks/pizza/pineapple(src)

/obj/item/storage/backpack/duffelbag/syndie/c4/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/grenade/c4(src)

/obj/item/storage/backpack/duffelbag/syndie/x4/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/grenade/c4/x4(src)

/obj/item/storage/backpack/duffelbag/syndie/firestarter
	desc = "Большая сумка с новым российским пиробуквенным опрыскивателем, элитным костюмом, пистолетом Stechkin APS, минибомбой, патронами и другим оборудованием."

/obj/item/storage/backpack/duffelbag/syndie/firestarter/PopulateContents()
	new /obj/item/clothing/under/syndicate/soviet(src)
	new /obj/item/watertank/op(src)
	new /obj/item/clothing/suit/space/hardsuit/syndi/elite(src)
	new /obj/item/gun/ballistic/automatic/pistol/aps(src)
	new /obj/item/ammo_box/magazine/m9mm_aps/fire(src)
	new /obj/item/ammo_box/magazine/m9mm_aps/fire(src)
	new /obj/item/reagent_containers/food/drinks/bottle/vodka/badminka(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimulants(src)
	new /obj/item/grenade/syndieminibomb(src)

// For ClownOps.
/obj/item/storage/backpack/duffelbag/clown/syndie/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	slowdown = 0
	STR.silent = TRUE

/obj/item/storage/backpack/duffelbag/clown/syndie/PopulateContents()
	new /obj/item/pda/clown(src)
	new /obj/item/clothing/under/rank/civilian/clown(src)
	new /obj/item/clothing/shoes/clown_shoes(src)
	new /obj/item/clothing/mask/gas/clown_hat(src)
	new /obj/item/bikehorn(src)
	new /obj/item/implanter/sad_trombone(src)

/obj/item/storage/backpack/henchmen
	name = "wings"
	desc = "Granted to the henchmen who deserve it. This probably doesn't include you."
	icon_state = "henchmen"
	inhand_icon_state = "henchmen"

/obj/item/storage/backpack/duffelbag/cops
	name = "police bag"
	desc = "A large duffel bag for holding extra police gear."
	slowdown = 0
