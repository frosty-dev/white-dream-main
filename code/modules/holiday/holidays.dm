/datum/holiday
	var/name = "If you see this the holiday calendar code is broken"

	var/begin_day = 1
	var/begin_month = 0
	var/end_day = 0 // Default of 0 means the holiday lasts a single day
	var/end_month = 0
	var/begin_week = FALSE //If set to a number, then this holiday will begin on certain week
	var/begin_weekday = FALSE //If set to a weekday, then this will trigger the holiday on the above week
	var/always_celebrate = FALSE // for christmas neverending, or testing.
	var/current_year = 0
	var/year_offset = 0
	var/obj/item/drone_hat //If this is defined, drones without a default hat will spawn with this one during the holiday; check drones_as_items.dm to see this used

// This proc gets run before the game starts when the holiday is activated. Do festive shit here.
/datum/holiday/proc/celebrate()
	return

// When the round starts, this proc is ran to get a text message to display to everyone to wish them a happy holiday
/datum/holiday/proc/greet()
	return "Да это же [name]!"

// Returns special prefixes for the station name on certain days. You wind up with names like "Christmas Object Epsilon". See new_station_name()
/datum/holiday/proc/getStationPrefix()
	//get the first word of the Holiday and use that
	var/i = findtext(name, " ")
	return copytext(name, 1, i)

// Return 1 if this holidy should be celebrated today
/datum/holiday/proc/shouldCelebrate(dd, mm, yy, ww, ddd)
	if(always_celebrate)
		return TRUE

	if(!end_day)
		end_day = begin_day
	if(!end_month)
		end_month = begin_month
	if(begin_week && begin_weekday)
		if(begin_week == ww && begin_weekday == ddd && begin_month == mm)
			return TRUE
	if(end_month > begin_month) //holiday spans multiple months in one year
		if(mm == end_month) //in final month
			if(dd <= end_day)
				return TRUE

		else if(mm == begin_month)//in first month
			if(dd >= begin_day)
				return TRUE

		else if(mm in begin_month to end_month) //holiday spans 3+ months and we're in the middle, day doesn't matter at all
			return TRUE

	else if(end_month == begin_month) // starts and stops in same month, simplest case
		if(mm == begin_month && (dd in begin_day to end_day))
			return TRUE

	else // starts in one year, ends in the next
		if(mm >= begin_month && dd >= begin_day) // Holiday ends next year
			return TRUE
		if(mm <= end_month && dd <= end_day) // Holiday started last year
			return TRUE

	return FALSE

// The actual holidays

/datum/holiday/new_year
	name = NEW_YEAR
	begin_day = 30
	begin_month = DECEMBER
	end_day = 2
	end_month = JANUARY
	drone_hat = /obj/item/clothing/head/festive

/datum/holiday/new_year/getStationPrefix()
	return pick("Пати","Новый","Похмельный","Развалистый", "Старый")

/datum/holiday/groundhog
	name = "День Сурка"
	begin_day = 2
	begin_month = FEBRUARY
	drone_hat = /obj/item/clothing/head/helmet/space/chronos

/datum/holiday/groundhog/getStationPrefix()
	return pick("Deja Vu") //I have been to this place before

/datum/holiday/valentines
	name = VALENTINES
	begin_day = 13
	end_day = 15
	begin_month = FEBRUARY

/datum/holiday/valentines/getStationPrefix()
	return pick("Любовный","Аморный","Одинокий","Легкосердечный","Обнимашковый")

/// Garbage DAYYYYY
/// Huh?.... NOOOO
/// *GUNSHOT*
/// AHHHGHHHHHHH
/datum/holiday/garbageday
	name = GARBAGEDAY
	begin_day = 17
	end_day = 17
	begin_month = JUNE

/datum/holiday/birthday
	name = "День рождения Space Station 13"
	begin_day = 16
	begin_month = FEBRUARY
	drone_hat = /obj/item/clothing/head/festive

/datum/holiday/birthday/greet()
	var/game_age = text2num(time2text(world.timeofday, "YY")) - 3
	var/Fact
	switch(game_age)
		if(16)
			Fact = " SS13 сейчас достаточно взрослый, чтобы водить!"
		if(18)
			Fact = " SS13 сейчас легален!"
		if(21)
			Fact = " SS13 теперь может пить!"
		if(26)
			Fact = " SS13 теперь может арендовать машину!"
		if(30)
			Fact = " SS13 теперь может возвращаться домой к семье!"
		if(35)
			Fact = " SS13 теперь может быть президентом США!"
		if(40)
			Fact = " SS13 теперь может страдать от кризиса среднего возраста!"
		if(50)
			Fact = " Счастливая золотая годовщина!"
		if(65)
			Fact = " SS13 теперь можно начать думать о выходе на пенсию!"
		if(96)
			Fact = " Пожалуйста, отправьте машину времени обратно, чтобы забрать меня, мне нужно обновить форматирование времени для этой функции!" //See you later suckers
	if(!Fact)
		Fact = " SS13 теперь на [game_age] лет старее!"

	return "Скажи 'С Днём Рождения' Space Station 13, первой версии от 16 Февраля, 2003 года![Fact]"

