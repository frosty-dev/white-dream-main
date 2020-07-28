//nutrition
/datum/mood_event/fat
	description = "<span class='warning'><B>Во мне столько жира...</B></span>\n" //muh fatshaming
	mood_change = -6

/datum/mood_event/wellfed
	description = "<span class='nicegreen'>Мой желудок полон!</span>\n"
	mood_change = 8

/datum/mood_event/fed
	description = "<span class='nicegreen'>Я не хочу есть.</span>\n"
	mood_change = 5

/datum/mood_event/hungry
	description = "<span class='warning'>Я хочу есть.</span>\n"
	mood_change = -6

/datum/mood_event/starving
	description = "<span class='boldwarning'>Я голодаю!</span>\n"
	mood_change = -10

//charge
/datum/mood_event/supercharged
	description = "<span class='boldwarning'>I can't possibly keep all this power inside, I need to release some quick!</span>\n"
	mood_change = -10

/datum/mood_event/overcharged
	description = "<span class='warning'>I feel dangerously overcharged, perhaps I should release some power.</span>\n"
	mood_change = -4

/datum/mood_event/charged
	description = "<span class='nicegreen'>Я чувствую электричество в моих венах!</span>\n"
	mood_change = 6

/datum/mood_event/lowpower
	description = "<span class='warning'>Моя энергия заканчивается, нужно зарядиться где-нибудь.</span>\n"
	mood_change = -6

/datum/mood_event/decharged
	description = "<span class='boldwarning'>Я отчаянно нуждаюсь в электричестве!</span>\n"
	mood_change = -10

//Disgust
/datum/mood_event/gross
	description = "<span class='warning'>Это было что-то мерзкое.</span>\n"
	mood_change = -4

/datum/mood_event/verygross
	description = "<span class='warning'>Кажется, меня вырвет.</span>\n"
	mood_change = -6

/datum/mood_event/disgusted
	description = "<span class='boldwarning'>О, боже, это было отвратительно.</span>\n"
	mood_change = -8

/datum/mood_event/disgust/bad_smell
	description = "<span class='warning'>Я чувствую запах чего-то ужасно разложившегося внутри этой комнаты.</span>\n"
	mood_change = -6

/datum/mood_event/disgust/nauseating_stench
	description = "<span class='warning'>Запах гниющего мяса невыносим!</span>\n"
	mood_change = -12

//Generic needs events
/datum/mood_event/favorite_food
	description = "<span class='nicegreen'>Это было вкусно.</span>\n"
	mood_change = 5
	timeout = 4 MINUTES

/datum/mood_event/gross_food
	description = "<span class='warning'>Это было невкусно.</span>\n"
	mood_change = -2
	timeout = 4 MINUTES

/datum/mood_event/disgusting_food
	description = "<span class='warning'>Эта еда была отвратительна!</span>\n"
	mood_change = -6
	timeout = 4 MINUTES

/datum/mood_event/breakfast
	description = "<span class='nicegreen'>Нет ничего приятнее, чем начать смену с приятного завтрака.</span>\n"
	mood_change = 2
	timeout = 10 MINUTES

/datum/mood_event/nice_shower
	description = "<span class='nicegreen'>Отличный душ.</span>\n"
	mood_change = 4
	timeout = 5 MINUTES

/datum/mood_event/fresh_laundry
	description = "<span class='nicegreen'>Нет ничего лучше, чем надеть свежевыстиранный комбинезон.</span>\n"
	mood_change = 2
	timeout = 10 MINUTES
