/obj/item/gun/energy/kinetic_accelerator
	name = "протокинетический ускоритель"
	desc = "Самозарядный, дальнобойный инструмент, наносящий повышенный урон при низком давлении."
	icon_state = "kineticgun"
	inhand_icon_state = "kineticgun"
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic)
	cell_type = /obj/item/stock_parts/cell/emproof
	item_flags = NONE
	obj_flags = UNIQUE_RENAME
	weapon_weight = WEAPON_LIGHT
	can_flashlight = TRUE
	flight_x_offset = 15
	flight_y_offset = 9
	automatic_charge_overlays = FALSE
	can_bayonet = TRUE
	knife_x_offset = 20
	knife_y_offset = 12
	var/overheat_time = 16
	var/holds_charge = FALSE
	var/unique_frequency = FALSE // modified by KA modkits
	var/overheat = FALSE
	var/mob/holder


	var/max_mod_capacity = 100
	var/list/modkits = list()

	var/recharge_timerid

/obj/item/gun/energy/kinetic_accelerator/examine(mob/user)
	. = ..()
	if(max_mod_capacity)
		. += "<b>[get_remaining_mod_capacity()]%</b> осталось для установки модификаций."
		. += "<span class='info'>Можно использовать <b>ломик</b> для изъятия модификаций.</span>"
		for(var/A in get_modkits())
			var/obj/item/borg/upgrade/modkit/M = A
			. += "<span class='notice'>Здесь установлен [M.name]. Использует <b>[M.cost]%</b> мощности.</span>"

/obj/item/gun/energy/kinetic_accelerator/crowbar_act(mob/living/user, obj/item/I)
	. = TRUE
	if(modkits.len)
		to_chat(user, "<span class='notice'>Вытаскиваю все модификации.</span>")
		I.play_tool_sound(src, 100)
		for(var/obj/item/borg/upgrade/modkit/M in modkits)
			M.uninstall(src)
	else
		to_chat(user, "<span class='notice'>Внутри нет модификаций.</span>")

/obj/item/gun/energy/kinetic_accelerator/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/borg/upgrade/modkit))
		var/obj/item/borg/upgrade/modkit/MK = I
		MK.install(src, user)
	else
		..()

/obj/item/gun/energy/kinetic_accelerator/proc/get_remaining_mod_capacity()
	var/current_capacity_used = 0
	for(var/A in get_modkits())
		var/obj/item/borg/upgrade/modkit/M = A
		current_capacity_used += M.cost
	return max_mod_capacity - current_capacity_used

/obj/item/gun/energy/kinetic_accelerator/proc/get_modkits()
	. = list()
	for(var/A in modkits)
		. += A

/obj/item/gun/energy/kinetic_accelerator/proc/modify_projectile(obj/projectile/kinetic/K)
	K.kinetic_gun = src //do something special on-hit, easy!
	for(var/A in get_modkits())
		var/obj/item/borg/upgrade/modkit/M = A
		M.modify_projectile(K)

/obj/item/gun/energy/kinetic_accelerator/cyborg
	holds_charge = TRUE
	unique_frequency = TRUE
	max_mod_capacity = 80

/obj/item/gun/energy/kinetic_accelerator/minebot
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL
	overheat_time = 20
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/kinetic_accelerator/Initialize()
	. = ..()
	if(!holds_charge)
		empty()

/obj/item/gun/energy/kinetic_accelerator/shoot_live_shot(mob/living/user, pointblank = 0, atom/pbtarget = null, message = 1)
	. = ..()
	attempt_reload()

/obj/item/gun/energy/kinetic_accelerator/equipped(mob/user)
	. = ..()
	holder = user
	if(!can_shoot())
		attempt_reload()

/obj/item/gun/energy/kinetic_accelerator/dropped()
	. = ..()
	holder = null
	if(!QDELING(src) && !holds_charge)
		// Put it on a delay because moving item from slot to hand
		// calls dropped().
		addtimer(CALLBACK(src, .proc/empty_if_not_held), 2)

/obj/item/gun/energy/kinetic_accelerator/proc/empty_if_not_held()
	if(!ismob(loc))
		empty()

/obj/item/gun/energy/kinetic_accelerator/proc/empty()
	if(cell)
		cell.use(cell.charge)
	update_icon()

