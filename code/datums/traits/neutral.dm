//traits with no real impact that can be taken freely
//MAKE SURE THESE DO NOT MAJORLY IMPACT GAMEPLAY. those should be positive or negative traits.

/datum/quirk/no_taste
	name = "Агевзия"
	desc = "Я потерял свои вкусовые рецепторы и не могу почувствовать вкус какой-либо еды! Но токсичная пища всё-равно будет отравлять вас."
	value = 0
	mob_trait = TRAIT_AGEUSIA
	gain_text = "<span class='notice'>Я больше не чувствую вкус еды!</span>"
	lose_text = "<span class='notice'>Теперь я могу почувствовать вкус еды!</span>"
	medical_record_text = "Пациент страдает от агавзии и неспособен чувствовать вкус еды или жидкости."

/datum/quirk/vegetarian
	name = "Вегетарианец"
	desc = "Я находите идею есть мясо физически и морально отталкивающим."
	value = 0
	gain_text = "<span class='notice'>Я находите идею есть мясо физически и морально отталкивающим.</span>"
	lose_text = "<span class='notice'>Я чувствую, что перестал быть вегетарианцем..</span>"
	medical_record_text = "Пациент сообщает о вегетарианской диете.."

/datum/quirk/vegetarian/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.liked_food &= ~MEAT
	species.disliked_food |= MEAT

/datum/quirk/vegetarian/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		if(initial(species.liked_food) & MEAT)
			species.liked_food |= MEAT
		if(!initial(species.disliked_food) & MEAT)
			species.disliked_food &= ~MEAT

/datum/quirk/snob
	name = "Snob"
	desc = "You care about the finer things, if a room doesn't look nice its just not really worth it, is it?"
	value = 0
	gain_text = "<span class='notice'>You feel like you understand what things should look like.</span>"
	lose_text = "<span class='notice'>Well who cares about deco anyways?</span>"
	medical_record_text = "Patient seems to be rather stuck up."
	mob_trait = TRAIT_SNOB

/datum/quirk/pineapple_liker
	name = "Любитель ананасов"
	desc = "Я очень сильно люблю ананасы. Я никогда ими не наедитесь!"
	value = 0
	gain_text = "<span class='notice'>Я чувствую, что испытываете сильную тягу к ананасам..</span>"
	lose_text = "<span class='notice'>Моя любовь к ананасам медленно угасает..</span>"
	medical_record_text = "Пациент демонстрирует патологическую любовь к ананасу."

/datum/quirk/pineapple_liker/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.liked_food |= PINEAPPLE

/datum/quirk/pineapple_liker/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		species.liked_food &= ~PINEAPPLE

/datum/quirk/pineapple_hater
	name = "Отвращение к ананасам"
	desc = "Я ненавижу ананасы. Серьёзно, кто, чёрт возьми, в здравом уме скажет, что они вкусные? И какой психопат посмел бы положить это в ПИЦЦУ?!"
	value = 0
	gain_text = "<span class='notice'>Я думаете над тем, какой кусок идиота любит ананасы...</span>"
	lose_text = "<span class='notice'>Моя ненависть к ананасам медленнно угасает...</span>"
	medical_record_text = "Пациент считает, что ананасы отвратительны."

/datum/quirk/pineapple_hater/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.disliked_food |= PINEAPPLE

/datum/quirk/pineapple_hater/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		species.disliked_food &= ~PINEAPPLE

/datum/quirk/deviant_tastes
	name = "Девиантные вкусы"
	desc = "Я не люблю ту еду, которое большинство предпочитает употреблять. Тем не менее, я люблю то, что не любят они."
	value = 0
	gain_text = "<span class='notice'>У вас возникает жажда съесть что-нибудь странное на вкус.</span>"
	lose_text = "<span class='notice'>Мне хочется поесть нормальную еду.</span>"
	medical_record_text = "Пациент демонстрирует необычные предпочтения к еде."

/datum/quirk/deviant_tastes/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	var/liked = species.liked_food
	species.liked_food = species.disliked_food
	species.disliked_food = liked

/datum/quirk/deviant_tastes/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		species.liked_food = initial(species.liked_food)
		species.disliked_food = initial(species.disliked_food)

/datum/quirk/monochromatic
	name = "Монохромия"
	desc = "Я не могу различать цвета и вижу весь мир в черно-белых тонах."
	value = 0
	medical_record_text = "У пациента было обнаружено нарушение цветового зрения."

/datum/quirk/monochromatic/add()
	quirk_holder.add_client_colour(/datum/client_colour/monochrome)

/datum/quirk/monochromatic/post_add()
	if(quirk_holder.mind.assigned_role == "Detective")
		to_chat(quirk_holder, "<span class='boldannounce'>Ммм. На этой станции нет ничего чистого. Это всё оттенки серого...</span>")
		quirk_holder.playsound_local(quirk_holder, 'sound/ambience/ambidet1.ogg', 50, FALSE)

/datum/quirk/monochromatic/remove()
	if(quirk_holder)
		quirk_holder.remove_client_colour(/datum/client_colour/monochrome)

/datum/quirk/phobia
	name = "Фобия"
	desc = "Ты чего-то боишься."
	value = 0
	medical_record_text = "Пациент чего-то очень сильно боится."

/datum/quirk/phobia/post_add()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(new /datum/brain_trauma/mild/phobia(H.client.prefs.phobia), TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/phobia/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.cure_trauma_type(/datum/brain_trauma/mild/phobia, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/needswayfinder
	name = "Navigationally Challenged"
	desc = "Lacking familiarity with certain stations, you start with a wayfinding pinpointer where available."
	value = 0
	medical_record_text = "Patient demonstrates a keen ability to get lost."

	var/obj/item/pinpointer/wayfinding/wayfinder
	var/where

/datum/quirk/needswayfinder/on_spawn()
	if(!GLOB.wayfindingbeacons.len)
		return
	var/mob/living/carbon/human/H = quirk_holder

	wayfinder = new /obj/item/pinpointer/wayfinding
	wayfinder.owner = H.real_name
	wayfinder.roundstart = TRUE

	var/list/slots = list(
		"in your left pocket" = ITEM_SLOT_LPOCKET,
		"in your right pocket" = ITEM_SLOT_RPOCKET,
		"in your backpack" = ITEM_SLOT_BACKPACK
	)
	where = H.equip_in_one_of_slots(wayfinder, slots, FALSE) || "at your feet"

/datum/quirk/needswayfinder/post_add()
	if(!GLOB.wayfindingbeacons.len)
		return
	if(where == "in your backpack")
		var/mob/living/carbon/human/H = quirk_holder
		SEND_SIGNAL(H.back, COMSIG_TRY_STORAGE_SHOW, H)

	to_chat(quirk_holder, "<span class='notice'>There is a pinpointer [where], which can help you find your way around. Click in-hand to activate.</span>")
