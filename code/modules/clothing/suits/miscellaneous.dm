/*
 * Contains:
 *		Lasertag
 *		Costume
 *		Misc
 */

/*
 * Lasertag
 */
/obj/item/clothing/suit/bluetag
	name = "синяя броня лазер-тэга"
	desc = "Кусок пластиковой брони. У него есть датчики, которые реагируют на красный свет." //Lasers are concentrated light
	icon_state = "bluetag"
	inhand_icon_state = "bluetag"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST
	allowed = list (/obj/item/gun/energy/laser/bluetag)
	resistance_flags = NONE

/obj/item/clothing/suit/redtag
	name = "красная броня лазер-тэга"
	desc = "Кусок пластиковой брони. У него есть датчики, которые реагируют на синий свет."
	icon_state = "redtag"
	inhand_icon_state = "redtag"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST
	allowed = list (/obj/item/gun/energy/laser/redtag)
	resistance_flags = NONE

/*
 * Costume
 */
/obj/item/clothing/suit/hooded/flashsuit
	name = "флэшкостюм"
	desc = "Чего ты ожидал?"
	icon_state = "flashsuit"
	inhand_icon_state = "armor"
	body_parts_covered = CHEST|GROIN
	hoodtype = /obj/item/clothing/head/hooded/flashsuit

/obj/item/clothing/head/hooded/flashsuit
	name = "кнопка флэшки"
	desc = "Вы научитесь бояться вспышки."
	icon_state = "flashsuit"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEEARS|HIDEFACIALHAIR|HIDEFACE|HIDEMASK

/obj/item/clothing/suit/pirate
	name = "пиратское пальто"
	desc = "Yarr."
	icon_state = "pirate"
	inhand_icon_state = "pirate"
	allowed = list(/obj/item/melee/transforming/energy/sword/pirate, /obj/item/clothing/glasses/eyepatch, /obj/item/reagent_containers/food/drinks/bottle/rum)

/obj/item/clothing/suit/pirate/captain
	name = "пиратское пальто капитана"
	desc = "Yarr."
	icon_state = "hgpirate"
	inhand_icon_state = "hgpirate"


/obj/item/clothing/suit/cyborg_suit
	name = "костюм киборга"
	desc = "Костюм для костюма киборга."
	icon_state = "death"
	inhand_icon_state = "death"
	flags_1 = CONDUCT_1
	fire_resist = T0C+5200
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT


/obj/item/clothing/suit/justice
	name = "костюм справедливости"
	desc = "это выглядит довольно смешно" //Needs no fixing
	icon_state = "justice"
	inhand_icon_state = "justice"
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)


/obj/item/clothing/suit/judgerobe
	name = "одежда судьи"
	desc = "Этот халат командует властью."
	icon_state = "judge"
	inhand_icon_state = "judge"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	allowed = list(/obj/item/storage/fancy/cigarettes, /obj/item/stack/spacecash)
	flags_inv = HIDEJUMPSUIT


/obj/item/clothing/suit/apron/overalls
	name = "комбинезон"
	desc = "Комплект джинсовых комбинезонов."
	icon_state = "overalls"
	inhand_icon_state = "overalls"
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/suit/apron/purple_bartender
	name = "фиолетовый фартук бармена"
	desc = "Модный фиолетовый фартук для стильного человека."
	icon_state = "purplebartenderapron"
	inhand_icon_state = "purplebartenderapron"
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/suit/syndicatefake
	name = "чёрный и красный скафандр реплика"
	icon_state = "syndicate-black-red"
	inhand_icon_state = "syndicate-black-red"
	desc = "Пластиковая копия скафандра Синдиката. В этом вы будете выглядеть как настоящий убийственный агент Синдиката! Это игрушка, она не предназначена для использования в космосе!"
	w_class = WEIGHT_CLASS_NORMAL
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	resistance_flags = NONE