/obj/item/gun/energy/kinetic_accelerator/proc/attempt_reload(recharge_time)
	if(!cell)
		return
	if(overheat)
		return
	if(!recharge_time)
		recharge_time = overheat_time
	overheat = TRUE

	var/carried = 0
	if(!unique_frequency)
		for(var/obj/item/gun/energy/kinetic_accelerator/K in loc.GetAllContents())
			if(!K.unique_frequency)
				carried++

		carried = max(carried, 1)
	else
		carried = 1

	deltimer(recharge_timerid)
	recharge_timerid = addtimer(CALLBACK(src, .proc/reload), recharge_time * carried, TIMER_STOPPABLE)

/obj/item/gun/energy/kinetic_accelerator/emp_act(severity)
	return

/obj/item/gun/energy/kinetic_accelerator/proc/reload()
	cell.give(cell.maxcharge)
	if(!suppressed)
		playsound(src.loc, 'sound/weapons/kenetic_reload.ogg', 60, TRUE)
	else
		to_chat(loc, "<span class='warning'>[capitalize(src.name)] тихо перезаряжается.</span>")
	update_icon()
	overheat = FALSE

/obj/item/gun/energy/kinetic_accelerator/update_overlays()
	. = ..()
	if(!can_shoot())
		. += "[icon_state]_empty"

//Casing
/obj/item/ammo_casing/energy/kinetic
	projectile_type = /obj/projectile/kinetic
	select_name = "kinetic"
	e_cost = 500
	fire_sound = 'sound/weapons/kenetic_accel.ogg' // fine spelling there chap

/obj/item/ammo_casing/energy/kinetic/ready_proj(atom/target, mob/living/user, quiet, zone_override = "")
	..()
	if(loc && istype(loc, /obj/item/gun/energy/kinetic_accelerator))
		var/obj/item/gun/energy/kinetic_accelerator/KA = loc
		KA.modify_projectile(BB)

//Projectiles
/obj/projectile/kinetic
	name = "кинетическая сила"
	icon_state = null
	damage = 40
	damage_type = BRUTE
	flag = "bomb"
	range = 3
	log_override = TRUE

	var/pressure_decrease_active = FALSE
	var/pressure_decrease = 0.25
	var/obj/item/gun/energy/kinetic_accelerator/kinetic_gun

/obj/projectile/kinetic/Destroy()
	kinetic_gun = null
	return ..()

/obj/projectile/kinetic/prehit(atom/target)
	. = ..()
	if(.)
		if(kinetic_gun)
			var/list/mods = kinetic_gun.get_modkits()
			for(var/obj/item/borg/upgrade/modkit/M in mods)
				M.projectile_prehit(src, target, kinetic_gun)
		if(!lavaland_equipment_pressure_check(get_turf(target)))
			name = "ослабленная [name]"
			damage = damage * pressure_decrease
			pressure_decrease_active = TRUE

/obj/projectile/kinetic/on_range()
	strike_thing()
	..()

/obj/projectile/kinetic/on_hit(atom/target)
	strike_thing(target)
	. = ..()

/obj/projectile/kinetic/proc/strike_thing(atom/target)
	var/turf/target_turf = get_turf(target)
	if(!target_turf)
		target_turf = get_turf(src)
	if(kinetic_gun) //hopefully whoever shot this was not very, very unfortunate.
		var/list/mods = kinetic_gun.get_modkits()
		for(var/obj/item/borg/upgrade/modkit/M in mods)
			M.projectile_strike_predamage(src, target_turf, target, kinetic_gun)
		for(var/obj/item/borg/upgrade/modkit/M in mods)
			M.projectile_strike(src, target_turf, target, kinetic_gun)
	if(ismineralturf(target_turf))
		var/turf/closed/mineral/M = target_turf
		M.gets_drilled(firer, TRUE)
		if(iscarbon(firer))
			var/mob/living/carbon/C = firer
			var/skill_modifier = C?.mind.get_skill_modifier(/datum/skill/mining, SKILL_SPEED_MODIFIER)
			kinetic_gun.attempt_reload(kinetic_gun.overheat_time * skill_modifier) //If you hit a mineral, you might get a quicker reload. epic gamer style.
	var/obj/effect/temp_visual/kinetic_blast/K = new /obj/effect/temp_visual/kinetic_blast(target_turf)
	var/_step_x = 0
	var/_step_y = 0
	if(ismovable(target))
		var/atom/movable/AM = target
		_step_x = AM.step_x
		_step_y = AM.step_y
	K.forceStep(null, _step_x, _step_y)
	K.color = color


