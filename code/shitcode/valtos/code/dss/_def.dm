//fuck

#define MOB_STR "strength"
#define MOB_STM "stamina"
#define MOB_INT "intelligence"
#define MOB_DEX "dexterity"

// stats

/mob/living/carbon/human/var/list/dstats = list(MOB_STR = 10, MOB_STM = 10, MOB_INT = 10, MOB_DEX = 10)

// do this shit

/mob/living/carbon/human/New()
	. = ..()
	for(var/S in dstats)
		S = rand(7, 12)