/datum/holiday/random_kindness
	name = "Случайные Акты Дня Доброты"
	begin_day = 17
	begin_month = FEBRUARY

/datum/holiday/random_kindness/greet()
	return "Пойди сделай несколько случайных актов доброты для незнакомца!" //haha yeah right

/datum/holiday/leap
	name = "Високосный день"
	begin_day = 29
	begin_month = FEBRUARY

/datum/holiday/pi
	name = "День Пи"
	begin_day = 14
	begin_month = MARCH

/datum/holiday/pi/getStationPrefix()
	return pick("Синусоидный","Косинусоидный","Тангенсный","Пересекающий", "Не пересекающий", "Котангенсный")

/datum/holiday/no_this_is_patrick
	name = "День Святого Патрика"
	begin_day = 17
	begin_month = MARCH
	drone_hat = /obj/item/clothing/head/soft/green

/datum/holiday/no_this_is_patrick/getStationPrefix()
	return pick("Лестный","Зелёный","Лепреконовский","Пьяный")

/datum/holiday/no_this_is_patrick/greet()
	return "Счастливый Национальный день Опьянения!"

/datum/holiday/april_fools
	name = APRIL_FOOLS
	begin_day = 1
	end_day = 5
	begin_month = APRIL

/datum/holiday/april_fools/celebrate()
	SSjob.set_overflow_role("Clown")
	SSticker.login_music = 'sound/ambience/clown.ogg'
	for(var/i in GLOB.new_player_list)
		var/mob/dead/new_player/P = i
		if(P.client)
			P.client.playtitlemusic()

/datum/holiday/spess
	name = "День Космонавта"
	begin_day = 12
	begin_month = APRIL
	drone_hat = /obj/item/clothing/head/syndicatefake

/datum/holiday/spess/greet()
	return "В этот день более 600 лет назад товарищ Юрий Гагарин впервые отправился в космос!"

/datum/holiday/fourtwenty
	name = "День Четыре Двадцать"
	begin_day = 20
	begin_month = APRIL

/datum/holiday/fourtwenty/getStationPrefix()
	return pick("Шпионский","Туповатый","Затяжной","Промозглый","Чичевый","Чонговый")

/datum/holiday/tea
	name = "Национальный День Чая"
	begin_day = 21
	begin_month = APRIL

/datum/holiday/tea/getStationPrefix()
	return pick("Пышечный","Ассамский","Улунгский","Пу-эрский","Сладкочаевый","Зелёный","Чёрный")

/datum/holiday/earth
	name = "День Земли"
	begin_day = 22
	begin_month = APRIL

/datum/holiday/labor
	name = "День Труда"
	begin_day = 1
	begin_month = MAY
	drone_hat = /obj/item/clothing/head/hardhat

/datum/holiday/firefighter
	name = "День Пожарника"
	begin_day = 4
	begin_month = MAY
	drone_hat = /obj/item/clothing/head/hardhat/red

/datum/holiday/firefighter/getStationPrefix()
	return pick("Горящий","Пылающий","Плазменный","Огненный")

/datum/holiday/pobeda
	name = "День Победы"
	begin_day = 9
	begin_month = MAY

/datum/holiday/pobeda/getStationPrefix()
	return pick("Ветеранский","Победный","Ряженый","Окопный","Дедовский")

/datum/holiday/bee
	name = "День пчёл"
	begin_day = 20
	begin_month = MAY
	drone_hat = /obj/item/clothing/mask/rat/bee

/datum/holiday/bee/getStationPrefix()
	return pick("Пчёлочный","Медовый","Роевой","Бжжжжжж","Медовуховый","Жужжащий")

/datum/holiday/summersolstice
	name = "День Летнего Солнцестояния"
	begin_day = 21
	begin_month = JUNE

/datum/holiday/doctor
	name = "День Доктора"
	begin_day = 1
	begin_month = JULY
	drone_hat = /obj/item/clothing/head/nursehat

/datum/holiday/ufo
	name = "День НЛО"
	begin_day = 2
	begin_month = JULY
	drone_hat = /obj/item/clothing/mask/facehugger/dead

