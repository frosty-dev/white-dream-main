//predominantly negative traits

/// Defines for locations of items being added to your inventory on spawn
#define LOCATION_LPOCKET "в левом кармане"
#define LOCATION_RPOCKET "в правом кармане"
#define LOCATION_BACKPACK "в сумке"
#define LOCATION_HANDS "в руках"

/datum/quirk/badback
	name = "Больная спина"
	desc = " Благодаря вашей плохой осанке теперь рюкзаки будет неудобно носить."
	value = -2
	mood_quirk = TRUE
	gain_text = "<span class='danger'>Моя спина ОЧЕНЬ СИЛЬНО болит!</span>"
	lose_text = "<span class='notice'>Моя спина чувствует себя лучше...</span>"
	medical_record_text = "Сканирование пациента даёт показание, что его спина сильно болит."
	hardcore_value = 4

/datum/quirk/badback/on_process()
	var/mob/living/carbon/human/H = quirk_holder
	if(H.back && istype(H.back, /obj/item/storage/backpack))
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "back_pain", /datum/mood_event/back_pain)
	else
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "back_pain")

/datum/quirk/blooddeficiency
	name = "Дефицит крови"
	desc = "Ваш организм не может производить достаточно крови для нормального функционирования."
	value = -2
	gain_text = "<span class='danger'>Я чувствую онемение.</span>"
	lose_text = "<span class='notice'>Я чувствую себя бодрым!</span>"
	medical_record_text = " Пациенту необходима дополнительная помощь для переливания крови из-за её дефицита в его организме."
	hardcore_value = 8

/datum/quirk/blooddeficiency/on_process()
	var/mob/living/carbon/human/H = quirk_holder
	if(NOBLOOD in H.dna.species.species_traits) //can't lose blood if your species doesn't have any
		return
	else
		if (H.blood_volume > (BLOOD_VOLUME_SAFE - 25)) // just barely survivable without treatment
			H.blood_volume -= 0.275

/datum/quirk/blindness
	name = "Слепой"
	desc = "Я абсолютно слепы. Ничего не может воспрепятствовать этому."
	value = -4
	gain_text = "<span class='danger'>Я ничего не видите!</span>"
	lose_text = "<span class='notice'>Я чудесным образом снова видите!</span>"
	medical_record_text = "Пациент имеет постоянную слепоту."
	hardcore_value = 15

/datum/quirk/blindness/add()
	quirk_holder.become_blind(ROUNDSTART_TRAIT)

/datum/quirk/blindness/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/glasses/blindfold/white/B = new(get_turf(H))
	if(!H.equip_to_slot_if_possible(B, ITEM_SLOT_EYES, bypass_equip_delay_self = TRUE)) //if you can't put it on the user's eyes, put it in their hands, otherwise put it on their eyes
		H.put_in_hands(B)
	H.regenerate_icons()

	/* A couple of brain tumor stats for anyone curious / looking at this quirk for balancing:
	 * - It takes less 16 minute 40 seconds to die from brain death due to a brain tumor.
	 * - It takes 1 minutes 40 seconds to take 10% (20 organ damage) brain damage.
	 * - 5u mannitol will heal 12.5% (25 organ damage) brain damage
	 */
/datum/quirk/brainproblems
	name = "Паразит в голове"
	desc = "В вашей голове завёлся маленький дружок, который медленно уничтожает ваш мозг. Лучше носить с собой маннитол!"
	value = -3
	gain_text = "<span class='danger'>Я чувствую боль в голове.</span>"
	lose_text = "<span class='notice'>Я чувствую, что голова перестала болеть.</span>"
	medical_record_text = "Пациент имеет паразита в своей голове, который медленно пожирает его мозг, что в скором будущем может привести к гибели пациента."
	hardcore_value = 12
	/// Location of the bottle of pills on spawn
	var/where

/datum/quirk/brainproblems/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/pills = new /obj/item/storage/pill_bottle/mannitol/braintumor()
	var/list/slots = list(
		LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
		LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
		LOCATION_BACKPACK = ITEM_SLOT_BACKPACK,
		LOCATION_HANDS = ITEM_SLOT_HANDS
	)
	where = H.equip_in_one_of_slots(pills, slots, FALSE) || "at your feet"

/datum/quirk/brainproblems/post_add()
	if(where == LOCATION_BACKPACK)
		var/mob/living/carbon/human/H = quirk_holder
		SEND_SIGNAL(H.back, COMSIG_TRY_STORAGE_SHOW, H)

	to_chat(quirk_holder, "<span class='boldnotice'>There is a bottle of mannitol pills [where] to keep you alive until you can secure a supply of medication. Don't rely on it too much!</span>")

