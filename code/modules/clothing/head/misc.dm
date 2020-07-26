

/obj/item/clothing/head/centhat
	name = "шапочка ЦентКома"
	icon_state = "centcom"
	desc = "Как же заебись быть императором."
	inhand_icon_state = "that"
	flags_inv = 0
	armor = list("melee" = 30, "bullet" = 15, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	strip_delay = 80

/obj/item/clothing/head/spacepolice
	name = "space police cap"
	desc = "A blue cap for patrolling the daily beat."
	icon_state = "policecap_families"
	inhand_icon_state = "policecap_families"

/obj/item/clothing/head/powdered_wig
	name = "напудренный парик"
	desc = "Пахнет стариной."
	icon_state = "pwig"
	inhand_icon_state = "pwig"

/obj/item/clothing/head/that
	name = "цилиндр"
	desc = "Кругленький."
	icon_state = "tophat"
	inhand_icon_state = "that"
	dog_fashion = /datum/dog_fashion/head
	throwforce = 1

/obj/item/clothing/head/canada
	name = "полосатый красный цилиндр"
	desc = "Пахнет как свежие дырки от бублика. / <i>Il sent comme des trous de beignets frais.</i>"
	icon_state = "canada"
	inhand_icon_state = "canada"

/obj/item/clothing/head/redcoat
	name = "красная шапочка"
	icon_state = "redcoat"
	desc = "<i>'Я думаю, это рыжий.'</i>"

/obj/item/clothing/head/mailman
	name = "шляпа почтальона"
	icon_state = "mailman"
	desc = "<i>'Вовремя!'</i> - головной убор почтальона."

/obj/item/clothing/head/plaguedoctorhat
	name = "шляпа чумного доктора"
	desc = "Когда-то их использовали чумные врачи. Они практически бесполезны."
	icon_state = "plaguedoctor"
	permeability_coefficient = 0.01

/obj/item/clothing/head/hasturhood
	name = "капюшон Хастура"
	desc = "Это <I>невероятно</I> стильно."
	icon_state = "hasturhood"
	flags_inv = HIDEHAIR
	flags_cover = HEADCOVERSEYES

/obj/item/clothing/head/nursehat
	name = "шляпа медсестры"
	desc = "Это позволяет быстро идентифицировать обученный медицинский персонал."
	icon_state = "nursehat"
	dynamic_hair_suffix = ""

	dog_fashion = /datum/dog_fashion/head/nurse

/obj/item/clothing/head/syndicatefake
	name = "чёрная реплика космошлема"
	icon_state = "syndicate-helm-black-red"
	inhand_icon_state = "syndicate-helm-black-red"
	desc = "Пластиковая копия космического шлема агента Синдиката. В этом вы будете выглядеть как настоящий убийственный агент Синдиката! Это игрушка, она не предназначена для использования в космосе!"
	clothing_flags = SNUG_FIT
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/head/cueball
	name = "бильярдный шлем"
	desc = "Большой, безликий белый шар, предназначенный для ношения на голове. Как ты вообще видишь из этого?"
	icon_state = "cueball"
	inhand_icon_state="cueball"
	clothing_flags = SNUG_FIT
	flags_cover = HEADCOVERSEYES|HEADCOVERSMOUTH
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/head/snowman
	name = "Голова Снеговика"
	desc = "Шар из белого пенопласта. Так празднично."
	icon_state = "snowman_h"
	inhand_icon_state = "snowman_h"
	clothing_flags = SNUG_FIT
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/head/justice
	name = "шляпа правосудия"
	desc = "Борись за то, что праведно!"
	icon_state = "justicered"
	inhand_icon_state = "justicered"
	clothing_flags = SNUG_FIT
	flags_inv = HIDEHAIR|HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR
	flags_cover = HEADCOVERSEYES

/obj/item/clothing/head/justice/blue
	icon_state = "justiceblue"
	inhand_icon_state = "justiceblue"

/obj/item/clothing/head/justice/yellow
	icon_state = "justiceyellow"
	inhand_icon_state = "justiceyellow"

/obj/item/clothing/head/justice/green
	icon_state = "justicegreen"
	inhand_icon_state = "justicegreen"

/obj/item/clothing/head/justice/pink
	icon_state = "justicepink"
	inhand_icon_state = "justicepink"

/obj/item/clothing/head/rabbitears
	name = "кроличьи уши"
	desc = "Ношение этих вещей делает вас бесполезным, и только полезно для вашей сексуальной привлекательности."
	icon_state = "bunny"
	dynamic_hair_suffix = ""

	dog_fashion = /datum/dog_fashion/head/rabbit

/obj/item/clothing/head/pirate
	name = "пиратская шляпа"
	desc = "Ярр."
	icon_state = "pirate"
	inhand_icon_state = "pirate"
	dog_fashion = /datum/dog_fashion/head/pirate

/obj/item/clothing/head/pirate
	var/datum/language/piratespeak/L = new

/obj/item/clothing/head/pirate/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	if(slot == ITEM_SLOT_HEAD)
		user.grant_language(/datum/language/piratespeak/, TRUE, TRUE, LANGUAGE_HAT)
		to_chat(user, "<span class='boldnotice'>Я вспоминаю как говорить, как пират!</span>")

/obj/item/clothing/head/pirate/dropped(mob/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.get_item_by_slot(ITEM_SLOT_HEAD) == src)
		user.remove_language(/datum/language/piratespeak/, TRUE, TRUE, LANGUAGE_HAT)
		to_chat(user, "<span class='boldnotice'>Я забываю как говорить, как пират.</span>")

/obj/item/clothing/head/pirate/captain
	name = "шляпа капитана пиратов"
	icon_state = "hgpiratecap"
	inhand_icon_state = "hgpiratecap"

/obj/item/clothing/head/bandana
	name = "пиратская бандана"
	desc = "Ярр."
	icon_state = "bandana"
	inhand_icon_state = "bandana"
	dynamic_hair_suffix = ""

/obj/item/clothing/head/bowler
	name = "котелок"
	desc = "Джентльмен, элита на борту!"
	icon_state = "bowler"
	inhand_icon_state = "bowler"
	dynamic_hair_suffix = ""

/obj/item/clothing/head/witchwig
	name = "ведьмин парик"
	desc = "Eeeee~heheheheheheh!"
	icon_state = "witch"
	inhand_icon_state = "witch"
	flags_inv = HIDEHAIR

/obj/item/clothing/head/chicken
	name = "куриная голова"
	desc = "Кудах!"
	icon_state = "chickenhead"
	inhand_icon_state = "chickensuit"
	clothing_flags = SNUG_FIT
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/head/griffin
	name = "голова гриффона"
	desc = "Почему не «голова орла»? Кто знает."
	icon_state = "griffinhat"
	inhand_icon_state = "griffinhat"
	clothing_flags = SNUG_FIT
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/head/bearpelt
	name = "медвежья шкура"
	desc = "Чётко."
	icon_state = "bearpelt"
	inhand_icon_state = "bearpelt"

/obj/item/clothing/head/xenos
	name = "голова ксеноморфа"
	icon_state = "xenos"
	inhand_icon_state = "xenos_helm"
	desc = "Шлем из хитиновой шкуры ксеноса."
	clothing_flags = SNUG_FIT
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH

/obj/item/clothing/head/fedora
	name = "федора"
	icon_state = "fedora"
	inhand_icon_state = "fedora"
	desc = "Действительно классная шляпа, если ты бандит. Действительно хромая шляпа, если ты нет."
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/fedora

/obj/item/clothing/head/fedora/white
	name = "white fedora"
	icon_state = "fedora_white"
	inhand_icon_state = "fedora_white"

/obj/item/clothing/head/fedora/beige
	name = "beige fedora"
	icon_state = "fedora_beige"
	inhand_icon_state = "fedora_beige"

/obj/item/clothing/head/fedora/suicide_act(mob/user)
	if(user.gender == FEMALE)
		return 0
	var/mob/living/carbon/human/H = user
	user.visible_message("<span class='suicide'>[user] is donning [src]! It looks like [user.p_theyre()] trying to be nice to girls.</span>")
	user.say("M'lady.", forced = "fedora suicide")
	sleep(10)
	H.facial_hairstyle = "Neckbeard"
	return(BRUTELOSS)

/obj/item/clothing/head/sombrero
	name = "сомбреро"
	icon_state = "sombrero"
	inhand_icon_state = "sombrero"
	desc = "Вы можете практически попробовать фиесту."
	flags_inv = HIDEHAIR

	dog_fashion = /datum/dog_fashion/head/sombrero

/obj/item/clothing/head/sombrero/green
	name = "зелёный сомбреро"
	icon_state = "greensombrero"
	inhand_icon_state = "greensombrero"
	desc = "Изящен, как танцующий кактус."
	flags_inv = HIDEHAIR|HIDEFACE|HIDEEARS
	dog_fashion = null

/obj/item/clothing/head/sombrero/shamebrero
	name = "позорбреро"
	icon_state = "shamebrero"
	inhand_icon_state = "shamebrero"
	desc = "Как только он надет, он никогда не снимется."
	dog_fashion = null

/obj/item/clothing/head/sombrero/shamebrero/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, SHAMEBRERO_TRAIT)

