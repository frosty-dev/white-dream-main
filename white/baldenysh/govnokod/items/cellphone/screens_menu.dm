/datum/phonescreen/menu
	var/list/options
	var/ptr_i = 1

/datum/phonescreen/menu/proc/regen_options()
	options = list()

/datum/phonescreen/menu/proc/select_act(selection)

/datum/phonescreen/menu/screen_data()
	var/list/data = list()
	data["ptr_i"] = ptr_i
	regen_options()
	data["options"] = options
	return data

/datum/phonescreen/menu/dpad_act(button)
	switch(button)
		if("uarrow")
			ptr_i--
			if(ptr_i<1)
				ptr_i = options.len
		if("darrow")
			ptr_i++
			if(ptr_i>options.len)
				ptr_i = 1
		if("larrow")
			return
		if("rarrow")
			return
		if("enter")
			select_act(options[ptr_i])

///////////////////////////////////////////////

/datum/phonescreen/menu/matrix
	var/ptr_j = 1

/datum/phonescreen/menu/matrix/regen_options()
	options = list(list())

/datum/phonescreen/menu/matrix/screen_data()
	var/list/data = list()
	data["ptr_i"] = ptr_i
	data["ptr_j"] = ptr_j
	regen_options()
	data["options"] = options
	return data

/datum/phonescreen/menu/matrix/dpad_act(button)
	switch(button)
		if("larrow")
			ptr_i--
			if(ptr_i<1)
				ptr_i = options.len
			var/list/SL = options[ptr_i]
			if(ptr_j>SL.len)
				ptr_j = SL.len
		if("rarrow")
			ptr_i++
			if(ptr_i>options.len)
				ptr_i = 1
			var/list/SL = options[ptr_i]
			if(ptr_j>SL.len)
				ptr_j = SL.len
		if("uarrow")
			ptr_j--
			var/list/SL = options[ptr_i]
			if(ptr_j<1)
				ptr_j = SL.len
		if("darrow")
			ptr_j++
			var/list/SL = options[ptr_i]
			if(ptr_j>SL.len)
				ptr_j = 1
		if("enter")
			select_act(options[ptr_i][ptr_j])