/datum/quirk/brainproblems/on_process()
	if(HAS_TRAIT(quirk_holder, TRAIT_TUMOR_SUPPRESSED))
		return
	quirk_holder.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.2)

/datum/quirk/deafness
	name = "Глухонемой"
	desc = "Я ничего не слышите."
	value = -2
	mob_trait = TRAIT_DEAF
	gain_text = "<span class='danger'>Я не могу ничего слышать.</span>"
	lose_text = "<span class='notice'>Теперь я снова слышите!</span>"
	medical_record_text = "Улитка в ушах пациента повреждена и не подвергается лечению."
	hardcore_value = 12

/datum/quirk/depression
	name = "Депрессивный"
	desc = "Иногда я просто ненавидите свою жизнь."
	mob_trait = TRAIT_DEPRESSION
	value = -1
	gain_text = "<span class='danger'>Я чувствую себя депрессивным.</span>"
	lose_text = "<span class='notice'>Я больше не чувствую себя депрессивным.</span>" // если один это было так легко!
	medical_record_text = "Пациент имеет серьёзное психическое заболевание, в результате чего у него возникают острые эпизоды депрессии."
	mood_quirk = TRUE
	hardcore_value = 1

/datum/quirk/depression/on_process()
	if(prob(0.05))
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "depression_mild", /datum/mood_event/depression_mild)

/datum/quirk/family_heirloom
	name = "Семейная реликвия"
	desc = "Я являетесь владельцем семейной реликвии, которая передаётся из поколения в поколение. Стоит держать это с собой!"
	value = -1
	mood_quirk = TRUE
	var/obj/item/heirloom
	var/where
	medical_record_text = "Пациент демонстрирует неестественную привязанность к его семейной реликвии."
	hardcore_value = 1

/datum/quirk/family_heirloom/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/heirloom_type

	if(ismoth(H) && prob(50))
		heirloom_type = /obj/item/flashlight/lantern/heirloom_moth
	else
		switch(quirk_holder.mind.assigned_role)
			//Service jobs
			if("Clown")
				heirloom_type = /obj/item/bikehorn/golden
			if("Mime")
				heirloom_type = /obj/item/reagent_containers/food/snacks/baguette
			if("Janitor")
				heirloom_type = pick(/obj/item/mop, /obj/item/clothing/suit/caution, /obj/item/reagent_containers/glass/bucket, /obj/item/paper/fluff/stations/soap)
			if("Cook")
				heirloom_type = pick(/obj/item/reagent_containers/food/condiment/saltshaker, /obj/item/kitchen/rollingpin, /obj/item/clothing/head/chefhat)
			if("Botanist")
				heirloom_type = pick(/obj/item/cultivator, /obj/item/reagent_containers/glass/bucket, /obj/item/toy/plush/beeplushie)
			if("Bartender")
				heirloom_type = pick(/obj/item/reagent_containers/glass/rag, /obj/item/clothing/head/that, /obj/item/reagent_containers/food/drinks/shaker)
			if("Curator")
				heirloom_type = pick(/obj/item/pen/fountain, /obj/item/storage/pill_bottle/dice)
			if("Chaplain")
				heirloom_type = pick(/obj/item/toy/windup_toolbox, /obj/item/reagent_containers/food/drinks/bottle/holywater)
			if("Assistant")
				heirloom_type = /obj/item/storage/toolbox/mechanical/old/heirloom
			//Security/Command
			if("Captain")
				heirloom_type = /obj/item/reagent_containers/food/drinks/flask/gold
			if("Head of Security")
				heirloom_type = /obj/item/book/manual/wiki/security_space_law
			if("Head of Personnel")
				heirloom_type = /obj/item/reagent_containers/food/drinks/trophy/silver_cup
			if("Warden")
				heirloom_type = /obj/item/book/manual/wiki/security_space_law
			if("International Officer")
				heirloom_type = pick(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec)
			if("Russian Officer")
				heirloom_type = pick(/obj/item/book/manual/wiki/security_space_law, /obj/item/reagent_containers/food/drinks/bottle/vodka)
			if("Veteran")
				heirloom_type = pick(/obj/item/book/manual/wiki/security_space_law, /obj/item/reagent_containers/food/drinks/boyarka)
			if("Detective")
				heirloom_type = /obj/item/reagent_containers/food/drinks/bottle/whiskey
			if("Lawyer")
				heirloom_type = pick(/obj/item/gavelhammer, /obj/item/book/manual/wiki/security_space_law)
			if("Prisoner")
				heirloom_type = /obj/item/pen/blue
			//RnD
			if("Research Director")
				heirloom_type = /obj/item/toy/plush/slimeplushie
			if("Scientist")
				heirloom_type = /obj/item/toy/plush/slimeplushie
			if("Roboticist")
				heirloom_type = pick(subtypesof(/obj/item/toy/prize) + /obj/item/toy/plush/pkplush) //look at this nerd
			if("Geneticist")
				heirloom_type = /obj/item/clothing/under/shorts/purple
			//Medical
			if("Chief Medical Officer")
				heirloom_type = /obj/item/storage/firstaid/ancient/heirloom
			if("Medical Doctor")
				heirloom_type = /obj/item/storage/firstaid/ancient/heirloom
			if("Paramedic")
				heirloom_type = /obj/item/storage/firstaid/ancient/heirloom
			if("Psychologist")
				heirloom_type = /obj/item/storage/pill_bottle
			if("Chemist")
				heirloom_type = /obj/item/book/manual/wiki/chemistry
			if("Virologist")
				heirloom_type = /obj/item/reagent_containers/syringe
			//Engineering
			if("Chief Engineer")
				heirloom_type = pick(/obj/item/clothing/head/hardhat/white, /obj/item/screwdriver, /obj/item/wrench, /obj/item/weldingtool, /obj/item/crowbar, /obj/item/wirecutters)
			if("Station Engineer")
				heirloom_type = pick(/obj/item/clothing/head/hardhat, /obj/item/screwdriver, /obj/item/wrench, /obj/item/weldingtool, /obj/item/crowbar, /obj/item/wirecutters)
			if("Atmospheric Technician")
				heirloom_type = pick(/obj/item/lighter, /obj/item/lighter/greyscale, /obj/item/storage/box/matches)
			//Supply
			if("Quartermaster")
				heirloom_type = pick(/obj/item/stamp, /obj/item/stamp/denied)
			if("Cargo Technician")
				heirloom_type = /obj/item/clipboard
			if("Shaft Miner")
				heirloom_type = pick(/obj/item/pickaxe/mini, /obj/item/shovel)

	if(!heirloom_type)
		heirloom_type = pick(
		/obj/item/toy/cards/deck,
		/obj/item/lighter,
		/obj/item/dice/d20)
	heirloom = new heirloom_type(get_turf(quirk_holder))
	var/list/slots = list(
		LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
		LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
		LOCATION_BACKPACK = ITEM_SLOT_BACKPACK,
		LOCATION_HANDS = ITEM_SLOT_HANDS
	)
	where = H.equip_in_one_of_slots(heirloom, slots, FALSE) || "у ваших ног"

