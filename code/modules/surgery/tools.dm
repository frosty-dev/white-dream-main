/obj/item/retractor
	name = "расширитель"
	desc = "Расширяет штуки."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "retractor"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	inhand_icon_state = "clamps"
	custom_materials = list(/datum/material/iron=6000, /datum/material/glass=3000)
	flags_1 = CONDUCT_1
	item_flags = SURGICAL_TOOL
	w_class = WEIGHT_CLASS_TINY
	tool_behaviour = TOOL_RETRACTOR
	toolspeed = 1

/obj/item/retractor/augment
	desc = "Микромеханический манипулятор для расширения штук."
	toolspeed = 0.5


/obj/item/hemostat
	name = "зажим"
	desc = "Вы думаете, что видели это раньше."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "hemostat"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	inhand_icon_state = "clamps"
	custom_materials = list(/datum/material/iron=5000, /datum/material/glass=2500)
	flags_1 = CONDUCT_1
	item_flags = SURGICAL_TOOL
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("атакует", "прокусывает")
	tool_behaviour = TOOL_HEMOSTAT
	toolspeed = 1

/obj/item/hemostat/augment
	desc = "Крошечные сервоприводы приводят пару клещей в действие, чтобы остановить кровотечение."
	toolspeed = 0.5


/obj/item/cautery
	name = "термокаутер"
	desc = "Это останавливает кровотечения."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "cautery"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	inhand_icon_state = "cautery"
	custom_materials = list(/datum/material/iron=2500, /datum/material/glass=750)
	flags_1 = CONDUCT_1
	item_flags = SURGICAL_TOOL
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("прожигает")
	tool_behaviour = TOOL_CAUTERY
	toolspeed = 1

/obj/item/cautery/augment
	desc = "Нагревательный элемент, который прижигает раны."
	toolspeed = 0.5


/obj/item/surgicaldrill
	name = "хирургическая дрель"
	desc = "Можно просверлить с помощью этого что-то. Или пробурить?"
	icon = 'icons/obj/surgery.dmi'
	icon_state = "drill"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	hitsound = 'sound/weapons/circsawhit.ogg'
	custom_materials = list(/datum/material/iron=10000, /datum/material/glass=6000)
	flags_1 = CONDUCT_1
	item_flags = SURGICAL_TOOL | EYE_STAB
	force = 15
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("дырявит")
	tool_behaviour = TOOL_DRILL
	toolspeed = 1

/obj/item/surgicaldrill/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] rams [src] into [user.p_their()] chest! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	addtimer(CALLBACK(user, /mob/living/carbon.proc/gib, null, null, TRUE, TRUE), 25)
	user.SpinAnimation(3, 10)
	playsound(user, 'sound/machines/juicer.ogg', 20, TRUE)
	return (MANUAL_SUICIDE)

/obj/item/surgicaldrill/augment
	desc = "По сути, небольшая электрическая дрель, содержащаяся в руке, края притуплены, чтобы предотвратить повреждение тканей. Может или не может пронзить небеса."
	hitsound = 'sound/weapons/circsawhit.ogg'
	force = 10
	w_class = WEIGHT_CLASS_SMALL
	toolspeed = 0.5


/obj/item/scalpel
	name = "скальпель"
	desc = "Резать, резать и еще раз резать."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "scalpel"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	inhand_icon_state = "scalpel"
	flags_1 = CONDUCT_1
	item_flags = SURGICAL_TOOL | EYE_STAB
	force = 10
	w_class = WEIGHT_CLASS_TINY
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	custom_materials = list(/datum/material/iron=4000, /datum/material/glass=1000)
	attack_verb = list("атакует", "рубит", "втыкает", "разрезает", "кромсает", "разрывает", "нарезает", "режет")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = IS_SHARP_ACCURATE
	tool_behaviour = TOOL_SCALPEL
	toolspeed = 1
	bare_wound_bonus = 20

/obj/item/scalpel/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 80 * toolspeed, 100, 0)

