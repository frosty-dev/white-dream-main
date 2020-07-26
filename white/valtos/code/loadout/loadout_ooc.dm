/datum/gear/ooc/char_slot
	display_name = "Ещё один слот персонажа"
	sort_category = "OOC"
	description = "Дополнительный слот. Что тут ещё сказать, а? Максимум 20 слотов."
	cost = 50

/datum/gear/ooc/char_slot/purchase(var/client/C)
	C?.prefs?.max_slots += 1
	C?.prefs?.save_preferences()
