/datum/interaction/lewd/kiss
	command = "deepkiss"
	description = "Глубокий засос."
	require_user_mouth = 1
	write_log_user = "kissed"
	write_log_target = "was kissed by"
	interaction_sound = null
	max_distance = 1

/datum/interaction/lewd/kiss/post_interaction(var/mob/living/user, var/mob/living/target)
	. = ..()
	if(user.lust < 5)   user.lust = 5
	if(target.lust < 5) target.lust = 5

/datum/interaction/lewd/kiss/evaluate_user(var/mob/living/user, var/silent=1)
	if(..())
		return 1
	return 0

/datum/interaction/lewd/kiss/display_interaction(var/mob/living/user, var/mob/living/target)
	. = ..()
	if (user.lust >= 3)
		user.visible_message("<span class='warning'>[user] делает глубокий и продолжительный поцелуй с [target].</span>")
	else
		user.visible_message("<span class='warning'>[user] целует [target] по-французки.</span>")

/datum/interaction/lewd/assslap
	command = "assslap"
	description = "Шлёпнуть по заднице."
	simple_message = "USER шлёпает TARGET по заднице!"
	simple_style = "danger"
	interaction_sound = 'white/valtos/sounds/exrp/interactions/slap.ogg'
	needs_physical_contact = 1
	max_distance = 1
	write_log_user = "ass-slapped"
	write_log_target = "was ass-slapped by"
	whitelisted = FALSE

/datum/interaction/lewd/oral
	command = "suckvag"
	description = "Отполировать пельмешку."
	require_user_mouth = 1
	require_target_vagina = 1
	write_log_user = "gave head to"
	write_log_target = "was given head by"
	interaction_sound = null
	user_not_tired = 1
	require_target_naked = 1
	max_distance = 0
	write_log_user = "sucked"
	write_log_target = "was sucked by"

/datum/interaction/lewd/oral/display_interaction(var/mob/living/user, var/mob/living/target)
	. = ..()
	user.do_sex(target, "do_oral")

/datum/interaction/lewd/oral/blowjob
	command = "suckcock"
	description = "Отполировать огурец."
	require_target_vagina = 0
	require_target_penis = 1
	target_not_tired = 1
	write_log_user = "sucked"
	write_log_target = "was sucked by"

/datum/interaction/lewd/fuck
	command = "fuckvag"
	description = "Раскромсать вареник."
	require_user_penis = 1
	require_target_vagina = 1
	write_log_user = "fucked"
	write_log_target = "was fucked by"
	interaction_sound = null
	user_not_tired = 1
	require_user_naked = 1
	require_target_naked = 1
	max_distance = 0
	write_log_user = "fucked"
	write_log_target = "was fucked by"

/datum/interaction/lewd/fuck/display_interaction(var/mob/living/user, var/mob/living/target)
	. = ..()
	user.do_sex(target, "do_vaginal")

/datum/interaction/lewd/fuck/anal
	command = "fuckass"
	description = "Пробить шоколадницу."
	require_target_vagina = 0
	require_target_anus = 1
	user_not_tired = 1
	write_log_user = "ass-fucked"
	write_log_target = "was ass-fucked by"

/datum/interaction/lewd/fuck/anal/display_interaction(var/mob/living/user, var/mob/living/target)
	. = ..()
	user.do_sex(target, "do_anal")

/datum/interaction/lewd/finger
	command = "finger"
	description = "Засунуть сигарету в пепельницу."
	require_user_hands = 1
	require_target_vagina = 1
	interaction_sound = null
	user_not_tired = 1
	require_target_naked = 1
	max_distance = 0
	write_log_user = "fingered"
	write_log_target = "was fingered by"

/datum/interaction/lewd/finger/display_interaction(var/mob/living/user, var/mob/living/target)
	. = ..()
	user.do_sex(target, "do_fingering")

/datum/interaction/lewd/fingerass
	command = "fingerm"
	description = "Почесать шоколадный глаз."
	interaction_sound = null
	require_user_hands = 1
	require_target_anus = 1
	user_not_tired = 1
	require_target_naked = 1
	max_distance = 0
	write_log_user = "fingered"
	write_log_target = "was fingered by"

/datum/interaction/lewd/fingerass/display_interaction(var/mob/living/user, var/mob/living/target)
	. = ..()
	user.do_sex(target, "do_fingerass")


/datum/interaction/lewd/facefuck
	command = "facefuck"
	description = "Проверить глубину проруби."
	interaction_sound = null
	require_target_mouth = 1
	user_not_tired = 1
	require_user_naked = 1
	max_distance = 0
	write_log_user = "face-fucked"
	write_log_target = "was face-fucked by"

/datum/interaction/lewd/facefuck/display_interaction(var/mob/living/user, var/mob/living/target)
	. = ..()
	user.do_sex(target, "do_facefuck")

/datum/interaction/lewd/throatfuck
	command = "throatfuck"
	description = "Утопить муму в проруби."
	interaction_sound = null
	require_user_penis = 1
	require_target_mouth = 1
	user_not_tired = 1
	require_user_naked = 1
	max_distance = 0
	write_log_user = "throat-fucked"
	write_log_target = "was throat-fucked by"