//Modkits
/obj/item/borg/upgrade/modkit
	name = "комплект для модификации кинетического ускорителя"
	desc = "Апгрейд для кинетических ускорителей."
	icon = 'icons/obj/objects.dmi'
	icon_state = "modkit"
	w_class = WEIGHT_CLASS_SMALL
	require_module = 1
	module_type = list(/obj/item/robot_module/miner)
	module_flags = BORG_MODULE_MINER
	var/denied_type = null
	var/maximum_of_type = 1
	var/cost = 30
	var/modifier = 1 //For use in any mod kit that has numerical modifiers
	var/minebot_upgrade = TRUE
	var/minebot_exclusive = FALSE

/obj/item/borg/upgrade/modkit/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Занимает <b>[cost]%</b> от общей вместимости модификаций.</span>"

/obj/item/borg/upgrade/modkit/attackby(obj/item/A, mob/user)
	if(istype(A, /obj/item/gun/energy/kinetic_accelerator) && !issilicon(user))
		install(A, user)
	else
		..()

/obj/item/borg/upgrade/modkit/action(mob/living/silicon/robot/R)
	. = ..()
	if (.)
		for(var/obj/item/gun/energy/kinetic_accelerator/cyborg/H in R.module.modules)
			return install(H, usr)

/obj/item/borg/upgrade/modkit/proc/install(obj/item/gun/energy/kinetic_accelerator/KA, mob/user)
	. = TRUE
	if(minebot_upgrade)
		if(minebot_exclusive && !istype(KA.loc, /mob/living/simple_animal/hostile/mining_drone))
			to_chat(user, "<span class='notice'>Модкит, который я пытаюсь установить, рассчитан только на использование для шахтёрского робота.</span>")
			return FALSE
	else if(istype(KA.loc, /mob/living/simple_animal/hostile/mining_drone))
		to_chat(user, "<span class='notice'>Модкит, который я пытаюсь установить, не рассчитан на использование для шахтёрского робота.</span>")
		return FALSE
	if(denied_type)
		var/number_of_denied = 0
		for(var/A in KA.get_modkits())
			var/obj/item/borg/upgrade/modkit/M = A
			if(istype(M, denied_type))
				number_of_denied++
			if(number_of_denied >= maximum_of_type)
				. = FALSE
				break
	if(KA.get_remaining_mod_capacity() >= cost)
		if(.)
			if(!user.transferItemToLoc(src, KA))
				return
			to_chat(user, "<span class='notice'>Устанавливаю модификацию.</span>")
			playsound(loc, 'sound/items/screwdriver.ogg', 100, TRUE)
			KA.modkits += src
		else
			to_chat(user, "<span class='notice'>Модкит, который я пытаюсь установить, будет конфликтовать с уже установленным модкитом. Стоит использовать лом для удаления существующих модкитов.</span>")
	else
		to_chat(user, "<span class='notice'>Здесь недостаточно места. <b>[KA.get_remaining_mod_capacity()]%</b> осталось, [cost]% требуется для установки модификации. Стоит использовать лом для удаления существующих модкитов.</span>")
		. = FALSE

