/datum/bounty/item/assistant/strange_object
	name = "Странный обьект"
	description = "Нанотрасен интересуется странными предметами. Найите один в исправности и сразу же отправьте его на ЦК."
	reward = 1200
	wanted_types = list(/obj/item/relic)

/datum/bounty/item/assistant/scooter
	name = "Скутер"
	description = "Нанотразен решила что ходить бесполезно. Отправьте скутер на ЦК, чтобы ускорить работу."
	reward = 1080 // the mat hoffman
	wanted_types = list(/obj/vehicle/ridden/scooter)
	include_subtypes = FALSE

/datum/bounty/item/assistant/skateboard
	name = "Скейтборд"
	description = "Нанотразен решила что ходить бесполезно. Отправьте скейтборд на ЦК, чтобы ускорить работу."
	reward = 900 // the tony hawk
	wanted_types = list(/obj/vehicle/ridden/scooter/skateboard, /obj/item/melee/skateboard)

/datum/bounty/item/assistant/stunprod
	name = "Палка-Оглушалка"
	description = "ЦК требует использовать палка-оглушалки против диссидентов. Сделайте один, и затем отправьте на ЦК."
	reward = 1300
	wanted_types = list(/obj/item/melee/baton/cattleprod)

/datum/bounty/item/assistant/soap
	name = "Мыло"
	description = "Мыло пропало из ванных комнат ЦК. Никто не знает кто его взял. Отправьте мыло и станьте героем, в котором нуждается ЦК."
	reward = 2000
	required_count = 3
	wanted_types = list(/obj/item/soap)

/datum/bounty/item/assistant/spear
	name = "Копья"
	description = "У Службы Безопасности ЦК сокращение бюджета. Вам заплатят, если вы отправите им набор копий."
	reward = 2000
	required_count = 5
	wanted_types = list(/obj/item/spear)

/datum/bounty/item/assistant/toolbox
	name = "Тулбоксы"
	description = "На ЦК нехватка робаста! Поспешите и отправьте несколько наборов инструментов в качестве решения проблемы."
	reward = 2000
	required_count = 6
	wanted_types = list(/obj/item/storage/toolbox)

/datum/bounty/item/assistant/statue
	name = "Статуя"
	description = "ЦК заказало статую художника для вестибюля. Отправьте один, когда это будет возможно."
	reward = 2000
	wanted_types = list(/obj/structure/statue)

/datum/bounty/item/assistant/clown_box
	name = "Ящик клоуна"
	description = "Вселенной нужен смех. Отпечатайте корбку штампом клоуна и отправьте его."
	reward = 1500
	wanted_types = list(/obj/item/storage/box/clown)

/datum/bounty/item/assistant/cheesiehonkers
	name = "Сырные Хонкеры"
	description = "Очевидно, что компания, которая делает Сырные Хонкеры, скоро уходит из бизнеса. ЦК хочет запастись ими до того, как это произойдет!"
	reward = 1200
	required_count = 3
	wanted_types = list(/obj/item/reagent_containers/food/snacks/cheesiehonkers)

/datum/bounty/item/assistant/baseball_bat
	name = "Бейсбольная бита"
	description = "В ЦентКоме продолжается бейсбольная лихорадка! Будьте добрыми и отправьте им несколько бейсбольных бит, чтобы руководство смогло осуществить их детскую мечту."
	reward = 2000
	required_count = 5
	wanted_types = list(/obj/item/melee/baseball_bat)

/datum/bounty/item/assistant/extendohand
	name = "Расширяющаяся рука"
	description = "Коммандер Бетси стареет и больше не может наклоняться, чтобы получить дистанционный пульт. Руководство попросило отправить руку, чтобы помочь ей."
	reward = 2500
	wanted_types = list(/obj/item/extendohand)

/datum/bounty/item/assistant/donut
	name = "Пончики"
	description = "Силы безопасности CentCom несут большие потери против Синдиката. Отправьте им пончики, чтобы поднять боевой дух."
	reward = 3000
	required_count = 10
	wanted_types = list(/obj/item/reagent_containers/food/snacks/donut)

/datum/bounty/item/assistant/donkpocket
	name = "Донк-Покеты"
	description = "отзыв безопасности потребителей: Внимание! Донк-Покеты, изготовленные в прошлом году, содержат опасный биоматерию ящерицы. Верните их на ЦК немедленно."
	reward = 3000
	required_count = 10
	wanted_types = list(/obj/item/reagent_containers/food/snacks/donkpocket)

/datum/bounty/item/assistant/briefcase
	name = "Портфель"
	description = "Центральное командование в этом году проведет деловую конвенцию. Отправьте несколько портфелей в их поддержку."
	reward = 2500
	required_count = 5
	wanted_types = list(/obj/item/storage/briefcase, /obj/item/storage/secure/briefcase)

/datum/bounty/item/assistant/sunglasses
	name = "Солнечные очки"
	description = "Известный блюзовый дуэт проходит через наш сектор, но они потеряли свои очки и они не могут выступать. Отправьте новые очки на ЦК чтобы исправить это."
	reward = 3000
	required_count = 2
	wanted_types = list(/obj/item/clothing/glasses/sunglasses)

/datum/bounty/item/assistant/monkey_hide
	name = "Кожа обезьяны"
	description = "One of the scientists at CentCom is interested in testing products on monkey skin. Your mission is to acquire monkey's hide and ship it."
	reward = 1500
	wanted_types = list(/obj/item/stack/sheet/animalhide/monkey)

