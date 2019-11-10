/*********************Ebonumba TOPOR****************/
/obj/item/twohanded/required/paxe
	name = "poleaxe"
	desc = "Одно из самых универсальных видов оружия."
	icon = 'code/shitcode/maxsc/icons/axe.dmi'
	icon_state = "axe1"
	item_state = "paxe1"
	lefthand_file = 'code/shitcode/maxsc/icons/lefthand.dmi'
	righthand_file = 'code/shitcode/maxsc/icons/righthand.dmi'
	block_chance = 10
	slot_flags = ITEM_SLOT_BACK
	force = 5
	force_wielded = 15
	throwforce = 20
	attack_verb = list("ударяет", "рубит", "протыкает", "режет")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = IS_SHARP
	custom_materials = list(MAT_METAL=5000)
	max_integrity = 200

/obj/item/twohanded/required/paxe/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 60, 110)

/obj/item/twohanded/required/paxee
	name = "poleaxe of law"
	desc = "Одно из самых универсальных видов оружия. Оружие справедливости."
	icon = 'code/shitcode/maxsc/icons/axe.dmi'
	icon_state = "axe1"
	item_state = "paxe1"
	lefthand_file = 'code/shitcode/maxsc/icons/lefthand.dmi'
	righthand_file = 'code/shitcode/maxsc/icons/righthand.dmi'
	block_chance = 0
	slot_flags = ITEM_SLOT_BACK
	force = 5
	force_wielded = 20
	throwforce = 24
	attack_verb = list("ударяет", "приносит справедливость", "рубит", "протыкает")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = IS_SHARP
	custom_materials = list(MAT_METAL=5000)
	max_integrity = 200
	var/charged = TRUE
	var/recharge_time = 600

/obj/item/twohanded/required/paxee/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 60, 110)

/obj/item/twohanded/required/paxee/attack_self(mob/user)
	if (charged)
		to_chat(user, "<span class='notice'>Вы готовы нести справедливость.</span>")
		charged = FALSE
		block_chance = 100
		sleep(30)
		to_chat(user, "<span class='notice'>Сейчас вы не готовы нести справедливость.</span>")
		block_chance = 0
		addtimer(CALLBACK(src, .proc/Recharge), recharge_time)

/obj/item/twohanded/required/paxee/proc/Recharge()
	if(!charged)
		charged = TRUE

/obj/item/twohanded/required/paxee/examine(mob/living/user)
	..()
	if (charged)
		to_chat(user, "Вы чувствуете невероятную силу, исходящую из этого.")
	else
		to_chat(user, "Выглядит нормально.")

/obj/item/twohanded/required/paxee/attack(mob/living/target, mob/living/carbon/user)
	if (istype(user, /mob/living/carbon/human/) && block_chance == 100)
		var/mob/living/carbon/human/H = user
		H.say("AD MORTEM INIMICUS!!!", ignore_spam = TRUE)
	..()

/obj/item/book/manual/wiki/security_space_law/afterattack(atom/target, mob/living/user, proximity_flag, clickparams)
	. = ..()
	if (istype(target, /obj/item/twohanded/required/paxe))
		to_chat(user, "<span class='notice'>Вы улучшаете алебарду властью, данною вам законом.</span>")
		var/obj/item/twohanded/required/paxe/I = target
		new /obj/item/twohanded/required/paxee(I.loc)
		qdel(I)
		for (var/mob/i in GLOB.player_list)
			if (istype (i, /mob/living/carbon/human/))
				var/mob/living/carbon/human/H = i
				to_chat(H, "<span class='warning'>Вы чувствуете высвобождение сил ебонумбы.</span>")
