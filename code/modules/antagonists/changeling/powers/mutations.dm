/*
	Changeling Mutations! ~By Miauw (ALL OF IT :V)
	Contains:
		Arm Blade
		Space Suit
		Shield
		Armor
		Tentacles
*/


//Parent to shields and blades because muh copypasted code.
/datum/action/changeling/weapon
	name = "Organic Weapon"
	desc = "Go tell a coder if you see this"
	helptext = "Yell at Miauw and/or Perakp"
	chemical_cost = 1000
	dna_cost = -1

	var/silent = FALSE
	var/weapon_type
	var/weapon_name_simple

/datum/action/changeling/weapon/try_to_sting(mob/user, mob/target)
	for(var/obj/item/I in user.held_items)
		if(check_weapon(user, I))
			return
	..(user, target)

/datum/action/changeling/weapon/proc/check_weapon(mob/user, obj/item/hand_item)
	if(istype(hand_item, weapon_type))
		user.temporarilyRemoveItemFromInventory(hand_item, TRUE) //DROPDEL will delete the item
		if(!silent)
			playsound(user, 'sound/effects/blobattack.ogg', 30, TRUE)
			user.visible_message("<span class='warning'>С отвратительным хрустом, <b>[user]</b> формирует [weapon_name_simple] обратно в руку!</span>", "<span class='notice'>Мы возвращаем [weapon_name_simple] обратно в наше тело.</span>", "<span class='italics>Слышу как что-то органическое разрывается!</span>")
		user.update_inv_hands()
		return 1

/datum/action/changeling/weapon/sting_action(mob/living/user)
	var/obj/item/held = user.get_active_held_item()
	if(held && !user.dropItemToGround(held))
		to_chat(user, "<span class='warning'><b>[capitalize(held)]</b> застряло в моей руке, не получится сделать [weapon_name_simple] поверх этого!</span>")
		return
	..()
	var/limb_regen = 0
	if(user.active_hand_index % 2 == 0) //we regen the arm before changing it into the weapon
		limb_regen = user.regenerate_limb(BODY_ZONE_R_ARM, 1)
	else
		limb_regen = user.regenerate_limb(BODY_ZONE_L_ARM, 1)
	if(limb_regen)
		user.visible_message("<span class='warning'>Рука <b>[user]</b> трансформируется издавая громкий и неприятный звук!</span>", "<span class='userdanger'>Моя рука отрастает, издает громкий хрустящий звук и причиняет мне сильную боль!</span>", "<span class='hear'>Слышу как что-то органическое разрывается!</span>")
		user.emote("scream")
	var/obj/item/W = new weapon_type(user, silent)
	user.put_in_hands(W)
	if(!silent)
		playsound(user, 'sound/effects/blobattack.ogg', 30, TRUE)
	return W

/datum/action/changeling/weapon/Remove(mob/user)
	for(var/obj/item/I in user.held_items)
		check_weapon(user, I)
	..()


//Parent to space suits and armor.
/datum/action/changeling/suit
	name = "Organic Suit"
	desc = "Go tell a coder if you see this"
	helptext = "Yell at Miauw and/or Perakp"
	chemical_cost = 1000
	dna_cost = -1

	var/helmet_type = /obj/item
	var/suit_type = /obj/item
	var/suit_name_simple = "    "
	var/helmet_name_simple = "     "
	var/recharge_slowdown = 0
	var/blood_on_castoff = 0

/datum/action/changeling/suit/try_to_sting(mob/user, mob/target)
	if(check_suit(user))
		return
	var/mob/living/carbon/human/H = user
	..(H, target)

//checks if we already have an organic suit and casts it off.
/datum/action/changeling/suit/proc/check_suit(mob/user)
	var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling)
	if(!ishuman(user) || !changeling)
		return 1
	var/mob/living/carbon/human/H = user
	if(istype(H.wear_suit, suit_type) || istype(H.head, helmet_type))
		H.visible_message("<span class='warning'><b>[H]</b> сбрасывает с себя [suit_name_simple]!</span>", "<span class='warning'>Мы сбрасываем [suit_name_simple].</span>", "<span class='hear'>Слышу как что-то органическое разрывается!</span>")
		H.temporarilyRemoveItemFromInventory(H.head, TRUE) //The qdel on dropped() takes care of it
		H.temporarilyRemoveItemFromInventory(H.wear_suit, TRUE)
		H.update_inv_wear_suit()
		H.update_inv_head()
		H.update_hair()

		if(blood_on_castoff)
			H.add_splatter_floor()
			playsound(H.loc, 'sound/effects/splat.ogg', 50, TRUE) //So real sounds

		changeling.chem_recharge_slowdown -= recharge_slowdown
		return 1