/datum/holiday/ufo/getStationPrefix() //Is such a thing even possible?
	return pick("Ayy","Правдивый","Цукалосный","Малдеровый","Скаллевый") //Yes it is!

/datum/holiday/usa
	name = "День Независимости США"
	begin_day = 4
	begin_month = JULY

/datum/holiday/usa/getStationPrefix()
	return pick("Независимый","Американский","Бургеровый","Белоголово-орланский","Настроенный Шовинистически", "Фейерверковый")

/datum/holiday/writer
	name = "День Писателя"
	begin_day = 8
	begin_month = JULY

/datum/holiday/france
	name = "День взятия Бастилии"
	begin_day = 14
	begin_month = JULY
	drone_hat = /obj/item/clothing/head/beret

/datum/holiday/france/getStationPrefix()
	return pick("Французский","Fromage", "Zut", "Merde")

/datum/holiday/france/greet()
	return "Ты слышишь, как люди поют?"

/datum/holiday/friendship
	name = "День дружбы"
	begin_day = 30
	begin_month = JULY

/datum/holiday/friendship/greet()
	return "Есть волшебный [name]!"

/datum/holiday/beer
	name = "День Пива"

/datum/holiday/beer/shouldCelebrate(dd, mm, yy, ww, ddd)
	if(mm == 8 && ddd == FRIDAY && ww == 1) //First Friday in August
		return TRUE
	return FALSE

/datum/holiday/beer/getStationPrefix()
	return pick("Stout","Porter","Lager","Ale","Malt","Bock","Doppelbock","Hefeweizen","Pilsner","IPA","Lite") //I'm sorry for the last one

/datum/holiday/pirate
	name = "День Говорения-как-пират"
	begin_day = 19
	begin_month = SEPTEMBER
	drone_hat = /obj/item/clothing/head/pirate

/datum/holiday/pirate/greet()
	return "Ye be talkin' like a pirate today or else ye'r walkin' tha plank, matey!"

/datum/holiday/pirate/getStationPrefix()
	return pick("Yarr","Scurvy","Yo-ho-ho")

/datum/holiday/programmers
	name = "День Программиста"

/datum/holiday/programmers/shouldCelebrate(dd, mm, yy, ww, ddd) //Programmer's day falls on the 2^8th day of the year
	if(mm == 9)
		if(yy/4 == round(yy/4)) //Note: Won't work right on September 12th, 2200 (at least it's a Friday!)
			if(dd == 12)
				return 1
		else
			if(dd == 13)
				return 1
	return 0

/datum/holiday/programmers/getStationPrefix()
	return pick("span>","DEBUG: ","null","/list","EVENT PREFIX NOT FOUND") //Portability

/datum/holiday/questions
	name = "День Глупых Вопросов"
	begin_day = 28
	begin_month = SEPTEMBER

/datum/holiday/questions/greet()
	return "Имеете [name]?"

/datum/holiday/animal
	name = "День Животных"
	begin_day = 4
	begin_month = OCTOBER

/datum/holiday/animal/getStationPrefix()
	return pick("Parrot","Corgi","Cat","Pug","Goat","Fox")

/datum/holiday/smile
	name = "День Улыбок"
	begin_day = 7
	begin_month = OCTOBER
	drone_hat = /obj/item/clothing/head/papersack/smiley

/datum/holiday/boss
	name = "День Босса"
	begin_day = 16
	begin_month = OCTOBER
	drone_hat = /obj/item/clothing/head/that

/datum/holiday/halloween
	name = HALLOWEEN
	begin_day = 28
	begin_month = OCTOBER
	end_day = 2
	end_month = NOVEMBER

/datum/holiday/halloween/greet()
	return "Жуткий Хэллоуин!"

/datum/holiday/halloween/getStationPrefix()
	return pick("Bone-Rattling","Mr. Bones' Own","2SPOOKY","Spooky","Scary","Skeletons")

/datum/holiday/vegan
	name = "День Вегана"
	begin_day = 1
	begin_month = NOVEMBER

/datum/holiday/vegan/getStationPrefix()
	return pick("Tofu", "Tempeh", "Seitan", "Tofurkey")

/datum/holiday/october_revolution
	name = "Октябрьская Революция"
	begin_day = 6
	begin_month = NOVEMBER
	end_day = 7

/datum/holiday/october_revolution/getStationPrefix()
	return pick("Коммунистический", "Советский", "Большевиковский", "Социалистический", "Красный", "Рабочий")

/datum/holiday/kindness
	name = "День доброты"
	begin_day = 13
	begin_month = NOVEMBER