/obj/item/scalpel/augment
	desc = "Ультра-острое лезвие прикреплено непосредственно к кости для дополнительной точности."
	toolspeed = 0.5

/obj/item/scalpel/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is slitting [user.p_their()] [pick("wrists", "throat", "stomach")] with [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return (BRUTELOSS)


/obj/item/circular_saw
	name = "циркулярная пила"
	desc = "Для тяжелой резки."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "saw"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	hitsound = 'sound/weapons/circsawhit.ogg'
	mob_throw_hit_sound =  'sound/weapons/pierce.ogg'
	flags_1 = CONDUCT_1
	item_flags = SURGICAL_TOOL
	force = 15
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 9
	throw_speed = 2
	throw_range = 5
	custom_materials = list(/datum/material/iron=1000)
	attack_verb = list("атакует", "рубит", "пилит", "режет")
	sharpness = IS_SHARP
	tool_behaviour = TOOL_SAW
	toolspeed = 1
	wound_bonus = 10
	bare_wound_bonus = 15

/obj/item/circular_saw/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 40 * toolspeed, 100, 5, 'sound/weapons/circsawhit.ogg') //saws are very accurate and fast at butchering

/obj/item/circular_saw/augment
	desc = "Маленькая, но очень быстро вращающаяся пила. Края притуплены, чтобы предотвратить случайные порезы внутри хирурга."
	w_class = WEIGHT_CLASS_SMALL
	force = 10
	toolspeed = 0.5

/obj/item/surgical_drapes
	name = "хирургическая простыня"
	desc = "Хирургические простыни марки Нанотрейзен обеспечивают оптимальную безопасность и защиту от инфекций."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "surgical_drapes"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	inhand_icon_state = "drapes"
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("шлёпает")

/obj/item/surgical_drapes/attack(mob/living/M, mob/user)
	if(!attempt_initiate_surgery(src, M, user))
		..()

/obj/item/organ_storage //allows medical cyborgs to manipulate organs without hands
	name = "сумка для хранения органов"
	desc = "Контейнер для хранения частей тела."
	icon = 'icons/obj/storage.dmi'
	icon_state = "evidenceobj"
	item_flags = SURGICAL_TOOL