/datum/action/changeling/suit/Remove(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	check_suit(H)
	..()

/datum/action/changeling/suit/sting_action(mob/living/carbon/human/user)
	if(!user.canUnEquip(user.wear_suit))
		to_chat(user, "<span class='warning'>[capitalize(user.wear_suit)] крепко сидит на моём теле, не получится вырастить [suit_name_simple] поверх этого!</span>")
		return
	if(!user.canUnEquip(user.head))
		to_chat(user, "<span class='warning'>[capitalize(user.head)] крепко сидит на моей голове, не получится вырастить [helmet_name_simple] поверх этого!</span>")
		return
	..()
	user.dropItemToGround(user.head)
	user.dropItemToGround(user.wear_suit)

	user.equip_to_slot_if_possible(new suit_type(user), ITEM_SLOT_OCLOTHING, 1, 1, 1)
	user.equip_to_slot_if_possible(new helmet_type(user), ITEM_SLOT_HEAD, 1, 1, 1)

	var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling)
	changeling.chem_recharge_slowdown += recharge_slowdown
	return TRUE


//fancy headers yo
/***************************************\
|***************ARM BLADE***************|
\***************************************/
/datum/action/changeling/weapon/arm_blade
	name = "Рука-лезвие"
	desc = "Мы превращаем одну из наших рук в смертельный клинок. Стоит 20 химикатов."
	helptext = "Мы можем втягивать наш клинок так же, как мы его формируем. Не может быть использовано в меньшей форме."
	button_icon_state = "armblade"
	chemical_cost = 20
	dna_cost = 2
	req_human = 1
	weapon_type = /obj/item/melee/arm_blade
	weapon_name_simple = "лезвие"

/obj/item/melee/arm_blade
	name = "рука-лезвие"
	desc = "Гротескный клинок из кости и плоти, который пронзает людей, как горячий нож сквозь масло."
	icon = 'icons/obj/changeling_items.dmi'
	icon_state = "arm_blade"
	inhand_icon_state = "arm_blade"
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	item_flags = NEEDS_PERMIT | ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	force = 25
	throwforce = 0 //Just to be on the safe side
	throw_range = 0
	throw_speed = 0
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("атакует", "рубит", "втыкает", "разрезает", "кромсает", "разрывает", "нарезает", "режет")
	sharpness = SHARP_EDGED
	wound_bonus = -60
	bare_wound_bonus = 20
	var/can_drop = FALSE
	var/fake = FALSE

/obj/item/melee/arm_blade/Initialize(mapload,silent,synthetic)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CHANGELING_TRAIT)
	if(ismob(loc) && !silent)
		loc.visible_message("<span class='warning'>Гротескный клинок формируется из руки <b>[loc.name]</b>!</span>", "<span class='warning'>Наша рука крутится и мутирует, превращаясь в смертельный клинок.</span>", "<span class='hear'>Слышу как что-то органическое разрывается!</span>")
	if(synthetic)
		can_drop = TRUE
	AddComponent(/datum/component/butchering, 60, 80)