/obj/item/clothing/suit/hastur
	name = "\improper Hastur's robe"
	desc = "Robes not meant to be worn by man."
	icon_state = "hastur"
	inhand_icon_state = "hastur"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT


/obj/item/clothing/suit/imperium_monk
	name = "\improper Imperium monk suit"
	desc = "Have YOU killed a xeno today?"
	icon_state = "imperium_monk"
	inhand_icon_state = "imperium_monk"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDESHOES|HIDEJUMPSUIT
	allowed = list(/obj/item/storage/book/bible, /obj/item/nullrod, /obj/item/reagent_containers/food/drinks/bottle/holywater, /obj/item/storage/fancy/candle_box, /obj/item/candle, /obj/item/tank/internals/emergency_oxygen)


/obj/item/clothing/suit/chickensuit
	name = "куриный костюм"
	desc = "Костюм, сделанный давно древней империей KFC."
	icon_state = "chickensuit"
	inhand_icon_state = "chickensuit"
	body_parts_covered = CHEST|ARMS|GROIN|LEGS|FEET
	flags_inv = HIDESHOES|HIDEJUMPSUIT


/obj/item/clothing/suit/monkeysuit
	name = "костюм обезьяны"
	desc = "Костюм, который выглядит как примат."
	icon_state = "monkeysuit"
	inhand_icon_state = "monkeysuit"
	body_parts_covered = CHEST|ARMS|GROIN|LEGS|FEET|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT

/obj/item/clothing/suit/toggle/owlwings
	name = "плащ совы"
	desc = "Мягкий коричневый плащ из синтетических перьев. Мягкий на ощупь, стильный и 2-метровый размах крыльев, который сводит женщин с ума."
	icon_state = "owl_wings"
	inhand_icon_state = "owl_wings"
	togglename = "wings"
	body_parts_covered = ARMS|CHEST
	actions_types = list(/datum/action/item_action/toggle_wings)

/obj/item/clothing/suit/toggle/owlwings/Initialize()
	. = ..()
	allowed = GLOB.security_vest_allowed

/obj/item/clothing/suit/toggle/owlwings/griffinwings
	name = "плащ-грифон"
	desc = "Шикарный белый плащ из синтетических перьев. Мягкий на ощупь, стильный и 2-метровый размах крыльев, который сведет ваших пленных с ума."
	icon_state = "griffin_wings"
	inhand_icon_state = "griffin_wings"

/obj/item/clothing/suit/cardborg
	name = "костюм кардборга"
	desc = "Обычная картонная коробка с прорезанными по бокам отверстиями."
	icon_state = "cardborg"
	inhand_icon_state = "cardborg"
	body_parts_covered = CHEST|GROIN
	flags_inv = HIDEJUMPSUIT
	dog_fashion = /datum/dog_fashion/back

/obj/item/clothing/suit/cardborg/equipped(mob/living/user, slot)
	..()
	if(slot == ITEM_SLOT_OCLOTHING)
		disguise(user)

/obj/item/clothing/suit/cardborg/dropped(mob/living/user)
	..()
	user.remove_alt_appearance("standard_borg_disguise")

/obj/item/clothing/suit/cardborg/proc/disguise(mob/living/carbon/human/H, obj/item/clothing/head/cardborg/borghead)
	if(istype(H))
		if(!borghead)
			borghead = H.head
		if(istype(borghead, /obj/item/clothing/head/cardborg)) //why is this done this way? because equipped() is called BEFORE THE ITEM IS IN THE SLOT WHYYYY
			var/image/I = image(icon = 'icons/mob/robots.dmi' , icon_state = "robot", loc = H)
			I.override = 1
			I.add_overlay(mutable_appearance('icons/mob/robots.dmi', "robot_e")) //gotta look realistic
			add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/silicons, "standard_borg_disguise", I) //you look like a robot to robots! (including yourself because you're totally a robot)