/obj/item/organ_storage/afterattack(obj/item/I, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(contents.len)
		to_chat(user, "<span class='warning'>[src] уже что-то хранит!</span>")
		return
	if(!isorgan(I) && !isbodypart(I))
		to_chat(user, "<span class='warning'>[src] может содержать только части тела!</span>")
		return

	user.visible_message("<span class='notice'>[user] кладёт [I] внутрь [src].</span>", "<span class='notice'>Кладу [I] внутрь [src].</span>")
	icon_state = "evidence"
	var/xx = I.pixel_x
	var/yy = I.pixel_y
	I.pixel_x = 0
	I.pixel_y = 0
	var/image/img = image("icon"=I, "layer"=FLOAT_LAYER)
	img.plane = FLOAT_PLANE
	I.pixel_x = xx
	I.pixel_y = yy
	add_overlay(img)
	add_overlay("evidence")
	desc = "Контейнер содержит [I]."
	I.forceMove(src)
	w_class = I.w_class

/obj/item/organ_storage/attack_self(mob/user)
	if(contents.len)
		var/obj/item/I = contents[1]
		user.visible_message("<span class='notice'>[user] вытряхивает [I] из [src].</span>", "<span class='notice'>Вытряхиваю [I] из [src].</span>")
		cut_overlays()
		I.forceMove(get_turf(src))
		icon_state = "evidenceobj"
		desc = "Контейнер для хранения частей тела."
	else
		to_chat(user, "<span class='notice'>[src] пуст.</span>")
	return

/obj/item/surgical_processor //allows medical cyborgs to scan and initiate advanced surgeries
	name = "Хирургический процессор"
	desc = "Устройство для сканирования и запуска операций с диска или операционного компьютера."
	icon = 'icons/obj/device.dmi'
	icon_state = "spectrometer"
	item_flags = NOBLUDGEON
	var/list/advanced_surgeries = list()

/obj/item/surgical_processor/afterattack(obj/item/O, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(istype(O, /obj/item/disk/surgery))
		to_chat(user, "<span class='notice'>Загружаю хирургический протокол из [O] в [src].</span>")
		var/obj/item/disk/surgery/D = O
		if(do_after(user, 10, target = O))
			advanced_surgeries |= D.surgeries
		return TRUE
	if(istype(O, /obj/machinery/computer/operating))
		to_chat(user, "<span class='notice'>Копирую хирургический протокол из [O] в [src].</span>")
		var/obj/machinery/computer/operating/OC = O
		if(do_after(user, 10, target = O))
			advanced_surgeries |= OC.advanced_surgeries
		return TRUE
	return

/obj/item/scalpel/advanced
	name = "лазерный скальпель"
	desc = "Усовершенствованный скальпель, который использует лазерную технологию для резки."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "scalpel_a"
	hitsound = 'sound/weapons/blade1.ogg'
	force = 16
	toolspeed = 0.7
	light_color = LIGHT_COLOR_GREEN
	sharpness = IS_SHARP_ACCURATE

/obj/item/scalpel/advanced/Initialize()
	. = ..()
	set_light(1)

/obj/item/scalpel/advanced/attack_self(mob/user)
	playsound(get_turf(user), 'sound/machines/click.ogg', 50, TRUE)
	if(tool_behaviour == TOOL_SCALPEL)
		tool_behaviour = TOOL_SAW
		to_chat(user, "<span class='notice'>Увеличиваю мощность [src]. Теперь он может резать кости.</span>")
		set_light(2)
		force += 1 //we don't want to ruin sharpened stuff
		icon_state = "saw_a"
	else
		tool_behaviour = TOOL_SCALPEL
		to_chat(user, "<span class='notice'>Уменьшаю мощность [src]. Теперь он не может резать кости.</span>")
		set_light(1)
		force -= 1
		icon_state = "scalpel_a"

/obj/item/scalpel/advanced/examine()
	. = ..()
	. += " Переключатель стоит на [tool_behaviour == TOOL_SCALPEL ? "скальпеле" : "пиле"]."

/obj/item/retractor/advanced
	name = "механические зажимы"
	desc = "Агломерация шатунов и зубчатых колес."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "retractor_a"
	toolspeed = 0.7

/obj/item/retractor/advanced/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_drill.ogg', 50, TRUE)
	if(tool_behaviour == TOOL_RETRACTOR)
		tool_behaviour = TOOL_HEMOSTAT
		to_chat(user, "<span class='notice'>Настраиваю шестерни [src], теперь они в режиме зажима.</span>")
		icon_state = "hemostat_a"
	else
		tool_behaviour = TOOL_RETRACTOR
		to_chat(user, "<span class='notice'>Настраиваю шестерни [src], теперь они в режиме расширителя.</span>")
		icon_state = "retractor_a"

/obj/item/retractor/advanced/examine()
	. = ..()
	. += " Находится в положении [tool_behaviour == TOOL_RETRACTOR ? "расширителя" : "зажима"]."

/obj/item/surgicaldrill/advanced
	name = "жгучий инструмент"
	desc = "Он проектирует мощный лазер для медицинского применения."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "surgicaldrill_a"
	hitsound = 'sound/items/welder.ogg'
	toolspeed = 0.7
	light_color = LIGHT_COLOR_RED

/obj/item/surgicaldrill/advanced/Initialize()
	. = ..()
	set_light(1)

/obj/item/surgicaldrill/advanced/attack_self(mob/user)
	playsound(get_turf(user), 'sound/weapons/tap.ogg', 50, TRUE)
	if(tool_behaviour == TOOL_DRILL)
		tool_behaviour = TOOL_CAUTERY
		to_chat(user, "<span class='notice'>Фокусирую линзы инструмента, теперь он может прижигать раны.</span>")
		icon_state = "cautery_a"
	else
		tool_behaviour = TOOL_DRILL
		to_chat(user, "<span class='notice'>Ставлю линзы инструмента на место, теперь он может сверлить кости.</span>")
		icon_state = "surgicaldrill_a"

/obj/item/surgicaldrill/advanced/examine()
	. = ..()
	. += " It's set to [tool_behaviour == TOOL_DRILL ? "drilling" : "mending"] mode."

/obj/item/shears
	name = "ножницы для ампутации"
	desc = "Тип тяжелых хирургических ножниц, используемых для достижения чистого разделения между конечностью и пациентом. Держать пациента по-прежнему необходимо, чтобы иметь возможность закрепить и выровнять ножницы."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "shears"
	flags_1 = CONDUCT_1
	item_flags = SURGICAL_TOOL
	toolspeed  = 1
	force = 12
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 6
	throw_speed = 2
	throw_range = 5
	custom_materials = list(/datum/material/iron=8000, /datum/material/titanium=6000)
	attack_verb = list("стрижёт", "режет")
	sharpness = IS_SHARP
	custom_premium_price = 1800

/obj/item/shears/attack(mob/living/M, mob/user)
	if(!iscarbon(M) || user.a_intent != INTENT_HELP)
		return ..()

	if(user.zone_selected == BODY_ZONE_CHEST)
		return ..()

	var/mob/living/carbon/patient = M

	if(HAS_TRAIT(patient, TRAIT_NODISMEMBER))
		to_chat(user, "<span class='warning'>Конечности пациента выглядят слишком крепкими для ампутации.</span>")
		return

	var/candidate_name
	var/obj/item/organ/tail_snip_candidate
	var/obj/item/bodypart/limb_snip_candidate

	if(user.zone_selected == BODY_ZONE_PRECISE_GROIN)
		tail_snip_candidate = patient.getorganslot(ORGAN_SLOT_TAIL)
		if(!tail_snip_candidate)
			to_chat(user, "<span class='warning'>[patient] не имеет хвоста.</span>")
			return
		candidate_name = tail_snip_candidate.name

	else
		limb_snip_candidate = patient.get_bodypart(check_zone(user.zone_selected))
		if(!limb_snip_candidate)
			to_chat(user, "<span class='warning'>[patient] не имеет здесь конечности, че ещё блять?</span>")
			return
		candidate_name = limb_snip_candidate.name

	var/amputation_speed_mod

	patient.visible_message("<span class='danger'>[user] начинает устанавливать [src] вокруг [candidate_name] [patient].</span>", "<span class='userdanger'>[user] начинает закреплять [src] вокруг моей [candidate_name]!</span>")
	playsound(get_turf(patient), 'sound/items/ratchet.ogg', 20, TRUE)
	if(patient.stat == DEAD || patient.stat == UNCONSCIOUS || patient.IsStun()) //Stun is used by paralytics like curare it should not be confused with the more common paralyze.
		amputation_speed_mod = 0.5
	else if(patient.jitteriness >= 1)
		amputation_speed_mod = 1.5
	else
		amputation_speed_mod = 1

	if(do_after(user,  toolspeed * 150 * amputation_speed_mod, target = patient))
		playsound(get_turf(patient), 'sound/weapons/bladeslice.ogg', 250, TRUE)
		if(user.zone_selected == BODY_ZONE_PRECISE_GROIN) //OwO
			tail_snip_candidate.Remove(patient)
			tail_snip_candidate.forceMove(get_turf(patient))
		else
			limb_snip_candidate.dismember()
		user.visible_message("<span class='danger'>[src] яростно захлопывается, ампутируя [candidate_name] [patient].</span>", "<span class='notice'>Ампутирую [candidate_name] [patient] используя [src].</span>")

/obj/item/bonesetter
	name = "костоправ"
	desc = "Для правильной настройки."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "bone setter"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	custom_materials = list(/datum/material/iron=5000, /datum/material/glass=2500)
	flags_1 = CONDUCT_1
	item_flags = SURGICAL_TOOL
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("корректирует", "правильно устанавливает")
	tool_behaviour = TOOL_BONESET
	toolspeed = 1
