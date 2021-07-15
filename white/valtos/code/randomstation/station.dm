/datum/map_template/ruin/station
	prefix = "_maps/RandomRuins/StationRuins/"
	cost = 0

/datum/map_template/ruin/station/brig
	id = "default_brig"
	suffix = "default_brig.dmm"
	name = "Default Brig"

/datum/map_template/ruin/station/brig/loose
	id = "loose_brig"
	suffix = "loose_brig.dmm"
	name = "Loose Brig"

/datum/map_template/ruin/station/brig/armored
	id = "armored_brig"
	suffix = "armored_brig.dmm"
	name = "Armored Brig"

/datum/map_template/ruin/station/bar
	id = "default_bar"
	suffix = "default_bar.dmm"
	name = "Default Bar"

/datum/map_template/ruin/station/bar/neon
	id = "neon_bar"
	suffix = "neon_bar.dmm"
	name = "Neon Bar"

/datum/map_template/ruin/station/bar/lava
	id = "lava_bar"
	suffix = "lava_bar.dmm"
	name = "Lava Bar"

/datum/map_template/ruin/station/bridge
	id = "default_central"
	suffix = "default_central.dmm"
	name = "Default Central"
	always_spawn_with = list(/datum/map_template/ruin/station/bridge/bottom = PLACE_BELOW)

/datum/map_template/ruin/station/bridge/bottom
	id = "default_central_bottom"
	suffix = "default_central_bottom.dmm"
	name = "Default Central Bottom"

/datum/map_template/ruin/station/bridge/compact
	id = "compact_central"
	suffix = "compact_central.dmm"
	name = "Compact Central"
	always_spawn_with = list(/datum/map_template/ruin/station/bridge/compact/bottom = PLACE_BELOW)

/datum/map_template/ruin/station/bridge/compact/bottom
	id = "compact_central_bottom"
	suffix = "compact_central_bottom.dmm"
	name = "Compact Central Bottom"

/datum/map_template/ruin/station/bridge/interesting
	id = "interesting_central"
	suffix = "interesting_central.dmm"
	name = "Interesting Central"

/datum/map_template/ruin/station/engine
	id = "engine_sm"
	suffix = "engine_sm.dmm"
	name = "Supermatter"
	always_spawn_with = list(/datum/map_template/ruin/station/engine/bottom = PLACE_BELOW)

/datum/map_template/ruin/station/engine/bottom
	id = "engine_sm_bottom"
	suffix = "engine_sm_bottom.dmm"
	name = "Supermatter Bottom"

/datum/map_template/ruin/station/engine/singulotesla
	id = "engine_singulo_tesla"
	suffix = "engine_singulo_tesla.dmm"
	name = "Singulo or Tesla"
	always_spawn_with = list(/datum/map_template/ruin/station/engine/bottom/singulotesla = PLACE_BELOW)

/datum/map_template/ruin/station/engine/bottom/singulotesla
	id = "engine_singulo_tesla_bottom"
	suffix = "engine_singulo_tesla_bottom.dmm"
	name = "Singulo or Tesla Bottom"

/datum/map_template/ruin/station/engine/antimatter
	id = "engine_am"
	suffix = "engine_am.dmm"
	name = "Antimatter"
	always_spawn_with = list(/datum/map_template/ruin/station/engine/bottom/default = PLACE_BELOW)

/datum/map_template/ruin/station/engine/budget
	id = "engine_budget"
	suffix = "engine_budget.dmm"
	name = "Budget"
	always_spawn_with = list(/datum/map_template/ruin/station/engine/bottom/default = PLACE_BELOW)

/datum/map_template/ruin/station/engine/teg
	id = "engine_teg"
	suffix = "engine_teg.dmm"
	name = "Teg"
	always_spawn_with = list(/datum/map_template/ruin/station/engine/bottom/teg = PLACE_BELOW)

/datum/map_template/ruin/station/engine/bottom/teg
	id = "engine_teg_bottom"
	suffix = "engine_teg_bottom.dmm"
	name = "TEG Bottom"

/datum/map_template/ruin/station/engine/bottom/default
	id = "engine_default_bottom"
	suffix = "engine_default_bottom.dmm"
	name = "Default Engine Bottom"

/datum/map_template/ruin/station/maint_sw
	id = "default_maint_sw"
	suffix = "default_maint_sw.dmm"
	name = "Default Maint SW"

/datum/map_template/ruin/station/maint_sw/arena
	id = "arena_maint_sw"
	suffix = "arena_maint_sw.dmm"
	name = "Arena Maint SW"

/datum/map_template/ruin/station/maint_sw/chess
	id = "chess_maint_sw"
	suffix = "chess_maint_sw.dmm"
	name = "Chess Maint SW"

/datum/map_template/ruin/station/med
	id = "default_med"
	suffix = "default_med.dmm"
	name = "Default Medbay"

/datum/map_template/ruin/station/med/durka
	id = "durka_med2"
	suffix = "durka_med2.dmm"
	name = "Durka Fortress"
	always_spawn_with = list(/datum/map_template/ruin/station/med/durka/bottom = PLACE_BELOW)

/datum/map_template/ruin/station/med/durka/bottom
	id = "durka_med_bottom"
	suffix = "durka_med_bottom.dmm"
	name = "Durka Fortress Bottom"

/datum/map_template/ruin/station/med/old
	id = "old_med"
	suffix = "old_med.dmm"
	name = "Old Medbay"