/obj/item/clothing/head/flatcap
	name = "кепка"
	desc = "Рабочая мужская шапка."
	icon_state = "flat_cap"
	inhand_icon_state = "detective"

/obj/item/clothing/head/hunter
	name = "шляпа охотника за головами"
	desc = "Никто не собирается обманывать палача в моем городе."
	icon_state = "cowboy"
	worn_icon_state = "hunter"
	inhand_icon_state = "hunter"
	armor = list("melee" = 5, "bullet" = 5, "laser" = 5, "energy" = 15, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/head/cone
	desc = "Этот конус пытается предупредить вас о чем-то!"
	name = "предупреждающий конус"
	icon = 'icons/obj/janitor.dmi'
	icon_state = "cone"
	inhand_icon_state = "cone"
	force = 1
	throwforce = 3
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("предупреждает", "предостерегает", "размазывает")
	resistance_flags = NONE
	dynamic_hair_suffix = ""

/obj/item/clothing/head/santa
	name = "шляпа санты"
	desc = "В первый день рождества мой работодатель подарил мне это!"
	icon_state = "santahatnorm"
	inhand_icon_state = "that"
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	dog_fashion = /datum/dog_fashion/head/santa

/obj/item/clothing/head/jester
	name = "шапка шута"
	desc = "Шапка с колокольчиками, чтобы добавить веселья в костюм."
	icon_state = "jester_hat"
	dynamic_hair_suffix = ""

/obj/item/clothing/head/jester/alt
	icon_state = "jester2"

/obj/item/clothing/head/rice_hat
	name = "рисовая шапка"
	desc = "Welcome to the rice fields, motherfucker."
	icon_state = "rice_hat"

/obj/item/clothing/head/lizard
	name = "шляпа из ящерицы"
	desc = "Сколько ящериц умерло, чтобы сделать эту шляпу? Недостаточно."
	icon_state = "lizard"

/obj/item/clothing/head/papersack
	name = "бумажная шапка"
	desc = "Бумажный мешок с грубыми отверстиями для глаз. Полезно для сокрытия личности или безобразия."
	icon_state = "papersack"
	flags_inv = HIDEHAIR|HIDEFACE|HIDEEARS

/obj/item/clothing/head/papersack/smiley
	name = "бумажная шапка"
	desc = "Бумажный мешок с грубыми прорезями для глаз и схематичной улыбкой, нарисованной спереди. Совсем не жутко."
	icon_state = "papersack_smile"
	flags_inv = HIDEHAIR|HIDEFACE|HIDEEARS

/obj/item/clothing/head/crown
	name = "корона"
	desc = "Корона, подходящая для короля, может быть, для короля поменьше."
	icon_state = "crown"
	armor = list("melee" = 15, "bullet" = 0, "laser" = 0,"energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	dynamic_hair_suffix = ""

/obj/item/clothing/head/crown/fancy
	name = "великолепная корона"
	desc = "Корона, которую носят только самые высшие императоры из <s>land</s> космоса."
	icon_state = "fancycrown"

/obj/item/clothing/head/scarecrow_hat
	name = "шляпа чучела"
	desc = "Простая соломенная шляпа."
	icon_state = "scarecrow_hat"

/obj/item/clothing/head/lobsterhat
	name = "пенная головка омара"
	desc = "Когда все пойдет не так, защита головы - лучший выбор."
	icon_state = "lobster_hat"
	clothing_flags = SNUG_FIT
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/head/drfreezehat
	name = "парик доктора заморозки"
	desc = "Классный парик для классных людей."
	icon_state = "drfreeze_hat"
	flags_inv = HIDEHAIR

/obj/item/clothing/head/pharaoh
	name = "фараоновая шляпа"
	desc = "Ходи как египтянин."
	icon_state = "pharoah_hat"
	inhand_icon_state = "pharoah_hat"

/obj/item/clothing/head/nemes
	name = "головной убор Немеса"
	desc = "Щедрые космические гробницы не включены."
	icon_state = "nemes_headdress"

/obj/item/clothing/head/delinquent
	name = "шляпа делинквент"
	desc = "Грифер."
	icon_state = "delinquent"

/obj/item/clothing/head/frenchberet
	name = "французский берет"
	desc = "Качественный берет, наполненный ароматом курящих, парящих парижан. По какой-то причине вы чувствуете себя менее склонным к военному конфликту."
	icon_state = "beret"
	dynamic_hair_suffix = ""

/obj/item/clothing/head/frenchberet/equipped(mob/M, slot)
	. = ..()
	if (slot == ITEM_SLOT_HEAD)
		RegisterSignal(M, COMSIG_MOB_SAY, .proc/handle_speech)
	else
		UnregisterSignal(M, COMSIG_MOB_SAY)

/obj/item/clothing/head/frenchberet/dropped(mob/M)
	. = ..()
	UnregisterSignal(M, COMSIG_MOB_SAY)

/obj/item/clothing/head/frenchberet/proc/handle_speech(datum/source, mob/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = " [message]"
		var/list/french_words = strings("french_replacement.json", "french")

		for(var/key in french_words)
			var/value = french_words[key]
			if(islist(value))
				value = pick(value)

			message = replacetextEx(message, " [uppertext(key)]", " [uppertext(value)]")
			message = replacetextEx(message, " [capitalize(key)]", " [capitalize(value)]")
			message = replacetextEx(message, " [key]", " [value]")

		if(prob(3))
			message += pick(" Honh honh honh!"," Honh!"," Zut Alors!")
	speech_args[SPEECH_MESSAGE] = trim(message)

/obj/item/clothing/head/clownmitre
	name = "Hat of the Honkmother"
	desc = "Прихожанам трудно увидеть банановую кожуру на полу, когда они смотрят на вашу славную вводную часть."
	icon_state = "clownmitre"

/obj/item/clothing/head/kippah
	name = "ермолка"
	desc = "Знак того, что вы следуете за еврейской Галахой. Держит голову покрытой, а душу внеправославной."
	icon_state = "kippah"

/obj/item/clothing/head/medievaljewhat
	name = "средневековая шляпа еврея"
	desc = "Глупо выглядящая шляпа, предназначенная для того, чтобы надевать на головы угнетенных религиозных меньшинств станции."
	icon_state = "medievaljewhat"

/obj/item/clothing/head/taqiyahwhite
	name = "белый арахчын"
	desc = "Внеочередной способ показать свою преданность Аллаху."
	icon_state = "taqiyahwhite"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small

/obj/item/clothing/head/taqiyahred
	name = "красный арахчын"
	desc = "Внеочередной способ показать свою преданность Аллаху."
	icon_state = "taqiyahred"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small

/obj/item/clothing/head/shrine_wig
	name = "парик святой девы"
	desc = "Очищайтесь стильно!"
	flags_inv = HIDEHAIR //bald
	worn_icon = 'icons/mob/large-worn-icons/64x64/head.dmi'
	icon_state = "shrine_wig"
	inhand_icon_state = "shrine_wig"
	worn_x_dimension = 64
	worn_y_dimension = 64
	dynamic_hair_suffix = ""

/obj/item/clothing/head/intern
	name = "шляпа интерна"
	desc = "Ужасная смесь из шапочки и мягкого колпачка зеленого цвета ЦентКома. Вы должны быть в отчаянии от власти над своими сверстниками, чтобы согласиться носить это."
	icon_state = "intern_hat"
	inhand_icon_state = "intern_hat"

/obj/item/clothing/head/coordinator
	name = "coordinator cap"
	desc = "A cap for a party ooordinator, stylish!."
	icon_state = "capcap"
	inhand_icon_state = "that"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 25, "energy" = 35, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/head/jackbros
	name = "frosty hat"
	desc = "Hee-ho!"
	icon_state = "JackFrostHat"
	inhand_icon_state = "JackFrostHat"
