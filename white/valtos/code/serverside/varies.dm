// возвращает вариативную приставку или ничего
/proc/gvorno(capitalize = FALSE, chance = 100)
	if(!prob(chance))
		return
	var/to_ret = pick("невероятно", "удивительно", "немыслимо", "красиво", "наверняка", "скорее всего", "превосходно", "иронично", "прикольно")

	if(capitalize)
		return capitalize(to_ret)
	else
		return to_ret

/proc/get_num_string(amount, type = "cr")
	amount = text2num(copytext("[amount]", -2))
	if(amount >= 20)
		amount = text2num(copytext("[amount]", -1))
	switch(type)
		if("cr")
			switch(amount)
				if(0, 5 to 20)
					return "ов"
				if(1)
					return ""
				if(2 to 4)
					return "а"
