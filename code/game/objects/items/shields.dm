/obj/item/shield
	name = "щит"
	icon = 'icons/obj/shields.dmi'
	block_chance = 50
	armor = list("melee" = 50, "bullet" = 50, "laser" = 50, "energy" = 0, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 70)
	var/transparent = FALSE	// makes beam projectiles pass through the shield

/obj/item/shield/proc/on_shield_block(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "атаку", damage = 0, attack_type = MELEE_ATTACK)
	return TRUE

/obj/item/shield/riot
	name = "защитный щит"
	desc = "Щит умеет блокировать тупые предметы от соединения с туловищем владельца щита."
	icon_state = "riot"
	lefthand_file = 'icons/mob/inhands/equipment/shields_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/shields_righthand.dmi'
	slot_flags = ITEM_SLOT_BACK
	force = 10
	throwforce = 5
	throw_speed = 2
	throw_range = 3
	w_class = WEIGHT_CLASS_BULKY
	custom_materials = list(/datum/material/glass=7500, /datum/material/iron=1000)
	attack_verb = list("толкает", "бьёт")
	var/cooldown = 0 //shield bash cooldown. based on world.time
	transparent = TRUE
	max_integrity = 75
	material_flags = MATERIAL_NO_EFFECTS

/obj/item/shield/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "атаку", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(transparent && (hitby.pass_flags & PASSGLASS))
		return FALSE
	if(attack_type == THROWN_PROJECTILE_ATTACK)
		final_block_chance += 30
	if(attack_type == LEAP_ATTACK)
		final_block_chance = 100
	. = ..()
	if(.)
		on_shield_block(owner, hitby, attack_text, damage, attack_type)

/obj/item/shield/riot/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/melee/baton))
		if(cooldown < world.time - 25)
			user.visible_message("<span class='warning'><b>[user]</b> хуярит <b>[src.name]</b> используя [W]!</span>")
			playsound(user.loc, 'sound/effects/shieldbash.ogg', 50, TRUE)
			cooldown = world.time
	else if(istype(W, /obj/item/stack/sheet/mineral/titanium))
		if (obj_integrity >= max_integrity)
			to_chat(user, "<span class='warning'><b>[src.name]</b> уже в превосходном состоянии.</span>")
		else
			var/obj/item/stack/sheet/mineral/titanium/T = W
			T.use(1)
			obj_integrity = max_integrity
			to_chat(user, "<span class='notice'>Чиню <b>[src.name]</b> используя <b>[T]</b>.</span>")
	else
		return ..()

/obj/item/shield/riot/examine(mob/user)
	. = ..()
	var/healthpercent = round((obj_integrity/max_integrity) * 100, 1)
	switch(healthpercent)
		if(50 to 99)
			. += "<span class='info'>Виднеются небольшие царапины.</span>"
		if(25 to 50)
			. += "<span class='info'>Выглядит серьёзно повреждённым.</span>"
		if(0 to 25)
			. += "<span class='warning'>Вот-вот развалится!</span>"

/obj/item/shield/riot/proc/shatter(mob/living/carbon/human/owner)
	playsound(owner, 'sound/effects/glassbr3.ogg', 100)
	new /obj/item/shard((get_turf(src)))

/obj/item/shield/riot/on_shield_block(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "атаку", damage = 0, attack_type = MELEE_ATTACK)
	if (obj_integrity <= damage)
		var/turf/T = get_turf(owner)
		T.visible_message("<span class='warning'><b>[capitalize(hitby.name)]</b> уничтожает <b>[src.name]</b>!</span>")
		shatter(owner)
		qdel(src)
		return FALSE
	take_damage(damage)
	return ..()

/obj/item/shield/riot/roman
	name = "Римский щит"
	desc = "На внутренней стороне надпись: <i>\"Romanes venio domus\"</i>."
	icon_state = "roman_shield"
	inhand_icon_state = "roman_shield"
	lefthand_file = 'icons/mob/inhands/equipment/shields_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/shields_righthand.dmi'
	transparent = FALSE
	custom_materials = list(/datum/material/iron=8500)
	max_integrity = 65

/obj/item/shield/riot/roman/fake
	desc = "На внутренней стороне надпись: <i>\"Romanes venio domus\"</i>. Это кажется немного хрупким."
	block_chance = 0
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	max_integrity = 30

/obj/item/shield/riot/roman/shatter(mob/living/carbon/human/owner)
	playsound(owner, 'sound/effects/grillehit.ogg', 100)
	new /obj/item/stack/sheet/metal(get_turf(src))

/obj/item/shield/riot/buckler
	name = "деревянный баклер"
	desc = "Средневековый деревянный баклер."
	icon_state = "buckler"
	inhand_icon_state = "buckler"
	lefthand_file = 'icons/mob/inhands/equipment/shields_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/shields_righthand.dmi'
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT * 10)
	resistance_flags = FLAMMABLE
	block_chance = 30
	transparent = FALSE
	max_integrity = 55
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/shield/riot/buckler/shatter(mob/living/carbon/human/owner)
	playsound(owner, 'sound/effects/bang.ogg', 50)
	new /obj/item/stack/sheet/mineral/wood(get_turf(src))

/obj/item/shield/riot/flash
	name = "ослепляющий щит"
	desc = "Щит со встроенным высокоинтенсивным светом, способным ослеплять и дезориентировать подозреваемых. Принимает обычные ручные флэшки в виде лампочек."
	icon_state = "flashshield"
	inhand_icon_state = "flashshield"
	var/obj/item/assembly/flash/handheld/embedded_flash