/datum/holiday/flowers
	name = "День цветов"
	begin_day = 19
	begin_month = NOVEMBER
	drone_hat = /obj/item/reagent_containers/food/snacks/grown/moonflower

/datum/holiday/hello
	name = "'Привет' День"
	begin_day = 21
	begin_month = NOVEMBER

/datum/holiday/hello/greet()
	return "[pick(list("Aloha", "Bonjour", "Hello", "Hi", "Greetings", "Salutations", "Bienvenidos", "Hola", "Howdy", "Ni hao", "Guten Tag", "Konnichiwa", "G'day cunt"))]! " + ..()

/datum/holiday/human_rights
	name = "День прав человека"
	begin_day = 10
	begin_month = DECEMBER

/datum/holiday/monkey
	name = "День обезьяны"
	begin_day = 14
	begin_month = DECEMBER
	drone_hat = /obj/item/clothing/mask/gas/monkeymask

/datum/holiday/thanksgiving
	name = "День благодарения в Соединенных Штатах"
	begin_week = 4
	begin_month = NOVEMBER
	begin_weekday = THURSDAY
	drone_hat = /obj/item/clothing/head/that //This is the closest we can get to a pilgrim's hat

/datum/holiday/thanksgiving/canada
	name = "День благодарения в Канаде"
	begin_week = 2
	begin_month = OCTOBER
	begin_weekday = MONDAY

/datum/holiday/columbus
	name = "День Колумба"
	begin_week = 2
	begin_month = OCTOBER
	begin_weekday = MONDAY

/datum/holiday/mother
	name = "День Матери"
	begin_week = 2
	begin_month = MAY
	begin_weekday = SUNDAY

/datum/holiday/mother/greet()
	return "Счастливого Дня Матери в большинстве стран Америки, Азии и Океании!"

/datum/holiday/father
	name = "День Отца"
	begin_week = 3
	begin_month = JUNE
	begin_weekday = SUNDAY

/datum/holiday/moth
	name = "Неделя Моли"

/datum/holiday/moth/shouldCelebrate(dd, mm, yy, ww, ddd) //National Moth Week falls on the last full week of July, including the saturday and sunday before. See http://nationalmothweek.org/ for precise tracking.
	if(mm == JULY)
		var/week
		if(first_day_of_month() >= 5)	//Friday or later start of the month means week 5 is a full week.
			week = 5
		else
			week = 4

		return (ww == week-1 && (ddd == SATURDAY || ddd == SUNDAY)) || ww == week


/datum/holiday/moth/getStationPrefix()
	return pick("Mothball","Lepidopteran","Lightbulb","Moth","Giant Atlas","Twin-spotted Sphynx","Madagascan Sunset","Luna","Death's Head","Emperor Gum","Polyphenus","Oleander Hawk","Io","Rosy Maple","Cecropia","Noctuidae","Giant Leopard","Dysphania Militaris","Garden Tiger")

/datum/holiday/islamic
	name = "Islamic calendar code broken"

/datum/holiday/islamic/shouldCelebrate(dd, mm, yy, ww, ddd)
	var/datum/foreign_calendar/islamic/cal = new
	return ..(cal.dd, cal.mm, cal.yy, ww, ddd)

/datum/holiday/islamic/ramadan
	name = "Начало Рамадана"
	begin_month = 9
	begin_day = 1
	end_day = 3

/datum/holiday/islamic/ramadan/getStationPrefix()
	return pick("Вредный","Халяльный","Джихадный","Мусульманский")

/datum/holiday/islamic/ramadan/end
	name = "Конец Рамадана"
	end_month = 10
	begin_day = 28
	end_day = 1

/datum/holiday/lifeday
	name = "День Жизни"
	begin_day = 17
	begin_month = NOVEMBER

/datum/holiday/lifeday/getStationPrefix()
	return pick("Зудящий", "Комковатый", "Маллайий", "Казучий") //he really pronounced it "Kazook", I wish I was making shit up

/datum/holiday/doomsday
	name = "Годовщина Судного Дня Майя"
	begin_day = 21
	begin_month = DECEMBER
	drone_hat = /obj/item/clothing/mask/rat/tribal

/datum/holiday/xmas
	name = CHRISTMAS
	begin_day = 22
	begin_month = DECEMBER
	end_day = 27
	drone_hat = /obj/item/clothing/head/santa

/datum/holiday/xmas/greet()
	return "Счастливого Рождества!"

/datum/holiday/xmas/celebrate()
	SSticker.OnRoundstart(CALLBACK(src, .proc/roundstart_celebrate))
	GLOB.maintenance_loot += list(
		list(
			/obj/item/toy/xmas_cracker = 3,
			/obj/item/clothing/head/santa = 1,
			/obj/item/a_gift/anything = 1
		) = maint_holiday_weight,
	)