/obj/item/clothing/suit/snowman
	name = "наряд снеговика"
	desc = "Две белые сферы покрыты белым блеском. Это сезон."
	icon_state = "snowman"
	inhand_icon_state = "snowman"
	body_parts_covered = CHEST|GROIN
	flags_inv = HIDEJUMPSUIT

/obj/item/clothing/suit/poncho
	name = "пончо"
	desc = "Ваше классическое нерасистское пончо."
	icon_state = "classicponcho"
	inhand_icon_state = "classicponcho"

/obj/item/clothing/suit/poncho/green
	name = "зелёный пончо"
	desc = "Ваше классическое нерасистское пончо. Этот зеленый."
	icon_state = "greenponcho"
	inhand_icon_state = "greenponcho"

/obj/item/clothing/suit/poncho/red
	name = "красный пончо"
	desc = "Ваше классическое нерасистское пончо. Этот красный."
	icon_state = "redponcho"
	inhand_icon_state = "redponcho"

/obj/item/clothing/suit/poncho/ponchoshame
	name = "пончо стыда"
	desc = "Вы вынуждены жить на своем постыдном действии как поддельный мексиканец, вы и ваше пончо стали неразлучными. В прямом смысле."
	icon_state = "ponchoshame"
	inhand_icon_state = "ponchoshame"

/obj/item/clothing/suit/poncho/ponchoshame/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, SHAMEBRERO_TRAIT)

/obj/item/clothing/suit/whitedress
	name = "белое платье"
	desc = "Модное белое платье."
	icon_state = "white_dress"
	inhand_icon_state = "w_suit"
	body_parts_covered = CHEST|GROIN|LEGS|FEET
	flags_inv = HIDEJUMPSUIT|HIDESHOES

/obj/item/clothing/suit/hooded/carp_costume
	name = "костюм карпа"
	desc = "Это костюм из «синтетических» карповых чешуек, он пахнет."
	icon_state = "carp_casual"
	inhand_icon_state = "labcoat"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT	//Space carp like space, so you should too
	allowed = list(/obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/pneumatic_cannon/speargun)
	hoodtype = /obj/item/clothing/head/hooded/carp_hood

/obj/item/clothing/head/hooded/carp_hood
	name = "карповый капюшон"
	desc = "Капюшон прикреплен к карповому костюму."
	icon_state = "carp_casual"
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/clothing/head/hooded/carp_hood/equipped(mob/living/carbon/human/user, slot)
	..()
	if (slot == ITEM_SLOT_HEAD)
		user.faction |= "carp"

/obj/item/clothing/head/hooded/carp_hood/dropped(mob/living/carbon/human/user)
	..()
	if (user.head == src)
		user.faction -= "carp"

/obj/item/clothing/suit/hooded/ian_costume	//It's Ian, rub his bell- oh god what happened to his inside parts?
	name = "костюм корги"
	desc = "Костюм, который выглядит, как будто кто-то сделал похожий на человека корги, он не гарантирует трения живота."
	icon_state = "ian"
	inhand_icon_state = "labcoat"
	body_parts_covered = CHEST|GROIN|ARMS
	//cold_protection = CHEST|GROIN|ARMS
	//min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	allowed = list()
	hoodtype = /obj/item/clothing/head/hooded/ian_hood
	dog_fashion = /datum/dog_fashion/back

/obj/item/clothing/head/hooded/ian_hood
	name = "капюшон корги"
	desc = "Капюшон, похожий на голову корги, не гарантирует собачьего печенья."
	icon_state = "ian"
	body_parts_covered = HEAD
	//cold_protection = HEAD
	//min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/clothing/suit/hooded/bee_costume // It's Hip!
	name = "костюм пчелы"
	desc = "Пчела настоящая королева!"
	icon_state = "bee"
	inhand_icon_state = "labcoat"
	body_parts_covered = CHEST|GROIN|ARMS
	clothing_flags = THICKMATERIAL
	hoodtype = /obj/item/clothing/head/hooded/bee_hood