/obj/item/shield/riot/flash/Initialize()
	. = ..()
	embedded_flash = new(src)

/obj/item/shield/riot/flash/ComponentInitialize()
	. = .. ()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/shield/riot/flash/attack(mob/living/M, mob/user)
	. =  embedded_flash.attack(M, user)
	update_icon()

/obj/item/shield/riot/flash/attack_self(mob/living/carbon/user)
	. = embedded_flash.attack_self(user)
	update_icon()

/obj/item/shield/riot/flash/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "атаку", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	. = ..()
	if (. && !embedded_flash.burnt_out)
		embedded_flash.activate()
		update_icon()


/obj/item/shield/riot/flash/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/assembly/flash/handheld))
		var/obj/item/assembly/flash/handheld/flash = W
		if(flash.burnt_out)
			to_chat(user, "<span class='warning'>Нет смысла заменять её сломанной лампочкой!</span>")
			return
		else
			to_chat(user, "<span class='notice'>Начинаю заменять лампочку...</span>")
			if(do_after(user, 20, target = user))
				if(flash.burnt_out || !flash || QDELETED(flash))
					return
				playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
				qdel(embedded_flash)
				embedded_flash = flash
				flash.forceMove(src)
				update_icon()
				return
	..()

/obj/item/shield/riot/flash/emp_act(severity)
	. = ..()
	embedded_flash.emp_act(severity)
	update_icon()

/obj/item/shield/riot/flash/update_icon_state()
	if(!embedded_flash || embedded_flash.burnt_out)
		icon_state = "riot"
		inhand_icon_state = "riot"
	else
		icon_state = "flashshield"
		inhand_icon_state = "flashshield"

/obj/item/shield/riot/flash/examine(mob/user)
	. = ..()
	if (embedded_flash?.burnt_out)
		. += "<span class='info'>Установленная лампа перегорела. Стоит попробовать заменить её на новую.</span>"

/obj/item/shield/energy
	name = "энергетический боевой щит"
	desc = "Щит, который отражает почти все энергетические снаряды, но бесполезен против физических атак. Его можно убирать, расширять и хранить где угодно."
	lefthand_file = 'icons/mob/inhands/equipment/shields_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/shields_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("толкает", "бьёт")
	throw_range = 5
	force = 3
	throwforce = 3
	throw_speed = 3
	var/base_icon_state = "eshield" // [base_icon_state]1 for expanded, [base_icon_state]0 for contracted
	var/on_force = 10
	var/on_throwforce = 8
	var/on_throw_speed = 2
	var/active = 0
	var/clumsy_check = TRUE

/obj/item/shield/energy/Initialize()
	. = ..()
	icon_state = "[base_icon_state]0"

/obj/item/shield/energy/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "атаку", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	return 0

/obj/item/shield/energy/IsReflect()
	return (active)

/obj/item/shield/energy/attack_self(mob/living/carbon/human/user)
	if(clumsy_check && HAS_TRAIT(user, TRAIT_CLUMSY) && prob(50))
		to_chat(user, "<span class='userdanger'>Бью себя в голову используя <b>[src.name]</b>!</span>")
		user.take_bodypart_damage(5)
	active = !active
	icon_state = "[base_icon_state][active]"

	if(active)
		force = on_force
		throwforce = on_throwforce
		throw_speed = on_throw_speed
		w_class = WEIGHT_CLASS_BULKY
		playsound(user, 'sound/weapons/saberon.ogg', 35, TRUE)
		to_chat(user, "<span class='notice'><b>[src.name]</b> теперь активен.</span>")
	else
		force = initial(force)
		throwforce = initial(throwforce)
		throw_speed = initial(throw_speed)
		w_class = WEIGHT_CLASS_TINY
		playsound(user, 'sound/weapons/saberoff.ogg', 35, TRUE)
		to_chat(user, "<span class='notice'><b>[src.name]</b> теперь может быть спрятан.</span>")
	add_fingerprint(user)

/obj/item/shield/riot/tele
	name = "телескопический щит"
	desc = "Усовершенствованный защитный экран от легких материалов, который разрушается для удобства хранения."
	icon_state = "teleriot0"
	lefthand_file = 'icons/mob/inhands/equipment/shields_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/shields_righthand.dmi'
	custom_materials = list(/datum/material/iron = 3600, /datum/material/glass = 3600, /datum/material/silver = 270, /datum/material/titanium = 180)
	slot_flags = null
	force = 3
	throwforce = 3
	throw_speed = 3
	throw_range = 4
	w_class = WEIGHT_CLASS_NORMAL
	var/active = 0

/obj/item/shield/riot/tele/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "атаку", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(active)
		return ..()
	return 0

/obj/item/shield/riot/tele/attack_self(mob/living/user)
	active = !active
	icon_state = "teleriot[active]"
	playsound(src.loc, 'sound/weapons/batonextend.ogg', 50, TRUE)

	if(active)
		force = 8
		throwforce = 5
		throw_speed = 2
		w_class = WEIGHT_CLASS_BULKY
		slot_flags = ITEM_SLOT_BACK
		to_chat(user, "<span class='notice'>Раскрываю <b>[src.name]</b>.</span>")
	else
		force = 3
		throwforce = 3
		throw_speed = 3
		w_class = WEIGHT_CLASS_NORMAL
		slot_flags = null
		to_chat(user, "<span class='notice'>Сворачиваю <b>[src.name]</b>.</span>")
	add_fingerprint(user)
