/obj/structure/flora/rospilovo
	name = "растительность"
	icon = 'white/valtos/icons/rospilovo/flora.dmi'

/obj/structure/flora/rospilovo/bush
	icon_state = "very_tall_grass_8"
	layer = 4.01
	anchored = 1
	opacity = 1

/obj/structure/flora/rospilovo/bush/Initialize()
	..()
	icon_state = "very_tall_grass_[rand(5,8)]"

/turf/open/floor/grass/rospilovo
	name = "травяной покров"
	desc = "Эх, а раньше она была зеленее..."
	icon = 'white/valtos/icons/rospilovo/grass.dmi'
	icon_state = "grass1"
	color = "#ffffaa"
	broken_states = list("sand1", "sand2", "sand3", "sand4")

/turf/open/floor/grass/rospilovo/Initialize()
	. = ..()
	icon_state = "grass[rand(1, 5)]"
	if (prob(70))
		var/obj/structure/flora/ausbushes/rospilovo/F = pick(subtypesof(/obj/structure/flora/ausbushes/rospilovo))
		new F(get_turf(src))
		if (prob(70))
			var/obj/structure/flora/ausbushes/rospilovo/D = pick(subtypesof(/obj/structure/flora/ausbushes/rospilovo))
			new D(get_turf(src))

/turf/open/floor/rospilovo
	name = "асфальт"
	desc = "Не мягкий."
	icon = 'white/valtos/icons/rospilovo/floor.dmi'
	icon_state = "beton"

/turf/open/floor/rospilovo/cyber
	name = "киберпол"
	desc = "БЛЯТЬ!"
	icon = 'white/valtos/icons/rospilovo/cybershit.dmi'
	icon_state = "bfloor-1"

/turf/open/floor/rospilovo/wood
	name = "деревянный пол"
	desc = "Скрипучий пиздец."
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	icon_state = "wood1"

/turf/open/floor/rospilovo/wood/Initialize()
	. = ..()
	icon_state = "wood[rand(1, 6)]"

/turf/open/floor/rospilovo/plitka
	name = "плитка"
	desc = "Очень грязная."
	icon_state = "plitka1"

/turf/open/floor/rospilovo/plitka/Initialize()
	. = ..()
	icon_state = "plitka[rand(1, 7)]"

/turf/open/floor/rospilovo/plitka/full
	icon_state = "plita1"

/turf/open/floor/rospilovo/plitka/full/Initialize()
	. = ..()
	icon_state = "plita[rand(1, 4)]"

/turf/open/floor/rospilovo/plitka/old
	icon_state = "plitka_old1"

/turf/open/floor/rospilovo/plitka/old/Initialize()
	. = ..()
	icon_state = "plitka_old[rand(1, 8)]"


/turf/closed/wall/rospilovo
	hardness = 40000
	slicing_duration = 100000
	explosion_block = 100
	canSmoothWith = list(
	/turf/closed/wall/rospilovo/beton,
	/turf/closed/wall/rospilovo/bricks,
	/turf/closed/wall/rospilovo/bricks_yellow,
	/turf/closed/wall/rospilovo/bricks_white,
	/turf/closed/wall/rospilovo/beton_agro
	)
	smooth = SMOOTH_TRUE

/turf/closed/wall/rospilovo/cyberwall
	name = "стена"
	desc = "Здоровенная, пиздец."
	icon = 'white/valtos/icons/rospilovo/cyberwall.dmi'
	icon_state = "cyberwall"
	canSmoothWith = list(
	/turf/closed/wall/rospilovo/cyberwall
	)

/turf/closed/wall/rospilovo/cyberwall/not
	icon = 'white/valtos/icons/rospilovo/notacyberwall.dmi'
	icon_state = "notacyberwall"
	canSmoothWith = list(
	/turf/closed/wall/rospilovo/cyberwall/not
	)

/turf/closed/wall/rospilovo/beton
	name = "стена"
	desc = "Здоровенная, пиздец."
	icon = 'white/valtos/icons/rospilovo/beton_tg.dmi'
	icon_state = "beton"
	canSmoothWith = list(
	/turf/closed/wall/rospilovo/beton,
	/turf/closed/wall/rospilovo/beton_agro
	)

/turf/closed/wall/rospilovo/bricks
	name = "стена"
	desc = "Здоровенная, пиздец."
	icon = 'white/valtos/icons/rospilovo/bricks_tg.dmi'
	icon_state = "bricks"
	canSmoothWith = list(
	/turf/closed/wall/rospilovo/bricks
	)

