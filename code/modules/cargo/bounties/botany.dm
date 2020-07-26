/datum/bounty/item/botany
	reward = 5000
	var/datum/bounty/item/botany/multiplier = 0 //adds bonus reward money; increased for higher tier or rare mutations
	var/datum/bounty/item/botany/bonus_desc //for adding extra flavor text to bounty descriptions
	var/datum/bounty/item/botany/foodtype = "meal" //same here

/datum/bounty/item/botany/New()
	..()
	description = "Шеф-повар ЦК готовит вкусный [foodtype] с [name]. [bonus_desc]»"
	reward += multiplier * 1000
	required_count = rand(5, 10)

/datum/bounty/item/botany/ambrosia_vulgaris
	name = "Листья Амброзии Вулгарис"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/ambrosia/vulgaris)
	foodtype = "stew"

/datum/bounty/item/botany/ambrosia_gaia
	name = "Листья Амброзии Гайи"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/ambrosia/gaia)
	multiplier = 4
	foodtype = "stew"

/datum/bounty/item/botany/apple_golden
	name = "Золотые яблоки"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/apple/gold)
	multiplier = 4
	foodtype = "dessert"

/datum/bounty/item/botany/banana
	name = "Бананы"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/banana)
	exclude_types = list(/obj/item/reagent_containers/food/snacks/grown/banana/bluespace)
	foodtype = "banana split"

/datum/bounty/item/botany/banana_bluespace
	name = "Блюспейс бананы"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/banana/bluespace)
	multiplier = 2
	foodtype = "banana split"

/datum/bounty/item/botany/beans_koi
	name = "Бобы Кои"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/koibeans)
	multiplier = 2

/datum/bounty/item/botany/berries_death
	name = "Ягоды смерти"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/berries/death)
	multiplier = 2
	bonus_desc = "Он утверждает \"что он знает что он делает\"."
	foodtype = "sorbet"

/datum/bounty/item/botany/berries_glow
	name = "Свето-Ягода"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/berries/glow)
	multiplier = 2
	foodtype = "sorbet"

/datum/bounty/item/botany/cannabis
	name = "Листья Каннабиса"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/cannabis)
	exclude_types = list(/obj/item/reagent_containers/food/snacks/grown/cannabis/white, /obj/item/reagent_containers/food/snacks/grown/cannabis/death, /obj/item/reagent_containers/food/snacks/grown/cannabis/ultimate)
	multiplier = 4 //hush money
	bonus_desc = "Не говорите СБ про эту доставку."
	foodtype = "batch of \"muffins\""

/datum/bounty/item/botany/cannabis_white
	name = "Листья растения жизни"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/cannabis/white)
	multiplier = 6
	bonus_desc = "Не говорите СБ про эту доставку."
	foodtype = "\"meal\""

/datum/bounty/item/botany/cannabis_death
	name = "Листья растения смерти"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/cannabis/death)
	multiplier = 6
	bonus_desc = "Не говорите СБ про эту доставку."
	foodtype = "\"meal\""

/datum/bounty/item/botany/cannabis_ultimate
	name = "Листья омега растения"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/cannabis/ultimate)
	multiplier = 6
	bonus_desc = "Ни при каких обстоятельствах не упоминайте эту отправку СБ."
	foodtype = "batch of \"brownies\""

/datum/bounty/item/botany/wheat
	name = "Зерна пшеницы"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/wheat)

/datum/bounty/item/botany/rice
	name = "Зерна риса"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/rice)

/datum/bounty/item/botany/chili
	name = "Перец чили"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/chili)

/datum/bounty/item/botany/ice_chili
	name = "Морозный перец чили"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/icepepper)
	multiplier = 2

/datum/bounty/item/botany/ghost_chili
	name = "Призрачный перец чили"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/ghost_chili)
	multiplier = 2

/datum/bounty/item/botany/citrus_lime
	name = "Лайм"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/citrus/lime)
	foodtype = "sorbet"

/datum/bounty/item/botany/citrus_lemon
	name = "Лемон"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/citrus/lemon)
	foodtype = "sorbet"

/datum/bounty/item/botany/citrus_oranges
	name = "Апельсин"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/citrus/orange)
	bonus_desc = "Не отправлять лемоны и лаймы." //I vanted orahnge!
	foodtype = "sorbet"

/datum/bounty/item/botany/eggplant
	name = "Баклажан"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/eggplant)
	bonus_desc = "Not to be confused with egg-plants."

/datum/bounty/item/botany/eggplant_eggy
	name = "Растение-яйцо"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/shell/eggy)
	bonus_desc = "Not to be confused with eggplants."
	multiplier = 2

/datum/bounty/item/botany/kudzu
	name = "Стручки кудзу"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/kudzupod)
	bonus_desc = "Store in a dry, dark place."
	multiplier = 4

/datum/bounty/item/botany/watermelon
	name = "Арбуз"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/watermelon)
	foodtype = "dessert"

/datum/bounty/item/botany/watermelon_holy
	name = "Святой арбуз"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/holymelon)
	multiplier = 2
	foodtype = "dessert"

/datum/bounty/item/botany/glowshroom
	name = "Светящийся гриб"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/mushroom/glowshroom)
	exclude_types = list(/obj/item/reagent_containers/food/snacks/grown/mushroom/glowshroom/glowcap, /obj/item/reagent_containers/food/snacks/grown/mushroom/glowshroom/shadowshroom)
	foodtype = "omelet"

/datum/bounty/item/botany/glowshroom_cap
	name = "Светящаяся шапка" // надо что-то оригинальней
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/mushroom/glowshroom/glowcap)
	multiplier = 2
	foodtype = "omelet"

/datum/bounty/item/botany/glowshroom_shadow
	name = "Теневой гриб"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/mushroom/glowshroom/shadowshroom)
	multiplier = 2
	foodtype = "omelet"

/datum/bounty/item/botany/nettles_death
	name = "Крапива смерти"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/nettle/death)
	multiplier = 2
	bonus_desc = "Носите защиту при обращении с ними."
	foodtype = "cheese"

/datum/bounty/item/botany/pineapples
	name = "Ананас"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/pineapple)
	bonus_desc = "Не для потребления человеком."
	foodtype = "ashtray"

/datum/bounty/item/botany/tomato
	name = "Помидор"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/tomato)
	exclude_types = list(/obj/item/reagent_containers/food/snacks/grown/tomato/blue)

/datum/bounty/item/botany/tomato_bluespace
	name = "Блюспейм помидор"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/tomato/blue/bluespace)
	multiplier = 4

/datum/bounty/item/botany/oatz
	name = "Овес"
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/oat)
	multiplier = 2
	foodtype = "партия овсянки"
	bonus_desc = "Squats and oats. We're all out of oats."