/obj/item/clothing/head/hooded/bee_hood
	name = "пчелиный капюшон"
	desc = "Капюшон, прикрепленный к костюму пчелы."
	icon_state = "bee"
	body_parts_covered = HEAD
	clothing_flags = THICKMATERIAL
	flags_inv = HIDEHAIR|HIDEEARS
	dynamic_hair_suffix = ""

/obj/item/clothing/suit/hooded/bloated_human	//OH MY GOD WHAT HAVE YOU DONE!?!?!?
	name = "раздутый человеческий костюм"
	desc = "Ужасно раздутый костюм из человеческой кожи."
	icon_state = "lingspacesuit"
	inhand_icon_state = "labcoat"
	body_parts_covered = CHEST|GROIN|ARMS
	allowed = list()
	actions_types = list(/datum/action/item_action/toggle_human_head)
	hoodtype = /obj/item/clothing/head/hooded/human_head


/obj/item/clothing/head/hooded/human_head
	name = "раздутая человеческая голова"
	desc = "Ужасно раздутая и несоответствующая человеческая голова."
	icon_state = "lingspacehelmet"
	body_parts_covered = HEAD
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/suit/security/officer/russian
	name = "Русская офицерская куртка"
	desc = "Эта куртка предназначена для тех особых случаев, когда русский офицер не обязан носить свои доспехи."
	icon_state = "officertanjacket"
	inhand_icon_state = "officertanjacket"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/shrine_maiden
	name = "наряд мико"
	desc = "Заставляет вас хотеть уничтожить некоторых проблемных ёкаев."
	icon_state = "shrine_maiden"
	inhand_icon_state = "shrine_maiden"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDEJUMPSUIT

/*
 * Misc
 */

/obj/item/clothing/suit/straight_jacket
	name = "смирительная рубашка"
	desc = "Костюм, который полностью сдерживает владельца. Изготовлено Antyphun Corp." //Straight jacket is antifun
	icon_state = "straight_jacket"
	inhand_icon_state = "straight_jacket"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	clothing_flags = DANGEROUS_OBJECT
	equip_delay_self = 50
	strip_delay = 60
	breakouttime = 3000

/obj/item/clothing/suit/ianshirt
	name = "изношенная рубашка"
	desc = "Изношенная, любопытно удобная футболка с изображением Яна. Вы бы не зашли так далеко, чтобы сказать, что вы чувствуете, что вас обнимают, когда вы его носите, но это довольно близко. Хорошо для сна."
	icon_state = "ianshirt"
	inhand_icon_state = "ianshirt"

/obj/item/clothing/suit/nerdshirt
	name = "рубашка геймера"
	desc = "Мешковатая рубашка со старинным игровым персонажем Phanic the Weasel. Зачем кому-то носить это?"
	icon_state = "nerdshirt"
	inhand_icon_state = "nerdshirt"

/obj/item/clothing/suit/vapeshirt //wearing this is asking to get beat.
	name = "рубашка вейпа нейшена"
	desc = "Дешевая белая футболка с большой липкой \"VN\" спереди, с какой стати вы носите это?"
	icon_state = "vapeshirt"
	inhand_icon_state = "vapeshirt"

/obj/item/clothing/suit/striped_sweater
	name = "полосатый свитер"
	desc = "Напоминает вам кого-то, но вы просто не можете положить на это палец ..."
	icon_state = "waldo_shirt"
	inhand_icon_state = "waldo_shirt"

/obj/item/clothing/suit/jacket
	name = "куртка бомбер"
	desc = "Авиаторы не включены."
	icon_state = "bomberjacket"
	inhand_icon_state = "brownjsuit"
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/radio)
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/suit/jacket/leather
	name = "кожаный пиджак"
	desc = "Помпадур не включен."
	icon_state = "leatherjacket"
	inhand_icon_state = "hostrench"
	resistance_flags = NONE
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/gun/ballistic/automatic/pistol, /obj/item/gun/ballistic/revolver, /obj/item/gun/ballistic/revolver/detective, /obj/item/radio)

