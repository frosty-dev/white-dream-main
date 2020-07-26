////////////////////////////////////////////////////////////////////////////////
//
//
// Этот код написан демонами в подвале и куском валтоса.
// Если собираетесь копипастить это, то рекомендуется ничего здесь не трогать или оно сломается нахуй.
// Я предупредил.
//
//
////////////////////////////////////////////////////////////////////////////////

/*
/client/verb/fuck()
	set name = "memes"
	set category = "Особенное"
	var/pizdos = input("")
	if(pizdos)
		world << "Начальное слово: [pizdos]"

		world << "Ж. Родительный: [sklonenie(pizdos, RODITELNI, 	"female")]"
		world << "Ж. Дательный: [sklonenie(pizdos, DATELNI, 		"female")]"
		world << "Ж. Винительный: [sklonenie(pizdos, VINITELNI, 	"female")]"
		world << "Ж. Творительный: [sklonenie(pizdos, TVORITELNI, 	"female")]"
		world << "Ж. Предложный: [sklonenie(pizdos, PREDLOZHNI, 	"female")]"

		world << "М. Родительный: [sklonenie(pizdos, RODITELNI, 	"male")]"
		world << "М. Дательный: [sklonenie(pizdos, DATELNI, 		"male")]"
		world << "М. Винительный: [sklonenie(pizdos, VINITELNI, 	"male")]"
		world << "М. Творительный: [sklonenie(pizdos, TVORITELNI, 	"male")]"
		world << "М. Предложный: [sklonenie(pizdos, PREDLOZHNI, 	"male")]"

		world << "С. Родительный: [sklonenie(pizdos, RODITELNI)]"
		world << "С. Дательный: [sklonenie(pizdos, DATELNI)]"
		world << "С. Винительный: [sklonenie(pizdos, VINITELNI)]"
		world << "С. Творительный: [sklonenie(pizdos, TVORITELNI)]"
		world << "С. Предложный: [sklonenie(pizdos, PREDLOZHNI)]"
*/

/proc/sklonenie_item_tvor(msgfrom)
	if(length(msgfrom) <= 2)
		return msgfrom
	var/word_end = copytext_char(msgfrom, -2)
	if(word_end == "ёт" || word_end == "ет")
		return replacetext_char(msgfrom, copytext_char(word_end, -2), "ю ", -2)
	else if (word_end == "бит")
		return replacetext_char(msgfrom, copytext_char(word_end, -3), "блю", -2)
	else if (word_end == "нит")
		return replacetext_char(msgfrom, copytext_char(word_end, -3), "ню", -2)
	else if (word_end == "рю")
		return replacetext_char(msgfrom, copytext_char(word_end, -2), "ню", -2)
	return msgfrom

/proc/sklonenie(msgfrom, rule, gender = null)
	var/to_ret = ""
	for(var/word in splittext_char(msgfrom, " "))
		to_ret += " [sklonenie_do(word, rule, gender)]"
	return to_ret