/datum/bounty/item/assistant/shard
	name = "Осколки стекла"
	description = "ЦК преследует убийцу-клоуна и сотрудники не могут поймать его потому что она не носит обувь. Пожалуйста, отправьте несколько осколков, чтобы сделать ловушку."
	reward = 1500
	required_count = 15
	wanted_types = list(/obj/item/shard)

/datum/bounty/item/assistant/comfy_chair
	name = "Удобные кресла"
	description = "Коммандер Пэт недоволен своим креслом. Он утверждает, что у него болит спина. Отправьте несколько кресел чтобы ублажить его."
	reward = 1500
	required_count = 5
	wanted_types = list(/obj/structure/chair/comfy)

/datum/bounty/item/assistant/geranium
	name = "Герань"
	description = "У командира Зота любовь к командиру Зена. Отправьте партию герани - её любимого цветка и он с радостью наградит вас."
	reward = 4000
	required_count = 3
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/poppy/geranium)

/datum/bounty/item/assistant/poppy
	name = "Мак"
	description = "Командир Зот действительно хочет сбить офицера безопасности Оливию с ног. Отправьте партию маков - её любимого цветка - и он с радостью наградит вас."
	reward = 1000
	required_count = 3
	wanted_types = list(/obj/item/reagent_containers/food/snacks/grown/poppy)
	include_subtypes = FALSE

/datum/bounty/item/assistant/shadyjims
	name = "Шейди Джим"
	description = "В ЦК разгневанный офицер требует, чтобы он получил пачку сигарет Шейди Джима. Пожалуйста, отправьте один. Он начинает угрожать."
	reward = 500
	wanted_types = list(/obj/item/storage/fancy/cigarettes/cigpack_shadyjims)

/datum/bounty/item/assistant/potted_plants
	name = "Растения в горшке"
	description = "ЦК планирует ввести в эксплуатацию новую станцию класса BirdBoat. Вам было приказано отправить растения в горшках."
	reward = 2000
	required_count = 8
	wanted_types = list(/obj/item/kirbyplants)

/datum/bounty/item/assistant/earmuffs
	name = "Наушники"
	description = "Центральное командование устало от сообщений вашей станции. Они приказали вам отправить несколько наушников, чтобы уменьшить раздражение."
	reward = 1000
	wanted_types = list(/obj/item/clothing/ears/earmuffs)

/datum/bounty/item/assistant/handcuffs
	name = "Наручники"
	description = "Большой поток сбежавших осужденных прибыло на ЦК. Сейчас самое подходящее время для отправки запасных наручников."
	reward = 1000
	required_count = 5
	wanted_types = list(/obj/item/restraints/handcuffs)

/datum/bounty/item/assistant/monkey_cubes
	name = "Кубики с обезьянами"
	description = "Из-за недавней генетической аварии ЦК остро нуждается в обезьянах. Ваша миссия состоит в том, чтобы отправить им кубики обезьян."
	reward = 2000
	required_count = 3
	wanted_types = list(/obj/item/reagent_containers/food/snacks/monkeycube)

/datum/bounty/item/assistant/chainsaw
	name = "Бензопила"
	description = "У шеф-повара на ЦК возникают проблемы с разделкой животных. Он просит одну бензопилу..."
	reward = 2500
	wanted_types = list(/obj/item/chainsaw)

/datum/bounty/item/assistant/ied
	name = "IED"
	description = "Тюрьма строгого режима НТ на ЦК проходит обучение персонала. Отправьте несколько устройств IED, которые будут служить им учебным пособием..."
	reward = 2000
	required_count = 3
	wanted_types = list(/obj/item/grenade/iedcasing)

/datum/bounty/item/assistant/bonfire
	name = "Горящий костёр"
	description = "Обогреватели неисправны, и грузовой экипаж Центрального командования начинает мерзнуть. Поставьте зажженный костер, чтобы согреть их."
	reward = 5000
	wanted_types = list(/obj/structure/bonfire)

/datum/bounty/item/assistant/bonfire/applies_to(obj/O)
	if(!..())
		return FALSE
	var/obj/structure/bonfire/B = O
	return !!B.burning

/datum/bounty/item/assistant/corgimeat
	name = "Свежее мясо корги"
	description = "Синдикат недавно украл всё мясо корги у ЦК. Отправьте замену немедленно."
	reward = 3000
	wanted_types = list(/obj/item/reagent_containers/food/snacks/meat/slab/corgi)

/datum/bounty/item/assistant/corgifarming
	name = "Шкура Корги"
	description = "Космическая яхта адмирала Вайнштейна нуждается в новой обивке. Дюжина шкур корги должна подойти."
	reward = 30000 //that's a lot of dead dogs
	required_count = 12
	wanted_types = list(/obj/item/stack/sheet/animalhide/corgi)

/datum/bounty/item/assistant/action_figures
	name = "Фигурки"
	description = "Сын вице-президента увидел рекламу телешоу по телевизору, и теперь он не умолкает про них. Отправьте немного фигурок чтобы успокоить сына"
	reward = 4000
	required_count = 5
	wanted_types = list(/obj/item/toy/figure)

/datum/bounty/item/assistant/tail_whip
	name = "Девятихвостый кнут"
	description = "Коммандер Джексон ищет прекрасное дополнение к своей коллекции экзотического оружия. Она щедро вознаградит вас за девятихвостый кнут (кнут из ящера учитывается также)"
	reward = 4000
	wanted_types = list(/obj/item/melee/chainofcommand/tailwhip)

/datum/bounty/item/assistant/dead_mice
	name = "Мёртвая мышь"
	description = "На станции 14 закончились замороженные мыши. Отправьте несколько свежих, чтобы их уборщик не бастовал..."
	reward = 5000
	required_count = 5
	wanted_types = list(/obj/item/reagent_containers/food/snacks/deadmouse)
