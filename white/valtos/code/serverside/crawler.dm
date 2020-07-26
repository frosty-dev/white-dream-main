/client/proc/ask_crawler_for_support()
	var/http[] = world.Export("http://nossl.crawler.station13.ru/api/?ckey=[ckey]")

	if(http)
		return json_decode(file2text(http["CONTENT"]))
	else
		return list("tauceti" = "N/A", "infinity" = "N/A", "onyx" = "N/A", "wycc" = "N/A", "bypass" = "N/A")

/client/proc/crawler_sanity_check()
	if(!ckey)
		return

	var/list/cril = ask_crawler_for_support()

	if(!cril)
		return TRUE

	if((text2num(cril["tauceti"]) > 180 || text2num(cril["infinity"]) > 180 || text2num(cril["onyx"]) > 180 || text2num(cril["wycc"]) > 180) && text2num(cril["bypass"]) == 0)
		message_admins("[key_name(src)] потенциальный педофил. Держать банхаммер на готове.")
		spawn(10)
			to_chat(src, "<span class='userdanger'>Тебе здесь не рады. Подробнее: <a href='https://crawler.station13.ru/?ckey=[ckey]'>https://crawler.station13.ru/?ckey=[ckey]</a></span>")
		return FALSE

	return TRUE