/datum/quirk/family_heirloom/post_add()
	if(where == LOCATION_BACKPACK)
		var/mob/living/carbon/human/H = quirk_holder
		SEND_SIGNAL(H.back, COMSIG_TRY_STORAGE_SHOW, H)

	to_chat(quirk_holder, "<span class='boldnotice'>Дорогая для вас реликвия [heirloom.name] [where], передавалась из поколения в поколение. Хранить в безопасности!</span>")

	var/list/names = splittext(quirk_holder.real_name, " ")
	var/family_name = names[names.len]

	heirloom.AddComponent(/datum/component/heirloom, quirk_holder.mind, family_name)

/datum/quirk/family_heirloom/on_process()
	if(heirloom in quirk_holder.GetAllContents())
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "family_heirloom_missing")
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "family_heirloom", /datum/mood_event/family_heirloom)
	else
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "family_heirloom")
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "family_heirloom_missing", /datum/mood_event/family_heirloom_missing)

/datum/quirk/family_heirloom/remove()
	SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "family_heirloom_missing")
	SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "family_heirloom")

/datum/quirk/frail
	name = "Хилый"
	desc = "Ваши кости как-будто сделаны из стекла! Ваши конечности не смогут выдержать много повреждений."
	value = -2
	mob_trait = TRAIT_EASYLIMBDISABLE
	gain_text = "<span class='danger'>Я чувствую себя слабым.</span>"
	lose_text = "<span class='notice'>Я вновь чувствую себя крепким..</span>"
	medical_record_text = "Пациент имеет очень слабые кости, рекомендуется кальцевая диета."
	hardcore_value = 4

/datum/quirk/heavy_sleeper
	name = "Крепкий сон"
	desc = " Я крепко спите! Всякий раз, когда я ложитесь спать или теряете сознание, мне потребуется немного больше времени, чтобы встать."
	value = -1
	mob_trait = TRAIT_HEAVY_SLEEPER
	gain_text = "<span class='danger'>Я чувствую себя вялым.</span>"
	lose_text = "<span class='notice'>Я вновь чувствую себя бодрым!</span>"
	medical_record_text = "Пациент имеет отрицательные результаты качества сна и его трудно разбудить."
	hardcore_value = 2

