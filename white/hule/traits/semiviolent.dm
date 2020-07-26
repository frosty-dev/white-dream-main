/datum/quirk/semiviolent
	name = "Полупацифист"
	desc = "Мысль о насилии заставляет вас чувствовать себя неприятно. Но всему есть предел..."
	value = 0
	//mob_trait = TRAIT_PACIFISM
	gain_text = "<span class='danger'>Я чувствую себя жутко, подумав о насилии!</span>"
	lose_text = "<span class='notice'>Я чувствую, что смогу защитить себя вновь.</span>"
	medical_record_text = "Пациент является пацифистом и не может заставить себя причинить вред кому-либо."
	var/ragemode_time = 0
	var/duration = 60
	var/cooldown = 360

/datum/quirk/semiviolent/on_spawn()
	ADD_TRAIT(quirk_holder, TRAIT_PACIFISM, "semiviolent")

/datum/quirk/semiviolent/on_process()
	if(ragemode_time > 0)
		ragemode_time--
		//quirk_holder.create_tension(2)
		return
	else if(ragemode_time < 0)
		ragemode_time++
		return

	if(quirk_holder.health < 65 && HAS_TRAIT_FROM(quirk_holder,TRAIT_PACIFISM, "semiviolent"))
		REMOVE_TRAIT(quirk_holder, TRAIT_PACIFISM, "semiviolent")

		ragemode_time += duration
		quirk_holder.reagents.add_reagent(/datum/reagent/medicine/ephedrine,2)
		rage_effect()
		//quirk_holder.create_tension(60)

	else if(!HAS_TRAIT_FROM(quirk_holder,TRAIT_PACIFISM, "semiviolent"))
		ADD_TRAIT(quirk_holder, TRAIT_PACIFISM, "semiviolent")

		ragemode_time -= cooldown
		quirk_holder.reagents.add_reagent(/datum/reagent/toxin/skewium,5)

/datum/quirk/semiviolent/proc/rage_effect()
	if(!quirk_holder.client || !iscarbon(quirk_holder))
		return
	var/mob/living/carbon/M = quirk_holder

	//to_chat(M, "<span class='reallybig redtext'>RIP AND TEAR</span>")

	var/old_color = M.client.color

	var/static/list/red_splash = list(1,0,0,0.8,0.2,0, 0.8,0,0.2,0.1,0,0)
	var/static/list/pure_red = list(0,0,0,0,0,0,0,0,0,1,0,0)

	animate(M.client,color = red_splash, time = 10, easing = SINE_EASING|EASE_OUT)
	sleep(10)
	animate(M.client,color = old_color, time = duration)//, easing = SINE_EASING|EASE_OUT)