/obj/item/melee/arm_blade/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(istype(target, /obj/structure/table))
		var/obj/structure/table/T = target
		T.deconstruct(FALSE)

	else if(istype(target, /obj/machinery/computer))
		var/obj/machinery/computer/C = target
		C.attack_alien(user) //muh copypasta

	else if(istype(target, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/A = target

		if((!A.requiresID() || A.allowed(user)) && A.hasPower()) //This is to prevent stupid shit like hitting a door with an arm blade, the door opening because you have acces and still getting a "the airlocks motors resist our efforts to force it" message, power requirement is so this doesn't stop unpowered doors from being pried open if you have access
			return
		if(A.locked)
			to_chat(user, "<span class='warning'>Болты шлюза предотвращают его принудительное открытие!</span>")
			return

		if(A.hasPower())
			user.visible_message("<span class='warning'><b>[user]</b> втискивает <b>руку-лезвие</b> в шлюз и начинает открывать его!</span>", "<span class='warning'>Мы начинаем открывать [A].</span>", \
			"<span class='hear'>Слышу металлический лязг.</span>")
			playsound(A, 'sound/machines/airlock_alien_prying.ogg', 100, TRUE)
			if(!do_after(user, 100, target = A))
				return
		//user.say("Heeeeeeeeeerrre's Johnny!")
		user.visible_message("<span class='warning'><b>[user]</b> заставляет шлюз открыться под силой <b>руки-лезвия</b>!</span>", "<span class='warning'>Мы заставляем [A] открыться.</span>", \
		"<span class='hear'>Слышу металлический лязг.</span>")
		A.open(2)

/obj/item/melee/arm_blade/dropped(mob/user)
	..()
	if(can_drop)
		new /obj/item/melee/synthetic_arm_blade(get_turf(user))

/***************************************\
|***********COMBAT TENTACLES*************|
\***************************************/

/datum/action/changeling/weapon/tentacle
	name = "Щупальце"
	desc = "Мы готовим щупальце, способное захватывать предметы или живых существ. Стоит 10 химикатов."
	helptext = "Мы можем использовать его один раз, чтобы получить отдаленный предмет. При использовании на живых существ, эффект зависит от намерения: \
	Помощь просто притянет их ближе, Разоружение захватит все, что они держат вместо них, Захват поместит жертву в нашу хватку после того, как поймает ее, \
	и Вред втянет его и нанесет удар, если у нас тоже острое оружие. Не может быть использовано в меньшей форме."
	button_icon_state = "tentacle"
	chemical_cost = 10
	dna_cost = 2
	req_human = 1
	weapon_type = /obj/item/gun/magic/tentacle
	weapon_name_simple = "щупальце"
	silent = TRUE

/obj/item/gun/magic/tentacle
	name = "щупальце"
	desc = "Мясистое щупальце, которое может вытянуться и захватить вещи или людей."
	icon = 'icons/obj/changeling_items.dmi'
	icon_state = "tentacle"
	inhand_icon_state = "tentacle"
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	item_flags = NEEDS_PERMIT | ABSTRACT | DROPDEL | NOBLUDGEON
	flags_1 = NONE
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = NONE
	ammo_type = /obj/item/ammo_casing/magic/tentacle
	fire_sound = 'sound/effects/splat.ogg'
	force = 0
	max_charges = 1
	fire_delay = 1
	throwforce = 0 //Just to be on the safe side
	throw_range = 0
	throw_speed = 0

/obj/item/gun/magic/tentacle/Initialize(mapload, silent)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CHANGELING_TRAIT)
	if(ismob(loc))
		if(!silent)
			loc.visible_message("<span class='warning'>Рука <b>[loc.name]</b> начинает странно растягиваться!</span>", "<span class='warning'>Наша рука изгибается и мутирует, превращая ее в щупальце.</span>", "<span class='hear'>Слышу как что-то органическое разрывается!</span>")
		else
			to_chat(loc, "<span class='notice'>Мы готовимся вытянуть щупальце.</span>")


/obj/item/gun/magic/tentacle/shoot_with_empty_chamber(mob/living/user as mob|obj)
	to_chat(user, "<span class='warning'>Щупальце ещё не готово.</span>")

/obj/item/gun/magic/tentacle/process_fire()
	. = ..()
	if(charges == 0)
		qdel(src)

/obj/item/gun/magic/tentacle/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] coils [src] tightly around [user.p_their()] neck! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return (OXYLOSS)


/obj/item/ammo_casing/magic/tentacle
	name = "щупальце"
	desc = "Прикол."
	projectile_type = /obj/projectile/tentacle
	caliber = "tentacle"
	icon_state = "tentacle_end"
	firing_effect_type = null
	var/obj/item/gun/magic/tentacle/gun //the item that shot it

/obj/item/ammo_casing/magic/tentacle/Initialize()
	gun = loc
	. = ..()

/obj/item/ammo_casing/magic/tentacle/Destroy()
	gun = null
	return ..()

