/obj/item/tank/internals/dwarf
	worn_icon = 'white/valtos/icons/forge/belt.dmi' // by the way, why do we put alternate_worn_icon first?
	name = "баллон с углекислым газом"
	desc = "Твой личный билет в АД, но только если ты не Дворф"
	icon = 'white/valtos/icons/dwarfs/tank.dmi' // yeah I used the old oxygen sprite. what are you gonna do about it?
	icon_state = "dwarftank"
	inhand_icon_state = "dwarftank"
	lefthand_file = 'white/valtos/icons/lefthand.dmi'
	righthand_file = 'white/valtos/icons/righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	force = 4
	distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE
	volume = 8


/obj/item/tank/internals/dwarf/populate_gas()
	air_contents.set_moles(/datum/gas/carbon_dioxide, (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))
