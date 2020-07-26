/obj/machinery/power/port_gen/pacman/ecrys
	name = "\improper W.E.E.B.-type portable generator"
	icon_state = "portgen1_0"
	base_icon = "portgen1"
	circuit = /obj/item/circuitboard/machine/pacman/ecrys
	sheet_path = /obj/item/stack/solid_electricity
	power_gen = 20000
	time_per_sheet = 120

/obj/item/circuitboard/machine/pacman/ecrys
	name = "WEEB-type Generator (Machine Board)"
	icon_state = "engineering"
	build_path = /obj/machinery/power/port_gen/pacman/ecrys

/obj/machinery/power/port_gen/pacman/biogen
	name = "portable biogenerator"
	desc = "Внутри мутной жижи можно заметить генномодифицированных детей донбасса, потребляющих кристаллы аммиака и крутящих динамомашинки."
	icon = 'icons/obj/machines/cloning.dmi'
	icon_state = "pod_0"
	base_icon = "pod"
	circuit = /obj/item/circuitboard/machine/pacman/biogen
	sheet_path = /obj/item/stack/ammonia_crystals
	power_gen = 40000
	time_per_sheet = 60

/obj/item/circuitboard/machine/pacman/biogen
	name = "Portable Biogenerator (Machine Board)"
	icon_state = "engineering"
	build_path = /obj/machinery/power/port_gen/pacman/biogen
