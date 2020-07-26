/datum/env_editor
	var/datum/sound_player/player

/datum/env_editor/New(datum/sound_player/player)
	src.player = player

/datum/env_editor/ui_data(mob/user)
	var/list/list/data = list()
	data["env_params"] = list()
	for (var/i=1 to 23)
		var/list/env_data = list()
		env_data["index"] = i
		env_data["name"] = GLOB.musical_config.env_param_names[i]
		env_data["value"] = src.player.env[i]
		env_data["real"] = GLOB.musical_config.env_params_bounds[i][3]
		data["env_params"] += list(env_data)
	return data

/datum/env_editor/ui_interact(mob/user, ui_key = "env_editor", datum/tgui/ui = null, force_open = FALSE, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.conscious_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "env_editor", "Environment Editor", 400, 500, master_ui, state)
		ui.open()

/datum/env_editor/ui_act(action, params)
	if (!GLOB.musical_config.env_settings_available)
		return 0

	if (..())
		return

	var/index = text2num(params["index"])
	if (params["index"] && !(index in 1 to 23))
		to_chat(usr, "Wrong index was provided: [index]")
		return 0

	var/name = GLOB.musical_config.env_param_names[index]
	var/desc = GLOB.musical_config.env_param_desc[index]
	var/default = GLOB.musical_config.env_default[index]
	var/list/bounds = GLOB.musical_config.env_params_bounds[index]
	var/bound_min = bounds[1]
	var/bound_max = bounds[2]
	var/reals_allowed = bounds[3]

	switch (action)
		if ("set")
			var/new_value = min(max(input(usr, "[name]: [bound_min] - [bound_max]") as num, bound_min), bound_max)
			if (!isnum(new_value))
				return
			new_value = reals_allowed ? new_value : round(new_value)
			src.player.env[index] = new_value
		if ("reset")
			src.player.env[index] = default
		if ("reset_all")
			src.player.env = GLOB.musical_config.env_default.Copy()
		if ("desc")
			to_chat(usr, "[name]: from [bound_min] to [bound_max] (default: [default])<br>[desc]")

	return 1
