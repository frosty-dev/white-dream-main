/client/proc/ToggleFullscreen()
    if(prefs.fullscreen)
        winset(src, "mainwindow", "is-maximized=false;can-resize=false;titlebar=false;menu=\"\"")
        winset(src, "mainwindow", "is-maximized=true")
    else
        winset(src, "mainwindow", "is-maximized=false;can-resize=true;titlebar=true;menu=menu")
        winset(src, "mainwindow", "is-maximized=true")
    addtimer(CALLBACK(src,.verb/fit_viewport,10))

/datum/keybinding/client/widecreen_toggle
	hotkey_keys = list("CtrlF11")
	name = "widecreen_toggle"
	full_name = "Widescreen"
	description = "Делает экран широким (19x15), либо узким (15x15)."

/datum/keybinding/client/widecreen_toggle/down(client/user)
	user.prefs.widescreenpref = !user.prefs.widescreenpref
	user.view_size.setDefault(getScreenSize(user.prefs.widescreenpref))
	return TRUE

/datum/keybinding/client/fullscreen_toggle
	hotkey_keys = list("F11")
	name = "fullscreen_toggle"
	full_name = "Fullscreen"
	description = "Разворачивает игру на весь экран, либо сворачивает обратно в нормальное положение."

/datum/keybinding/client/fullscreen_toggle/down(client/user)
	user.prefs.fullscreen = !user.prefs.fullscreen
	user.ToggleFullscreen()
	return TRUE
