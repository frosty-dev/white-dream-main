/datum/blackmarket_item/clothing
	markets = list(/datum/blackmarket_market/blackmarket)
	category = "Одежда"

/datum/blackmarket_item/clothing/ninja_mask
	name = "Маска космического ниндзи"
	desc = "Маска сделанная со стилем"
	item = /obj/item/clothing/mask/gas/space_ninja

	price_min = 200
	price_max = 5000
	stock_max = 1
	availability_prob = 40

/datum/blackmarket_item/clothing/durathread_vest
	name = "Дюрасталевый бронежилет"
	desc = "Don't let them tell you this stuff is \"Like asbestos\" or \"Pulled from the market for safety concerns\". It could be the difference between a robusting and a retaliation."
	item = /obj/item/clothing/suit/armor/vest/durathread

	price_min = 200
	price_max = 400
	stock_max = 4
	availability_prob = 50

/datum/blackmarket_item/clothing/durathread_helmet
	name = "Дюратсалевый шлем"
	desc = "Customers ask why it's called a helmet when it's just made from armoured fabric and I always say the same thing: No refunds."
	item = /obj/item/clothing/head/helmet/durathread

	price_min = 100
	price_max = 200
	stock_max = 4
	availability_prob = 50

/datum/blackmarket_item/clothing/full_spacesuit_set
	name = "Устаревший космический костюм НТ"
	desc = "Космический костюм НТ устаревшего вида"
	item = /obj/item/storage/box

	price_min = 10000
	price_max = 25000
	stock_max = 1
	availability_prob = 100

/datum/blackmarket_item/clothing/full_spacesuit_set/spawn_item(loc)
	var/obj/item/storage/box/B = ..()
	B.name = "Коробка с космическим костюмом"
	B.desc = "На коробке надпись НТ"
	new /obj/item/clothing/suit/space(B)
	new /obj/item/clothing/head/helmet/space(B)
	return B

/datum/blackmarket_item/clothing/wzzzz/null
	name = "Скафандр"
	desc = "Улучшенная версия обыного скафандра"
	item = /obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/null

	price_min = 10000
	price_max = 50000
	stock_min = 1
	stock_max = 5
	availability_prob = 100

/datum/blackmarket_item/clothing/wzzzz/void_explorer
	name = "Скафандр исследователя космоса"
	desc = "Улучшенная версия обыного скафандра"
	item = /obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/void_explorer

	price_min = 15000
	price_max = 60000
	stock_max = 2
	availability_prob = 100

/datum/blackmarket_item/clothing/combatmedic_suit
	name = "Скафандр Боевого медика"
	desc = "Этот скафандр был найден в уничтоженном гнезде ксеноморфов. Судьба носителя неизвестна, но этот скафандр до сих пор соответсвует стандартам боевых скафандров"
	item = /obj/item/clothing/suit/space/hardsuit/combatmedic

	price_min = 5500
	price_max = 7000
	stock_max = 1
	availability_prob = 70

/datum/blackmarket_item/clothing/wzzzz/security_rig
	name = "Боевой скафандр СБ"
	desc = "Обновлённая модель скафандра СБ"
	item = /obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/security_rig

	price_min = 100000
	price_max = 500000
	stock_max = 1
	availability_prob = 100

/datum/blackmarket_item/clothing/chameleon_hat
	name = "Шляпа-Хамелеон"
	desc = "Очень модная шляпа"
	item = /obj/item/clothing/head/chameleon/broken

	price_min = 100
	price_max = 2000
	stock_min = 1
	stock_max = 10
	availability_prob = 70


/datum/blackmarket_item/clothing/petehat
	name = "Коллекционная шляпа Пита"
	desc = "Пахнет плазмой!"
	item = /obj/item/clothing/head/collectable/petehat

	price_min = 100
	price_max = 500
	stock_max = 5
	availability_prob = 30

/datum/blackmarket_item/clothing/xeno
	name = "Маска Ксеноморфа"
	desc = "Hiss hiss hiss!"
	item = /obj/item/clothing/head/collectable/xenom

	price_min = 100
	price_max = 500
	stock_max = 5
	availability_prob = 30

/datum/blackmarket_item/clothing/tophat
	name = "Коллекционный Цилиндр"
	desc = "A"
	item = /obj/item/clothing/head/collectable/tophat

	price_min = 100
	price_max = 500
	stock_max = 5
	availability_prob = 30

