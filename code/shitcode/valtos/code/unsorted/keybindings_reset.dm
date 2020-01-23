/client/verb/reset_hotkeys_please()
	set name = " ❗ Починить управление"
	set category = "ОСОБЕННОЕ"
	set desc = "Даёт возможность выбрать какое управление ты больше предпочитаешь. Также чинит \"нерабочие\" хоткеи."

	var/choice = tgalert(usr, "Would you prefer 'hotkey' or 'classic' defaults?", "Setup keybindings", "Hotkey", "Classic", "Cancel")
	if(choice == "Cancel")
		return
	prefs.hotkeys = (choice == "Hotkey")
	prefs.key_bindings = (prefs.hotkeys) ? deepCopyList(GLOB.hotkey_keybinding_list_by_key) : deepCopyList(GLOB.classic_keybinding_list_by_key)
	update_movement_keys()

	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Resetted Keys")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