/datum/quirk/hypersensitive
	name = "Гиперчувствительный"
	desc = "Хорошо ли это, или плохо, но влияние на ваше настроение становится более сильнее, чем должно быть."
	value = -1
	gain_text = "<span class='danger'>Я, кажется, хотите создать огромную проблему из всего.</span>"
	lose_text = "<span class='notice'>Вам больше не хочется устраивать шумиху.</span>"
	medical_record_text = "Пациент демонстрирует высокие перепады настроения."
	hardcore_value = 3

/datum/quirk/hypersensitive/add()
	var/datum/component/mood/mood = quirk_holder.GetComponent(/datum/component/mood)
	if(mood)
		mood.mood_modifier += 0.5

/datum/quirk/hypersensitive/remove()
	if(quirk_holder)
		var/datum/component/mood/mood = quirk_holder.GetComponent(/datum/component/mood)
		if(mood)
			mood.mood_modifier -= 0.5

/datum/quirk/light_drinker
	name = "Сильное воздействие алкоголя"
	desc = "У вас низкая устойчивость к алкоголю и я очень быстро становитесь пьяным."
	value = -1
	mob_trait = TRAIT_LIGHT_DRINKER
	gain_text = "<span class='notice'>Даже мысль об алкоголе заставляет вашу голову кружится.</span>"
	lose_text = "<span class='danger'>Я больше не страдаете от алкоголя.</span>"
	medical_record_text = "Пациент демонстрирует низкую устойчивость к алкоголю."
	hardcore_value = 3

/datum/quirk/nearsighted //t. errorage
	name = "Близорукий"
	desc = "Я близоруки без очков, но появляетесь с одной такой парой."
	value = -1
	gain_text = "<span class='danger'>Вещи вдалеке кажутся мне сильно расплывчатыми.</span>"
	lose_text = "<span class='notice'>Вещи вдалеке теперь видны более четко.</span>"
	medical_record_text = "Пациенту необходимо носить пара очков, чтобы не страдать от близорукости."
	hardcore_value = 5

/datum/quirk/nearsighted/add()
	quirk_holder.become_nearsighted(ROUNDSTART_TRAIT)

/datum/quirk/nearsighted/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/glasses/regular/glasses = new(get_turf(H))
	H.put_in_hands(glasses)
	H.equip_to_slot(glasses, ITEM_SLOT_EYES)
	H.regenerate_icons() //this is to remove the inhand icon, which persists even if it's not in their hands

/datum/quirk/nyctophobia
	name = "Боязнь темноты"
	desc = "Насколько я помню, я всегда боюсь темноты. Будучи в темноте без света, я буду чувствовать страх и вести себя аккуратно"
	value = -1
	medical_record_text = "Пациент демонстрирует страх к темноте."
	hardcore_value = 5

/datum/quirk/nyctophobia/on_process()
	var/mob/living/carbon/human/H = quirk_holder
	if(H.dna.species.id in list("shadow", "nightmare"))
		return //we're tied with the dark, so we don't get scared of it; don't cleanse outright to avoid cheese
	var/turf/T = get_turf(quirk_holder)
	var/lums = T.get_lumcount()
	if(lums <= 0.2)
		if(quirk_holder.m_intent == MOVE_INTENT_RUN)
			to_chat(quirk_holder, "<span class='warning'>Так, спокойно, спокойно... ничего страшного...</span>")
			quirk_holder.toggle_move_intent()
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "nyctophobia", /datum/mood_event/nyctophobia)
	else
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "nyctophobia")

/datum/quirk/nonviolent
	name = "Пацифист"
	desc = "Мысль о насилии заставляет меня чувствовать себя неприятно. Настолько, что я не могу нанести вред окружающим."
	value = -2
	mob_trait = TRAIT_PACIFISM
	gain_text = "<span class='danger'>Я чувствую себя жутко, подумав о насилии!</span>"
	lose_text = "<span class='notice'>Я чувствую, что я могу защитить себя вновь.</span>"
	medical_record_text = "Пациент является пацифистом и не может заставить себя причинить вред кому-либо."
	hardcore_value = 6

/datum/quirk/paraplegic
	name = "Инвалид"
	desc = "Мои ноги не функционируют. Ничего не может помочь мне вновь встать на ноги. Но зато у меня есть бесплатная инвалидная коляска!"
	value = -3
	human_only = TRUE
	gain_text = null // Handled by trauma.
	lose_text = null
	medical_record_text = "Пациент страдает параличом нижних конечностей.."
	hardcore_value = 15