/datum/blackmarket_item/clothing/kitty
	name = "Кошачьи ушки"
	desc = "ERP shit"
	item = /obj/item/clothing/head/kitty

	price_min = 1000
	price_max = 10000
	stock_min = 1
	stock_max = 10
	availability_prob = 30

/datum/blackmarket_item/clothing/ushanka
	name = "Ушанка"
	desc = "Идеально подходит для зимы в Сибири, да?"
	item = /obj/item/clothing/head/ushanka

	price_min = 100
	price_max = 500
	stock_max = 5
	availability_prob = 30

/datum/blackmarket_item/clothing/beret
	name = "Берет"
	desc = "Маска мима"
	item = /obj/item/clothing/head/beret

	price_min = 100
	price_max = 500
	stock_max = 5
	availability_prob = 30

/datum/blackmarket_item/clothing/witchwig
	name = "Ведьмин парик"
	desc = "Eeeee~heheheheheheh!"
	item = /obj/item/clothing/head/witchwig

	price_min = 100
	price_max = 500
	stock_max =  5
	availability_prob = 30

/datum/blackmarket_item/clothing/cakehat
	name = "Шляпа-торт"
	desc = "Make a cake!"
	item = /obj/item/clothing/head/hardhat/cakehat

	price_min = 100
	price_max = 500
	stock_max = 5
	availability_prob = 30

/datum/blackmarket_item/clothing/wizard/fake
	name = "Шляпа Мага"
	desc = "Wizard! Call the shuttle!"
	item = /obj/item/clothing/head/wizard/fake

	price_min = 100
	price_max = 500
	stock_max = 5
	availability_prob = 30

/datum/blackmarket_item/clothing/flatcap
	name = "кепка"
	desc = "Обычная кепка"
	item = /obj/item/clothing/head/flatcap

	price_min = 100
	price_max = 500
	stock_max = 5
	availability_prob = 30

/datum/blackmarket_item/clothing/rabbitears
	name = "Заячьи ушки"
	desc = "Бесполезный кролик"
	item = /obj/item/clothing/head/collectable/rabbitears

	price_min = 1000
	price_max = 5000
	stock_max = 1
	availability_prob = 30

/datum/blackmarket_item/clothing/cardborg
	name = "Картонная шляпа"
	desc = "Шляпа сделанная из картона"
	item = /obj/item/clothing/head/cardborg

	price_min = 100
	price_max = 500
	stock_max = 5
	availability_prob = 30

/datum/blackmarket_item/clothing/bearpelt
	name = "Медвежья накидка"
	desc = "Не спрашивайте где мы её получили"
	item = /obj/item/clothing/head/bearpelt

	price_min = 1000
	price_max = 5000
	stock_max = 1
	availability_prob = 30

/datum/blackmarket_item/clothing/scarecrow_hat
	name = "Шляпа чучела"
	desc = "Простая соломенная шляпа"
	item = /obj/item/clothing/head/scarecrow_hat

	price_min = 100
	price_max = 500
	stock_max = 5
	availability_prob = 30

/datum/blackmarket_item/clothing/fakemoustache
	name = "Усы"
	desc = "Самые лучшие усы в космосе!"
	item = /obj/item/clothing/mask/fakemoustache

	price_min = 100
	price_max = 500
	stock_max = 5
	availability_prob = 30

/datum/blackmarket_item/clothing/pigmask
	name = "Маска свиньи"
	desc = "REEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
	item = /obj/item/clothing/mask/pig

	price_min = 100
	price_max = 500
	stock_max = 5
	availability_prob = 30

/datum/blackmarket_item/clothing/cowmask
	name = "Маска коровы"
	desc = "Moo"
	item = /obj/item/clothing/mask/cowmask

	price_min = 100
	price_max = 500
	stock_max = 5
	availability_prob = 30

/datum/blackmarket_item/clothing/horsehead
	name = "Голова лошади"
	desc = "Neith"
	item = /obj/item/clothing/mask/horsehead

	price_min = 100
	price_max = 500
	stock_max = 5
	availability_prob = 30

/datum/blackmarket_item/clothing/carpmask
	name = "Маска карпа"
	desc = "Стань злейшим врагом для станции!"
	item = /obj/item/clothing/mask/gas/carp

	price_min = 100
	price_max = 500
	stock_max = 5
	availability_prob = 30

/datum/blackmarket_item/clothing/plaguedoctor
	name = "Маска чумного доктора"
	desc = "Coronavirus speedrun ANY%"
	item = /obj/item/clothing/mask/gas/plaguedoctor

	price_min = 1000
	price_max = 5000
	stock_max = 5
	availability_prob = 20

