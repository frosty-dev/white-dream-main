/datum/bounty/item/medical/heart
	name = "Сердце"
	description = "Командир Джонсон находится в критическом состоянии после очередного сердечного приступа. Врачи говорят, что ему нужно новое сердце быстро. Отправьте один, быстро!"
	reward = 3000
	wanted_types = list(/obj/item/organ/heart)

/datum/bounty/item/medical/lung
	name = "Лёгкие"
	description = "Недавний взрыв на ЦК оставил множество сотрудников с проколотыми легкими. Отправка запасных лёгких будет вознаграждена."
	reward = 10000
	required_count = 3
	wanted_types = list(/obj/item/organ/lungs)

/datum/bounty/item/medical/appendix
	name = "Аппендицит"
	description = "Шеф-повар Гибб Центрального командования хочет приготовить еду, используя особый деликатес: аппендицит. Если вы отправите один, он вам заплатит."
	reward = 5000 //there are no synthetic appendixes
	wanted_types = list(/obj/item/organ/appendix)

/datum/bounty/item/medical/ears
	name = "Уши"
	description = "Несколько сотрудников на Станции 12 остались глухими из-за несанкционированной клоунады. Отправь им новые уши."
	reward = 10000
	required_count = 3
	wanted_types = list(/obj/item/organ/ears)

/datum/bounty/item/medical/liver
	name = "Печень"
	description = "Несколько высокопоставленных дипломатов ЦК были госпитализированы с печеночной недостаточностью после недавней встречи с послами стран Третьего Советского Союза. Помоги нам, ладно?"
	reward = 10000
	required_count = 3
	wanted_types = list(/obj/item/organ/liver)

/datum/bounty/item/medical/eye
	name = "Глаза"
	description = "Директор по исследованиям станции 5 Виллем запрашивает несколько пар глаз. Не задавайте вопросы, просто отправляйте их."
	reward = 10000
	required_count = 3
	wanted_types = list(/obj/item/organ/eyes)
	exclude_types = list(/obj/item/organ/eyes/robotic)

/datum/bounty/item/medical/tongue
	name = "Язык"
	description = "Недавнее нападение мимов экстремистов оставило персонал на Станции 23 безмолвным. Отправьте несколько запасных языков."
	reward = 10000
	required_count = 3
	wanted_types = list(/obj/item/organ/tongue)

/datum/bounty/item/medical/lizard_tail
	name = "Хвост ящерицы"
	description = "Федерация Волшебников закончила поставку для НТ хвостов ящериц. Пока ЦК ведёт переговоры с волшебниками, может ли станция пощадить свой хвост?"
	reward = 3000
	wanted_types = list(/obj/item/organ/tail/lizard)

/datum/bounty/item/medical/cat_tail
	name = "Хвост кошки"
	description = "Центральное командование исчерпало запас мощных уборщиков труб. Можете ли вы отправить хвост кошки, чтобы помочь им?"
	reward = 3000
	wanted_types = list(/obj/item/organ/tail/cat)

/datum/bounty/item/medical/chainsaw
	name = "Chainsaw"
	description = "A CMO at CentCom is having trouble operating on golems. She requests one chainsaw, please."
	reward = 2500
	wanted_types = list(/obj/item/chainsaw)

/datum/bounty/item/medical/tail_whip //Like the cat tail bounties, with more processing.
	name = "Nine Tails whip"
	description = "Commander Jackson is looking for a fine addition to her exotic weapons collection. She will reward you handsomely for either a Cat or Liz o' Nine Tails."
	reward = 4000
	wanted_types = list(/obj/item/melee/chainofcommand/tailwhip)