/datum/quirk/paraplegic/add()
	var/datum/brain_trauma/severe/paralysis/paraplegic/T = new()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(T, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/paraplegic/on_spawn()
	if(quirk_holder.buckled) // Handle late joins being buckled to arrival shuttle chairs.
		quirk_holder.buckled.unbuckle_mob(quirk_holder)

	var/turf/T = get_turf(quirk_holder)
	var/obj/structure/chair/spawn_chair = locate() in T

	var/obj/vehicle/ridden/wheelchair/wheels
	if(quirk_holder.client?.get_award_status(HARDCORE_RANDOM_SCORE) >= 5000) //More than 5k score? you unlock the gamer wheelchair.
		wheels = new /obj/vehicle/ridden/wheelchair/gold(T)
	else
		wheels = new(T)
	if(spawn_chair) // Makes spawning on the arrivals shuttle more consistent looking
		wheels.setDir(spawn_chair.dir)

	wheels.buckle_mob(quirk_holder)

	// During the spawning process, they may have dropped what they were holding, due to the paralysis
	// So put the things back in their hands.

	for(var/obj/item/I in T)
		if(I.fingerprintslast == quirk_holder.ckey)
			quirk_holder.put_in_hands(I)

/datum/quirk/poor_aim
	name = "Плохо стреляющий"
	desc = "Я не умею обращаться с оружием и не могу сделать точный выстрел ради спасения своей жизни. Dual-wielding is right out."
	value = -1
	mob_trait = TRAIT_POOR_AIM
	medical_record_text = "У пациента сильная дрожь в обеих руках."
	hardcore_value = 3

/datum/quirk/prosopagnosia
	name = "Прозопагнозия"
	desc = "Я имею психическое расстройство, которое мешает мне распознавать лица."
	value = -1
	mob_trait = TRAIT_PROSOPAGNOSIA
	medical_record_text = "Пациент страдает от прозопагнозии и не может узнать лица."
	hardcore_value = 5

/datum/quirk/prosthetic_limb
	name = "Протез конечности"
	desc = "В связи с инцидентом в прошлом, я потерял одну из моих конечностей. По крайней мере, у меня имеется протез этой конечности!"
	value = -1
	var/slot_string = "limb"
	medical_record_text = "Во время физического обследования у пациента был обнаружен протез."
	hardcore_value = 3

/datum/quirk/prosthetic_limb/on_spawn()
	var/limb_slot = pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/bodypart/old_part = H.get_bodypart(limb_slot)
	var/obj/item/bodypart/prosthetic
	switch(limb_slot)
		if(BODY_ZONE_L_ARM)
			prosthetic = new/obj/item/bodypart/l_arm/robot/surplus(quirk_holder)
			slot_string = "левая рука"
		if(BODY_ZONE_R_ARM)
			prosthetic = new/obj/item/bodypart/r_arm/robot/surplus(quirk_holder)
			slot_string = "правая рука"
		if(BODY_ZONE_L_LEG)
			prosthetic = new/obj/item/bodypart/l_leg/robot/surplus(quirk_holder)
			slot_string = "левая нога"
		if(BODY_ZONE_R_LEG)
			prosthetic = new/obj/item/bodypart/r_leg/robot/surplus(quirk_holder)
			slot_string = "правая нога"
	prosthetic.replace_limb(H)
	qdel(old_part)
	H.regenerate_icons()

/datum/quirk/prosthetic_limb/post_add()
	to_chat(quirk_holder, "<span class='boldannounce'>Моя [slot_string] была заменена протезом. Оно хрупкое и будет легко ломаться под давлением какой-либо силы. Стоит добавить, \
	что мне будет нужно использовать сварочный инструмент и кабели для починки протеза, вместо традиционных пластырей и мазей.</span>")

/datum/quirk/pushover
	name = "Неуверенный"
	desc = "Мой первый инстинкт будет позволять людям толкать меня. Вырываться из захвата будет также сложнее."
	value = -2
	mob_trait = TRAIT_GRABWEAKNESS
	gain_text = "<span class='danger'>Я чувствую себя неуверенно.</span>"
	lose_text = "<span class='notice'>Теперь-то я могу убить всех нахуй блядь.</span>"
	medical_record_text = "Пациент представляет собой неуверенную и наивную личность, и им легко манипулировать."
	hardcore_value = 4

/datum/quirk/insanity
	name = "Синдром Диссоциации Реальности"
	desc = "Я страдаю от серьёзного психического расстройства, которое вызывает очень сильные галлюцинации. Вещество \"Майндбрейкер\" поможет мне подавить эти эффекты, и я невосприимчив к эффектам \"Майндбрейкера\". <b>Это не является лицензией на гриф..</b>"
	value = -2
	//no mob trait because it's handled uniquely
	gain_text = "<span class='userdanger'>...</span>"
	lose_text = "<span class='notice'>Я чувствую себя нормальным..</span>"
	medical_record_text = "Пациент страдает от Синдрома Диссоциации Реальности, вызывающее у него тяжелые галлюцинации."
	hardcore_value = 6

/datum/quirk/insanity/on_process()
	if(quirk_holder.reagents.has_reagent(/datum/reagent/toxin/mindbreaker, needs_metabolizing = TRUE))
		quirk_holder.hallucination = 0
		return
	if(prob(2)) //we'll all be mad soon enough
		madness()

/datum/quirk/insanity/proc/madness()
	quirk_holder.hallucination += rand(10, 25)

/datum/quirk/insanity/post_add() //I don't /think/ we'll need this but for newbies who think "roleplay as insane" = "license to kill" it's probably a good thing to have
	if(!quirk_holder.mind || quirk_holder.mind.special_role)
		return
	to_chat(quirk_holder, "<span class='big bold info'>Учтите, что ваш синдром диссоциации НЕ даёт мне права нападать на других людей, или каким-нибудь образом портить раунд окружающим. \
Я не антагонист, и правила игры все еще действуют на вас, как на остальных игроков..</span>")

/datum/quirk/social_anxiety
	name = "Социальная тревожность"
	desc = "Разговор с людьми очень сложен для вас, и я иногда будете заикаться, или даже просто молчать."
	value = -1
	gain_text = "<span class='danger'>Я начинаете волноваться насчёт мнения окружающих.</span>"
	lose_text = "<span class='notice'>Вам стало легче говорить.</span>" //if only it were that easy!
	medical_record_text = "Пациент, как правило, беспокоится о социальных связях и предпочитает избегать их."
	hardcore_value = 4
	var/dumb_thing = TRUE

/datum/quirk/social_anxiety/add()
	RegisterSignal(quirk_holder, COMSIG_MOB_EYECONTACT, .proc/eye_contact)
	RegisterSignal(quirk_holder, COMSIG_MOB_EXAMINATE, .proc/looks_at_floor)

/datum/quirk/social_anxiety/remove()
	UnregisterSignal(quirk_holder, list(COMSIG_MOB_EYECONTACT, COMSIG_MOB_EXAMINATE))

/datum/quirk/social_anxiety/on_process()
	var/nearby_people = 0
	for(var/mob/living/carbon/human/H in oview(3, quirk_holder))
		if(H.client)
			nearby_people++
	var/mob/living/carbon/human/H = quirk_holder
	if(prob(2 + nearby_people))
		H.stuttering = max(3, H.stuttering)
	else if(prob(min(3, nearby_people)) && !H.silent)
		to_chat(H, "<span class='danger'>Я решаете просто немного помолчать. Вам <i>совсем</i> не хочется разговаривать.</span>")
		H.silent = max(10, H.silent)
	else if(prob(0.5) && dumb_thing)
		to_chat(H, "<span class='userdanger'>Я вспоминаете дурацкую вещь, которую сказали давным давно и внутренне кричите.</span>")
		dumb_thing = FALSE //only once per life
		if(prob(1))
			new/obj/item/reagent_containers/food/snacks/spaghetti/pastatomato(get_turf(H)) //пош тнат'5 шНат 1 са11 5рагнетт1 соде.

// small chance to make eye contact with inanimate objects/mindless mobs because of nerves
/datum/quirk/social_anxiety/proc/looks_at_floor(datum/source, atom/A)
	var/mob/living/mind_check = A
	if(prob(85) || (istype(mind_check) && mind_check.mind))
		return

	addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, quirk_holder, "<span class='smallnotice'>You make eye contact with [A].</span>"), 3)