/proc/sklonenie_do(msgfrom, rule, gender = null)
	if(length(msgfrom) <= 2)
		return msgfrom
	var/list/femaleOneStop = list("б","в","г","д","ж","з","й","к","л","м","н","п","р","с","т","ф","х","ц","ч","ш","щ","ъ","ь")
	var/list/OneStop = list("о","е","ё","э","и","ы","у","ю")
	var/list/TwoStop = list("ия","иа","аа","оа","уа","ыа","еа","юа","эа","их","ых")

	var/list/femaleOneFrom = list("ь") // -1 but, VINITELNI and TVORITELNI are 0
	var/list/femaleOneTo = list("и","и","ь","ю","и")

	var/list/maleOneFrom = list("ь") // -1
	var/list/maleOneTo = list("я","ю","я","ем","е")

	var/list/femaleTwoFrom = list("ая","на")
	var/list/femaleTwoTo = list("ой","ой","ую","ой","ой", // -2
								"ой","ой","у","ой","ой") // -1

	var/list/femaleThreeFrom = list("ска","цка") // -1
	var/list/femaleThreeTo = list("ой","ой","ую","ой","ой")

	var/list/OneFrom = list("а","ь","я","й") // -1
	var/list/OneTo = list("ы","е","у","ой","е",
						  "я","ю","я","ем","е",
						  "и","у","ю","ей","е",
						  "я","ю","я","ем","е")

	var/list/OneListFrom = list("ц","ч","ш","щ") // 0
	var/list/OneListTo = list("а","у","а","ем","е")

	var/list/OneListOtherFrom = list("б","в","г","д","ж","з","к","л","м","н","п","р","с","т","ф","х","ц","ч") // 0
	var/list/OneListOtherTo = list("а","у","а","ом","е")

	var/list/OneListTooFrom = list("в","н") // 0
	var/list/OneListTooTo = list("а","у","а","ым","е")

	var/list/TwoFrom = list("ич","ша","ия","ей","ий","на","уй","ца","ай","ой","ок","ец") //supreme shenanigans
	var/list/TwoTo = list("а", "у", "а", "ем", "е", // 0   0
						  "и", "е", "у", "ей", "е", // -1  1
						  "и", "и", "ю", "ей", "и", // -1  2
						  "я", "ю", "я", "ем", "е", // -1  3
						  "я", "ю", "я", "ем", "и", // -1  4
						  "ы", "е", "у", "ой", "е", // -1  5
						  "я", "ю", "я", "ем", "е", // -1  6
						  "ы", "е", "у", "её", "е", // -1  7
						  "я", "ю", "я", "ем", "е", // -1  8
						  "го","му","го","ым", "м", // -1  9
						  "ка","ку","ка","ком","ке", // -2 10
						  "ца","цу","ца","цом","це") // -2 11

	var/list/TwoListFrom = list("га","ка","ха","ча","ща","жа") // -1
	var/list/TwoListTo = list("и","е","у","ой","е")

	var/list/TwoListOtherFrom = list("ян","ан","йн","ах","ив") // 0
	var/list/TwoListOtherTo = list("а","у","а","ом","е")

	var/list/ThreeFrom = list("рих") // 0
	var/list/ThreeTo =  list("а","у","а","ом","е")

	var/list/ThreeListFrom = list("ова","ева") // -1
	var/list/ThreeListTo = list("ой","ой","у","ой","ой")

	var/list/ThreeListOtherFrom = list("гой","кой") // -1 but -2 at TVORITELNI
	var/list/ThreeListOtherTo = list("го","му","го","им","м")

	var/list/ThreeListTooFrom = list("ший","щий","жий","ний") // -2 but -1 at TVORITELNI
	var/list/ThreeListTooTo = list("его","ему","его","м","ем")

	// OtherListFrom = list("кий", "ый")
	var/list/OtherListTo = list("ого","ому","ого","м","ом") // -2 but -1 at TVORITELNI

	var/list/FourFrom = list("ская") // -2
	var/list/FourTo = list("ой","ой","ую","ой","ой")

	var/list/FourOtherFrom = list("иной") // -1
	var/list/FourOtherTo = list("я","ю","я","ем","е")

	var/list/FourListFrom = list("ынец","обец") // -2
	var/list/FourListTo = list("ца","цу","ца","цем","це")

	var/list/FourListOtherFrom = list("онец","овец") // -2
	var/list/FourListOtherTo = list("ца","цу","ца","цом","це")

	var/word_end = ""
	var/i = 0

	//берём последние 2 буквы
	word_end = copytext_char(msgfrom, -2)

	for(var/end in TwoStop)
		if(end == word_end)
			return msgfrom

	//берём последнюю букву
	word_end = copytext_char(msgfrom, -1)

	for(var/end in OneStop)
		if(end == word_end)
			return msgfrom

	if(gender == "male")
		for(var/end in maleOneFrom)
			if(end == word_end)
				return replacetext_char(msgfrom, copytext_char(end, -1), maleOneTo[rule], -1)

	if(gender == "female")
		//берём последние 3 буквы
		word_end = copytext_char(msgfrom, -3)

		for(var/end in femaleThreeFrom)
			if(end == word_end)
				return replacetext_char(msgfrom, copytext_char(end, -1), femaleThreeTo[rule], -3)

		//берём последние 2 буквы
		word_end = copytext_char(msgfrom, -2)

		for(var/end in femaleTwoFrom)
			if(end == word_end)
				if(i == 0)
					return replacetext_char(msgfrom, copytext_char(end, -2), femaleTwoTo[rule], -2)
				else
					return replacetext_char(msgfrom, copytext_char(end, -1), femaleTwoTo[rule + 5], -2)
			i++

		for(var/end in femaleOneFrom)
			if(end == word_end)
				if(rule == VINITELNI || rule == TVORITELNI)
					return "[msgfrom][femaleOneTo[rule]]"
				return replacetext_char(msgfrom, copytext_char(end, -1), femaleOneTo[rule], -1)

		for(var/end in femaleOneStop)
			if(end == word_end)
				return msgfrom

	//берём последние 4 буквы
	word_end = copytext_char(msgfrom, -4)

	for(var/end in FourFrom)
		if(end == word_end)
			return replacetext_char(msgfrom, copytext_char(end, -2), FourTo[rule], -4)

	for(var/end in FourOtherFrom)
		if(end == word_end)
			return replacetext_char(msgfrom, copytext_char(end, -1), FourOtherTo[rule], -4)

	for(var/end in FourListFrom)
		if(end == word_end)
			return replacetext_char(msgfrom, copytext_char(end, -2), FourListTo[rule], -4)

	for(var/end in FourListOtherFrom)
		if(end == word_end)
			return replacetext_char(msgfrom, copytext_char(end, -2), FourListOtherTo[rule], -4)

	//берём последние 3 буквы
	word_end = copytext_char(msgfrom, -3)

	for(var/end in ThreeFrom)
		if(end == word_end)
			return "[msgfrom][ThreeTo[rule]]"

	for(var/end in ThreeListFrom)
		if(end == word_end)
			return replacetext_char(msgfrom, copytext_char(end, -1), ThreeListTo[rule], -3)

	for(var/end in ThreeListOtherFrom)
		if(end == word_end)
			if(rule == TVORITELNI)
				return replacetext_char(msgfrom, copytext_char(end, -2), ThreeListOtherTo[rule], -3)
			return replacetext_char(msgfrom, copytext_char(end, -1), ThreeListOtherTo[rule], -3)

	for(var/end in ThreeListTooFrom)
		if(end == word_end)
			if(rule == TVORITELNI)
				return replacetext_char(msgfrom, copytext_char(end, -1), ThreeListTooTo[rule], -3)
			return replacetext_char(msgfrom, copytext_char(end, -2), ThreeListTooTo[rule], -3)

	if("кий" == word_end)
		if(rule == TVORITELNI)
			return replacetext_char(msgfrom, copytext_char("кий", -1), OtherListTo[rule], -3)
		return replacetext_char(msgfrom, copytext_char("кий", -2), OtherListTo[rule], -3)

	//берём последние 2 буквы
	word_end = copytext_char(msgfrom, -2)

	i = 0
	for(var/end in TwoFrom)
		if(end == word_end)
			if(i == 0)
				return "[msgfrom][TwoTo[rule]]"
			if(i <= 9)
				return replacetext_char(msgfrom, copytext_char(end, -1), TwoTo[rule + (5 * i)], -2)
			else
				return replacetext_char(msgfrom, copytext_char(end, -2), TwoTo[rule + (5 * i)], -2)
		i++

	for(var/end in TwoListFrom)
		if(end == word_end)
			return replacetext_char(msgfrom, copytext_char(end, -1), TwoListTo[rule], -2)

	for(var/end in TwoListOtherFrom)
		if(end == word_end)
			return "[msgfrom][TwoListOtherTo[rule]]"

	if("ый" == word_end)
		if(rule == TVORITELNI)
			return replacetext_char(msgfrom, copytext_char("ый", -1), OtherListTo[rule], -2)
		return replacetext_char(msgfrom, copytext_char("ый", -2), OtherListTo[rule], -2)

	//берём последюю букву
	word_end = copytext_char(msgfrom, -1)

	i = 0
	for(var/end in OneFrom)
		if(end == word_end)
			return replacetext_char(msgfrom, copytext_char(end, -1), OneTo[rule + (5 * i)], -1)
		i++

	for(var/end in OneListFrom)
		if(end == word_end)
			return "[msgfrom][OneListTo[rule]]"

	for(var/end in OneListOtherFrom)
		if(end == word_end)
			return "[msgfrom][OneListOtherTo[rule]]"

	for(var/end in OneListTooFrom)
		if(end == word_end)
			return "[msgfrom][OneListTooTo[rule]]"

	return msgfrom // возвращаем слово, если оно чудом не нашло своего конца