/obj/item/clothing/suit/jacket/leather/overcoat
	name = "кожаное пальто"
	desc = "Это чертовски тонкая шерсть."
	icon_state = "leathercoat"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	cold_protection = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/suit/jacket/puffer
	name = "пуховик"
	desc = "Толстая куртка с резиновой, водостойкой оболочкой."
	icon_state = "pufferjacket"
	inhand_icon_state = "hostrench"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/jacket/puffer/vest
	name = "жилет"
	desc = "Толстый жилет с резиновой, водостойкой оболочкой."
	icon_state = "puffervest"
	inhand_icon_state = "armor"
	body_parts_covered = CHEST|GROIN
	cold_protection = CHEST|GROIN
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 30, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/jacket/miljacket
	name = "военная куртка"
	desc = "Холщовая куртка в стиле классической американской военной одежды. Чувствует себя крепким, но комфортно."
	icon_state = "militaryjacket"
	inhand_icon_state = "militaryjacket"
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/gun/ballistic/automatic/pistol, /obj/item/gun/ballistic/revolver, /obj/item/radio)

/obj/item/clothing/suit/jacket/letterman
	name = "куртка леттермана"
	desc = "Классическая коричневая куртка-леттерман. Выглядит довольно жарко и тяжело."
	icon_state = "letterman"
	inhand_icon_state = "letterman"

/obj/item/clothing/suit/jacket/letterman_red
	name = "красная куртка леттермана"
	desc = "Куртка леттермана в больном красном цвете. Радикально."
	icon_state = "letterman_red"
	inhand_icon_state = "letterman_red"

/obj/item/clothing/suit/jacket/letterman_syndie
	name = "кроваво-красная куртка леттермана"
	desc = "Как ни странно, эта куртка, кажется, имеет большой S на спине..."
	icon_state = "letterman_s"
	inhand_icon_state = "letterman_s"

/obj/item/clothing/suit/jacket/letterman_nanotrasen
	name = "синяя куртка леттермана"
	desc = "Синяя куртка-леттерман с гордым Нанотрейзен N на спине. Тег говорит, что это было сделано в Космическом Китае."
	icon_state = "letterman_n"
	inhand_icon_state = "letterman_n"

/obj/item/clothing/suit/dracula
	name = "пальто дракулы"
	desc = "Похоже, это относится к очень старому фильму."
	icon_state = "draculacoat"
	inhand_icon_state = "draculacoat"

/obj/item/clothing/suit/drfreeze_coat
	name = "лабораторный халат доктора Фриз"
	desc = "Лабораторный халат, наполненный силой функции заморозки."
	icon_state = "drfreeze_coat"
	inhand_icon_state = "drfreeze_coat"

/obj/item/clothing/suit/gothcoat
	name = "готическое пальто"
	desc = "Идеально подходит для тех, кто хочет прогуляться за углом бара."
	icon_state = "gothcoat"
	inhand_icon_state = "gothcoat"

/obj/item/clothing/suit/xenos
	name = "костюм ксеноса"
	desc = "Костюм из хитиновой шкуры пришельцев."
	icon_state = "xenos"
	inhand_icon_state = "xenos_helm"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	allowed = list(/obj/item/clothing/mask/facehugger/toy)

/obj/item/clothing/suit/nemes
	name = "туника фараона"
	desc = "Щедрая космическая гробница в комплект не входит."
	icon_state = "pharoah"
	inhand_icon_state = "pharoah"
	body_parts_covered = CHEST|GROIN

