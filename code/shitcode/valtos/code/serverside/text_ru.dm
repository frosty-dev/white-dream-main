// Для 513 в самый раз
// Люммокс пидорас

GLOBAL_LIST_INIT(rus_unicode_conversion_hex,list(
	"А" = "0410", "а" = "0430",
	"Б" = "0411", "б" = "0431",
	"В" = "0412", "в" = "0432",
	"Г" = "0413", "г" = "0433",
	"Д" = "0414", "д" = "0434",
	"Е" = "0415", "е" = "0435",
	"Ж" = "0416", "ж" = "0436",
	"З" = "0417", "з" = "0437",
	"И" = "0418", "и" = "0438",
	"Й" = "0419", "й" = "0439",
	"К" = "041a", "к" = "043a",
	"Л" = "041b", "л" = "043b",
	"М" = "041c", "м" = "043c",
	"Н" = "041d", "н" = "043d",
	"О" = "041e", "о" = "043e",
	"П" = "041f", "п" = "043f",
	"Р" = "0420", "р" = "0440",
	"С" = "0421", "с" = "0441",
	"Т" = "0422", "т" = "0442",
	"У" = "0423", "у" = "0443",
	"Ф" = "0424", "ф" = "0444",
	"Х" = "0425", "х" = "0445",
	"Ц" = "0426", "ц" = "0446",
	"Ч" = "0427", "ч" = "0447",
	"Ш" = "0428", "ш" = "0448",
	"Щ" = "0429", "щ" = "0449",
	"Ъ" = "042a", "ъ" = "044a",
	"Ы" = "042b", "ы" = "044b",
	"Ь" = "042c", "ь" = "044c",
	"Э" = "042d", "э" = "044d",
	"Ю" = "042e", "ю" = "044e",
	"Я" = "042f", "я" = "044f",

	"Ё" = "0401", "ё" = "0451"
	))

/proc/cp1252_to_utf8(text) //Временный прок. Транслирует не всё, но оно и не нужно
	var/t = ""
	for(var/i = 1, i <= length(text), i++)
		var/a = text2ascii(text, i)
		if (a < 224 || a > 255)
			t += ascii2text(a)
			continue
		t += ascii2text(a + 848)
	return t

/proc/r_lowertext(text)
	var/t = ""
	for(var/i = 1, i <= length(text), i++)
		var/a = text2ascii(text, i)
		if (a == 1105 || a == 1025)
			t += ascii2text(1105)
			continue
		if (a < 1040 || a > 1071)
			t += ascii2text(a)
			continue
		t += ascii2text(a + 32)
	return lowertext(t)

/proc/r_uppertext(text)
	var/t = ""
	for(var/i = 1, i <= length(text), i++)
		var/a = text2ascii(text, i)
		if (a == 1105 || a == 1025)
			t += ascii2text(1025)
			continue
		if (a < 1072 || a > 1105)
			t += ascii2text(a)
			continue
		t += ascii2text(a - 32)
	return uppertext(t)

/proc/pointization(text)
	if (!text)
		return
#if DM_VERSION >= 513 && DM_BUILD >= 1493
	if (copytext_char(text,1,2) == "*") //Emotes allowed.
		return text
	if (copytext_char(text,-1) in list("!", "?", "."))
		return text
#endif
	text += "."
	return text

/proc/r_capitalize(t as text)
    var/first = ascii2text(text2ascii(t))
    return r_uppertext(first) + copytext(t, length(first) + 1)

/proc/r_antidaunize(t as text)
    var/first = ascii2text(text2ascii(t))
    return r_lowertext(first) + copytext(t, length(first) + 1)

/proc/r_json_decode(text) //now I'm stupid
	for(var/s in GLOB.rus_unicode_conversion_hex)
		text = replacetext(text, "\\u[GLOB.rus_unicode_conversion_hex[s]]", s)
	return json_decode(text)

/proc/ru_comms(freq)
	if(freq == "Common")
		return "Основной"
	else if (freq == "Security")
		return "Секьюрити"
	else if (freq == "Engineering")
		return "Инженерия"
	else if (freq == "Command")
		return "Командование"
	else if (freq == "Science")
		return "Научный"
	else if (freq == "Medical")
		return "Медбей"
	else if (freq == "Supply")
		return "Карго"
	else if (freq == "Service")
		return "Обслуживание"
	else if (freq == "AI Private")
		return "Приватный ИИ"
	else if (freq == "Syndicate")
		return "Синдикат"
	else if (freq == "CentCom")
		return "ЦентКом"
	else if (freq == "Red Team")
		return "Советы"
	else if (freq == "Blue Team")
		return "Нацисты"
	else
		return freq

/proc/r_stutter(text) //ненавижу пиндосов
	var/list/soglasnie = list(	"б","в","г","д","ж","з","к","л","м","н","п","р","с","т","ф","х","ц","ч","ш","щ",
								"Б","В","Г","Д","Ж","З","К","Л","М","Н","П","Р","С","Т","Ф","Х","Ц","Ч","Ш","Щ",
								"b","c","d","f","g","h","j","k","l","m","n","p","q","r","s","t","v","w","x","y","z",
								"B","C","D","F","G","H","J","K","L","M","N","P","Q","R","S","T","V","W","X","Y","Z")
	var/t = ""
	for(var/i = 1, i <= length(text), i++)
		var/a = text2ascii(text, i)
		if (prob(80) && (ascii2text(a) in soglasnie))
			if (prob(10))
				t += text("[ascii2text(a)]-[ascii2text(a)]-[ascii2text(a)]-[ascii2text(a)]")
			else
				if (prob(20))
					t += text("[ascii2text(a)]-[ascii2text(a)]-[ascii2text(a)]")
				else
					if (prob(5))
						t += ""
					else
						t += text("[ascii2text(a)]-[ascii2text(a)]")
		t += ascii2text(a)
#if DM_VERSION >= 513 && DM_BUILD >= 1493
	return copytext_char(sanitize(t),1,MAX_MESSAGE_LEN * length(ascii2text(text2ascii(t))))
#endif