/datum/blackmarket_item/clothing/monkeymask
	name = "Маска обезьяны"
	desc = "Become a bartender’s hand-made monkey or the goal of experiments of doctors and scientists  "
	item = /obj/item/clothing/mask/gas/monkeymask

	price_min = 100
	price_max = 500
	stock_max = 5
	availability_prob = 50

/datum/blackmarket_item/clothing/owl_mask
	name = "Маска совы"
	desc = "Мы не знаем как написать звуки которые издаёт сова поэтому воспроизводите сами"
	item = /obj/item/clothing/mask/gas/owl_mask

	price_min = 100
	price_max = 500
	stock_max = 5
	availability_prob = 50

/datum/blackmarket_item/clothing/neck/cloak
	name = "Накидка"
	desc = "Очень похожа на накидку КМа"
	item = /obj/item/clothing/neck/cloak

	price_min = 100
	price_max = 1000
	stock_max = 5
	availability_prob = 50

/datum/blackmarket_item/clothing/shoes/cyborg
	name = "Обувь киборга"
	desc = "Hello World!"
	item = /obj/item/clothing/shoes/cyborg

	price_min = 100
	price_max = 1000
	stock_max = 5
	availability_prob = 50

/datum/blackmarket_item/clothing/jackboots
	name = "Военный ботинки"
	desc = "jackass"
	item = /obj/item/clothing/shoes/jackboots

	price_min = 100
	price_max = 1000
	stock_max = 5
	availability_prob = 50

/datum/blackmarket_item/clothing/piratesuit
	name = "Костюм пирата"
	desc = "YARR!"
	item = /obj/item/clothing/suit/pirate

	price_min = 100
	price_max = 1000
	stock_max = 5
	availability_prob = 30

/datum/blackmarket_item/clothing/vice_officer
	name = "Костюм старшего офицера"
	desc = "Это костюм старшего офицера станции Вхите Дрим"
	item = /obj/item/clothing/under/misc/vice_officer

	price_min = 500
	price_max = 1500
	stock_max = 1
	availability_prob = 30

/datum/blackmarket_item/clothing/
	name = "Костюм представителя ЦК"
	desc = "Для фейковых инспекций"
	item = /obj/item/clothing/under/rank/centcom/officer

	price_min = 1000
	price_max = 5000
	stock_max = 1
	availability_prob = 20

/datum/blackmarket_item/clothing/rainbow
	name = "Радужный костюм"
	desc = "Описание отсутсвует"
	item = /obj/item/clothing/under/color/rainbow

	price_min = 100
	price_max = 1000
	stock_max = 5
	availability_prob = 30

/datum/blackmarket_item/clothing/tacticool
	name = "Тактическая униформа"
	desc = "Просто взглянув на это, хочется купить SKS, пойти в лес и -оперативничать-"
	item = /obj/item/clothing/under/syndicate/tacticool

	price_min = 100
	price_max = 500
	stock_max = 5
	availability_prob = 30

/datum/blackmarket_item/clothing/tacticool/skirt
	name = "Тактическая юбка"
	desc = "Просто взглянув на это, хочется купить SKS, пойти в лес и -оперативничать-"
	item = /obj/item/clothing/under/syndicate/tacticool/skirt

	price_min = 100
	price_max = 500
	stock_max = 5
	availability_prob = 30

/datum/blackmarket_item/clothing/psyche
	name = "Психоделический костюм"
	desc = "Описание отсутствует"
	item = /obj/item/clothing/under/misc/psyche

	price_min = 1000
	price_max = 5000
	stock_max = 1
	availability_prob = 10

/datum/blackmarket_item/clothing/bedsheet/rainbow
	name = "Радужная накидка"
	desc = "Накидка сделанная под тематику радуги"
	item = /obj/item/bedsheet/rainbow

	price_min = 1000
	price_max = 5000
	stock_max = 1
	availability_prob = 30

/datum/blackmarket_item/clothing/bedsheet/captain
	name = "Кокпетанский плащ"
	desc = "На этом плаще есть бирка на которой написано SPACEWATER"
	item = /obj/item/bedsheet/captain

	price_min = 1000
	price_max = 5000
	stock_max = 1
	availability_prob = 20

/datum/blackmarket_item/clothing/bedsheet/cosmos
	name = "Космическая накидка"
	desc = "накидка сделанная под тематику космоса. Анимировано"
	item = /obj/item/bedsheet/cosmos

	price_min = 100
	price_max = 500
	stock_max = 1
	availability_prob = 20