/datum/holiday/xmas/proc/roundstart_celebrate()
	for(var/obj/machinery/computer/security/telescreen/entertainment/Monitor in GLOB.machines)
		Monitor.icon_state_on = "entertainment_xmas"

	for(var/mob/living/simple_animal/pet/dog/corgi/ian/Ian in GLOB.mob_living_list)
		Ian.place_on_head(new /obj/item/clothing/head/helmet/space/santahat(Ian))


/datum/holiday/festive_season
	name = FESTIVE_SEASON
	begin_day = 1
	begin_month = DECEMBER
	end_day = 31
	drone_hat = /obj/item/clothing/head/santa

/datum/holiday/festive_season/greet()
	return "Have a nice festive season!"

/datum/holiday/boxing
	name = "День подарков"
	begin_day = 26
	begin_month = DECEMBER

/datum/holiday/friday_thirteenth
	name = "Пятница 13-е"

/datum/holiday/friday_thirteenth/shouldCelebrate(dd, mm, yy, ww, ddd)
	if(dd == 13 && ddd == FRIDAY)
		return TRUE
	return FALSE

/datum/holiday/friday_thirteenth/getStationPrefix()
	return pick("Mike","Friday","Evil","Myers","Murder","Deathly","Stabby")

/datum/holiday/easter
	name = EASTER
	drone_hat = /obj/item/clothing/head/rabbitears
	var/const/days_early = 1 //to make editing the holiday easier
	var/const/days_extra = 1

/datum/holiday/easter/shouldCelebrate(dd, mm, yy, ww, ddd)
	if(!begin_month)
		current_year = text2num(time2text(world.timeofday, "YYYY"))
		var/list/easterResults = EasterDate(current_year+year_offset)

		begin_day = easterResults["day"]
		begin_month = easterResults["month"]

		end_day = begin_day + days_extra
		end_month = begin_month
		if(end_day >= 32 && end_month == MARCH) //begins in march, ends in april
			end_day -= 31
			end_month++
		if(end_day >= 31 && end_month == APRIL) //begins in april, ends in june
			end_day -= 30
			end_month++

		begin_day -= days_early
		if(begin_day <= 0)
			if(begin_month == APRIL)
				begin_day += 31
				begin_month-- //begins in march, ends in april

	return ..()

/datum/holiday/easter/celebrate()
	GLOB.maintenance_loot += list(
		list(
			/obj/item/reagent_containers/food/snacks/egg/loaded = 15,
			/obj/item/storage/bag/easterbasket = 15
		) = maint_holiday_weight,
	)

/datum/holiday/easter/greet()
	return "Привет! Счастливой Пасхи и следите за пасхальными кроликами!"

/datum/holiday/easter/getStationPrefix()
	return pick("Fluffy","Bunny","Easter","Egg")

/datum/holiday/ianbirthday
	name = "День Рождения Яна" //github.com/tgstation/tgstation/commit/de7e4f0de0d568cd6e1f0d7bcc3fd34700598acb
	begin_month = SEPTEMBER
	begin_day = 9
	end_day = 10

/datum/holiday/ianbirthday/greet()
	return "С днём рождения, Ян!"

/datum/holiday/ianbirthday/getStationPrefix()
	return pick("Ian", "Corgi", "Erro")

/datum/holiday/hotdogday //I have plans for this.
	name = "Национальный день хот-дога"
	begin_day = 17
	begin_month = JULY

/datum/holiday/hotdogday/greet()
	return "Happy National Hot Dog Day!"

/datum/holiday/hebrew
	name = "If you see this the Hebrew holiday calendar code is broken"

/datum/holiday/hebrew/shouldCelebrate(dd, mm, yy, ww, ddd)
	var/datum/foreign_calendar/hebrew/cal = new
	return ..(cal.dd, cal.mm, cal.yy, ww, ddd)

/datum/holiday/hebrew/hanukkah
	name = "Hanukkah"
	begin_day = 25
	begin_month = 9
	end_day = 2
	end_month = 10

/datum/holiday/hebrew/hanukkah/greet()
	return "Happy [pick("Hanukkah", "Chanukah")]!"

/datum/holiday/hebrew/hanukkah/getStationPrefix()
	return pick("Dreidel", "Menorah", "Latkes", "Gelt")

/datum/holiday/hebrew/passover
	name = "Passover"
	begin_day = 15
	begin_month = 1
	end_day = 22

/datum/holiday/hebrew/passover/getStationPrefix()
	return pick("Matzah", "Moses", "Red Sea")
