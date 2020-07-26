/datum/mood_event/hug
	description = "<span class='nicegreen'>Обнимашки - круто.</span>\n"
	mood_change = 1
	timeout = 2 MINUTES

/datum/mood_event/betterhug
	description = "<span class='nicegreen'>Кто-то очень добр ко мне.</span>\n"
	mood_change = 3
	timeout = 4 MINUTES

/datum/mood_event/betterhug/add_effects(mob/friend)
	description = "<span class='nicegreen'>[friend.name] очень мило себя ведёт.</span>\n"

/datum/mood_event/besthug
	description = "<span class='nicegreen'>Рядом с кем-то очень приятно находится, мне так хорошо с ним!</span>\n"
	mood_change = 5
	timeout = 4 MINUTES

/datum/mood_event/besthug/add_effects(mob/friend)
	description = "<span class='nicegreen'>[friend.name] очень мило себя ведёт, рядом с [friend.p_they()] так хорошо находиться!</span>\n"

/datum/mood_event/warmhug
	description = "<span class='nicegreen'>Warm cozy hugs are the best!</span>\n"
	mood_change = 1
	timeout = 2 MINUTES

/datum/mood_event/arcade
	description = "<span class='nicegreen'>У меня получилось пройти игру!</span>\n"
	mood_change = 3
	timeout = 8 MINUTES

/datum/mood_event/blessing
	description = "<span class='nicegreen'>Меня благословили.</span>\n"
	mood_change = 3
	timeout = 8 MINUTES

/datum/mood_event/book_nerd
	description = "<span class='nicegreen'>Это была хорошая книжка.</span>\n"
	mood_change = 1
	timeout = 5 MINUTES

/datum/mood_event/exercise
	description = "<span class='nicegreen'>Работа в спортзале выпускает энедорфины!</span>\n"
	mood_change = 2
	timeout = 5 MINUTES

/datum/mood_event/pet_animal
	description = "<span class='nicegreen'>Животные такие милые! Не могу перестать их гладить!</span>\n"
	mood_change = 2
	timeout = 5 MINUTES

/datum/mood_event/pet_animal/add_effects(mob/animal)
	description = "<span class='nicegreen'>[animal.name] такой милый! Я не могу перестать гладить [animal.p_them()]!</span>\n"

/datum/mood_event/honk
	description = "<span class='nicegreen'>Меня ХОНКнули!/span>\n"
	mood_change = 2
	timeout = 4 MINUTES
	special_screen_obj = "honked_nose"
	special_screen_replace = FALSE

/datum/mood_event/perform_cpr
	description = "<span class='nicegreen'>Так приятно спасти чью-то жизнь.</span>\n"
	mood_change = 6
	timeout = 8 MINUTES

/datum/mood_event/oblivious
	description = "<span class='nicegreen'>Какой прекрасный день..</span>\n"
	mood_change = 3

/datum/mood_event/jolly
	description = "<span class='nicegreen'>Мне весело без какой-либо причины.</span>\n"
	mood_change = 6
	timeout = 2 MINUTES

/datum/mood_event/focused
	description = "<span class='nicegreen'>У меня есть цель, и я добьюсь её, во что бы то ни стало!</span>\n" //Used for syndies, nukeops etc so they can focus on their goals
	mood_change = 4
	hidden = TRUE

/datum/mood_event/badass_antag
	description = "<span class='greentext'>Я так крут, и все это знают. Просто посмотри на них, они трясутся от одной мысли, что я рядом с ними.</span>\n"
	mood_change = 7
	hidden = TRUE
	special_screen_obj = "badass_sun"
	special_screen_replace = FALSE

/datum/mood_event/creeping
	description = "<span class='greentext'>Голоса освободили меня!</span>\n" //creeps get it when they are around their obsession
	mood_change = 18
	timeout = 3 SECONDS
	hidden = TRUE

/datum/mood_event/revolution
	description = "<span class='nicegreen'>СЛАВА РЕВОЛЮЦИИ!!!</span>\n"
	mood_change = 3
	hidden = TRUE