/obj/projectile/tentacle
	name = "щупальце"
	icon_state = "tentacle_end"
	pass_flags = PASSTABLE
	damage = 0
	damage_type = BRUTE
	range = 8
	hitsound = 'sound/weapons/thudswoosh.ogg'
	var/chain
	var/obj/item/ammo_casing/magic/tentacle/source //the item that shot it

/obj/projectile/tentacle/Initialize()
	source = loc
	. = ..()

/obj/projectile/tentacle/fire(setAngle)
	if(firer)
		chain = firer.Beam(src, icon_state = "tentacle", time = INFINITY)
	..()

/obj/projectile/tentacle/proc/reset_throw(mob/living/carbon/human/H)
	if(H.in_throw_mode)
		H.throw_mode_off() //Don't annoy the changeling if he doesn't catch the item

/obj/projectile/tentacle/proc/tentacle_grab(mob/living/carbon/human/H, mob/living/carbon/C)
	if(H.Adjacent(C))
		if(H.get_active_held_item() && !H.get_inactive_held_item())
			H.swap_hand()
		if(H.get_active_held_item())
			return
		C.grabbedby(H)
		C.grippedby(H, instant = TRUE) //instant aggro grab

/obj/projectile/tentacle/proc/tentacle_stab(mob/living/carbon/human/H, mob/living/carbon/C)
	if(H.Adjacent(C))
		for(var/obj/item/I in H.held_items)
			if(I.get_sharpness())
				C.visible_message("<span class='danger'><b>[H]</b> пронзает <b>[C]</b> своим [I.name]!</span>", "<span class='userdanger'><b>[H]</b> пронзает меня своим [I.name]!</span>")
				C.apply_damage(I.force, BRUTE, BODY_ZONE_CHEST)
				H.do_item_attack_animation(C, used_item = I)
				H.add_mob_blood(C)
				playsound(get_turf(H),I.hitsound,75,TRUE)
				return

/obj/projectile/tentacle/on_hit(atom/target, blocked = FALSE)
	var/mob/living/carbon/human/H = firer
	if(blocked >= 100)
		return BULLET_ACT_BLOCK
	if(isitem(target))
		var/obj/item/I = target
		if(!I.anchored)
			to_chat(firer, "<span class='notice'>Притягиваю <b>[I]</b> к себе.</span>")
			H.throw_mode_on()
			I.throw_at(H, 10, 2)
			. = BULLET_ACT_HIT

	else if(isliving(target))
		var/mob/living/L = target
		if(!L.anchored && !L.throwing)//avoid double hits
			if(iscarbon(L))
				var/mob/living/carbon/C = L
				var/firer_intent = INTENT_HARM
				var/mob/M = firer
				if(istype(M))
					firer_intent = M.a_intent
				switch(firer_intent)
					if(INTENT_HELP)
						C.visible_message("<span class='danger'><b>[L]</b> утягивается щупальцем <b>[H]</b>!</span>","<span class='userdanger'>Щупальце хватает меня и тянет к <b>[H]</b>!</span>")
						C.throw_at(get_step_towards(H,C), 8, 2)
						return BULLET_ACT_HIT

					if(INTENT_DISARM)
						var/obj/item/I = C.get_active_held_item()
						if(I)
							if(C.dropItemToGround(I))
								C.visible_message("<span class='danger'><b>[capitalize(I)]</b> выдёргивается из руки <b>[C]</b> щупальцем!</span>","<span class='userdanger'>Щупальце вырывает <b>[I]</b> из моей руки!</span>")
								on_hit(I) //grab the item as if you had hit it directly with the tentacle
								return BULLET_ACT_HIT
							else
								to_chat(firer, "<span class='warning'>У нас не вышло вырвать <b>[I]</b> из рук <b>[C]</b>!</span>")
								return BULLET_ACT_BLOCK
						else
							to_chat(firer, "<span class='danger'><b>[C]</b> ничего в руках и не держит!</span>")
							return BULLET_ACT_HIT

					if(INTENT_GRAB)
						C.visible_message("<span class='danger'><b>[L]</b> утягивает щупальце <b>[H]</b>!</span>","<span class='userdanger'>Щупальце хватает меня и тянет к <b>[H]</b>!</span>")
						C.throw_at(get_step_towards(H,C), 8, 2, H, TRUE, TRUE, callback=CALLBACK(src, .proc/tentacle_grab, H, C))
						return BULLET_ACT_HIT

					if(INTENT_HARM)
						C.visible_message("<span class='danger'><b>[L]</b> быстро улетает в сторону <b>[H]</b> под силой щупальца!</span>","<span class='userdanger'>Щупальце хватает меня и бросает к <b>[H]</b>!</span>")
						C.throw_at(get_step_towards(H,C), 8, 2, H, TRUE, TRUE, callback=CALLBACK(src, .proc/tentacle_stab, H, C))
						return BULLET_ACT_HIT
			else
				L.visible_message("<span class='danger'><b>[L]</b> утягивает щупальце <b>[H]</b>!</span>","<span class='userdanger'>Щупальце хватает меня и тянет к <b>[H]</b>!</span>")
				L.throw_at(get_step_towards(H,L), 8, 2)
				. = BULLET_ACT_HIT

