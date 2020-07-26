////////////////////
/////BODYPARTS/////
////////////////////


/obj/item/bodypart/var/should_draw_hippie = FALSE

/mob/living/carbon/proc/draw_hippie_parts(undo = FALSE)
	if(!undo)
		for(var/O in bodyparts)
			var/obj/item/bodypart/B = O
			B.should_draw_hippie = TRUE
	else
		for(var/O in bodyparts)
			var/obj/item/bodypart/B = O
			B.should_draw_hippie = FALSE

/datum/species/proc/hippie_handle_hiding_bodyparts(list/bodyparts_adding, obj/item/bodypart/head/head, mob/living/carbon/human/human)
	if("ipc_screen" in mutant_bodyparts)
		if((human.wear_mask && (human.wear_mask.flags_inv & HIDEFACE)) || (human.head && (human.head.flags_inv & HIDEFACE)) || !head || head.status == BODYPART_ROBOTIC)
			bodyparts_adding -= "ipc_screen"


#define DWARF_ALCOHOL_RATE 0.1 // The normal rate is 0.005. For 100 units of the strongest alcohol possible (boozepwr = 100), you'd have 10*100*0.005 = 5, which is too small as a value to operate with.
								// With 0.1, 100 units of the strongest alcohol would refill you completely from 0 to 100, which is perfect.
#define DRUNK_ALERT_TIME_OFFSET 10 SECONDS
// To make dwarven only jumpsuits, add this species' path to the clothing's species_exception list. By default jumpsuits don't fit dwarven since they're big boned
/datum/species/dwarf
	name = "Dwarf"
	id = "dwarf"
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS)
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,NO_UNDERWEAR)
	default_features = list("mcolor" = "FFF", "wings" = "None")
	use_skintones = 1
	disliked_food = GROSS | RAW
	liked_food = JUNKFOOD | FRIED
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	offset_features = list(OFFSET_UNIFORM = list(0,0), OFFSET_ID = list(0,0), OFFSET_GLOVES = list(0,0), OFFSET_GLASSES = list(0,0), OFFSET_EARS = list(0,0), OFFSET_SHOES = list(0,0), OFFSET_S_STORE = list(0,0), OFFSET_FACEMASK = list(0,-3), OFFSET_HEAD = list(0,-3), OFFSET_HAIR = list(0,-4), OFFSET_FACE = list(0,-3), OFFSET_BELT = list(0,0), OFFSET_BACK = list(0,0), OFFSET_SUIT = list(0,0), OFFSET_NECK = list(0,-3))
	mutantlungs = /obj/item/organ/lungs/dwarven
	mutanttongue = /obj/item/organ/tongue/dwarven
	var/dwarfDrunkness = 100 // A value between 0 and 100.
	var/notDrunkEnoughTime = 0 // World time offset
/datum/species/dwarf/check_roundstart_eligible()
	return FALSE
/datum/species/dwarf/can_equip(obj/item/I, slot, disable_warning, mob/living/carbon/human/H, bypass_equip_delay_self = FALSE)
	if((slot == ITEM_SLOT_ICLOTHING) && !is_type_in_list(src, I.species_exception))
		return FALSE
	return ..()

/datum/species/dwarf/on_species_gain(mob/living/carbon/human/C, datum/species/old_species, pref_load)
	var/facial_dwarf_hair = pick("Beard (Full)", "Beard (Dwarf)", "Beard (Very Long)")
	C.facial_hairstyle = facial_dwarf_hair
	var/dwarf_hair = pick("Bald", "Skinhead", "Dandy Pompadour")
	var/dwarf_beard = pick("Beard (Dwarf)") // you know it'd be cool if this actually worked with more than one beard
	C.hairstyle = dwarf_hair
	C.facial_hairstyle = dwarf_beard
	C.draw_hippie_parts()
	. = ..()
	C.remove_all_languages()
	C.grant_language(/datum/language/dwarven)
/datum/species/dwarf/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	C.draw_hippie_parts(TRUE)
	. = ..()
/datum/species/dwarf/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(!..())
		if(istype(chem, /datum/reagent/consumable/ethanol))
			var/datum/reagent/consumable/ethanol/theGoodStuff = chem
			var/boozePower = sqrt(theGoodStuff.volume) * theGoodStuff.boozepwr * DWARF_ALCOHOL_RATE
			dwarfDrunkness = clamp(dwarfDrunkness + boozePower, 0, 100)
			return TRUE // Don't metabolize alcohol like normal humans do.
