/datum/song_editor
	var/datum/synthesized_song/song
	var/show_help = 0
	var/page = 1

/datum/song_editor/New(atom/source, datum/synthesized_song/song)
	src.song = song

/proc/Ceiling(x)
	return -round(-x)

/datum/song_editor/proc/pages()
	return Ceiling(src.song.lines.len / GLOB.musical_config.song_editor_lines_per_page)

/datum/song_editor/proc/current_page()
	return src.song.current_line > 0 ? Ceiling(src.song.current_line / GLOB.musical_config.song_editor_lines_per_page) : src.page

/datum/song_editor/proc/page_bounds(page_num)
	return list(
		max(1 + GLOB.musical_config.song_editor_lines_per_page * (page_num-1), 1),
		min(GLOB.musical_config.song_editor_lines_per_page * page_num, src.song.lines.len))

/datum/song_editor/ui_data(mob/user)
	var/list/data = list()

	var/current_page = src.current_page()
	var/list/line_bounds = src.page_bounds(src.current_page())

	data["lines"] = src.song.lines.Copy(line_bounds[1], line_bounds[2]+1)
	data["active_line"] = src.song.current_line
	data["max_lines"] = GLOB.musical_config.max_lines
	data["max_line_length"] = GLOB.musical_config.max_line_length
	data["tick_lag"] = world.tick_lag
	data["show_help"] = src.show_help
	data["page_num"] = current_page
	data["page_offset"] = GLOB.musical_config.song_editor_lines_per_page * (current_page-1)

	return data

/datum/song_editor/ui_interact(mob/user, ui_key = "song_editor", datum/tgui/ui = null, force_open = FALSE, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.conscious_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "song_editor", "Song Editor", 550, 600, master_ui, state)
		ui.open()

/datum/song_editor/ui_act(action, params)
	if(..())
		return

	var/value = text2num(params["value"])
	if (params["value"] && !isnum(value))
		to_chat(usr, "Non-numeric value was supplied")
		return 0

	switch (action)
		if("newline")
			var/newline = html_encode(input(usr, "Enter your line: ") as text|null)
			if(!newline)
				return
			if(src.song.lines.len > GLOB.musical_config.max_lines)
				return
			if(length(newline) > GLOB.musical_config.max_line_length)
				newline = copytext(newline, 1, GLOB.musical_config.max_line_length)
			src.song.lines.Add(newline)

		if("deleteline")
			// This could kill the server if the synthesizer was playing, props to BeTePb
			// Impossible to do now. Dumbing down this section.
			var/num = round(value)
			if(num > src.song.lines.len || num < 1)
				return
			src.song.lines.Cut(num, num+1)

		if("modifyline")
			var/num = round(value)
			if(num > src.song.lines.len || num < 1)
				return
			var/content = html_encode(input(usr, "Enter your line: ", "Edit line", src.song.lines[num]) as text|null)
			if(!content)
				return
			if(length(content) > GLOB.musical_config.max_line_length)
				content = copytext(content, 1, GLOB.musical_config.max_line_length)
			src.song.lines[num] = content

		if ("help")
			src.show_help = value

		if ("next_page")
			src.page = max(min(src.page + 1, src.pages()), 1)

		if ("prev_page")
			src.page = max(min(src.page - 1, src.pages()), 1)

		if ("last_page")
			src.page = src.pages()
		if ("first_page")
			src.page = 1

	return 1