/turf/closed/wall/rospilovo/bricks_yellow
	name = "стена"
	desc = "Здоровенная, пиздец."
	icon = 'white/valtos/icons/rospilovo/bricks_tg_yellow.dmi'
	icon_state = "bricks"
	canSmoothWith = list(
	/turf/closed/wall/rospilovo/bricks_yellow
	)

/turf/closed/wall/rospilovo/bricks_white
	name = "стена"
	desc = "Здоровенная, пиздец."
	icon = 'white/valtos/icons/rospilovo/bricks_tg_white.dmi'
	icon_state = "bricks"
	canSmoothWith = list(
	/turf/closed/wall/rospilovo/bricks_white
	)

/turf/closed/wall/rospilovo/beton_agro
	name = "стена"
	desc = "Здоровенная, пиздец."
	icon = 'white/valtos/icons/rospilovo/beton_w_tg.dmi'
	icon_state = "beton"
	canSmoothWith = list(
	/turf/closed/wall/rospilovo/beton_agro
	)

/obj/structure/chair/brevno
	name = "бревно"
	desc = "Обычное бревно, на котором можно сидеть."
	icon = 'white/valtos/icons/rospilovo/decor.dmi'
	icon_state = "log1"

/obj/structure/chair/brevno/log2
	icon_state = "log2"

/obj/structure/flora/ausbushes/rospilovo
	name = "трава"
	desc = "Пахнет травой, охуеть."
	icon = 'white/valtos/icons/rospilovo/ausflora.dmi'
	icon_state = "firstbush_1"
	alpha = 225

/obj/structure/flora/ausbushes/rospilovo/Initialize()
	if(icon_state == "firstbush_1")
		icon_state = "firstbush_[rand(1, 4)]"
	if(prob(50))
		color = "#ffffaa"
	else if (prob(50))
		color = "#dddd99"
	pixel_x = rand(-12,12)
	pixel_y = rand(-12,12)
	. = ..()

/obj/structure/flora/ausbushes/rospilovo/reedbush
	icon_state = "reedbush_1"

/obj/structure/flora/ausbushes/rospilovo/reedbush/Initialize()
	icon_state = "reedbush_[rand(1, 4)]"
	. = ..()

/obj/structure/flora/ausbushes/rospilovo/leafybush
	icon_state = "leafybush_1"

/obj/structure/flora/ausbushes/rospilovo/leafybush/Initialize()
	icon_state = "leafybush_[rand(1, 3)]"
	. = ..()

/obj/structure/flora/ausbushes/rospilovo/palebush
	icon_state = "palebush_1"

/obj/structure/flora/ausbushes/rospilovo/palebush/Initialize()
	icon_state = "palebush_[rand(1, 4)]"
	. = ..()

/obj/structure/flora/ausbushes/rospilovo/stalkybush
	icon_state = "stalkybush_1"

/obj/structure/flora/ausbushes/rospilovo/stalkybush/Initialize()
	icon_state = "stalkybush_[rand(1, 3)]"
	. = ..()

/obj/structure/flora/ausbushes/rospilovo/grassybush
	icon_state = "grassybush_1"

/obj/structure/flora/ausbushes/rospilovo/grassybush/Initialize()
	icon_state = "grassybush_[rand(1, 4)]"
	. = ..()

/obj/structure/flora/ausbushes/rospilovo/fernybush
	icon_state = "fernybush_1"

/obj/structure/flora/ausbushes/rospilovo/fernybush/Initialize()
	icon_state = "fernybush_[rand(1, 3)]"
	. = ..()

/obj/structure/flora/ausbushes/rospilovo/sunnybush
	icon_state = "sunnybush_1"

/obj/structure/flora/ausbushes/rospilovo/sunnybush/Initialize()
	icon_state = "sunnybush_[rand(1, 3)]"
	. = ..()

/obj/structure/flora/ausbushes/rospilovo/genericbush
	icon_state = "genericbush_1"

/obj/structure/flora/ausbushes/rospilovo/genericbush/Initialize()
	icon_state = "genericbush_[rand(1, 4)]"
	. = ..()

/obj/structure/flora/ausbushes/rospilovo/pointybush
	icon_state = "pointybush_1"

