/datum/game_mode/teaparty
	name = "tea party"
	config_tag = "teaparty"
	report_type = "teaparty"
	false_report_weight = 0
	required_players = 0

	announce_span = "notice"
	announce_text = "Just have fun and enjoy the game!"

/datum/game_mode/teaparty/pre_setup()
	return 1

/datum/game_mode/teaparty/post_setup()
	..()
	CONFIG_SET(flag/allow_random_events, FALSE)

/datum/game_mode/teaparty/generate_report()
	return "В передаче в основном не упоминается ваш сектор. У вас чайная смена."

/datum/game_mode/teaparty/generate_station_goals()
	for(var/T in subtypesof(/datum/station_goal))
		var/datum/station_goal/G = new T
		station_goals += G
		G.on_report()

/datum/game_mode/teaparty/send_intercept(report = 0)
	priority_announce("Благодаря неустанным усилиям наших подразделений безопасности и разведки, в настоящее время нет никаких реальных угроз для [station_name()]. Все проекты строительства на станции были утверждены. Чайной смены!", "Отчёт отдела безопасности", 'sound/ai/announcer/alert.ogg')
