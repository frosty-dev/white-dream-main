/proc/get_luhn(num)
	var/numtext = "[num]"
	var/numlen = length_char(numtext)
	var/parity = numlen % 2
	var/sum = 0
	for(var/i = numlen; i > 0; i--)
		var/digit = text2num(numtext[i])
		if(i % 2 == parity)
			digit *= 2
			if(digit > 9)
				digit -= 9
			sum += digit

	for(var/i = numlen; i > 0; i--)
		var/digit = text2num(numtext[i])
		if(i % 2 != parity)
			sum += digit

	if((((sum % 10) - 10) * -1) == 10)
		return "[num]0"
	else
		return "[num][(((sum % 10) - 10) * -1)]"

/proc/check_luhn(num)
	var/numtext = "[num]"
	var/numlen = length_char(numtext)
	var/sum = 0
	for(var/i in 1 to numlen)
		var/digit = text2num(numtext[i])
		if(i % 2 != 0)
			digit *= 2
			if(digit > 9)
				digit -= 9
		sum += digit
	return sum % 10 == 0
