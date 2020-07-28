/datum/job/hacker
	title = "Hacker"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	department_head = list("Research Director")
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "научному руководителю"
	selection_color = "#00eeff"
	exp_requirements = 30000
	exp_type = EXP_TYPE_CREW
	display_order = JOB_DISPLAY_ORDER_SCIENTIST

	outfit = /datum/outfit/job/hacker

	mind_traits = list(TRAIT_HACKER)

/datum/job/hacker/get_access()
	return get_all_accesses()

/datum/atom_hud/hacker
	hud_icons = list(HACKER_HUD)

/*
/mob/living/Initialize()
	. = ..()
	if(!src)
		return
	var/datum/atom_hud/hacker/hhud = GLOB.huds[DATA_HUD_HACKER]
	hhud.add_to_hud(src)
	hud_list[HACKER_HUD].icon = image('white/valtos/icons/dz-031.dmi', src)
	hud_list[HACKER_HUD].icon_state = "node"
*/

/mob/living/simple_animal/hostile/Initialize()
	. = ..()
	hud_list[HACKER_HUD].add_overlay("node_enemy")

/obj/item/gun/examine(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(HAS_TRAIT(H, TRAIT_HACKER))
			prepare_huds()
			var/datum/atom_hud/hacker/hhud = GLOB.huds[DATA_HUD_HACKER]
			hhud.add_to_hud(src)
			hud_list[HACKER_HUD].icon = image('white/valtos/icons/dz-031.dmi', src)
			hud_list[HACKER_HUD].icon_state = "node_weapon"

/datum/job/hacker/after_spawn(mob/living/carbon/human/H, mob/M)
	ADD_TRAIT(H, TRAIT_HACKER, JOB_TRAIT)
	ADD_TRAIT(H, TRAIT_PACIFISM, JOB_TRAIT)
	H.add_client_colour(/datum/client_colour/hacker)
	H.hud_list[HACKER_HUD].icon = null
	//H.alpha = 75
	//H.verbs += /mob/living/carbon/proc/hackers_immortality
	//M.AddSpell(/obj/effect/proc_holder/spell/self/hacker_heal)
	//M.AddSpell(/obj/effect/proc_holder/spell/targeted/remove_retard)
	M.client << 'white/valtos/sounds/hacker_hello.ogg'
	spawn(50)
		H.hud_used.update_parallax_pref(H, TRUE)

/datum/client_colour/hacker
	colour = list(rgb(255,15,15), rgb(0,255,25), rgb(0,0,255), rgb(0,0,0))
	priority = 6

/obj/item/clothing/glasses/hud/wzzzz/hacker_rig/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	var/mob/living/carbon/human/user = src.loc
	to_chat(user, "<span class='danger'>E:FATAL:RAM_READ_FAIL\nE:FATAL:STACK_EMPTY\nE:FATAL:READ_NULL_POINT\nE:FATAL:PWR_BUS_OVERLOAD</span>")
	SEND_SOUND(user, sound('sound/ai/hacker/emp.ogg'))

/obj/item/clothing/glasses/hud/wzzzz/hacker_rig/equipped(mob/living/carbon/human/H, slot)
	. = ..()
	spawn(10)
		if(!HAS_TRAIT(H, TRAIT_HACKER))
			H.dropItemToGround(src, TRUE)
			H.Paralyze(50)
			H.electrocute_act(10, src)
			H.emote("scream")
			to_chat(H, "<span class='danger'>УЖАС! ЧТО ЭТО ТАКОЕ БЛЯТЬ?! СУКА!!!</span>")
			visible_message("<span class='warning'><b>[H]</b> в панике бросает [src] на пол!</span>")

/obj/item/clothing/suit/space/wzzzz/hacker_rig/equipped(mob/living/carbon/human/H, slot)
	. = ..()
	spawn(10)
		if(!HAS_TRAIT(H, TRAIT_HACKER))
			H.dropItemToGround(src, TRUE)
			H.Paralyze(50)
			H.electrocute_act(10, src)
			H.emote("scream")
			to_chat(H, "<span class='danger'>УЖАС! ЧТО ЭТО ТАКОЕ БЛЯТЬ?! СУКА!!!</span>")
			visible_message("<span class='warning'><b>[H]</b> в панике бросает [src] на пол!</span>")

/obj/item/clothing/head/helmet/space/chronos/hacker/equipped(mob/living/carbon/human/H, slot)
	. = ..()
	spawn(10)
		if(!HAS_TRAIT(H, TRAIT_HACKER))
			H.dropItemToGround(src, TRUE)
			H.Paralyze(50)
			H.electrocute_act(10, src)
			H.emote("scream")
			to_chat(H, "<span class='danger'>УЖАС! ЧТО ЭТО ТАКОЕ БЛЯТЬ?! СУКА!!!</span>")
			visible_message("<span class='warning'><b>[H]</b> в панике бросает [src] на пол!</span>")

/obj/item/clothing/head/helmet/space/chronos/hacker
	color = "#00ffff"
	name = "гипершлем"
	desc = "А ты заслуживаешь это?"
	flags_inv = HIDEHAIR|HIDEEARS|HIDEFACE|HIDEFACIALHAIR|HIDEMASK
	worn_icon = null
	slowdown = -1
	strip_delay = 1300
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100,"energy" = 100, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)

/obj/effect/proc_holder/spell/self/hacker_heal
	name = "Источник силы"
	desc = "Восполняет недостатки в теле."
	human_req = TRUE
	clothes_req = FALSE
	charge_max = 600
	cooldown_min = 600
	invocation = "Уёбки, сука!"
	invocation_type = "whisper"
	school = "restoration"
	sound = 'white/valtos/sounds/hacker_heal.ogg'
	action_icon_state = "spacetime"

