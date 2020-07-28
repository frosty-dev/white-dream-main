/datum/usage_info
	var/list/song_channels
	var/list/datum/musical_event/event_manager_events

/datum/usage_info/New(atom/source, datum/sound_player/player)
	src.song_channels = player.song.free_channels
	src.event_manager_events = player.event_manager.events
	src.track_usage()

/datum/usage_info/ui_interact(mob/user, ui_key = "usage_info", datum/tgui/ui = null, force_open = FALSE, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.default_state)
	var/global/list/data = list()
	data.Cut()
	data["channels_left"] = src.song_channels.len
	data["events_active"] = src.event_manager_events.len
	data["max_channels"] = GLOB.musical_config.channels_per_instrument
	data["max_events"] = GLOB.musical_config.max_events

	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "song_usage_info", "Usage info", 500, 150, master_ui, state)
		//ui.push_data(data)
		ui.open()

/datum/usage_info/proc/track_usage()
	var/cur_channels = src.song_channels.len
	var/cur_events = src.event_manager_events.len
	spawn while (src && src.song_channels && src.event_manager_events)
		var/new_channel_len = round(src.song_channels.len / GLOB.musical_config.usage_info_channel_resolution)
		var/new_event_len = round(src.event_manager_events.len / GLOB.musical_config.usage_info_event_resolution)
		if (cur_channels != new_channel_len || cur_events != new_event_len)
			SStgui.update_uis(src)
			cur_channels = src.song_channels.len
			cur_events = src.event_manager_events.len
		sleep(2*world.tick_lag) // Every two ticks