/datum/species/dwarf/spec_life(mob/living/carbon/human/H)
	..()
	if(notDrunkEnoughTime < world.time)
		dwarfDrunkness--
		notDrunkEnoughTime = world.time + DRUNK_ALERT_TIME_OFFSET + rand(0, DRUNK_ALERT_TIME_OFFSET/2) // between 10 and 15 seconds
		switch(dwarfDrunkness)
			if(0 to 30) // too low, harmful
				H.adjustBruteLoss(10)
				H.adjustStaminaLoss(80)
				to_chat(H, "<span class='userdanger'>The lack of alcohol hurts you!</span>") // I'm not good with fluff messages, todo: improve
			if(30 to 45)
				to_chat(H, "<span class='danger'>You feel really thirsty. Something's wrong.</span>")
				if(prob(5))
					H.gain_trauma_type(BRAIN_TRAUMA_MILD)
				H.adjustStaminaLoss(60)
			if(45 to 60)
				H.adjustStaminaLoss(40)
				if(prob(30))
					to_chat(H, "<span class='danger'>You could really use a drink right about now.</span>")
			if(60 to 75)
				if(prob(30))
					to_chat(H, "<span class='danger'>You feel quite thirsty. A good beverage wouldn't hurt.</span>")
			// Else nothing happens

/datum/species/dwarf/random_name(gender,unique,lastname, en_lang = FALSE)
	return dwarf_name()

#undef DWARF_ALCOHOL_RATE

// Dwarven tongue, they only know their language.
/obj/item/organ/tongue/dwarven
	name = "nol"
	var/static/list/dwarvenLang = typecacheof(list(/datum/language/dwarven))

/obj/item/organ/tongue/dwarven/Initialize(mapload)
	. = ..()
	languages_possible = dwarvenLang

/obj/item/organ/lungs/dwarven
    name = "dwarven lungs"
    desc = "A pair of quite small lungs. They look different than normal human's ones."

    safe_oxygen_min = 0 // We don't breathe this
    safe_co2_min = 16 // We breathe this
    safe_co2_max = 0 // And more of it doesn't harm us

/datum/language/dwarven
	name = "Dwarven"
	desc = "An old language still used by some stem of the human species."
	key = "w"
	syllables = list(
		"etag", "gekur", "tel", "gudos", "geth", "udiz", "zalud", "shoveth", "ver", "zilir",
		"eshobak", "sarumak", "asdobak", "fozak", "shovethak", "tangak", "dogak", "ashokak", "gethak", "slisak", "mulonak",
		"vadag", "vasag", "udosag", "-longudosag", "vanag", "hivag", "vilkag", "nigag",
		"asdob", "nir", "nob", "mez", "vor", "fim", "gät", "zun", "ått", "nag", "zez", "eshob", "asdob",
		"og", "get", "zal", "ud", "lok", "ad", "nat", "gat", "mit", "des", "shug", "kul", "git", "gad", "zis",
		"deb", "koshmot", "legon", "razmer", "lanzil", "gim", "gamil", "datlad", "tat", "gelut", "gakit", "tomus", "tizöt", "rirnöl",
		"med", "kulet", "ngalák", "kuthdêng", "cenäth", "ustos", "oshnïl", "nural", "nazush"
	)
	space_chance = 35
	icon = 'white/valtos/icons/language.dmi'
	icon_state = "dwarf"

/obj/item/clothing/mask/breath/dwarf
	name = "небольшая дыхательная маска"
	desc = "Загадочным образом исчезает при надевании."
	icon_state = null // you'll only see this through adminbus any way
	inhand_icon_state = null

/datum/outfit/dwarf
	name = "Dwarf"
	uniform = /obj/item/clothing/under/dwarf
	shoes = /obj/item/clothing/shoes/dwarf
	ears = /obj/item/radio/headset
	back = /obj/item/storage/backpack
	mask = /obj/item/clothing/mask/breath/dwarf
	r_pocket = /obj/item/tank/internals/dwarf
	id = /obj/item/card/id

/datum/outfit/dwarf/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(visualsOnly)
		return
	H.set_species(/datum/species/dwarf)
	H.gender = MALE
	var/new_name = H.dna.species.random_name(H.gender, TRUE)
	H.fully_replace_character_name(H.real_name, new_name)
	H.regenerate_icons()
	var/obj/item/card/id/W = H.wear_id
	W.assignment = "Dwarf"
	W.registered_name = H.real_name
	W.update_label()
	W.access = list(ACCESS_MAINT_TUNNELS)
	var/obj/item/tank/internals/dwarf/T = H.r_store
	T.toggle_internals(H)