/obj/structure/flora/ausbushes/rospilovo/pointybush/Initialize()
	icon_state = "pointybush_[rand(1, 4)]"
	. = ..()

/obj/structure/flora/ausbushes/rospilovo/lavendergrass
	icon_state = "lavendergrass_1"

/obj/structure/flora/ausbushes/rospilovo/lavendergrass/Initialize()
	icon_state = "lavendergrass_[rand(1, 4)]"
	. = ..()

/obj/structure/flora/ausbushes/rospilovo/ywflowers
	icon_state = "ywflowers_1"

/obj/structure/flora/ausbushes/rospilovo/ywflowers/Initialize()
	icon_state = "ywflowers_[rand(1, 3)]"
	. = ..()

/obj/structure/flora/ausbushes/rospilovo/brflowers
	icon_state = "brflowers_1"

/obj/structure/flora/ausbushes/rospilovo/brflowers/Initialize()
	icon_state = "brflowers_[rand(1, 3)]"
	. = ..()

/obj/structure/flora/ausbushes/rospilovo/ppflowers
	icon_state = "ppflowers_1"

/obj/structure/flora/ausbushes/rospilovo/ppflowers/Initialize()
	icon_state = "ppflowers_[rand(1, 3)]"
	. = ..()

/obj/structure/flora/ausbushes/rospilovo/sparsegrass
	icon_state = "sparsegrass_1"

/obj/structure/flora/ausbushes/rospilovo/sparsegrass/Initialize()
	icon_state = "sparsegrass_[rand(1, 3)]"
	. = ..()

/obj/structure/flora/ausbushes/rospilovo/fullgrass
	icon_state = "fullgrass_1"

/obj/structure/flora/ausbushes/rospilovo/fullgrass/Initialize()
	icon_state = "fullgrass_[rand(1, 3)]"
	. = ..()

/obj/structure/table/rospilovo
	canSmoothWith = list(/obj/structure/table/rospilovo)
	pass_flags = LETPASSTHROW
	name = "стол"
	desc = "Обычный деревянный слегка пошарпанный стол."
	icon = 'white/valtos/icons/rospilovo/stol_stalker.dmi'
	icon_state = "stol"
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/obj/structure/table/rospilovo)

/obj/structure/rospilovo/okno
	name = "окно"
	desc = "Старое деревянное окно."
	icon = 'white/valtos/icons/rospilovo/decor2.dmi'
	pass_flags = LETPASSTHROW
	density = 0
	opacity = 0

/obj/structure/rospilovo/tree
	name = "дерево"
	icon = 'white/valtos/icons/rospilovo/derevya.dmi'
	icon_state = "derevo1"
	density = 0
	opacity = 0
	layer = 9

/obj/structure/rospilovo/tree/New()
	icon_state = "derevo[rand(1, 5)]"

/obj/structure/rospilovo/tree/leafless/
	name = "мёртвое дерево"
	icon_state = "derevo1l"
	density = 0
	opacity = 0
	layer = 9

/obj/structure/rospilovo/tree/leafless/New()
	icon_state = "derevo[rand(1, 5)]l"

/obj/structure/rospilovo
	icon = 'white/valtos/icons/rospilovo/decor.dmi'
	density = 0
	anchored = 1
	layer = OBJ_LAYER

/obj/structure/rospilovo/polka
	name = "стеллаж"
	desc = "Деревянный стеллаж."
	icon = 'white/valtos/icons/rospilovo/polka.dmi'
	icon_state = "polka"
	density = 1
	anchored = 1

/obj/structure/rospilovo/radiation
	name = "знак"
	desc = "Этот знак здесь явно не для красоты."
	icon_state = "radiation_sign"
	density = 1
	pass_flags = LETPASSTHROW

/obj/structure/rospilovo/radiation/stop
	name = "табличка"
	desc = "На табличке написано - \"Стоп! Запретная зона! Проход запрещен!\"."
	icon_state = "stop_sign"

/obj/structure/rospilovo/water
	anchored = 1
	var/busy = 0

/obj/structure/rospilovo/water/luzha
	name = "лужа"
	desc = "Обыкновенная лужа. Вода, вроде бы, не самая чистая, но умыться или смыть остатки грязи с одежды в ней можно."
	icon_state = "luzha"

/obj/structure/rospilovo/water/luzha/kap
	desc = "Обыкновенная лужа. Вода, вроде бы, не самая чистая, но умыться или смыть остатки грязи с одежды в ней можно."
	icon_state = "luzha_kap"