/datum/quirk/social_anxiety/proc/eye_contact(datum/source, mob/living/other_mob, triggering_examiner)
	if(prob(75))
		return
	var/msg
	if(triggering_examiner)
		msg = "You make eye contact with [other_mob], "
	else
		msg = "[other_mob] makes eye contact with you, "

	switch(rand(1,3))
		if(1)
			quirk_holder.Jitter(10)
			msg += "causing you to start fidgeting!"
		if(2)
			quirk_holder.stuttering = max(3, quirk_holder.stuttering)
			msg += "causing you to start stuttering!"
		if(3)
			quirk_holder.Stun(2 SECONDS)
			msg += "causing you to freeze up!"

	SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "anxiety_eyecontact", /datum/mood_event/anxiety_eyecontact)
	addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, quirk_holder, "<span class='userdanger'>[msg]</span>"), 3) // so the examine signal has time to fire and this will print after
	return COMSIG_BLOCK_EYECONTACT

/datum/mood_event/anxiety_eyecontact
	description = "<span class='warning'>Sometimes eye contact makes me so nervous...</span>\n"
	mood_change = -5
	timeout = 3 MINUTES

/datum/quirk/junkie
	name = "Наркоман"
	desc = "Я страдаете от наркотической зависимости."
	value = -2
	gain_text = "<span class='danger'>Внезапно я почувствовали тягу к наркотикам.</span>"
	lose_text = "<span class='notice'>Мне стоит бросить принимать наркотики, подумали вы.</span>"
	medical_record_text = "Пациент страдает от зависимости и тяжелых наркотиков."
	hardcore_value = 4
	var/drug_list = list(/datum/reagent/drug/crank, /datum/reagent/drug/krokodil, /datum/reagent/medicine/morphine, /datum/reagent/drug/happiness, /datum/reagent/drug/methamphetamine) //List of possible IDs
	var/datum/reagent/reagent_type //!If this is defined, reagent_id will be unused and the defined reagent type will be instead.
	var/datum/reagent/reagent_instance //! actual instanced version of the reagent
	var/where_drug //! Where the drug spawned
	var/obj/item/drug_container_type //! If this is defined before pill generation, pill generation will be skipped. This is the type of the pill bottle.
	var/where_accessory //! where the accessory spawned
	var/obj/item/accessory_type //! If this is null, an accessory won't be spawned.
	var/process_interval = 30 SECONDS //! how frequently the quirk processes
	var/next_process = 0 //! ticker for processing

