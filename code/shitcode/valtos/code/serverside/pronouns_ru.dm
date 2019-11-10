//pronoun procs, for getting pronouns without using the text macros that only work in certain positions
//datums don't have gender, but most of their subtypes do!
/datum/proc/ru_who(capitalized, temp_gender)
	. = "он"
	if(capitalized)
		. = capitalize(.)

/datum/proc/ru_ego(capitalized, temp_gender)
	. = "его"
	if(capitalized)
		. = capitalize(.)

/datum/proc/ru_eto(capitalized, temp_gender)
	. = "это"
	if(capitalized)
		. = capitalize(.)

/datum/proc/ru_have(temp_gender)
	. = "имеет"

/datum/proc/ru_was(temp_gender)
	. = "был"

/datum/proc/ru_do(temp_gender)
	. = "делает"

/datum/proc/ru_kon(temp_gender)
	. = "ый"

/datum/proc/ru_na(temp_gender)
	. = "ём"

/datum/proc/ru_a(temp_gender)
	. = ""

//like clients, which do have gender.
/client/ru_who(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "он"
	switch(temp_gender)
		if(FEMALE)
			. = "она"
		if(MALE)
			. = "он"
	if(capitalized)
		. = capitalize(.)

/client/ru_ego(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "его"
	switch(temp_gender)
		if(FEMALE)
			. = "её"
		if(MALE)
			. = "его"
	if(capitalized)
		. = capitalize(.)

/client/ru_was(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "был"
	switch(temp_gender)
		if(FEMALE)
			. = "была"
		if(MALE)
			. = "был"
	if(capitalized)
		. = capitalize(.)

/client/ru_na(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "ём"
	switch(temp_gender)
		if(FEMALE)
			. = "ей"
		if(MALE)
			. = "ём"
	if(capitalized)
		. = capitalize(.)

/client/ru_a(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = ""
	switch(temp_gender)
		if(FEMALE)
			. = "а"
		if(MALE)
			. = ""
	if(capitalized)
		. = capitalize(.)

/client/ru_eto(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "это"
	if(temp_gender == PLURAL || temp_gender == NEUTER)
		. = "эти"

/client/ru_have(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "имеет"
	if(temp_gender == PLURAL || temp_gender == NEUTER)
		. = "имеет"


//mobs(and atoms but atoms don't really matter write your own proc overrides) also have gender!
/mob/ru_who(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "он"
	switch(temp_gender)
		if(FEMALE)
			. = "она"
		if(MALE)
			. = "он"
		if(PLURAL)
			. = "оно"
	if(capitalized)
		. = capitalize(.)

/mob/ru_ego(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "его"
	switch(temp_gender)
		if(FEMALE)
			. = "её"
		if(MALE)
			. = "его"
		if(PLURAL)
			. = "его"
	if(capitalized)
		. = capitalize(.)

/mob/ru_eto(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "это"
	switch(temp_gender)
		if(FEMALE)
			. = "это"
		if(MALE)
			. = "это"
		if(PLURAL)
			. = "это"
	if(capitalized)
		. = capitalize(.)

/mob/ru_na(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "ём"
	switch(temp_gender)
		if(FEMALE)
			. = "ей"
		if(MALE)
			. = "ём"
		if(PLURAL)
			. = "ём"
	if(capitalized)
		. = capitalize(.)

/mob/ru_kon(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "ый"
	switch(temp_gender)
		if(FEMALE)
			. = "аЯ"
		if(MALE)
			. = "ый"
		if(PLURAL)
			. = "ое"

/mob/ru_a(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = ""
	switch(temp_gender)
		if(FEMALE)
			. = "а"
		if(MALE)
			. = ""
		if(PLURAL)
			. = "о"

/mob/ru_was(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "был"
	switch(temp_gender)
		if(FEMALE)
			. = "была"
		if(MALE)
			. = "был"
		if(PLURAL)
			. = "был"

/mob/ru_have(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "имеет"
	if(temp_gender == PLURAL)
		. = "имело"

//humans need special handling, because they can have their gender hidden
/mob/living/carbon/human/ru_who(capitalized, temp_gender)
	var/list/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((SLOT_W_UNIFORM in obscured) && skipface)
		temp_gender = PLURAL
	return ..()

/mob/living/carbon/human/ru_ego(capitalized, temp_gender)
	var/list/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((SLOT_W_UNIFORM in obscured) && skipface)
		temp_gender = PLURAL
	return ..()

/mob/living/carbon/human/ru_eto(capitalized, temp_gender)
	var/list/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((SLOT_W_UNIFORM in obscured) && skipface)
		temp_gender = PLURAL
	return ..()

/mob/living/carbon/human/ru_was(capitalized, temp_gender)
	var/list/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((SLOT_W_UNIFORM in obscured) && skipface)
		temp_gender = PLURAL
	return ..()

/mob/living/carbon/human/ru_kon(capitalized, temp_gender)
	var/list/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((SLOT_W_UNIFORM in obscured) && skipface)
		temp_gender = PLURAL
	return ..()

/mob/living/carbon/human/ru_have(capitalized, temp_gender)
	var/list/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((SLOT_W_UNIFORM in obscured) && skipface)
		temp_gender = PLURAL
	return ..()

/mob/living/carbon/human/ru_a(capitalized, temp_gender)
	var/list/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((SLOT_W_UNIFORM in obscured) && skipface)
		temp_gender = PLURAL
	return ..()