/obj/item/clothing/suit/caution
	name = "знак мокрого пола"
	desc = "Внимание! Мокрый пол!"
	icon_state = "caution"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	force = 1
	throwforce = 3
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN
	attack_verb = list("предупреждает", "предостерегает", "размазывает")
	armor = list("melee" = 5, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/changshan_red
	name = "red changshan"
	desc = "A gorgeously embroidered silk shirt."
	icon_state = "changshan_red"
	inhand_icon_state = "changshan_red"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/suit/changshan_blue
	name = "blue changshan"
	desc = "A gorgeously embroidered silk shirt."
	icon_state = "changshan_blue"
	inhand_icon_state = "changshan_blue"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/suit/cheongsam_red
	name = "red cheongsam"
	desc = "A gorgeously embroidered silk dress."
	icon_state = "cheongsam_red"
	inhand_icon_state = "cheongsam_red"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/suit/cheongsam_blue
	name = "blue cheongsam"
	desc = "A gorgeously embroidered silk dress."
	icon_state = "cheongsam_blue"
	inhand_icon_state = "cheongsam_blue"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS

// WINTER COATS

/obj/item/clothing/suit/hooded/wintercoat
	name = "зимнее пальто"
	desc = "Тяжелая куртка из «синтетического» меха животных."
	icon_state = "coatwinter"
	inhand_icon_state = "coatwinter"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter)

/obj/item/clothing/head/hooded/winterhood
	name = "зимний капюшон"
	desc = "Капюшон прикреплен к тяжелой зимней куртке."
	icon_state = "winterhood"
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEEARS
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/hooded/wintercoat/captain
	name = "зимнее пальто капитана"
	icon_state = "coatcaptain"
	inhand_icon_state = "coatcaptain"
	armor = list("melee" = 25, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 50)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/captain

/obj/item/clothing/suit/hooded/wintercoat/captain/Initialize()
	. = ..()
	allowed = GLOB.security_wintercoat_allowed

/obj/item/clothing/head/hooded/winterhood/captain
	icon_state = "winterhood_captain"
	armor = list("melee" = 25, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 50)

/obj/item/clothing/suit/hooded/wintercoat/security
	name = "защитное зимнее пальто"
	icon_state = "coatsecurity"
	inhand_icon_state = "coatsecurity"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 45)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/security

/obj/item/clothing/suit/hooded/wintercoat/security/Initialize()
	. = ..()
	allowed = GLOB.security_wintercoat_allowed

/obj/item/clothing/head/hooded/winterhood/security
	icon_state = "winterhood_security"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 45)

/obj/item/clothing/suit/hooded/wintercoat/medical
	name = "медицинское зимнее пальто"
	icon_state = "coatmedical"
	inhand_icon_state = "coatmedical"
	allowed = list(/obj/item/analyzer, /obj/item/sensor_device, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight/pen, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/classic_baton/telescopic, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 0, "acid" = 45)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/medical

/obj/item/clothing/head/hooded/winterhood/medical
	icon_state = "winterhood_medical"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 0, "acid" = 45)

/obj/item/clothing/suit/hooded/wintercoat/science
	name = "научное зимнее пальто"
	icon_state = "coatscience"
	inhand_icon_state = "coatscience"
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight/pen, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/classic_baton/telescopic, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/science

/obj/item/clothing/head/hooded/winterhood/science
	icon_state = "winterhood_science"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/hooded/wintercoat/engineering
	name = "инженерное зимнее пальто"
	icon_state = "coatengineer"
	inhand_icon_state = "coatengineer"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 20, "fire" = 30, "acid" = 45)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/t_scanner, /obj/item/construction/rcd, /obj/item/pipe_dispenser, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/engineering

/obj/item/clothing/head/hooded/winterhood/engineering
	icon_state = "winterhood_engineer"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 20, "fire" = 30, "acid" = 45)

/obj/item/clothing/suit/hooded/wintercoat/engineering/atmos
	name = "атмосферное зимнее пальто"
	icon_state = "coatatmos"
	inhand_icon_state = "coatatmos"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/engineering/atmos

