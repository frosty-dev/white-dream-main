#define BADTRIP_COOLDOWN 180
/datum/reagent/drug/burpinate
    name = "Burpinate"
    description = "Они называют меня газообразной глиной."
    color = "#bfe8a7" // rgb: 191, 232, 167
    metabolization_rate = 0.9 * REAGENTS_METABOLISM
    taste_description = "мокрые хот-доги"

/datum/reagent/drug/burpinate/on_mob_life(mob/living/M)
    if(ishuman(M))
        var/mob/living/carbon/human/H = M
        if(prob(5+(current_cycle*0.6))) //burping intensifies
            H.emote("poo")
            if(prob(5))
                to_chat(H, "<span class='danger'>Я чувствую, что мой раздутый живот грохочет газом.</span>")

        if(current_cycle>90) //chance to burp = 55% (you can't stop burping)
            if(prob(5))
                to_chat(H, "<span class='danger'>Моё горло болит от всего газа, выходящего!</span>")
    return ..()

/datum/reagent/drug/fartium
	name = "Fartium"
	description = "Химическое соединение, которое способствует концентрированной выработке газа в области паха."
	color = "#8A4B08" // rgb: 138, 75, 8
	overdose_threshold = 30
	addiction_threshold = 50

/datum/reagent/drug/fartium/on_mob_life(mob/living/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(prob(7))
			H.emote("poo")
	return ..()

/datum/reagent/drug/fartium/overdose_process(mob/living/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(prob(9))
			H.emote("poo")
	return ..()

/datum/reagent/drug/fartium/addiction_act_stage1(mob/living/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(prob(11))
			H.emote("poo")
	return ..()

/datum/reagent/drug/fartium/addiction_act_stage2(mob/living/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(prob(13))
			H.emote("poo")
	return ..()

/datum/reagent/drug/fartium/addiction_act_stage3(mob/living/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(prob(15))
			H.emote("poo")
	return ..()

/datum/reagent/drug/fartium/addiction_act_stage4(mob/living/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(prob(15))
			H.emote("poo")
	return ..()

/datum/reagent/drug/nicotine
	description = "Немного увеличивает регенерацию выносливости и уменьшает чувство голода. При передозировке он нанесет вред токсинам и кислороду."

/datum/reagent/drug/nicotine/on_mob_life(mob/living/M)
	if(prob(1))
		var/smoke_message = pick("Я чувствую себя расслабленно.", "Я чувствую себя спокойно.","Я чувствую бдительность.","Я чувствую себя грубо.")
		to_chat(M, "<span class='notice'>[smoke_message]</span>")
	M.adjustStaminaLoss(-0.5*REM, 0)
	return FINISHONMOBLIFE(M)

/datum/reagent/drug/crank/on_mob_life(mob/living/M)
	var/high_message = pick("You feel jittery.", "You feel like you gotta go fast.", "You feel like you need to step it up.")
	if(prob(5))
		to_chat(M, "<span class='notice'>[high_message]</span>")
	M.AdjustStun(-20, 0)
	M.AdjustParalyzed(-20, 0)
	M.AdjustUnconscious(-20, 0)
	M.adjustToxLoss(2)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 1*REM)
	return FINISHONMOBLIFE(M)

/datum/reagent/drug/methamphetamine
	description = "Сокращает время оглушения примерно на 300% и позволяет пользователю быстро восстанавливать выносливость, нанося небольшой урон мозгу. Медленно распадается на гистамин и поражает пользователя большим количеством гистамина, если они оглушены. Плохо реагирует с эфедрином. При передозировке субъект будет двигаться случайно, смеяться случайным образом, бросать предметы и страдать от токсинов и повреждения мозга. Если он зависим, субъект будет постоянно дрожать и пускать слюни, прежде чем начнется головокружение и потеря моторного контроля, и в конечном итоге он получит тяжелые повреждения токсинами."

/datum/reagent/drug/methamphetamine/on_mob_life(mob/living/M)
	var/high_message = pick("Я чувствую скорость.", "Меня никто не остановит!", "Я чувствую, что могу взять мир в свои руки.")
	if(prob(5))
		to_chat(M, "<span class='notice'>[high_message]</span>")
	M.reagents.remove_reagent(/datum/reagent/medicine/diphenhydramine,2) //Greatly increases rate of decay
	if(M.IsStun() || M.IsParalyzed() || M.IsUnconscious())
		M.AdjustStun(-40, 0)
		M.AdjustParalyzed(-40, 0)
		M.AdjustUnconscious(-40, 0)
		var/amount2replace = rand(2,6)
		M.reagents.add_reagent(/datum/reagent/toxin/histamine,amount2replace)
		M.reagents.remove_reagent(/datum/reagent/drug/methamphetamine,amount2replace)
	M.adjustStaminaLoss(-2, 0)
	M.Jitter(2)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.25)
	if(prob(5))
		M.emote(pick("twitch", "shiver"))
		M.reagents.add_reagent(/datum/reagent/toxin/histamine, rand(1,5))
	return FINISHONMOBLIFE(M)

/datum/reagent/drug/bath_salts/on_mob_life(mob/living/M)
	var/high_message = pick("Я чувствую, что у меня есть силы.", "Я готов.", "Я чувствую, что могу довести это до предела.")
	if(prob(5))
		to_chat(M, "<span class='notice'>[high_message]</span>")
	M.add_movespeed_modifier(type, update=TRUE)
	M.AdjustUnconscious(-100, 0)
	M.AdjustStun(-100, 0)
	M.AdjustParalyzed(-100, 0)
	M.adjustStaminaLoss(-100, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5)
	M.adjustToxLoss(4)
	M.hallucination += 20
	if((M.mobility_flags & MOBILITY_MOVE) && !istype(M.loc, /atom/movable))
		step(M, pick(GLOB.cardinals))
		step(M, pick(GLOB.cardinals))
	if(prob(40))
		var/obj/item/I = M.get_active_held_item()
		if(I)
			M.dropItemToGround(M.get_active_held_item())
	return FINISHONMOBLIFE(M)

/datum/reagent/drug/bath_salts/on_mob_end_metabolize(mob/living/M)
	if (istype(M))
		M.remove_movespeed_modifier(type)
	..()

/datum/reagent/drug/flipout
	name = "Flipout"
	description = "Химическое соединение, вызывающее неконтролируемое и чрезвычайно сильное переворачивание."
	color = "#ff33cc" // rgb: 255, 51, 204
	overdose_threshold = 40
	addiction_threshold = 30


/datum/reagent/drug/flipout/on_mob_life(mob/living/M)
	var/high_message = pick("У меня есть неконтролируемое, всепоглощающее желание перевернуться!", "Я чувствую, как будто я перехожу на более высокий уровень существования.", "Я просто не могу остановить перевороты.")
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(prob(80))
			H.SpinAnimation(10,1)
		if(prob(10))
			M << "<span class='notice'>[high_message].</span>"

	..()
	return

/datum/reagent/drug/flipout/overdose_process(mob/living/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.SpinAnimation(16,100)
		if(prob(70))
			H.Dizzy(20)
			if((M.mobility_flags & MOBILITY_MOVE) && !istype(M.loc, /atom/movable))
				for(var/i = 0, i < 4, i++)
				step(M, pick(GLOB.cardinals))
		if(prob(15))
			M << "<span class='danger'>Переворот настолько интенсивен, что я начинаю уставать </span>"
			H.confused +=4
			M.adjustStaminaLoss(10)
			H.transform *= -1
	..()
	return

/datum/reagent/drug/flipout/addiction_act_stage1(mob/living/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(prob(85))
			H.SpinAnimation(12,1)
		else
			H.Dizzy(16)
	..()

/datum/reagent/drug/flipout/addiction_act_stage2(mob/living/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(prob(90))
			H.SpinAnimation(10,3)
		else
			H.Dizzy(20)
			M.adjustStaminaLoss(25)
	..()

/datum/reagent/drug/flipout/addiction_act_stage3(mob/living/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(prob(95))
			H.SpinAnimation(7,20)
		else
			H.Dizzy(30)
			M.adjustStaminaLoss(40)
	..()

/datum/reagent/drug/flipout/addiction_act_stage4(mob/living/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.SpinAnimation(2,100)
		if(prob(10))
			M << "<span class='danger'>Моё переворачивание стало настолько интенсивным, что я стал импровизированным генератором. </span>"
			H.Dizzy(25)
			M.electrocute_act(rand(1,5), 1, 1)
			playsound(M, "sparks", 50, 1)
			H.emote("scream")
			H.Jitter(-100)

		else
			H.Dizzy(60)
	..()

/datum/reagent/drug/flipout/expose_obj(obj/O, reac_volume)
	if(istype(O,/obj))
		O.SpinAnimation(16,40)

/datum/reagent/drug/yespowder
	name = "Yes Powder"
	description = "Порошок, который заставляет тебя сказать \"да\"."
	color = "#fffae0"

/datum/reagent/drug/yespowder/on_mob_life(mob/living/M)
	var/high_message = pick("Соглашение наполняет мой разум.", "'Нет' - прошлый век. 'Да' - это заебись.", "Да.")
	if(prob(5))
		to_chat(M, "<span class='notice'>[high_message]</span>")
	if(prob(20))
		M.say("Да.", forced = "yes powder")
	..()

/datum/reagent/drug/pupupipi
	name = "Sweet Brown"
	description = "Последняя надежда, которую часто пьют бродяги и бездельники. Высокие дозировки имеют... интересные эффекты."
	color = "#602101" // rgb: 96, 33, 1
	overdose_threshold = 100
	addiction_threshold = 50 // doesn't do shit though

/datum/reagent/drug/pupupipi/on_mob_life(mob/living/M)
	if(prob(5))
		var/high_message = pick("Мне нужен сладкий коричневый сок...", "Мои кишки дрожат...", "Я чувствую себя легкомысленным...")
		to_chat(M, "<span class='notice'>[high_message]</span>")
	M.Jitter(30)
	if(prob(15)) //once every six-ish ticks. is that ok?
		M.emote("burp")
	..()

/datum/reagent/drug/pupupipi/overdose_process(mob/living/carbon/human/H)
	CHECK_DNA_AND_SPECIES(H)
	H.setOrganLoss(ORGAN_SLOT_BRAIN, 30)
	if(ishuman(H))
		to_chat(H, "<span class= 'userdanger'>Вот блять!</span>")
		H.set_species(/datum/species/krokodil_addict)
	..()

/datum/reagent/drug/grape_blast
	name = "Grape Blast"
	description = "Сок очень особенных фруктов, концентрированный и продаваемый у вашего местного продавца А1."
	color = "#ffffe6"
	reagent_state = LIQUID
	taste_description = "искусственный виноград"
	var/obj/effect/hallucination/simple/druggy/brain
	var/bad_trip = FALSE
	var/badtrip_cooldown = 0
	var/list/sounds = list()

/datum/reagent/drug/grape_blast/proc/create_brain(mob/living/carbon/C)
	var/turf/T = locate(C.x + pick(-1, 1), C.y + pick(-1, 1), C.z)
	brain = new(T, C)

/datum/reagent/drug/grape_blast/on_mob_life(mob/living/carbon/H)
	if(!H && !H.hud_used)
		return
	if(prob(5))
		H.emote(pick("twitch","drool","moan"))
	var/high_message
	var/list/screens = list(H.hud_used.plane_masters["[FLOOR_PLANE]"], H.hud_used.plane_masters["[GAME_PLANE]"], H.hud_used.plane_masters["[LIGHTING_PLANE]"], H.hud_used.plane_masters["[CAMERA_STATIC_PLANE ]"], H.hud_used.plane_masters["[PLANE_SPACE_PARALLAX]"], H.hud_used.plane_masters["[PLANE_SPACE]"])
	switch(current_cycle)
		if(1 to 20)
			high_message = pick("Черт возьми, я так чертовски счастлив...", "Что, черт возьми, происходит?", "Где я?")
			if(prob(30)) //blurry eyes and talk like an idiot
				H.blur_eyes(2)
				H.derpspeech++
		if(31 to INFINITY)
			if(prob(20) && (H.mobility_flags & MOBILITY_MOVE) && !ismovable(H.loc))
				step(H, pick(GLOB.cardinals))
			if(H.client)
				sounds = H.client.SoundQuery()
				for(var/sound/S in sounds)
					if(S.len <= 3)
						PlaySpook(H, S.file, 23)
						sounds = list()
			high_message = pick("Я чувствую, что летаю!", "Я чувствую, что что-то плавает в моих легких...", "Я вижу слова, которые я говорю...")
			if(prob(25))
				var/rotation = max(min(round(current_cycle/4), 20),125)
				for(var/obj/screen/plane_master/whole_screen in screens)
					if(prob(60))
						animate(whole_screen, transform = turn(matrix(), rand(1,rotation)), time = 50, easing = CIRCULAR_EASING)
						animate(transform = turn(matrix(), -rotation), time = 10, easing = BACK_EASING)
					if(prob(30))
						animate(whole_screen, transform = turn(matrix(), rotation*rand(0.5,5)), time = 50, easing = QUAD_EASING)
						animate(whole_screen, transform = matrix()*1.5, time = 40, easing = BOUNCE_EASING)
					if(prob(15))
						whole_screen.filters += filter(type="wave", x=20*rand() - 20, y=20*rand() - 20, size=rand()*0.1, offset=rand()*0.5, flags = WAVE_BOUNDED)
						animate(whole_screen.filters[whole_screen.filters.len], size = rand(1,3), time = 30, easing = QUAD_EASING, loop = -1)
						to_chat(H, "<span class='notice'>Я чувствую, что реальность тает...</span>")
						addtimer(VARSET_CALLBACK(whole_screen, filters, list()), 1200)
				high_message = pick("Ебена мать...", "Реальность не существует, человек.", "...", "Никто не летает вокруг солнца.")
			else if(prob(5))
				create_brain(H)
				brain.spook(H)
			if(!bad_trip)
				if(prob(4))
					H.emote("laugh")
					H.say(pick("ГРЕРКРКРК",";ХАХА, Я БЛЯДЬ ПОД КАЙФОМ!!!","Я БАБОЧКА!!!"))
					H.visible_message("<span class='notice'>[H] выглядит охуенно высоко!</span>")
				else if(prob(3))
					H.Knockdown(20)
					H.emote("laugh")
					H.say(pick("ВКЛЮЧЕНО!!!","Я СЛЫШУ ГОЛОСА АХАХА","ТЫ ГОКУ!!!"))
					H.visible_message("<span class='notice'>[H] выглядит под крутым кайфом!</span>")
			if(prob(1) && badtrip_cooldown < world.time)
				bad_trip = TRUE
			if(bad_trip)
				for(var/obj/screen/plane_master/whole_screen in screens)
					if(prob(35))
						whole_screen.filters += filter(type="wave", x=30*rand() - 20, y=30*rand() - 20, size=rand()*0.5, offset=rand()*0.5)
						animate(whole_screen.filters[whole_screen.filters.len], size = rand(2,5), time = 60, easing = QUAD_EASING)
				var/list/t_ray_images = list()
				for(var/mob/living/L in orange(8, H) )
					if(!L.invisibility)
						var/image/I = new(loc = L)
						var/mutable_appearance/MA = new(L)
						MA.alpha = 128
						MA.dir = L.dir
						I.appearance = MA
						step(I, pick(GLOB.cardinals))
						t_ray_images += I
				if(t_ray_images.len)
					flick_overlay(t_ray_images, list(H.client), rand(10,30))
				high_message = pick("Я чувствую, как мои мысли гонятся!", "КТО, БЛЯДЬ, ЭТО СКАЗАЛ?!?!", "Я чувствую, что умру!")
				if(prob(25))
					H.hallucination += 2
					H.jitteriness += 3
					H.emote("me", 1, pick("быстро дышит", "задыхается"))
					H.confused += 2
				else if(prob(5))
					H.emote("cry")
					H.say(pick("ОСТАНОВИ ЭТО!! МНЕ ЖАЛЬ!!", ";Я СДЕЛАЮ ВСЕ, ЧТО УГОДНО, ЗАСТАВЬ ЭТО ОСТАНОВИТЬСЯ!!!", "ТЫ ДАЖЕ НЕ ПОБЕСПОКОИЛСЯ, ТЫ НЕ ВИДЕЛ, КАК ОНИ УШЛИ!!!", "ТЫ ХОЧЕШЬ УВИДЕТЬ, ЧТО ТАКОЕ РЕАЛЬНОСТЬ НА САМОМ ДЕЛЕ?!!"))
					H.visible_message("<span class='warning'>[H] appears to be freaking out!</span>")
				else if(prob(3))
					H.stop_sound_channel(CHANNEL_HEARTBEAT)
					H.playsound_local(H, 'sound/effects/singlebeat.ogg', 100, 0)
					if(prob(40))
						H.visible_message("<span class='warning'>[H] хватается за свою грудь и похоже это конец!</span>")
					H.adjustStaminaLoss(80)
				if(prob(3))
					addtimer(CALLBACK(src, .proc/end_bad_trip, H), 30)

	if(prob(5))
		to_chat(H, "<i>Я слышу свои собственные мысли... <b>[high_message]</i></b>")
	..()

/datum/reagent/drug/grape_blast/on_mob_end_metabolize(mob/living/L)
	cure_autism(L)
	..()

/datum/reagent/drug/grape_blast/proc/end_bad_trip(mob/living/carbon/human/H)
	bad_trip = FALSE
	badtrip_cooldown = world.time + BADTRIP_COOLDOWN
	H.visible_message("<span class='notice'>[H] похоже, успокаивается.</span>")
	H.emote("me", 1, pick("делает глубокий вдох", "расслабляется"))

/datum/reagent/drug/grape_blast/proc/cure_autism(mob/living/carbon/C)
	to_chat(C, "<span class='notice'>По мере того, как наркотики выходят, я чувствую, что медленно возвращаюсь к реальности...</span>")
	C.drowsyness++ //We feel sleepy after going through that trip.
	if(!HAS_TRAIT(C, TRAIT_DUMB))
		C.derpspeech = 0
	if(C && C.hud_used)
		var/list/screens = list(C.hud_used.plane_masters["[FLOOR_PLANE]"], C.hud_used.plane_masters["[GAME_PLANE]"], C.hud_used.plane_masters["[LIGHTING_PLANE]"], C.hud_used.plane_masters["[CAMERA_STATIC_PLANE ]"], C.hud_used.plane_masters["[PLANE_SPACE_PARALLAX]"], C.hud_used.plane_masters["[PLANE_SPACE]"])
		for(var/obj/screen/plane_master/whole_screen in screens)
			animate(whole_screen, transform = matrix(), time = 200, easing = ELASTIC_EASING)
			//animate(whole_screen.filters[whole_screen.filters.len], size = rand(2,5), time = 60, easing = QUAD_EASING)
			addtimer(VARSET_CALLBACK(whole_screen, filters, list()), 200) //reset filters
			addtimer(CALLBACK(whole_screen, /obj/screen/plane_master/.proc/backdrop, C), 201) //reset backdrop filters so they reappear
			PlaySpook(C, 'white/valtos/sounds/honk_echo_distant.ogg', 0, FALSE)

/obj/effect/hallucination/simple/druggy
	name = "Мой мозг"
	desc = "Ебать."
	image_icon = 'icons/obj/surgery.dmi'
	image_state = "brain"

/obj/effect/hallucination/simple/druggy/proc/spook(mob/living/L)
	sleep(20)
	var/image/I = image('icons/mob/talk.dmi', src, "default2", FLY_LAYER)
	var/message = "Это мой мозг под наркотиками."
	I.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA
	if(L)
		L.Hear(message, src, L.get_random_understood_language(), message)
		INVOKE_ASYNC(GLOBAL_PROC, /.proc/flick_overlay, I, list(L.client), 30)
	sleep(10)
	animate(src, transform = matrix()*0.75, time = 5)
	QDEL_IN(src, 30)

/datum/reagent/drug/grape_blast/proc/PlaySpook(mob/living/carbon/C, soundfile, environment = 0, vary = TRUE)
	var/sound/sound = sound(soundfile)
	sound.environment = environment //druggy
	sound.volume = rand(25,100)
	if(vary)
		sound.frequency = rand(10000,70000)
	SEND_SOUND(C.client, sound)

// white

/datum/reagent/drug/labebium
	name = "Labebium"
	description = "Пахнет интересно."
	color = "#999922"
	reagent_state = LIQUID
	taste_description = "моча"
	var/obj/effect/hallucination/simple/ovoshi/fruit
	var/obj/effect/hallucination/simple/water/flood
	var/obj/effect/hallucination/simple/ovoshi/statues/statuya
	var/list/trip_types = list("ovoshi", "statues")
	var/current_trip
	var/tripsoundstarted = FALSE
	var/list/shenanigans = list()
	var/list/sounds = list()

/datum/reagent/drug/labebium/on_mob_end_metabolize(mob/living/L)
	stop_shit(L)
	..()

/datum/reagent/drug/labebium/proc/stop_shit(mob/living/carbon/C)
	if(C && C.hud_used)
		if(!HAS_TRAIT(C, TRAIT_DUMB))
			C.derpspeech = 0
		C.cultslurring = 0
		C.hud_used.show_hud(HUD_STYLE_STANDARD)
		C.Paralyze(95)
		DIRECT_OUTPUT(C.client, sound(null))
		var/list/screens = list(C.hud_used.plane_masters["[FLOOR_PLANE]"], C.hud_used.plane_masters["[GAME_PLANE]"], C.hud_used.plane_masters["[LIGHTING_PLANE]"], C.hud_used.plane_masters["[CAMERA_STATIC_PLANE ]"], C.hud_used.plane_masters["[PLANE_SPACE_PARALLAX]"], C.hud_used.plane_masters["[PLANE_SPACE]"])
		for(var/obj/screen/plane_master/whole_screen in screens)
			animate(whole_screen, transform = matrix(), pixel_x = 0, pixel_y = 0, color = "#ffffff", time = 200, easing = ELASTIC_EASING)
			addtimer(VARSET_CALLBACK(whole_screen, filters, list()), 200) //reset filters
			addtimer(CALLBACK(whole_screen, /obj/screen/plane_master/.proc/backdrop, C), 201) //reset backdrop filters so they reappear
		to_chat(C, "<b><big>Неужели отпустило...</big></b>")

		if(C.client && current_cycle > 100)
			if(C.client.get_metabalance() < 0)
				to_chat(C, "<b><big>Эта терапия излечила мой аутизм.</big></b>")
				C.client.set_metacoin_count(0)
				return

		if(prob(50) && current_cycle > 50)
			spawn(30)
				to_chat(C, "<b><big>Или нет?!</big></b>")
				if(prob(50))
					spawn(50)
						to_chat(C, "<b><big>БЛЯЯЯЯЯЯЯЯЯЯЯЯЯЯЯЯТЬ!!!</big></b>")
						C.reagents.add_reagent_list(list(/datum/reagent/drug/labebium = 25))

/datum/reagent/drug/labebium/proc/create_flood(mob/living/carbon/C)
	for(var/turf/T in orange(14,C))
		if(prob(66))
			if(!(locate(flood) in T.contents))
				flood = new(T, C)

/datum/reagent/drug/labebium/proc/create_ovosh(mob/living/carbon/C)
	for(var/turf/T in orange(14,C))
		if(prob(23))
			if(!(locate(fruit) in T.contents))
				fruit = new(T, C, phrases = shenanigans)

/datum/reagent/drug/labebium/proc/create_statue(mob/living/carbon/C)
	for(var/turf/T in orange(14,C))
		if(prob(1))
			if(!(locate(statuya) in T.contents))
				statuya = new(T, C, phrases = shenanigans)

/datum/reagent/drug/labebium/on_mob_add(mob/living/L)
	. = ..()
	if (!current_trip)
		current_trip = pick(trip_types)
	var/json_file = file("data/npc_saves/Poly.json")
	if(!fexists(json_file))
		return
	var/list/json = r_json_decode(file2text(json_file))
	shenanigans = json["phrases"]
	return

/datum/reagent/drug/labebium/on_mob_life(mob/living/carbon/H)
	if(!H && !H.hud_used)
		return
	var/high_message
	var/list/screens = list(H.hud_used.plane_masters["[FLOOR_PLANE]"], H.hud_used.plane_masters["[GAME_PLANE]"], H.hud_used.plane_masters["[LIGHTING_PLANE]"], H.hud_used.plane_masters["[CAMERA_STATIC_PLANE ]"], H.hud_used.plane_masters["[PLANE_SPACE_PARALLAX]"], H.hud_used.plane_masters["[PLANE_SPACE]"])
	switch(current_trip)
		if("ovoshi")
			switch(current_cycle)
				if(1 to 20)
					high_message = "БЛЯТЬ! ТОЛЬКО НЕ ОВОЩИ!!!"
					if(prob(30))
						H.derpspeech++
						H.cultslurring++
					if(!tripsoundstarted)
						var/sound/sound = sound('white/valtos/sounds/lifeweb/cometodaddy.ogg', TRUE)
						sound.environment = 23
						sound.volume = 100
						SEND_SOUND(H.client, sound)
						create_ovosh(H)
						H.hud_used.show_hud(HUD_STYLE_NOHUD)
						H.emote("scream")
						tripsoundstarted = TRUE
				if(31 to INFINITY)
					if(prob(80) && (H.mobility_flags & MOBILITY_MOVE) && !ismovable(H.loc))
						step(H, pick(GLOB.cardinals))
					if(H.client)
						sounds = H.client.SoundQuery()
						for(var/sound/S in sounds)
							if(S.len <= 3)
								PlaySpook(H, S.file, 23)
								sounds = list()
					if(prob(85))
						H.Jitter(35)
						var/rotation = max(min(round(current_cycle/4), 20),360)
						for(var/obj/screen/plane_master/whole_screen in screens)
							if(prob(3))
								var/sound/sound = sound('white/valtos/sounds/trip_blast.wav')
								sound.environment = 23
								sound.volume = 100
								SEND_SOUND(H.client, sound)
								H.emote("scream")
								H.overlay_fullscreen("labebium", /obj/screen/fullscreen/labeb, rand(1, 23))
								H.clear_fullscreen("labebium", rand(15, 60))
								new /datum/hallucination/delusion(H, TRUE, duration = 150, skip_nearby = FALSE, custom_name = H.name)
								if(prob(50))
									spawn(30)
										H.overlay_fullscreen("labebium", /obj/screen/fullscreen/labeb, rand(1, 23))
										H.clear_fullscreen("labebium", rand(15, 60))
										H.emote("scream")
										if(prob(50))
											spawn(30)
												H.overlay_fullscreen("labebium", /obj/screen/fullscreen/labeb, rand(1, 23))
												H.clear_fullscreen("labebium", rand(15, 60))
												H.emote("scream")
							if(prob(40))
								H.stuttering = 90
								animate(whole_screen, color = color_matrix_rotate_hue(rand(0, 360)), transform = turn(matrix(), rand(1,rotation)), time = 150, easing = CIRCULAR_EASING)
								animate(transform = turn(matrix(), -rotation), time = 100, easing = BACK_EASING)
							if(prob(13))
								H.Jitter(100)
								whole_screen.filters += filter(type="wave", x=20*rand() - 20, y=20*rand() - 20, size=rand()*0.1, offset=rand()*0.5, flags = WAVE_BOUNDED)
								animate(whole_screen, transform = matrix()*2, time = 40, easing = BOUNCE_EASING)
								addtimer(VARSET_CALLBACK(whole_screen, filters, list()), 1200)
							addtimer(VARSET_CALLBACK(whole_screen, filters, list()), 600)
					high_message = "НУ НАХУЙ!!!"
					if(prob(5))
						animate(H.client, pixel_x = rand(-64,64), pixel_y = rand(-64,64), time = 100)
					create_flood(H)
					create_ovosh(H)
		if("statues")
			high_message = "Расслабон..."
			if(!tripsoundstarted)
				var/sound/sound = sound('white/valtos/sounds/lifeweb/caves8.ogg', TRUE)
				sound.environment = 23
				sound.volume = 80
				SEND_SOUND(H.client, sound)
				H.hud_used.show_hud(HUD_STYLE_NOHUD)
				tripsoundstarted = TRUE
			if(prob(15))
				for(var/obj/screen/plane_master/whole_screen in screens)
					animate(whole_screen, color = color_matrix_rotate_hue(rand(0, 360)), time = rand(5, 20))
			if(prob(15))
				if(H.client)
					sounds = H.client.SoundQuery()
					for(var/sound/S in sounds)
						if(S.len <= 3)
							PlaySpook(H, S.file, 23)
							sounds = list()
				create_statue(H)
				if(prob(3))
					var/sound/sound = sound('white/valtos/sounds/trip_blast.wav')
					sound.environment = 23
					sound.volume = 100
					SEND_SOUND(H.client, sound)
					H.overlay_fullscreen("labebium", /obj/screen/fullscreen/labeb, rand(1, 23))
					H.clear_fullscreen("labebium", rand(15, 60))
	if(prob(10))
		to_chat(H, "\n")
	if(prob(5))
		to_chat(H, "<b><big>[readable_corrupted_text(high_message)]</big></b>")
	..()

/datum/reagent/drug/labebium/proc/PlaySpook(mob/living/carbon/C, soundfile, environment = 0, vary = TRUE)
	var/sound/sound = sound(soundfile)
	sound.environment = environment //druggy
	sound.volume = rand(25,100)
	if(vary)
		sound.frequency = rand(10000,70000)
	SEND_SOUND(C.client, sound)

/obj/effect/hallucination/simple/water
	name = "ыххыхыхыыы"
	desc = "<big>АААААААААААААААААААААААА!!!</big>"
	image_icon = 'white/valtos/icons/lifeweb/water.dmi'
	image_state = "water0"
	image_layer = BYOND_LIGHTING_LAYER
	var/triggered_shit = FALSE

/obj/effect/hallucination/simple/water/New(turf/location_who_cares_fuck, mob/living/carbon/C, forced = TRUE)
	image_state = "water[rand(0, 7)]"
	. = ..()
	color = pick("#ff00ff", "#ff0000", "#0000ff", "#00ff00", "#00ffff")
	animate(src, color = color_matrix_rotate_hue(rand(0, 360)), time = 200, easing = CIRCULAR_EASING)
	QDEL_IN(src, rand(40, 200))

/obj/effect/hallucination/simple/water/Crossed(atom/movable/AM)
	. = ..()
	if(!triggered_shit)
		if(ishuman(AM))
			animate(src, pixel_y = 600, pixel_x = rand(-4, 4), time = 30, easing = BOUNCE_EASING)
			if(prob(10) && AM == target)
				var/mob/living/carbon/human/M = AM
				M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5, 170)
				to_chat(M, "<b>[readable_corrupted_text("ПШШШШШШШШШШШШШШШШШШШ!!!")]</b>")
				var/sound/sound = sound('white/valtos/sounds/pshsh.ogg')
				sound.environment = 23
				sound.volume = 20
				SEND_SOUND(M, sound)
				M.Paralyze(25)
			triggered_shit = TRUE


/obj/effect/hallucination/simple/ovoshi
	name = "Овощ"
	desc = "Ммм, заебись."
	image_icon = 'white/valtos/icons/lifeweb/harvest.dmi'
	image_state = "berrypile"
	var/list/states = list("berrypile", "chilipepper", "eggplant", "soybeans", \
		"plumphelmet", "carrot", "corn", "corn2", "corn_cob", "tomato", "ambrosiavulgaris", \
		"watermelon", "apple", "applestub", "appleold", "lime", "lemon", "poisonberrypile", \
		"grapes", "cabbage", "greengrapes", "orange", "potato", "potato-peeled", "wheat", \
		"ashroom", "cshroom", "eshroom", "fshroom", "amanita", "gshroom", "bshroom", "dshroom", \
		"bezglaznik", "krovnik", "pumpkin", "rice", "goldenapple", "gryab", "curer", "otorvyannik", \
		"glig", "beet", "turnip")
	image_layer = BYOND_LIGHTING_LAYER

/obj/effect/hallucination/simple/ovoshi/New(turf/location_who_cares_fuck, mob/living/carbon/C, forced = TRUE, list/phrases = list())
	image_state = pick(states)
	. = ..()
	SpinAnimation(rand(5, 40), TRUE, prob(50))
	pixel_x = (rand(-16, 16))
	pixel_y = (rand(-16, 16))
	if(prob(1) && C.client)
		if(!phrases.len)
			phrases = list("Мяу", "Кря")
		to_chat(C.client, "<b>[name]</b> <i>говорит</i>, <big>\"[readable_corrupted_text(pick(phrases))]\"</big>")
	animate(src, color = color_matrix_rotate_hue(rand(0, 360)), transform = matrix()*rand(1,3), time = 200, pixel_x = rand(-64,64), pixel_y = rand(-64,64), easing = CIRCULAR_EASING)
	QDEL_IN(src, rand(40, 200))

/obj/effect/hallucination/simple/ovoshi/attack_hand(mob/living/carbon/C)
	if(prob(10))
		to_chat(C, "<b>ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ!!!</b>")
	var/sound/sound = sound(pick('white/valtos/sounds/lifeweb/wallhit.ogg', \
		'white/valtos/sounds/lifeweb/wallhit2.ogg', 'white/valtos/sounds/lifeweb/wallhit3.ogg'))
	sound.environment = 23
	sound.volume = rand(50, 100)
	SEND_SOUND(C.client, sound)
	C.Paralyze(5)
	to_chat(C, "<span class='rose bold'>[prob(50) ? "Получено" : "Потеряно"] [rand(1, 20)] метакэша!</span>")
	. = ..()
	qdel(src)

/obj/effect/hallucination/simple/ovoshi/statues
	name = "Мяу"
	desc = "Ого!"
	image_icon = 'white/valtos/icons/lifeweb/crafts.dmi'
	image_state = "statue1"
	states = list("statue1", "statue2", "statue3", "statue4", \
		"statue6", "statue7", "seangel", "seangel2")

/obj/screen/fullscreen/labeb
	icon = 'white/valtos/icons/ruzone_went_up.dmi'
	layer = SPLASHSCREEN_LAYER
	plane = SPLASHSCREEN_PLANE
	screen_loc = "CENTER-7,SOUTH"
	icon_state = ""

/obj/item/reagent_containers/pill/labebium
	name = "таблетка правды"
	desc = "Выпей меня."
	icon_state = "pill5"
	list_reagents = list(/datum/reagent/drug/labebium = 15)

/obj/item/storage/pill_bottle/labebium
	name = "бутылочка правды"
	desc = "Поглощение одной такой таблетки превратит тебя в овоща. Я не шучу."

/obj/item/storage/pill_bottle/labebium/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/labebium(src)