/obj/effect/proc_holder/spell/self/hacker_heal/cast(list/targets, mob/living/carbon/human/user)
	user.visible_message("<span class='warning'>Странный свет исходит от <b>[user]</b>!</span>", "<span class='notice'>Мне удалось немного исправить своё тело!</span>")
	user.adjustBruteLoss(-10)
	user.adjustFireLoss(-10)

/obj/effect/proc_holder/spell/targeted/remove_retard
	name = "Стереть"
	desc = "При помощи этого я могу уничтожать тех, кто портит систему."
	school = "destruction"
	charge_type = "recharge"
	charge_max	= 6000
	charge_counter = 0
	clothes_req = FALSE
	stat_allowed = FALSE
	invocation = "Исчезни, пидор!"
	invocation_type = "shout"
	range = 4
	cooldown_min = 6000
	selection_type = "range"
	action_icon_state = "spacetime"

/obj/effect/proc_holder/spell/targeted/remove_retard/cast(list/targets, mob/user = usr)
	if(!targets.len)
		to_chat(user, "<span class='warning'>Не нашел гниду!</span>")
		return

	var/mob/living/carbon/target = targets[1]

	if(!(target in oview(range)))
		to_chat(user, "<span class='warning'>Этот пидор слишком далеко!</span>")
		return

	to_chat(target, "<span class='danger'>Кто-то хочет мне навредить!</span>")

	user.visible_message("<span class='warning'><b>[user]</b> бормочет себе что-то под нос!</span>", \
						   "<span class='danger'>Сейчас я этого пидораса сотру нахуй!</span>")

	if(do_after(user, 50, target = target))
		user.whisper(md5("Цель: [target]"))
		if(do_after(user, 30, target = target))
			user.whisper(md5("Метод: удаление [target]"))
			if(do_after(user, 30, target = target))
				user.say("Эй, [target], тебе сейчас будет пиздец!")
				if(do_after(user, 60, target = target))
					user.whisper(md5("Удаление  [target]..."))
					target.emote("scream")
					target.visible_message("<span class='danger'><b>[target]</b> исчезает!</span>", \
									"<span class='danger'>Мне пиздец!</span>")
					playsound(target, 'white/valtos/sounds/mechanized/kr1.wav', 100)
					spawn(5)
						qdel(target.client)
						spawn(5)
							target.dust(TRUE,TRUE)

/mob/living/carbon/proc/hackers_immortality()
	set category = "МАГИЯ"
	set name = "Бессмертие"

	var/mob/living/carbon/C = usr
	if(!C.stat)
		to_chat(C, "<span class='notice'>А я ещё не умер!</span>")
		return
	if(C.has_status_effect(STATUS_EFFECT_HACKERS_IMMORTALITY))
		to_chat(C, "<span class='warning'>А я уже воскрешаюсь!</span>")
		return
	C.apply_status_effect(STATUS_EFFECT_HACKERS_IMMORTALITY)
	return 1

/datum/status_effect/hackers_revive
	id = "hackers_revive"
	duration = 200
	alert_type = /obj/screen/alert/status_effect/hackers_revive

/datum/status_effect/hackers_revive/on_apply()
	to_chat(owner, "<span class='notice'>Смерть не мой конец! Сейчас восстановимся...</span>")
	return ..()

/datum/status_effect/hackers_revive/on_remove()
	owner.revive(full_heal = TRUE, admin_revive = TRUE)
	owner.visible_message("<span class='warning'><b>[owner]</b> восстаёт из мёртвых!</span>", "<span class='notice'>Я регенерирую полностью.</span>")
	owner.update_mobility()

/obj/screen/alert/status_effect/hackers_revive
	name = "Цифровое бессмертие"
	desc = "Мне не страшна смерть!"
	icon_state = "shadow_mend"

/*
// Hacking

/obj/item/modular_computer/tablet/hacktool
	name = "планшет"
	icon = 'icons/obj/contractor_tablet.dmi'
	icon_state = "tablet"
	icon_state_unpowered = "tablet"
	icon_state_powered = "tablet"
	icon_state_menu = "assign"
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_ID | ITEM_SLOT_BELT
	comp_light_luminosity = 6.3
	has_variants = FALSE

/obj/item/modular_computer/tablet/hacktool/Initialize()
	. = ..()
	var/obj/item/computer_hardware/hard_drive/small/hacker/hard_drive = new
	var/datum/computer_file/program/hacktool/ht = new

	active_program = ht
	ht.program_state = PROGRAM_STATE_ACTIVE
	ht.computer = src

	hard_drive.store_file(ht)

	install_component(new /obj/item/computer_hardware/processor_unit/small)
	install_component(new /obj/item/computer_hardware/battery(src, /obj/item/stock_parts/cell/computer))
	install_component(hard_drive)
	install_component(new /obj/item/computer_hardware/network_card)
	install_component(new /obj/item/computer_hardware/card_slot)
	install_component(new /obj/item/computer_hardware/printer/mini)

/obj/item/computer_hardware/hard_drive/small/hacker
	desc = "An efficient SSD for portable devices developed by a rival organisation."
	power_usage = 8
	max_capacity = 120

/datum/computer_file/program/hacktool
	filename = "hacktool"
	filedesc = "Tool for hacking everything"
	program_icon_state = "assign"
	extended_desc = "Содержит виртуальную машину со своим набором программ."
	size = 60
	requires_ntnet = 0
	available_on_ntnet = 0
	unsendable = 1
	undeletable = 1
	tgui_id = "HackerHackTool"
	ui_x = 500
	ui_y = 600

/datum/computer_file/program/hacktool/run_program(var/mob/living/user)
	. = ..(user)
*/