/datum/interaction/lewd/throatfuck/display_interaction(var/mob/living/user, var/mob/living/target)
	. = ..()
	user.do_sex(target, "do_throatfuck")

/datum/interaction/lewd/handjob
	command = "handjob"
	description = "Полировать ствол."
	interaction_sound = null
	require_user_hands = 1
	require_target_penis = 1
	target_not_tired = 1
	require_target_naked = 1
	max_distance = 1
	write_log_user = "jerked-off"
	write_log_target = "was jerked-off by"

/datum/interaction/lewd/handjob/display_interaction(var/mob/living/user, var/mob/living/target)
	. = ..()
	user.do_sex(target, "do_handjob")

/datum/interaction/lewd/breastfuck
	command = "breastfuck"
	description = "Проскользить между двух горок."
	interaction_sound = null
	require_user_penis = 1
	user_not_tired = 1
	require_user_naked = 1
	require_target_naked = 1
	require_target_vagina = 1
	max_distance = 0
	write_log_user = "breast-fucked"
	write_log_target = "was breast-fucked by"

/datum/interaction/lewd/breastfuck/display_interaction(var/mob/living/user, var/mob/living/target)
	. = ..()
	user.do_sex(target, "do_breastfuck")

/datum/interaction/lewd/mount
	command = "mount"
	description = "Покататься на карусели."
	interaction_sound = null
	require_user_vagina = 1
	require_target_penis = 1
	user_not_tired = 1
	target_not_tired = 1
	require_user_naked = 1
	require_target_naked = 1
	max_distance = 0
	write_log_user = "rode"
	write_log_target = "was rode by"

/datum/interaction/lewd/mount/display_interaction(var/mob/living/user, var/mob/living/target)
	. = ..()
	user.do_sex(target, "do_mount")

/datum/interaction/lewd/mountass
	command = "mountm"
	description = "Присесть на выступ."
	interaction_sound = null
	require_user_vagina = 0
	require_user_anus = 1
	require_target_penis = 1
	user_not_tired = 1
	target_not_tired = 1
	require_user_naked = 1
	require_target_naked = 1
	max_distance = 0
	write_log_user = "rode"
	write_log_target = "was rode by"

/datum/interaction/lewd/mountass/display_interaction(var/mob/living/user, var/mob/living/target)
	. = ..()
	user.do_sex(target, "do_mountass")

/datum/interaction/lewd/rimjob
	command = "rimjob"
	description = "Скушать шоколад."
	interaction_sound = null
	require_user_mouth = 1
	require_target_anus = 1
	user_not_tired = 1
	require_target_naked = 1
	max_distance = 0
	write_log_user = "rimmed"
	write_log_target = "was rimmed by"

/datum/interaction/lewd/rimjob/display_interaction(var/mob/living/user, var/mob/living/target)
	. = ..()
	user.do_sex(target, "do_rimjob")

/datum/interaction/lewd/mountface
	command = "mountface"
	description = "Промариновать лимончик."
	interaction_sound = null
	require_target_mouth = 1
	require_user_anus = 1
	user_not_tired = 1
	require_user_naked = 1
	max_distance = 0
	write_log_user = "made-them-rim"
	write_log_target = "was made-to-rim by"

/datum/interaction/lewd/mountface/display_interaction(var/mob/living/user, var/mob/living/target)
	. = ..()
	user.do_sex(target, "do_mountface")

/datum/interaction/lewd/grindface
	command = "grindface"
	description = "Дать понюхать ноги."
	interaction_sound = null
	require_target_mouth = 1
	max_distance = 0
	write_log_user = "feet-faced"
	write_log_target = "had feet grinded against their face by"

/datum/interaction/lewd/grindface/display_interaction(var/mob/living/user, var/mob/living/target)
	. = ..()
	user.do_sex(target, "do_grindface")

/datum/interaction/lewd/grindmouth
	command = "grindmouth"
	description = "Угостить ногами."
	interaction_sound = null
	require_target_mouth = 1
	max_distance = 0
	write_log_user = "feet-mouthed"
	write_log_target = "had feet grinding against their tongue by"

/datum/interaction/lewd/grindmouth/display_interaction(var/mob/living/user, var/mob/living/target)
	. = ..()
	user.do_sex(target, "do_grindmouth")

/datum/interaction/lewd/nuts
	command = "nuts"
	description = "Накормить яишницей."
	interaction_sound = null
	require_user_naked = 1
	require_user_penis = 1
	require_target_mouth = 1
	max_distance = 0
	write_log_user = "make-them-suck-their-nuts"
	write_log_target = "was made to suck nuts by"

/datum/interaction/lewd/nuts/display_interaction(var/mob/living/user, var/mob/living/target)
	. = ..()
	user.do_sex(target, "do_nuts")

/datum/interaction/lewd/thighs
	command = "thighs"
	description = "Взять в захват ногами."
	interaction_sound = null
	max_distance = 0
	require_user_naked = 1
	require_target_mouth = 1
	write_log_user = "thigh-trapped"
	write_log_target = "was smothered by"

/datum/interaction/lewd/thighs/display_interaction(var/mob/living/user, var/mob/living/target)
	. = ..()
	user.do_sex(target, "do_thighs")
