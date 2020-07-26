/datum/dog_fashion
	var/name
	var/desc
	var/emote_see
	var/emote_hear
	var/speak
	var/speak_emote

	// This isn't applied to the dog, but stores the icon_state of the
	// sprite that the associated item uses
	var/icon_file
	var/obj_icon_state
	var/obj_alpha
	var/obj_color

/datum/dog_fashion/New(mob/M)
	name = replacetext(name, "REAL_NAME", M.real_name)
	desc = replacetext(desc, "NAME", name)

/datum/dog_fashion/proc/apply(mob/living/simple_animal/pet/dog/D)
	if(name)
		D.name = name
	if(desc)
		D.desc = desc
	if(emote_see)
		D.emote_see = emote_see
	if(emote_hear)
		D.emote_hear = emote_hear
	if(speak)
		D.speak = speak
	if(speak_emote)
		D.speak_emote = speak_emote

/datum/dog_fashion/proc/get_overlay(dir)
	if(icon_file && obj_icon_state)
		var/image/corgI = image(icon_file, obj_icon_state, dir = dir)
		corgI.alpha = obj_alpha
		corgI.color = obj_color
		return corgI


/datum/dog_fashion/head
	icon_file = 'icons/mob/corgi_head.dmi'

/datum/dog_fashion/back
	icon_file = 'icons/mob/corgi_back.dmi'

/datum/dog_fashion/head/helmet
	name = "Сержант REAL_NAME"
	desc = "Всегда верный, всегда бдительный."

/datum/dog_fashion/head/chef
	name = "Соусный шеф REAL_NAME"
	desc = "Ваша еда будет проверена на вкус. Да."


/datum/dog_fashion/head/captain
	name = "Капитан REAL_NAME"
	desc = "Наверное, лучше, чем последний капитан."

/datum/dog_fashion/head/kitty
	name = "Рантайм"
	emote_see = list("выкашливает клубок шерсти", "тянется")
	emote_hear = list("мурлычет")
	speak = list("Мурр", "Мяу!", "МИААААУ!", "ПШШШШШШШ", "МИИИИИУ")
	desc = "Это милый маленький котенок!... подождите... какого черта?"

/datum/dog_fashion/head/rabbit
	name = "Хоппи"
	emote_see = list("дергает носиком", "немного прыгает")
	desc = "Это Хоппи. Это корги... Урмм... кролик."

/datum/dog_fashion/head/beret
	name = "Янн"
	desc = "Mon dieu! C'est un chien!"
	speak = list("le-вуф!", "le-гаф!", "JAPPE!!")
	emote_see = list("в страхе.", "сдаётся.", "изображает мёртвого.","выглядит так, как будто перед ним стена.")


/datum/dog_fashion/head/detective
	name = "Детектив REAL_NAME"
	desc = "NAME видит меня насквозь..."
	emote_see = list("исследует область.","обнюхивает подсказки.","ищет вкусные закуски.","берет конфетку из шляпы.")


/datum/dog_fashion/head/nurse
	name = "Медсестра REAL_NAME"
	desc = "NAME требуется 100кк стейка... СРОЧНО!"

/datum/dog_fashion/head/pirate
	name = "Спиздили"
	desc = "Яррррх!! Эта собака с цингой!"
	emote_see = list("охотится за сокровищами.","смотрит холодно...","скрежетает своими крошечными корги зубами!")
	emote_hear = list("свирепо рычит!", "огрызается.")
	speak = list("Аррргх!!","Гррррр!")

/datum/dog_fashion/head/pirate/New(mob/M)
	..()
	name = "[pick("Ol'","Scurvy","Black","Rum","Gammy","Bloody","Gangrene","Death","Long-John")] [pick("kibble","leg","beard","tooth","poop-deck","Threepwood","Le Chuck","corsair","Silver","Crusoe")]"

/datum/dog_fashion/head/ushanka
	name = "Котлетки будут завтра"
	desc = "Последователь Карла Баркса."
	emote_see = list("рассматривает недостатки капиталистической экономической модели.", "обдумывает плюсы и минусы авангардизма.")

/datum/dog_fashion/head/ushanka/New(mob/M)
	..()
	name = "[pick("Комрад","Комиссар","Славный лидер")] [M.real_name]"

/datum/dog_fashion/head/warden
	name = "Офицер REAL_NAME"
	emote_see = list("пускает слюни.","ищет пончики.")
	desc = "Stop right there criminal scum!"

/datum/dog_fashion/head/blue_wizard
	name = "Великий Волшебник REAL_NAME"
	speak = list("ЯП", "Вуф!", "Гав!", "АУУУУУ", "ЭЙ, НАХ!")

/datum/dog_fashion/head/red_wizard
	name = "Пиромансер REAL_NAME"
	speak = list("ЯП", "Вуф!", "Гав!", "АУУУУУ", "СОСНИ СОМА!")

/datum/dog_fashion/head/cardborg
	name = "Борги"
	speak = list("Пинг!","Бип!","Вуф!")
	emote_see = list("суетится.", "вынюхивает нелюдей.")
	desc = "Результат сокращения бюджета робототехники."

/datum/dog_fashion/head/ghost
	name = "Призрак"
	speak = list("ВуууУУУуууу~","АУУУУУУУУУУУУУУУУУУУУУУ")
	emote_see = list("спотыкается вокруг.", "дрожит.")
	emote_hear = list("воет!","стонет.")
	desc = "Жуткий!"
	obj_icon_state = "sheet"

/datum/dog_fashion/head/santa
	name = "Помощник Санты"
	emote_hear = list("лает рождественские песни.", "весело тявкает!")
	emote_see = list("ищет подарки.", "проверяет его список.")
	desc = "Он очень любит молоко и печенье."

/datum/dog_fashion/head/cargo_tech
	name = "Грузорги REAL_NAME"
	desc = "Причина, по которой у ваших желтых перчаток есть жевательные метки."

/datum/dog_fashion/head/reindeer
	name = "Красноносый корги REAL_NAME"
	emote_hear = list("освещает путь!", "подсвечивается.", "тявкает!")
	desc = "У него очень блестящий нос."

/datum/dog_fashion/head/sombrero
	name = "Старейшина REAL_NAME"
	desc = "Вы должны уважать БЛЯЯЯЯ"

/datum/dog_fashion/head/sombrero/New(mob/M)
	..()
	desc = "Вы должны уважать Старейшину [M.real_name]."

/datum/dog_fashion/head/hop
	name = "Лейтенант REAL_NAME"
	desc = "На самом деле можно доверять, чтобы он не сбежал сам по себе."

/datum/dog_fashion/head/deathsquad
	name = "Кавалерист REAL_NAME"
	desc = "Это не красная краска. Это настоящая кровь корги."

/datum/dog_fashion/head/clown
	name = "Клоун REAL_NAME"
	desc = "Лучший друг хонкающего человека"
	speak = list("ХОНК!", "Хонк!")
	emote_see = list("трюкачит.", "скользит.")

/datum/dog_fashion/back/deathsquad
	name = "Кавалерист REAL_NAME"
	desc = "Это не красная краска. Это настоящая кровь корги."

/datum/dog_fashion/head/festive
	name = "Праздничный REAL_NAME"
	desc = "Готов к вечеринке!"
	obj_icon_state = "festive"