/obj/structure/rospilovo/truba
	name = "труба"
	desc = "Старая ржавая труба."
	icon_state = "truba"
	density = 0

/obj/structure/rospilovo/truba/vert
	icon_state = "truba_v"

/obj/structure/rospilovo/bochka
	name = "бочка"
	desc = "Железная непримечательная бочка."
	icon_state = "bochka"
	density = 1

/obj/structure/rospilovo/bochka/red
	name = "красная бочка"
	icon_state = "red_bochka"

/obj/structure/rospilovo/water/bochka
	name = "бочка"
	desc = "Железная бочка, наполненная дождевой водой. Здесь можно умыться или смыть остатки грязи."
	icon_state = "bochka_s_vodoy"
	density = 1

/obj/structure/rospilovo/water/bochka/kap
	desc = "Железная бочка, наполненная дождевой водой. Здесь можно умыться или смыть остатки грязи."
	icon_state = "diryavaya_bochka_s_vodoy"


/obj/structure/rospilovo/rozetka
	name = "розетка"
	desc = "Старая советская розетка."
	icon_state = "rozetka"
	density = 0

/obj/structure/rospilovo/krest
	name = "крест"
	desc = "Деревянный крест. Кажется, здесь кто-то закопан."
	icon_state = "krest"
	density = 0

/obj/structure/rospilovo/krest/bereza
	icon_state = "krest_bereza"

/obj/structure/rospilovo/komod
	name = "комод"
	desc = "Обыкновенный деревянный комод."
	icon_state = "komod"
	density = 1
	pass_flags = LETPASSTHROW

/obj/structure/rospilovo/shina
	name = "шина"
	desc = "Тяжелая старая пробитая шина."
	icon_state = "shina"
	density = 1

/obj/structure/rospilovo/shina2
	name = "шина"
	desc = "Тяжелые старые пробитые шины."
	icon_state = "shina2"
	density = 1

/obj/structure/rospilovo/shina3
	name = "шина"
	desc = "Тяжелые старые пробитые шины."
	icon_state = "shina3a"
	density = 1

/obj/structure/rospilovo/switcher
	name = "выключатель"
	desc = "Неисправный выключатель.\n<span class='notice'>Я начинаю щелкать его и обретаю на некоторое время покой.</span>"
	icon_state = "vikluchatel"

/obj/structure/rospilovo/doski
	name = "доски"
	desc = "Сломанные доски. Использовать где-либо их уже не получится."
	icon_state = "doski_oblomki"
	layer = 2.9
	pass_flags = LETPASSTHROW

/obj/structure/rospilovo/doski/doski2
	icon_state = "doski_oblomki2"

/obj/structure/rospilovo/doski/doski3
	icon_state = "doski_oblomki3"

/obj/structure/rospilovo/doski/doski4
	icon_state = "doski_oblomki4"

/obj/structure/rospilovo/battery
	name = "батарея"
	desc = "Ржавая отопительная батарея. Когда-то согревала дома, сейчас - просто очередная железка."
	icon_state = "gazovaya_truba"
	density = 0

/obj/structure/rospilovo/vanna
	name = "ванна"
	desc = "Старая чугунная ванна. Ничего особенного."
	icon_state = "vanna"
	density = 1

/obj/structure/rospilovo/leest
	name = "лист"
	desc = "Тяжёлый жестянной покорёженный лист. Использовать его уже никак не получится."
	icon_state = "list_zhesti"
	density = 0

/obj/structure/rospilovo/yashik
	name = "деревянный ящик"
	icon_state = "yashik"
	desc = "Старый ящик."
	density = 1

/obj/structure/rospilovo/yashik/yaskik_a
	name = "ящик"
	icon_state = "yashik_a"
	desc = "Старый ящик."
	density = 1

/obj/structure/rospilovo/yashik/yaskik_a/big
	icon = 'white/valtos/icons/rospilovo/decorations_32x64.dmi'
	icon_state = "crate"
	desc = "Большой старый ящик."
	opacity = 1
	density = 1
	layer = MASSIVE_OBJ_LAYER

/obj/structure/rospilovo/propane
	name = "пропан"
	desc = "Баллон с пропаном. Огнеопасно."
	icon = 'white/valtos/icons/rospilovo/decorations_32x64.dmi'
	icon_state = "propane"
	density = 1

