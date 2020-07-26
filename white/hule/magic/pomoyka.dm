/turf/open/floor/plating/conc
	name = "Магический бетон"
	icon = 'white/hule/icons/obj/pomoyka.dmi'
	icon_plating = "concrete0"
	icon_state = "concrete0"

/turf/open/floor/plating/conc/Initialize()
	. = ..()
	if(prob(25))
		var/r = rand(1,2)
		icon_plating = "concrete[r]"
		icon_state = "concrete[r]"

/*
/obj/item/stack/tile/conc
	name = "Магическая пластиковая имитация бетона"
	desc = "Нахуя? Кто это придумал?"
	icon = 'white/hule/magic/pomoyka/pomoyka.dmi'
	icon_state = "conc-tile"
	turf_type = /turf/open/floor/plating/conc
	resistance_flags = FLAMMABLE
*/

/obj/structure/tyre
	name = "Покрышка от ПАЗика"
	icon = 'white/hule/icons/obj/pomoyka.dmi'
	icon_state = "shina0"
	desc = ""
	resistance_flags = FLAMMABLE
	max_integrity = 100
	anchored = TRUE

/obj/structure/tyre/pile
	name = "Куча покрышек"
	desc = "Куча покрышек, реализованная в виде стека"
	icon_state = "shina4"
	max_integrity = 200
	density = TRUE

/obj/structure/tyre/pile/Initialize()
	. = ..()
	if(prob(30))
		icon_state = "shina[rand(1,3)]"

/obj/structure/tbin
	name = "Мусорка"
	icon = 'white/hule/icons/obj/pomoyka.dmi'
	icon_state = "yashik_musor0"
	resistance_flags = FIRE_PROOF
	max_integrity = 400
	anchored = TRUE
	density = TRUE

/obj/structure/tbin/Initialize()
	. = ..()
	if(prob(50))
		icon_state = "yashik_musor1"

/obj/structure/tbin/full
	name = "Магическая мусорка"
	desc = "Полная неизведанного мусорка"
	icon_state = "yashik_musor0_full"
	var/list/lootn = list(	/obj/item/shard,
							/obj/item/reagent_containers/syringe
						)
	var/list/lootold = list(/obj/item/reagent_containers/food/snacks/grown/tomato,
							/obj/item/reagent_containers/food/snacks/grown/eggplant,
							/obj/item/reagent_containers/food/snacks/grown/carrot,
							/obj/item/reagent_containers/food/snacks/grown/apple,
							/obj/item/reagent_containers/food/snacks/grown/potato
						)
	var/list/lootr = list(	/obj/item/seeds/reishi,
							/obj/item/reagent_containers/food/snacks/khachapuri,
							/obj/item/soap,
							/obj/item/switchblade
						)
	var/ageb = 50
	var/usesleft = 10
	var/time = 0
	var/time2use = 300

/obj/structure/tbin/full/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)
	if(prob(50))
		icon_state = "yashik_musor1_full"


/obj/structure/tbin/full/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/structure/tbin/full/process()
	time++
	if(time >= time2use)
		time = 0
		usesleft++

/obj/structure/tbin/full/proc/spawnjunk(list/L, mob/M)
	var/obj/O = pick(L)
	var/obj/I = new O(get_turf(src),src)
	to_chat(M,"<span class='notice'>Ебать, целый [I.name] в мусорке!</span>")

/obj/structure/tbin/full/verb/use()
	set category = "IC"
	set name = "Порыться в муосрке"
	set src in view(1)

	if(usesleft <= 0)
		to_chat(usr,"<span class='notice'>Эта мусорка пуста</span>")
		return

	if(!ismonkey(usr)&&!ishuman(usr)|| usr.stat)
		to_chat(usr,"<span class='warning'>Ты што дэбил ты неможеш рыца в мусорке ТЫ ШТО</span>")
		return

	if(prob(30))
		if(ishuman(usr))
			var/mob/living/carbon/human/H = usr
			if(H.age >= ageb && rand(30))
				spawnjunk(lootold, H)
			else
				spawnjunk(lootn, H)
		else
			spawnjunk(lootn, usr)

		if(prob(1))
			spawnjunk(lootr, usr)
		usesleft--
	else
		to_chat(usr,"<span class='notice'>А тут ничего нет...</span>")

/obj/effect/proc_holder/spell/targeted/pomoyka
	name = "Призыв Сердца Помойки"
	desc = "Этот анекдот призывает магическую помойку из другого мира тупо исекай!!!!!"
	school = "College of руснявый humor, Manayamirok state, USA"
	charge_max = 100
	clothes_req = FALSE
	invocation = "V GOLOVU"
	invocation_type = "shout"
	sound = 'white/hule/SFX/anekdot_delimiter.ogg'
	action_icon_state = "shield"
	range = -1
	include_user = TRUE

/obj/effect/proc_holder/spell/targeted/pomoyka/cast(list/targets,mob/user = usr)
	new /obj/structure/pomoyka(get_turf(user),user)

	for(var/obj/effect/proc_holder/spell/aspell in user.mind.spell_list)
		if("Призыв Сердца Помойки" == aspell.name)
			user.mind.spell_list.Remove(aspell)

/obj/structure/pomoyka
	name = "Сердце Помойки"
	desc = ""
	icon = 'white/hule/icons/obj/pomoyka.dmi'
	icon_state = "fawkes"
	anchored = TRUE
	opacity = 0
	density = TRUE
	max_integrity = 1000
	var/radius = 1
	var/timemul = 2
	var/time = 0
	var/bdmgmul = 10
	var/bdmgacc = 0
	var/bdmg = 7
	var/list/musor = list(	/obj/structure/tyre,
							/obj/structure/tyre/pile,
							/obj/structure/tbin/full
						)

/obj/structure/pomoyka/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)
	for(var/turf/open/floor/T in range(radius, src))
		T.ChangeTurf(/turf/open/floor/plating/conc)


/obj/structure/pomoyka/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/structure/pomoyka/process()
	desc = "Пипец пафосное название прямо как в анимэ \nВремя: [time] / [timemul ** radius] \nРадиус: [radius] \nЭнергия: [bdmgacc] / [radius * bdmgmul]"
	for(var/mob/living/carbon/human/H in range(radius, src))
		var/bhp = 200 - H.getOrganLoss(ORGAN_SLOT_BRAIN)
		if(bhp > bdmg)
			H.adjustOrganLoss(ORGAN_SLOT_BRAIN, bdmg)
			bdmgacc += bdmg
		/*else if(bhp > 0)
			H.adjustBrainLoss(bhp)
			bdmgacc += bhp*/

	if(time >= timemul ** radius)
		if(bdmgacc >= radius * bdmgmul)
			time = 0
			bdmgacc -= radius * bdmgmul
			radius++

			for(var/turf/open/floor/T in range(radius, src))
				if(!(T in range(radius - 1, src)))
					T.ChangeTurf(/turf/open/floor/plating/conc)
					if(prob(20))
						var/obj/M = pick(musor)
						new M(T)

	else
		time++

/obj/structure/pomoyka/singularity_pull()
	return

/obj/item/book/granter/spell/pomoyka
	spell = /obj/effect/proc_holder/spell/targeted/pomoyka
	spellname = "pomoyka"
	icon_state ="bookfireball"
	desc = "Данная книга очень ватная на ощупь"
	remarks = list("Каво?", "Слава дедам - слава и нам...", "Трансформеры... ")
