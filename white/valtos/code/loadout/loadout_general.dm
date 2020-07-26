/datum/gear/dice
	display_name = "d20"
	path = /obj/item/dice/d20
	cost = 3

/datum/gear/auvtomat
	display_name = "WT-550"
	path = /obj/item/gun/ballistic/automatic/wt550
	allowed_roles = list("Veteran", "International Officer", "Russian Officer", "Head of Security")
	cost = 250

/datum/gear/spare_id
	display_name = "Золотая ID-карта капитана"
	description = "Мечта, которая никогда не сбудется. Наверное."
	path = /obj/item/card/id/captains_spare
	allowed_roles = list("Assistant")
	cost = 20007

/datum/gear/guitar
	display_name = "Гитара"
	description = "Хотите устроить рок-концерт или Вам нужно что-то крепкое в руках для потасовки? Возьмите с собой гитару!"
	path = /obj/item/instrument/guitar
	cost = 50

/datum/gear/backup_circuit
	display_name = "Запасная микросхема"
	description = "Если каким-то образом на этой станции не оказалось консоли, а вы прибыли поздно, то всегда поможет запасная плата вызова шаттла."
	path = /obj/machinery/computer/shuttle/ferry/request/trader
	allowed_roles = list("Trader")
	cost = 50

/datum/gear/lvlonetrader
	display_name = "Карта расширения L1"
	description = "Для доступа к дополнительному отсеку."
	path = /obj/item/card/id/trader_ex
	allowed_roles = list("Trader")
	cost = 350