/obj/item/borg/upgrade/modkit/deactivate(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if (.)
		for(var/obj/item/gun/energy/kinetic_accelerator/cyborg/KA in R.module.modules)
			uninstall(KA)

/obj/item/borg/upgrade/modkit/proc/uninstall(obj/item/gun/energy/kinetic_accelerator/KA)
	forceMove(get_turf(KA))
	KA.modkits -= src



/obj/item/borg/upgrade/modkit/proc/modify_projectile(obj/projectile/kinetic/K)

//use this one for effects you want to trigger before any damage is done at all and before damage is decreased by pressure
/obj/item/borg/upgrade/modkit/proc/projectile_prehit(obj/projectile/kinetic/K, atom/target, obj/item/gun/energy/kinetic_accelerator/KA)
//use this one for effects you want to trigger before mods that do damage
/obj/item/borg/upgrade/modkit/proc/projectile_strike_predamage(obj/projectile/kinetic/K, turf/target_turf, atom/target, obj/item/gun/energy/kinetic_accelerator/KA)
//and this one for things that don't need to trigger before other damage-dealing mods
/obj/item/borg/upgrade/modkit/proc/projectile_strike(obj/projectile/kinetic/K, turf/target_turf, atom/target, obj/item/gun/energy/kinetic_accelerator/KA)

//Range
/obj/item/borg/upgrade/modkit/range
	name = "увеличение дальности"
	desc = "Увеличивает дальность кинетического ускорителя при установке."
	modifier = 1
	cost = 25

/obj/item/borg/upgrade/modkit/range/modify_projectile(obj/projectile/kinetic/K)
	K.range += modifier


//Damage
/obj/item/borg/upgrade/modkit/damage
	name = "увеличение урона"
	desc = "Увеличивает урон кинетического ускорителя при установке."
	modifier = 10

/obj/item/borg/upgrade/modkit/damage/modify_projectile(obj/projectile/kinetic/K)
	K.damage += modifier


//Cooldown
/obj/item/borg/upgrade/modkit/cooldown
	name = "уменьшение времени перезарядки"
	desc = "Уменьшает время восстановления кинетического ускорителя. Не рассчитано на использование шахтёрском роботе."
	modifier = 3.2
	minebot_upgrade = FALSE

/obj/item/borg/upgrade/modkit/cooldown/install(obj/item/gun/energy/kinetic_accelerator/KA, mob/user)
	. = ..()
	if(.)
		KA.overheat_time -= modifier

/obj/item/borg/upgrade/modkit/cooldown/uninstall(obj/item/gun/energy/kinetic_accelerator/KA)
	KA.overheat_time += modifier
	..()

/obj/item/borg/upgrade/modkit/cooldown/minebot
	name = "уменьшение времени перезарядки для шахтёрского робота"
	desc = "Уменьшает время восстановления кинетического ускорителя. Только для использования в шахтёрском роботе."
	icon_state = "door_electronics"
	icon = 'icons/obj/module.dmi'
	denied_type = /obj/item/borg/upgrade/modkit/cooldown/minebot
	modifier = 10
	cost = 0
	minebot_upgrade = TRUE
	minebot_exclusive = TRUE


//AoE blasts
/obj/item/borg/upgrade/modkit/aoe
	modifier = 0
	var/turf_aoe = FALSE
	var/stats_stolen = FALSE

/obj/item/borg/upgrade/modkit/aoe/install(obj/item/gun/energy/kinetic_accelerator/KA, mob/user)
	. = ..()
	if(.)
		for(var/obj/item/borg/upgrade/modkit/aoe/AOE in KA.modkits) //make sure only one of the aoe modules has values if somebody has multiple
			if(AOE.stats_stolen || AOE == src)
				continue
			modifier += AOE.modifier //take its modifiers
			AOE.modifier = 0
			turf_aoe += AOE.turf_aoe
			AOE.turf_aoe = FALSE
			AOE.stats_stolen = TRUE

/obj/item/borg/upgrade/modkit/aoe/uninstall(obj/item/gun/energy/kinetic_accelerator/KA)
	..()
	modifier = initial(modifier) //get our modifiers back
	turf_aoe = initial(turf_aoe)
	stats_stolen = FALSE

/obj/item/borg/upgrade/modkit/aoe/modify_projectile(obj/projectile/kinetic/K)
	K.name = "кинетический взрыв"

/obj/item/borg/upgrade/modkit/aoe/projectile_strike(obj/projectile/kinetic/K, turf/target_turf, atom/target, obj/item/gun/energy/kinetic_accelerator/KA)
	if(stats_stolen)
		return
	new /obj/effect/temp_visual/explosion/fast(target_turf)
	if(turf_aoe)
		for(var/T in RANGE_TURFS(1, target_turf) - target_turf)
			if(ismineralturf(T))
				var/turf/closed/mineral/M = T
				M.gets_drilled(K.firer, TRUE)
	if(modifier)
		for(var/mob/living/L in range(1, target_turf) - K.firer - target)
			var/armor = L.run_armor_check(K.def_zone, K.flag, "", "", K.armour_penetration)
			L.apply_damage(K.damage*modifier, K.damage_type, K.def_zone, armor)
			to_chat(L, "<span class='userdanger'>В меня попадает [K.name]!</span>")

/obj/item/borg/upgrade/modkit/aoe/turfs
	name = "горный взрыв"
	desc = "Заставляет кинетический ускоритель разрушать камни в небольшом радиусе."
	denied_type = /obj/item/borg/upgrade/modkit/aoe/turfs
	turf_aoe = TRUE

/obj/item/borg/upgrade/modkit/aoe/turfs/andmobs
	name = "наступательный взрыв гор"
	desc = "Заставляет кинетический ускоритель разрушать камни и наносить урон мобам в небольшом радиусе."
	maximum_of_type = 3
	modifier = 0.25

/obj/item/borg/upgrade/modkit/aoe/mobs
	name = "наступательный взрыв"
	desc = "Заставляет кинетический ускоритель повредить мобов в небольшом радиусе."
	modifier = 0.2

//Minebot passthrough
/obj/item/borg/upgrade/modkit/minebot_passthrough
	name = "игнорирование шахтёрского робота"
	desc = "Заставляет кинетическую силу проходить минуя шахтёрских роботов."
	cost = 0

//Tendril-unique modules
/obj/item/borg/upgrade/modkit/cooldown/repeater
	name = "быстрый ретранслятор"
	desc = "Четвертирует время восстановления кинетического ускорителя при попадании в живую цель, но значительно увеличивает базовое время восстановления."
	denied_type = /obj/item/borg/upgrade/modkit/cooldown/repeater
	modifier = -14 //Makes the cooldown 3 seconds(with no cooldown mods) if you miss. Don't miss.
	cost = 50

/obj/item/borg/upgrade/modkit/cooldown/repeater/projectile_strike_predamage(obj/projectile/kinetic/K, turf/target_turf, atom/target, obj/item/gun/energy/kinetic_accelerator/KA)
	var/valid_repeat = FALSE
	if(isliving(target))
		var/mob/living/L = target
		if(L.stat != DEAD)
			valid_repeat = TRUE
	if(ismineralturf(target_turf))
		valid_repeat = TRUE
	if(valid_repeat)
		KA.overheat = FALSE
		KA.attempt_reload(KA.overheat_time * 0.25) //If you hit, the cooldown drops to 0.75 seconds.

/obj/item/borg/upgrade/modkit/lifesteal
	name = "кристалл кражи жизни"
	desc = "Заставляет выстрелы ускорителя слегка излечивать стрелка при попадании в живую цель."
	icon_state = "modkit_crystal"
	modifier = 2.5 //Not a very effective method of healing.
	cost = 20
	var/static/list/damage_heal_order = list(BRUTE, BURN, OXY)

/obj/item/borg/upgrade/modkit/lifesteal/projectile_prehit(obj/projectile/kinetic/K, atom/target, obj/item/gun/energy/kinetic_accelerator/KA)
	if(isliving(target) && isliving(K.firer))
		var/mob/living/L = target
		if(L.stat == DEAD)
			return
		L = K.firer
		L.heal_ordered_damage(modifier, damage_heal_order)

/obj/item/borg/upgrade/modkit/resonator_blasts
	name = "взрыв резонатора"
	desc = "Заставляет выстрелы кинетического ускорителя создавать резонаторные волны."
	denied_type = /obj/item/borg/upgrade/modkit/resonator_blasts
	cost = 30
	modifier = 0.25 //A bonus 15 damage if you burst the field on a target, 60 if you lure them into it.

/obj/item/borg/upgrade/modkit/resonator_blasts/projectile_strike(obj/projectile/kinetic/K, turf/target_turf, atom/target, obj/item/gun/energy/kinetic_accelerator/KA)
	if(target_turf && !ismineralturf(target_turf)) //Don't make fields on mineral turfs.
		var/obj/effect/temp_visual/resonance/R = locate(/obj/effect/temp_visual/resonance) in target_turf
		if(R)
			R.damage_multiplier = modifier
			R.burst()
			return
		new /obj/effect/temp_visual/resonance(target_turf, K.firer, null, 30)

/obj/item/borg/upgrade/modkit/bounty
	name = "смертельный сифон"
	desc = "Убийство или помощь в убийстве существа постоянно увеличивает ваш урон против этого типа существ."
	denied_type = /obj/item/borg/upgrade/modkit/bounty
	modifier = 1.25
	cost = 30
	var/maximum_bounty = 25
	var/list/bounties_reaped = list()

/obj/item/borg/upgrade/modkit/bounty/projectile_prehit(obj/projectile/kinetic/K, atom/target, obj/item/gun/energy/kinetic_accelerator/KA)
	if(isliving(target))
		var/mob/living/L = target
		var/list/existing_marks = L.has_status_effect_list(STATUS_EFFECT_SYPHONMARK)
		for(var/i in existing_marks)
			var/datum/status_effect/syphon_mark/SM = i
			if(SM.reward_target == src) //we want to allow multiple people with bounty modkits to use them, but we need to replace our own marks so we don't multi-reward
				SM.reward_target = null
				qdel(SM)
		L.apply_status_effect(STATUS_EFFECT_SYPHONMARK, src)

/obj/item/borg/upgrade/modkit/bounty/projectile_strike(obj/projectile/kinetic/K, turf/target_turf, atom/target, obj/item/gun/energy/kinetic_accelerator/KA)
	if(isliving(target))
		var/mob/living/L = target
		if(bounties_reaped[L.type])
			var/kill_modifier = 1
			if(K.pressure_decrease_active)
				kill_modifier *= K.pressure_decrease
			var/armor = L.run_armor_check(K.def_zone, K.flag, "", "", K.armour_penetration)
			L.apply_damage(bounties_reaped[L.type]*kill_modifier, K.damage_type, K.def_zone, armor)

/obj/item/borg/upgrade/modkit/bounty/proc/get_kill(mob/living/L)
	var/bonus_mod = 1
	if(ismegafauna(L)) //megafauna reward
		bonus_mod = 4
	if(!bounties_reaped[L.type])
		bounties_reaped[L.type] = min(modifier * bonus_mod, maximum_bounty)
	else
		bounties_reaped[L.type] = min(bounties_reaped[L.type] + (modifier * bonus_mod), maximum_bounty)

//Indoors
/obj/item/borg/upgrade/modkit/indoors
	name = "уменьшение штрафа за давление"
	desc = "Комплект модификации синдиката, который увеличивает урон, который кинетический ускоритель наносит в условиях высокого давления."
	modifier = 2
	denied_type = /obj/item/borg/upgrade/modkit/indoors
	maximum_of_type = 2
	cost = 35

/obj/item/borg/upgrade/modkit/indoors/modify_projectile(obj/projectile/kinetic/K)
	K.pressure_decrease *= modifier


//Trigger Guard
/obj/item/borg/upgrade/modkit/trigger_guard
	name = "модифицированный курок"
	desc = "Позволяет существам, обычно неспособным стрелять из оружия, управлять оружием, когда оно установлено."
	cost = 20
	denied_type = /obj/item/borg/upgrade/modkit/trigger_guard

/obj/item/borg/upgrade/modkit/trigger_guard/install(obj/item/gun/energy/kinetic_accelerator/KA, mob/user)
	. = ..()
	if(.)
		KA.trigger_guard = TRIGGER_GUARD_ALLOW_ALL

/obj/item/borg/upgrade/modkit/trigger_guard/uninstall(obj/item/gun/energy/kinetic_accelerator/KA)
	KA.trigger_guard = TRIGGER_GUARD_NORMAL
	..()


//Cosmetic

/obj/item/borg/upgrade/modkit/chassis_mod
	name = "супер шасси"
	desc = "Делает ваш КА желтым. Все удовольствие в том, чтобы иметь более мощный КА, но не иметь более мощного КА."
	cost = 0
	denied_type = /obj/item/borg/upgrade/modkit/chassis_mod
	var/chassis_icon = "kineticgun_u"
	var/chassis_name = "super-kinetic accelerator"

/obj/item/borg/upgrade/modkit/chassis_mod/install(obj/item/gun/energy/kinetic_accelerator/KA, mob/user)
	. = ..()
	if(.)
		KA.icon_state = chassis_icon
		KA.name = chassis_name

/obj/item/borg/upgrade/modkit/chassis_mod/uninstall(obj/item/gun/energy/kinetic_accelerator/KA)
	KA.icon_state = initial(KA.icon_state)
	KA.name = initial(KA.name)
	..()

/obj/item/borg/upgrade/modkit/chassis_mod/orange
	name = "гипер шасси"
	desc = "Делает ваш КА оранжевым. Все удовольствие от взрывных взрывов без взрывных взрывов."
	chassis_icon = "kineticgun_h"
	chassis_name = "hyper-kinetic accelerator"

/obj/item/borg/upgrade/modkit/tracer
	name = "белые трассирующие болты"
	desc = "Заставляет кинетические ускорители иметь белый след трассировки и взрыв."
	cost = 0
	denied_type = /obj/item/borg/upgrade/modkit/tracer
	var/bolt_color = "#FFFFFF"

/obj/item/borg/upgrade/modkit/tracer/modify_projectile(obj/projectile/kinetic/K)
	K.icon_state = "ka_tracer"
	K.color = bolt_color

/obj/item/borg/upgrade/modkit/tracer/adjustable
	name = "регулируемые болты"
	desc = "Приводит к тому, что у болтов кинетического ускорителя есть след регулируемого цвета и взрыв. Используйте в руке, чтобы изменить цвет."

/obj/item/borg/upgrade/modkit/tracer/adjustable/attack_self(mob/user)
	bolt_color = input(user,"","Выбрать бы цвет",bolt_color) as color|null
