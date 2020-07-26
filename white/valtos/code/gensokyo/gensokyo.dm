/obj/structure/flora/tree/gensokyo
	name = "дерево"
	desc = "Огромное! Да..."
	icon = 'white/valtos/icons/gensokyo/bigtrees.dmi'
	icon_state = "tree_1"

/obj/structure/flora/tree/gensokyo/Initialize()
	. = ..()
	icon_state = "tree_[rand(1, 8)]"

/datum/award/achievement/boss/reimu_kill
	name = "Reimu Killer"
	desc = "Reimu is gone."
	database_id = BOSS_MEDAL_REIMU

/datum/award/achievement/boss/reimu_crusher
	name = "Reimu Killer Crusher"
	desc = "Reimu is gone."
	database_id = BOSS_MEDAL_REIMU_CRUSHER

/datum/award/score/reimu_score
	name = "Reimu's Killed"
	desc = "You've killed HOW many?"
	database_id = REIMU_SCORE