/datum/quirk/junkie/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	if (!reagent_type)
		reagent_type = pick(drug_list)
	reagent_instance = new reagent_type()
	H.reagents.addiction_list.Add(reagent_instance)
	var/current_turf = get_turf(quirk_holder)
	if (!drug_container_type)
		drug_container_type = /obj/item/storage/pill_bottle
	var/obj/item/drug_instance = new drug_container_type(current_turf)
	if (istype(drug_instance, /obj/item/storage/pill_bottle))
		var/pill_state = "pill[rand(1,20)]"
		for(var/i in 1 to 7)
			var/obj/item/reagent_containers/pill/P = new(drug_instance)
			P.icon_state = pill_state
			P.reagents.add_reagent(reagent_type, 1)

	var/obj/item/accessory_instance
	if (accessory_type)
		accessory_instance = new accessory_type(current_turf)
	var/list/slots = list(
		LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
		LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
		LOCATION_BACKPACK = ITEM_SLOT_BACKPACK
	)
	where_drug = H.equip_in_one_of_slots(drug_instance, slots, FALSE) || "у ваших ног"
	if (accessory_instance)
		where_accessory = H.equip_in_one_of_slots(accessory_instance, slots, FALSE) || "у ваших ног"
	announce_drugs()

/datum/quirk/junkie/post_add()
	if(where_drug == LOCATION_BACKPACK || where_accessory == LOCATION_BACKPACK)
		var/mob/living/carbon/human/H = quirk_holder
		SEND_SIGNAL(H.back, COMSIG_TRY_STORAGE_SHOW, H)

/datum/quirk/junkie/proc/announce_drugs()
	to_chat(quirk_holder, "<span class='boldnotice'>Я пронёс [initial(drug_container_type.name)] из [initial(reagent_type.name)] [where_drug]. Скоро он закончится...</span>")

/datum/quirk/junkie/on_process()
	var/mob/living/carbon/human/H = quirk_holder
	if(world.time > next_process)
		next_process = world.time + process_interval
		if(!H.reagents.addiction_list.Find(reagent_instance))
			if(QDELETED(reagent_instance))
				reagent_instance = new reagent_type()
			else
				reagent_instance.addiction_stage = 0
			H.reagents.addiction_list += reagent_instance
			to_chat(quirk_holder, "<span class='danger'>Я внезапно хотите [reagent_instance.name] снова...</span>")

/datum/quirk/junkie/smoker
	name = "Курильщик"
	desc = "Иногда мне просто хочется закурить. Возможно, не очень-то и полезно для ваших легких."
	value = -1
	gain_text = "<span class='danger'>Вам стоит снова закурить.</span>"
	lose_text = "<span class='notice'>Я чувствую, что я бросили привычку курить..</span>"
	medical_record_text = "Пациент является курильщиком.."
	reagent_type = /datum/reagent/drug/nicotine
	accessory_type = /obj/item/lighter/greyscale
	hardcore_value = 1

/datum/quirk/junkie/smoker/on_spawn()
	drug_container_type = pick(/obj/item/storage/fancy/cigarettes,
		/obj/item/storage/fancy/cigarettes/cigpack_midori,
		/obj/item/storage/fancy/cigarettes/cigpack_uplift,
		/obj/item/storage/fancy/cigarettes/cigpack_robust,
		/obj/item/storage/fancy/cigarettes/cigpack_robustgold,
		/obj/item/storage/fancy/cigarettes/cigpack_carp)
	. = ..()

/datum/quirk/junkie/smoker/announce_drugs()
	to_chat(quirk_holder, "<span class='boldnotice'>Пачка сигарет [initial(drug_container_type.name)] [where_drug], и зажигалочка [where_accessory]. Убедись, что ты достанешь свой любимый бренд, если тот закончится.</span>")


