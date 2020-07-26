/obj/effect/turf_decal/tile/hex
	name = "hex tile decal"
	icon = 'white/valtos/icons/decals.dmi'
	icon_state = "hex_tile_corner"
	alpha = 35

/obj/effect/turf_decal/tile/hex/blue
	name = "синий hex corner"
	color = "#52B4E9"

/obj/effect/turf_decal/tile/hex/green
	name = "зелёный hex corner"
	color = "#9FED58"

/obj/effect/turf_decal/tile/hex/yellow
	name = "жёлтый hex corner"
	color = "#EFB341"

/obj/effect/turf_decal/tile/hex/red
	name = "красный hex corner"
	color = "#DE3A3A"

/obj/effect/turf_decal/tile/hex/bar
	name = "bar hex corner"
	color = "#791500"
	alpha = 130

/obj/effect/turf_decal/tile/hex/purple
	name = "фиолетовый hex corner"
	color = "#D381C9"

/obj/effect/turf_decal/tile/hex/brown
	name = "brown hex corner"
	color = "#A46106"

/obj/effect/turf_decal/tile/hex/neutral
	name = "neutral hex corner"
	color = "#D4D4D4"
	alpha = 10

/obj/effect/turf_decal/tile/hex/dark
	name = "dark hex corner"
	color = "#222222"

/obj/effect/turf_decal/tile/hex/random // so many colors
	name = "colorful hex corner"
	color = "#E300FF" //bright pink as default for mapping

/obj/effect/turf_decal/tile/hex/random/Initialize()
	color = "#[random_short_color()]"
	. = ..()