/obj/structure/rospilovo/stolb
	name = "столб"
	icon = 'white/valtos/icons/rospilovo/decorations_32x64.dmi'
	icon_state = "stolb"
	desc = "Столб с висящими остатками проводов."
	layer = MASSIVE_OBJ_LAYER
	density = 0

/obj/structure/rospilovo/propane/dual
	icon_state = "propane_dual"

/obj/structure/rospilovo/pen
	name = "пень"
	desc = "Обычный пень. Ни больше, ни меньше."
	icon_state = "pen"
	density = 0

/obj/structure/rospilovo/radio
	name = "радио"
	desc = "Старое сломанное советское радио."
	icon_state = "radio"
	density = 1

/obj/structure/rospilovo/apc
	name = "электрощиток"
	desc = "Старый электрощиток."
	icon_state = "apc"
	density = 0

/obj/structure/rospilovo/apc/open
	icon_state = "apc1"

/obj/structure/rospilovo/apc/open2
	icon_state = "apc2"

/obj/structure/rospilovo/cover
	name = "ковёр"
	icon = 'white/valtos/icons/rospilovo/cover.dmi'
	icon_state = "cover"
	desc = "Старый ковёр. Обычно висит на стене."
	density = 0

/obj/structure/rospilovo/porog
	name = "порог"
	icon = 'white/valtos/icons/rospilovo/decor.dmi'
	icon_state = "porog1"
	desc = "Старый порог, о который можно легко зацепиться ногой."
	layer = BELOW_OBJ_LAYER
	density = 0

/obj/structure/rospilovo/porog/porog2
	icon = 'white/valtos/icons/rospilovo/decor.dmi'
	icon_state = "porog2"

/obj/structure/rospilovo/televizor
	name =  "ТВ-ящик"
	desc = "Старый советский телевизор."
	icon_state = "TV"
	density = 1

/obj/structure/rospilovo/clocks
	name =  "часы"
	desc = "Остановились."
	icon = 'white/valtos/icons/rospilovo/decorations_32x32.dmi'
	icon_state = "clocks"
	density = 0

/obj/structure/rospilovo/painting
	icon = 'white/valtos/icons/rospilovo/decorations_32x32.dmi'
	density = 0

/obj/structure/rospilovo/painting/gorbachev
	name = "картина"
	desc = "Портрет последнего секретаря ЦК КПСС."
	icon_state = "gorbachev"

/obj/structure/rospilovo/painting/stalin
	name = "картина"
	desc = "Портрет второго секретаря ЦК КПСС."
	icon_state = "stalin"

/obj/structure/rospilovo/painting/lenin
	name = "картина"
	desc = "Портрет первого секретаря ЦК КПСС."
	icon_state = "lenin"

/obj/structure/rospilovo/intercom
	name = "домофон"
	desc = "Да..."
	icon = 'white/valtos/icons/rospilovo/backwater.dmi'
	icon_state = "intercom"
	density = 0

/obj/structure/rospilovo/televizor/broken
	icon_state = "TV_b"
	name =  "TV-ящик"
	desc = "Старый разбитый советский телевизор."
	density = 1

/obj/structure/rospilovo/bigyashik
	name = "здоровый ящик"
	icon = 'white/valtos/icons/rospilovo/decorations_64x64.dmi'
	icon_state = "bigyashik 0.0"
	density = 1
	opacity = 1

/obj/structure/rospilovo/bigyashik/melkiy
	icon = 'white/valtos/icons/rospilovo/decorations_32x64.dmi'
	icon_state = "bigyashik"

/obj/structure/rospilovo/oscillograph
	name = "осцилограф"
	desc = ""
	icon_state = "oscillograph_off"
	density = 1

/obj/structure/rospilovo/panel
	name = "машина"
	desc = ""
	icon_state = "panel_1"
	density = 1

/obj/structure/rospilovo/panel/panel2
	icon_state = "panel_2"

/obj/structure/rospilovo/musor_yashik
	name = "мусорка"
	desc = "Мусорный ящик"
	density = 1

/obj/structure/rospilovo/musor_yashik/red
	icon_state = "yashik_musor"

/obj/structure/rospilovo/musor_yashik/red/full
	icon_state = "yashik_musor_full"

/obj/structure/rospilovo/musor_yashik/green
	icon_state = "yashik_musor2"

/obj/structure/rospilovo/musor_yashik/green/full
	icon_state = "yashik_musor2_full"