/obj/projectile/tentacle/Destroy()
	qdel(chain)
	source = null
	return ..()


/***************************************\
|****************SHIELD*****************|
\***************************************/
/datum/action/changeling/weapon/shield
	name = "Органический щит"
	desc = "Мы превращаем одну из наших рук в жесткий щит. Стоит 20 химикатов."
	helptext = "Органическая ткань не может противостоять повреждениям всегда; щит сломается после того, как его ударили слишком сильно. Чем больше геномов мы поглощаем, тем он сильнее. Не может быть использовано в меньшей форме."
	button_icon_state = "organic_shield"
	chemical_cost = 20
	dna_cost = 1
	req_human = 1

	weapon_type = /obj/item/shield/changeling
	weapon_name_simple = "щит"

/datum/action/changeling/weapon/shield/sting_action(mob/user)
	var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling) //So we can read the absorbedcount.
	if(!changeling)
		return

	var/obj/item/shield/changeling/S = ..(user)
	S.remaining_uses = round(changeling.absorbedcount * 3)
	return TRUE

/obj/item/shield/changeling
	name = "щитообразная масса"
	desc = "Масса жесткой костной ткани. Мы все еще можем видеть пальцы в виде скрученного рисунка на щите."
	item_flags = ABSTRACT | DROPDEL
	icon = 'icons/obj/changeling_items.dmi'
	icon_state = "ling_shield"
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	block_chance = 50

	var/remaining_uses //Set by the changeling ability.

/obj/item/shield/changeling/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CHANGELING_TRAIT)
	if(ismob(loc))
		loc.visible_message("<span class='warning'>Конец руки [loc.name] быстро расширяется формируя щитообразное месиво!</span>", "<span class='warning'>Мы раздуваем нашу руку в сильный щит.</span>", "<span class='hear'>Слышу как что-то органическое разрывается!</span>")

/obj/item/shield/changeling/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(remaining_uses < 1)
		if(ishuman(loc))
			var/mob/living/carbon/human/H = loc
			H.visible_message("<span class='warning'>С отвратительным хрустом, <b>[H]</b> превращает щит в руку!</span>", "<span class='notice'>Мы возвращаем щит обратно в наше тело.</span>", "<span class='italics>Слышу как что-то органическое разрывается!</span>")
		qdel(src)
		return 0
	else
		remaining_uses--
		return ..()


/***************************************\
|*********SPACE SUIT + HELMET***********|
\***************************************/
/datum/action/changeling/suit/organic_space_suit
	name = "Органический скафандр"
	desc = "Мы выращиваем органический костюм, чтобы защитить себя от воздействия космоса. Стоит 20 химикатов."
	helptext = "Мы должны постоянно ремонтировать нашу форму, чтобы сделать ее космической, сокращая химическое производство, пока мы защищены. Не может использоваться в меньшей форме."
	button_icon_state = "organic_suit"
	chemical_cost = 20
	dna_cost = 2
	req_human = 1

	suit_type = /obj/item/clothing/suit/space/changeling
	helmet_type = /obj/item/clothing/head/helmet/space/changeling
	suit_name_simple = "костюм из плоти"
	helmet_name_simple = "шлем из плоти"
	recharge_slowdown = 0.5
	blood_on_castoff = 1