/obj/item/clothing/head/hooded/winterhood/engineering/atmos
	icon_state = "winterhood_atmos"

/obj/item/clothing/suit/hooded/wintercoat/hydro
	name = "гидропоническое зимнее пальто"
	icon_state = "coathydro"
	inhand_icon_state = "coathydro"
	allowed = list(/obj/item/reagent_containers/spray/plantbgone, /obj/item/plant_analyzer, /obj/item/seeds, /obj/item/reagent_containers/glass/bottle, /obj/item/cultivator, /obj/item/reagent_containers/spray/pestspray, /obj/item/hatchet, /obj/item/storage/bag/plants, /obj/item/toy, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/storage/fancy/cigarettes, /obj/item/lighter)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/hydro

/obj/item/clothing/head/hooded/winterhood/hydro
	icon_state = "winterhood_hydro"

/obj/item/clothing/suit/hooded/wintercoat/cargo
	name = "грузовое зимнее пальто"
	icon_state = "coatcargo"
	inhand_icon_state = "coatcargo"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/cargo

/obj/item/clothing/head/hooded/winterhood/cargo
	icon_state = "winterhood_cargo"

/obj/item/clothing/suit/hooded/wintercoat/miner
	name = "шахтёрское зимнее пальто"
	icon_state = "coatminer"
	inhand_icon_state = "coatminer"
	allowed = list(/obj/item/pickaxe, /obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter)
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/miner

/obj/item/clothing/head/hooded/winterhood/miner
	icon_state = "winterhood_miner"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/head/hooded/ablative
	name = "аблативный капюшон"
	desc = "Надеюсь, что капюшон принадлежит аблятивному плащу. Включает в себя козырек для прохладного зрения."
	icon_state = "ablativehood"
	armor = list("melee" = 10, "bullet" = 10, "laser" = 60, "energy" = 60, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100)
	strip_delay = 30
	var/hit_reflect_chance = 50

/obj/item/clothing/head/hooded/ablative/equipped(mob/living/carbon/human/user, slot)
	..()
	to_chat(user, "Когда вы надеваете капюшон, козырек сдвигается на место и начинает анализировать людей вокруг вас. Ухоженная!")
	ADD_TRAIT(user, TRAIT_SECURITY_HUD, HELMET_TRAIT)
	var/datum/atom_hud/H = GLOB.huds[DATA_HUD_SECURITY_ADVANCED]
	H.add_hud_to(user)

/obj/item/clothing/head/hooded/ablative/dropped(mob/living/carbon/human/user)
	..()
	to_chat(user, "Вы снимаете капот, снимая козырек в процессе и отключая его встроенный кожух.")
	REMOVE_TRAIT(user, TRAIT_SECURITY_HUD, HELMET_TRAIT)
	var/datum/atom_hud/H = GLOB.huds[DATA_HUD_SECURITY_ADVANCED]
	H.remove_hud_from(user)

/obj/item/clothing/head/hooded/ablative/IsReflect(def_zone)
	if(def_zone != BODY_ZONE_HEAD) //If not shot where ablative is covering you, you don't get the reflection bonus!
		return FALSE
	if (prob(hit_reflect_chance))
		return TRUE

/obj/item/clothing/suit/hooded/ablative
	name = "аблятивный плащ"
	desc = "Экспериментальный плащ, специально созданный для отражения и поглощения лазерных и дезактивирующих ударов. Однако не ожидайте, что он так много сделает против топора или дробовика."
	icon_state = "ablativecoat"
	inhand_icon_state = "ablativecoat"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	armor = list("melee" = 10, "bullet" = 10, "laser" = 60, "energy" = 60, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100)
	hoodtype = /obj/item/clothing/head/hooded/ablative
	strip_delay = 30
	equip_delay_other = 40
	var/hit_reflect_chance = 50

/obj/item/clothing/suit/hooded/ablative/Initialize()
	. = ..()
	allowed = GLOB.security_vest_allowed