/obj/structure/rospilovo/shitok
	name = "электрощит"
	desc = "Старый электрический щиток."
	icon_state = "shitok"
	density = 0

/obj/structure/rospilovo/shitok/shitok2
	icon_state = "shitok2"
	density = 0

/obj/structure/rospilovo/broke_table
	name = "стол"
	desc = "Перевёрнутый стол."
	icon_state = "broke_table1"
	density = 1

/obj/structure/rospilovo/broke_table/right
	icon_state = "broke_table2"

/obj/structure/rospilovo/lift
	name = "лифт"
	desc = "Старый ооветский лифт. Вероятнее всего он уже никогда не заработает."
	icon_state = "lift"

/obj/structure/rospilovo/luk
	name = "люк"
	desc = "Закрытый канализационный люк"
	icon = 'white/valtos/icons/rospilovo/decor2.dmi'
	icon_state = "luk0"

/obj/structure/rospilovo/luk/open
	desc = "Открытый канализационый люк. Интересно, что внутри?"
	icon_state = "luk1"

/obj/structure/rospilovo/luk/open/ladder
	desc = "Открытый канализационны люк с лестницей. Интересно, что внутри?"
	icon_state = "luk2"

/obj/structure/rospilovo/trubas
	name = "труба"
	desc = "Большая ржавая труба, служившая для газоснабжения."
	icon = 'white/valtos/icons/rospilovo/trubas.dmi'
	icon_state = "trubas"
	density = 1

/obj/structure/rospilovo/bar_plitka
	name = "tile"
	icon = 'white/valtos/icons/rospilovo/floor.dmi'
	icon_state = "bar_plate1"
	layer = DISPOSAL_PIPE_LAYER

/obj/structure/rospilovo/bar_plitka/New()
	..()
	pixel_x = rand(-2, 2)
	pixel_y = rand(-2, 2)

/obj/structure/rospilovo/bunker
	name = "бункер"
	icon = 'white/valtos/icons/rospilovo/bunker.dmi'
	density = 1
	opacity = 1

/obj/structure/rospilovo/plita
	name = "плита"
	desc = "Ржавая и очень старая газовая плита. Где-то еще можно различить слой засохшего жира вперемешку с грязью и пылью."
	icon = 'white/valtos/icons/rospilovo/decor.dmi'
	icon_state = "gazovaya_plita"
	density = 1
	anchored= 1

/obj/structure/rospilovo/pech
	name = "печь"
	desc = "Старая печь."
	icon = 'white/valtos/icons/rospilovo/decor.dmi'
	icon_state = "pech"
	density = 0
	anchored = 1

/obj/structure/rospilovo/shkaf64
	name = "шкаф"
	desc = "Большой деревянный шкаф. Красивый, но в некоторых местах стерся и облез, на стекле пошли трещины. Несмотря на это, кажется, будто всего пару минут назад внутри стоял хрустальный бабушкин сервиз."
	icon = 'white/valtos/icons/rospilovo/decorations_32x64.dmi'
	icon_state = "shkaf64"
	density = 1
	anchored = 1

/obj/structure/fluff/rospilovo
	name = "машина"
	desc = "Ржавая пиздец."
	icon = 'white/valtos/icons/rospilovo/decor128.dmi'
	icon_state = "civilgruz"
	density = TRUE

/obj/structure/fluff/rospilovo/gruzovik
	icon = 'white/valtos/icons/rospilovo/gruzovik.dmi'
	icon_state = "gruzovik_v"

/obj/structure/grille/rospilovo
	desc = "Крепкий железный забор."
	name = "забор"
	icon = 'white/valtos/icons/rospilovo/structure.dmi'
	icon_state = "fence1"
	density = 1
	anchored = 1
	flags_1 = CONDUCT_1
	layer = CLOSED_DOOR_LAYER
	max_integrity = 10000000

/obj/structure/grille/rospilovo/ex_act(severity, target)
	return

/obj/structure/grille/rospilovo/attack_paw(mob/user)
	return

/obj/structure/grille/rospilovo/attack_hand(mob/living/user)
	user.do_attack_animation(src)
	return

/obj/structure/grille/rospilovo/attack_animal(var/mob/living/simple_animal/M)
	M.do_attack_animation(src)
	return

/obj/structure/grille/rospilovo/bullet_act(var/obj/projectile/Proj)
	if(!Proj)
		return
	..()
	if((Proj.damage_type != STAMINA)) //Grilles can't be exhausted to death
		return
	return