/datum/quirk/junkie/smoker/on_process()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/I = H.get_item_by_slot(ITEM_SLOT_MASK)
	if (istype(I, /obj/item/clothing/mask/cigarette))
		var/obj/item/storage/fancy/cigarettes/C = drug_container_type
		if(istype(I, initial(C.spawn_type)))
			SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "wrong_cigs")
			return
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "wrong_cigs", /datum/mood_event/wrong_brand)

/datum/quirk/unstable
	name = "Неустойчивый"
	desc = "В связи с прошлыми проблемами, я больше не смогу вернуть свою психику, если вдруг станете психопатом. Будьте очень осторожным и повышайте свое настроение!"
	value = -2
	mob_trait = TRAIT_UNSTABLE
	gain_text = "<span class='danger'>Столько вещей сейчас в голове...</span>"
	lose_text = "<span class='notice'>Я чувствую себя гораздо спокойнее.</span>"
	medical_record_text = "Психика пациента находится в уязвимом состоянии и не сможет больше оправиться после травмы."
	hardcore_value = 9

/datum/quirk/allergic
	name = "Extreme Medicine Allergy"
	desc = "Ever since you were a kid, you've been allergic to certain chemicals..."
	value = -2
	gain_text = "<span class='danger'>You feel your immune system shift.</span>"
	lose_text = "<span class='notice'>You feel your immune system phase back into perfect shape.</span>"
	medical_record_text = "Patient's immune system responds violently to certain chemicals."
	hardcore_value = 3
	var/list/allergies = list()
	var/list/blacklist = list(/datum/reagent/medicine/c2,/datum/reagent/medicine/epinephrine,/datum/reagent/medicine/adminordrazine,/datum/reagent/medicine/omnizine/godblood,/datum/reagent/medicine/cordiolis_hepatico,/datum/reagent/medicine/synaphydramine,/datum/reagent/medicine/diphenhydramine)

/datum/quirk/allergic/on_spawn()
	var/list/chem_list = subtypesof(/datum/reagent/medicine) - blacklist
	for(var/i in 0 to 5)
		var/chem = pick(chem_list)
		chem_list -= chem
		allergies += chem

/datum/quirk/allergic/post_add()
	var/display = ""
	for(var/C in allergies)
		var/datum/reagent/chemical = C
		display += initial(chemical.name) + ", "
	name = "Extreme " + display +"Allergies"
	medical_record_text = "Patient's immune system responds violently to [display]"
	quirk_holder?.mind.store_memory("You are allergic to [display]")
	to_chat(quirk_holder, "<span class='boldnotice'>You are allergic to [display]make sure not to consume any of it!</span>")
	if(!ishuman(quirk_holder))
		return
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/clothing/accessory/allergy_dogtag/dogtag = new(get_turf(human_holder))
	var/list/slots = list (
		"backpack" = ITEM_SLOT_BACKPACK,
		"hands" = ITEM_SLOT_HANDS
	)
	dogtag.display = display
	human_holder.equip_in_one_of_slots(dogtag, slots , qdel_on_fail = TRUE)

/datum/quirk/allergic/on_process()
	. = ..()
	if(!iscarbon(quirk_holder))
		return
	var/mob/living/carbon/carbon_quirk_holder = quirk_holder
	for(var/M in allergies)
		var/datum/reagent/instantiated_med = carbon_quirk_holder.reagents.has_reagent(M)
		if(!instantiated_med)
			continue
		//Just halts the progression, I'd suggest you run to medbay asap to get it fixed
		if(carbon_quirk_holder.reagents.has_reagent(/datum/reagent/medicine/epinephrine))
			instantiated_med.reagent_removal_skip_list |= ALLERGIC_REMOVAL_SKIP
			return //intentionally stops the entire proc so we avoid the organ damage after the loop
		instantiated_med.reagent_removal_skip_list -= ALLERGIC_REMOVAL_SKIP
		carbon_quirk_holder.adjustToxLoss(3)
		carbon_quirk_holder.reagents.add_reagent(/datum/reagent/toxin/histamine,3)
		if(prob(10))
			carbon_quirk_holder.vomit()
			carbon_quirk_holder.adjustOrganLoss(pick(ORGAN_SLOT_BRAIN,ORGAN_SLOT_APPENDIX,ORGAN_SLOT_LUNGS,ORGAN_SLOT_HEART,ORGAN_SLOT_LIVER,ORGAN_SLOT_STOMACH),10)

#undef LOCATION_LPOCKET
#undef LOCATION_RPOCKET
#undef LOCATION_BACKPACK
#undef LOCATION_HANDS