/datum/mood_event/cult
	description = "<span class='nicegreen'>Я знаю правду, славим великого!</span>\n"
	mood_change = 10 //maybe being a cultist isnt that bad after all
	hidden = TRUE

/datum/mood_event/heretics
	description = "<span class='nicegreen'>THE HIGHER I RISE , THE MORE I SEE.</span>\n"
	mood_change = 10 //maybe being a cultist isnt that bad after all
	hidden = TRUE

/datum/mood_event/family_heirloom
	description = "<span class='nicegreen'>Со мной моя семейная реликвия в безопасности.</span>\n"
	mood_change = 1

/datum/mood_event/fan_clown_pin
	description = "<span class='nicegreen'>I love showing off my clown pin!</span>\n"
	mood_change = 1

/datum/mood_event/fan_mime_pin
	description = "<span class='nicegreen'>I love showing off my mime pin!</span>\n"
	mood_change = 1

/datum/mood_event/goodmusic
	description = "<span class='nicegreen'>В этой музыке есть что-то успокаивающее.</span>\n"
	mood_change = 3
	timeout = 60 SECONDS

/datum/mood_event/chemical_euphoria
	description = "<span class='nicegreen'>Хех... Хехехе... Хехе...</span>\n"
	mood_change = 4

/datum/mood_event/chemical_laughter
	description = "<span class='nicegreen'>Laughter самая лучшая медицина, не так ли?!</span>\n"
	mood_change = 4
	timeout = 3 MINUTES

/datum/mood_event/chemical_superlaughter
	description = "<span class='nicegreen'>*ХРИП*</span>\n"
	mood_change = 12
	timeout = 3 MINUTES

/datum/mood_event/religiously_comforted
	description = "<span class='nicegreen'>Мне приятно находится рядом со священным человеком.</span>\n"
	mood_change = 3
	timeout = 5 MINUTES

/datum/mood_event/clownshoes
	description = "<span class='nicegreen'>Эта обувь - наследие клоунады, я не хочу их снимать!</span>\n"
	mood_change = 5

/datum/mood_event/sacrifice_good
	description ="<span class='nicegreen'>Боги довольны этим подношением!</span>\n"
	mood_change = 5
	timeout = 3 MINUTES

/datum/mood_event/artok
	description = "<span class='nicegreen'>Так приятно, что здесь занимаются искусством.</span>\n"
	mood_change = 2
	timeout = 5 MINUTES

/datum/mood_event/artgood
	description = "<span class='nicegreen'>Какое заставляющее задуматься произведение искусства, я не могу перестать думать о нём!</span>\n"
	mood_change = 4
	timeout = 5 MINUTES

/datum/mood_event/artgreat
	description = "<span class='nicegreen'>Это произведение искусства такое прекрасное! Я снова верю в доброту человечества, очень многое говорит о людях, что рисуют такое в этом месте.</span>\n"
	mood_change = 6
	timeout = 5 MINUTES

/datum/mood_event/pet_borg
	description = "<span class='nicegreen'>I just love my robotic friends!</span>\n"
	mood_change = 3
	timeout = 5 MINUTES

/datum/mood_event/bottle_flip
	description = "<span class='nicegreen'>The bottle landing like that was satisfying.</span>\n"
	mood_change = 2
	timeout = 3 MINUTES

/datum/mood_event/hope_lavaland
	description = "<span class='nicegreen'>What a peculiar emblem.  It makes me feel hopeful for my future.</span>\n"
	mood_change = 10

/datum/mood_event/nanite_happiness
	description = "<span class='nicegreen robot'>+++++++HAPPINESS ENHANCEMENT+++++++</span>\n"
	mood_change = 7

/datum/mood_event/nanite_happiness/add_effects(message)
	description = "<span class='nicegreen robot'>+++++++[message]+++++++</span>\n"

/datum/mood_event/area
	description = "" //Fill this out in the area
	mood_change = 0

/datum/mood_event/area/add_effects(_mood_change, _description)
	mood_change = _mood_change
	description = _description

/datum/mood_event/confident_mane
	description = "<span class='nicegreen'>I'm feeling confident with a head full of hair.</span>\n"
	mood_change = 2