/obj/item/clothing/suit/hooded/ablative/IsReflect(def_zone)
	if(!(def_zone in list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))) //If not shot where ablative is covering you, you don't get the reflection bonus!
		return FALSE
	if (prob(hit_reflect_chance))
		return TRUE

/obj/item/clothing/suit/spookyghost
	name = "жуткий призрак"
	desc = "Это, очевидно, просто простыня, но, может быть, примерить?"
	icon_state = "bedsheet"
	user_vars_to_edit = list("name" = "Жуткий призрак", "real_name" = "Жуткий призрак" , "incorporeal_move" = INCORPOREAL_MOVE_BASIC, "appearance_flags" = KEEP_TOGETHER|TILE_BOUND, "alpha" = 150)
	alternate_worn_layer = ABOVE_BODY_FRONT_LAYER //so the bedsheet goes over everything but fire

/obj/item/clothing/suit/bronze
	name = "бронзовый костюм"
	desc = "Большой строгий костюм из бронзы, который не защищает и выглядит очень не модно. Отлично."
	icon = 'icons/obj/clothing/clockwork_garb.dmi'
	icon_state = "clockwork_cuirass_old"
	armor = list("melee" = 5, "bullet" = 0, "laser" = -5, "energy" = -15, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 20)

/obj/item/clothing/suit/ghost_sheet
	name = "призрачный лист"
	desc = "Руки плавают сами по себе, поэтому они очень жуткие."
	icon_state = "ghost_sheet"
	inhand_icon_state = "ghost_sheet"
	throwforce = 0
	throw_speed = 1
	throw_range = 2
	w_class = WEIGHT_CLASS_TINY
	flags_inv = HIDEGLOVES|HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	alternate_worn_layer = UNDER_HEAD_LAYER

/obj/item/clothing/suit/toggle/suspenders/blue
	name = "синие подтяжки"
	desc = "Символ тяжелого труда и грязных работ."
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "suspenders_blue"

/obj/item/clothing/suit/toggle/suspenders/gray
	name = "серые подтяжки"
	desc = "Символ тяжелого труда и грязных работ."
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "suspenders_gray"

/obj/item/clothing/suit/hooded/mysticrobe
	name = "мантия"
	desc = "Ношение этого заставляет вас чувствовать себя более сонастроенным с природой вселенной... а также немного более безответственным."
	icon_state = "mysticrobe"
	inhand_icon_state = "mysticrobe"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	allowed = list(/obj/item/spellbook, /obj/item/storage/book/bible)
	flags_inv = HIDEJUMPSUIT
	hoodtype = /obj/item/clothing/head/hooded/mysticrobe

/obj/item/clothing/head/hooded/mysticrobe
	name = "капюшон мистика"
	desc = "Баланс реальности подсказывает порядок."
	icon_state = "mystichood"
	inhand_icon_state = "mystichood"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEEARS|HIDEFACIALHAIR|HIDEFACE|HIDEMASK

/obj/item/clothing/suit/coordinator
	name = "coordinator jacket"
	desc = "A jacket for a party ooordinator, stylish!."
	icon_state = "capformal"
	inhand_icon_state = "capspacesuit"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 25, "energy" = 35, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/suit/hawaiian
	name = "hawaiian overshirt"
	desc = "A cool shirt for chilling on the beach."
	icon_state = "hawaiian_blue"
	inhand_icon_state = "hawaiian_blue"

/obj/item/clothing/suit/yakuza
	name = "tojo clan jacket"
	desc = "The jacket of a mad dog."
	icon_state = "MajimaJacket"
	inhand_icon_state = "MajimaJacket"
	body_parts_covered = ARMS

/obj/item/clothing/suit/dutch
	name = "dutch's jacket"
	desc = "For those long nights on the beach in Tahiti."
	icon_state = "DutchJacket"
	inhand_icon_state = "DutchJacket"
	body_parts_covered = ARMS