/obj/structure/grille/rospilovo/attackby(obj/item/W, mob/user, params)
	return

/obj/structure/grille/rospilovo/wood
	desc = "Старый деревянный забор."
	icon_state = "zabor_horizontal1"
	density = 1
	opacity = 0

/obj/structure/grille/rospilovo/beton
	name = "бетонный забор"
	icon = 'white/valtos/icons/rospilovo/beton_zabor.dmi'
	desc = "Слишком крепкий."
	icon_state = "1"
	density = 1
	opacity = 0

/obj/structure/grille/rospilovo/beton/green
	name = "забор"
	icon = 'white/valtos/icons/rospilovo/green_zabor.dmi'
	desc = "Зелённый забор. Лучше, чем серый."
	icon_state = "1"

obj/structure/grille/rospilovo/beton/CanPass(atom/movable/mover, turf/target, height=0)
	. = ..()
	if(height==0) return 1
	if(istype(mover) && (mover.pass_flags == PASSGRILLE))
		return 1
	else
		if(istype(mover, /obj/projectile) && density)
			return prob(0)
		else
			return !density

/obj/item/clothing/under/switer
	name = "свитер"
	desc = "Грязный и поношенный старый бабушкин свитер из натуральной собачьей шерсти, обладающий естественными лечебными свойствами. Этот свитер очень тёплый и удобный."
	worn_icon = 'white/valtos/icons/rospilovo/uniform_mob.dmi'
	icon = 'white/valtos/icons/rospilovo/uniform_item.dmi'
	body_parts_covered = CHEST|ARMS|LEGS
	cold_protection = CHEST|ARMS|LEGS
	icon_state = "switer"
	inhand_icon_state = "g_suit"
	can_adjust = 0
	has_sensor = 0

/obj/item/clothing/under/switer/dark
	icon_state = "switer2"

/obj/item/clothing/under/switer/lolg
	name = "тельняшка"
	desc = "Теплая майка-тельняха и черные поношенные штаны - стандартная одежда всех долговцев и военных."
	icon_state = "lolg"
	inhand_icon_state = "lolg"

/obj/item/clothing/under/switer/tracksuit
	name = "спортивный костюм"
	desc = "Такой спортивный костюм обычно можно увидеть на пацанах с района."
	icon_state = "tracksuit"
	inhand_icon_state = "tracksuit"

/obj/effect/step_trigger/r3b0lut10n
	var/message = "Как-то тут не по себе..."
	mobs_only = TRUE

/obj/effect/step_trigger/r3b0lut10n/Trigger(mob/M)
	if(M.client)
		to_chat(M, "<span class='info'>[message]</span>")
		qdel(src)

/obj/effect/step_trigger/r3b0lut10n/deathtrap
	message = "Ӧ̶̖̦̹́Ш̶͓̆́͋И̵̺̫͍̇̐̐Б̵̭̭̱͑К̵̪̣͋́͠А̵͔̃̇ ̴̧̳̊͆О̷̢̟̼͊Ш̴̞́И̷͎̩̮̅͋̿Б̷͉͊̆К̴̮̄А̸̪̰̺̕ ̸͙͓̈́̈̊О̷̝̭̣̀̾͊Ш̸̛͖И̶̫̬̬̾Б̷̮͔͋͛̐К̴̺͓͎̋А̶͓͑̓̚ ̸̙̼̗͊̽С̷̤̈В̷͇̤̏̕Я̵̪̥̀͑Ж̷͙͌̓̚Ӥ̷̲͕̖́Т̶̘̳̠͂Е̶̢͚̺̓С̵͖͓̳͛͗̿Ь̶̳̀̈́ ̸̘̹͙̉͑̌С̴͎́ ̴̛̪̇Р̶̛̹͉̄̈͜А̶͖̑͠З̴̹͕̏͠Р̵̙̪̌̀͜А̶̮̉̔̂Б̴̱͝ͅО̶̧͐͂̑Т̶̬͚̉͠Ч̵̮̥͊͂И̷̢͊̂̚К̵̩͓̟̌͆̚О̵͖͘М̴̹͚͚͌̈́ ̵̡̰̫̋О̵͎͙́͘Ш̷̢͆̓̂Ӥ̶͉̖̙́Б̴͎̄́̍К̴̰͋̒Ӓ̵̞́ ̷̪̊О̸̟͒̉Ш̸̲͕͒̿͊И̷̨̫̖́̊Б̷̗͈̱̅̍̓К̶̼̞̈́́А̴̩̑ ̸͙͈̽̋̅О̴̙͊͝Ш̵̯̒̍́Ӥ̴͓͚͕́Б̴̯̉К̵̢̩̐͛́А̶̖͕̙̓̑"
	mobs_only = TRUE