/obj/item/clothing/suit/space/changeling
	name = "плоть"
	icon_state = "lingspacesuit"
	desc = "Огромная, громоздкая масса, устойчивая к давлению и температуре, эволюционировала для облегчения космических путешествий."
	item_flags = DROPDEL
	clothing_flags = STOPSPRESSUREDAMAGE //Not THICKMATERIAL because it's organic tissue, so if somebody tries to inject something into it, it still ends up in your blood. (also balance but muh fluff)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/oxygen)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 90, "acid" = 90) //No armor at all.
	actions_types = list()
	cell = null

/obj/item/clothing/suit/space/changeling/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CHANGELING_TRAIT)
	if(ismob(loc))
		loc.visible_message("<span class='warning'>Плоть <b>[loc.name]</b> быстро надувается, образуя вздутую массу вокруг тела!</span>", "<span class='warning'>Мы раздуваем нашу плоть, создавая космический костюм!</span>", "<span class='hear'>Слышу как что-то органическое разрывается!</span>")
	START_PROCESSING(SSobj, src)

// seal the cell door
/obj/item/clothing/suit/space/changeling/toggle_spacesuit_cell(mob/user)
	return

/obj/item/clothing/suit/space/changeling/process()
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		H.reagents.add_reagent(/datum/reagent/medicine/salbutamol, REAGENTS_METABOLISM)
		H.adjust_bodytemperature(temperature_setting - H.bodytemperature) // force changelings to normal temp step mode played badly

/obj/item/clothing/head/helmet/space/changeling
	name = "плоть"
	icon_state = "lingspacehelmet"
	desc = "Покрытие из термостойкой органической ткани со стекловидным хитиновым покрытием."
	item_flags = DROPDEL
	clothing_flags = STOPSPRESSUREDAMAGE
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 90, "acid" = 90)
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH

/obj/item/clothing/head/helmet/space/changeling/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CHANGELING_TRAIT)

/***************************************\
|*****************ARMOR*****************|
\***************************************/
/datum/action/changeling/suit/armor
	name = "Хитиновый доспех"
	desc = "Мы превращаем нашу кожу в жесткий хитин, чтобы защитить нас от повреждений. Стоит 20 химикатов."
	helptext = "Содержание доспехов требует низких затрат химикатов. Броня сильна против грубой силы, но не обеспечивает достаточной защиты от лазеров. Не может использоваться в меньшей форме."
	button_icon_state = "chitinous_armor"
	chemical_cost = 20
	dna_cost = 1
	req_human = 1
	recharge_slowdown = 0.25

	suit_type = /obj/item/clothing/suit/armor/changeling
	helmet_type = /obj/item/clothing/head/helmet/changeling
	suit_name_simple = "хитиновый доспех"
	helmet_name_simple = "хитиновый шлем"

/obj/item/clothing/suit/armor/changeling
	name = "хитиновый доспех"
	desc = "Прочное твердое покрытие из черного хитина."
	icon_state = "lingarmor"
	item_flags = DROPDEL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor = list("melee" = 40, "bullet" = 40, "laser" = 40, "energy" = 50, "bomb" = 10, "bio" = 4, "rad" = 0, "fire" = 90, "acid" = 90)
	flags_inv = HIDEJUMPSUIT
	cold_protection = 0
	heat_protection = 0

/obj/item/clothing/suit/armor/changeling/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CHANGELING_TRAIT)
	if(ismob(loc))
		loc.visible_message("<span class='warning'>Плоть <b>[loc.name]</b> становится черной, быстро превращаясь в твердую хитиновую массу!</span>", "<span class='warning'>Мы укрепляем нашу плоть, создавая доспехи!</span>", "<span class='hear'>Слышу как что-то органическое разрывается!</span>")

/obj/item/clothing/head/helmet/changeling
	name = "хитиновый шлем"
	desc = "Прочное твердое покрытие из черного хитина с прозрачным хитином спереди."
	icon_state = "lingarmorhelmet"
	item_flags = DROPDEL
	armor = list("melee" = 40, "bullet" = 40, "laser" = 40, "energy" = 50, "bomb" = 10, "bio" = 4, "rad" = 0, "fire" = 90, "acid" = 90)
	flags_inv = HIDEEARS|HIDEHAIR|HIDEEYES|HIDEFACIALHAIR|HIDEFACE

/obj/item/clothing/head/helmet/changeling/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CHANGELING_TRAIT)