/obj/effect/step_trigger/r3b0lut10n/deathtrap/Trigger(mob/M)
	if(M.client)
		var/turf/T = get_turf(M)
		M.playsound_local(T, 'white/valtos/sounds/wrongdoorbuddy.ogg', 100, 0)
		spawn(400)
			to_chat(M, "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
			to_chat(M, "<span class='info'>[message]</span>")
			var/turf/G = locate(83, 99, M.z)
			M.forceMove(G)
			var/area/awaymission/rospilovo/deathtrap/A = get_area(G)
			A.fuckplayer()
		qdel(src)

/area/awaymission/rospilovo
	name = "Rospilovo"
	icon_state = "awaycontent6"
	requires_power = FALSE
	noteleport = TRUE
	has_gravity = TRUE
	mood_bonus = -25
	mood_message = "<span class='red'>Тут не очень приятно!\n</span>"

/area/awaymission/rospilovo/deathtrap
	icon_state = "awaycontent5"
	mood_bonus = -250000
	mood_message = "<span class='nicegreen'>Ӧ̶̖̦̹́Ш̶͓̆́͋И̵̺̫͍̇̐̐Б̵̭̭̱͑К̵̪̣͋́͠А̵͔̃̇ ̴̧̳̊͆О̷̢̟̼͊Ш̴̞́И̷͎̩̮̅͋̿Б̷͉͊̆К̴̮̄А̸̪̰̺̕ ̸͙͓̈́̈̊О̷̝̭̣̀̾͊Ш̸̛͖И̶̫̬̬̾Б̷̮͔͋͛̐К̴̺͓͎̋А̶͓͑̓̚ ̸̙̼̗͊̽С̷̤̈В̷͇̤̏̕Я̵̪̥̀͑Ж̷͙͌̓̚Ӥ̷̲͕̖́Т̶̘̳̠͂Е̶̢͚̺̓С̵͖͓̳͛͗̿Ь̶̳̀̈́ ̸̘̹͙̉͑̌С̴͎́ ̴̛̪̇Р̶̛̹͉̄̈͜А̶͖̑͠З̴̹͕̏͠Р̵̙̪̌̀͜А̶̮̉̔̂Б̴̱͝ͅО̶̧͐͂̑Т̶̬͚̉͠Ч̵̮̥͊͂И̷̢͊̂̚К̵̩͓̟̌͆̚О̵͖͘М̴̹͚͚͌̈́ ̵̡̰̫̋О̵͎͙́͘Ш̷̢͆̓̂Ӥ̶͉̖̙́Б̴͎̄́̍К̴̰͋̒Ӓ̵̞́ ̷̪̊О̸̟͒̉Ш̸̲͕͒̿͊И̷̨̫̖́̊Б̷̗͈̱̅̍̓К̶̼̞̈́́А̴̩̑ ̸͙͈̽̋̅О̴̙͊͝Ш̵̯̒̍́Ӥ̴͓͚͕́Б̴̯̉К̵̢̩̐͛́А̶̖͕̙̓̑</span>"

/area/awaymission/rospilovo/deathtrap/proc/fuckplayer()
	for (var/turf/fuck in src)
		if (prob(10))
			continue
		var/matrix/M = matrix()
		M.Translate(0, rand(-7, 7))
		animate(fuck, transform = M, time = rand(15, 35), loop = -1, easing = SINE_EASING)
		animate(transform = null, time = rand(15, 35), easing = SINE_EASING)

	sleep(100)

	for(var/mob/M in src)
		animate(M.client, pixel_x=rand(-64,64), pixel_y=rand(-64,64), time=100)

	for (var/turf/fuck in src)
		fuck.icon_state = "ohshit"

	sleep(100)

	for(var/mob/M in src)
		animate(M.client, pixel_x=rand(-64,64), pixel_y=rand(-64,64), time=100)

	for (var/turf/fuck in src)
		fuck.icon_state = "ohshit"
		fuck.color = "#000000"
