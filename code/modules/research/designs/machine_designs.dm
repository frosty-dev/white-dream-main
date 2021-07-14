////////////////////////////////////////
//////////////MISC Boards///////////////
////////////////////////////////////////
/datum/design/board/electrolyzer
	name = "Оборудование (Electrolyzer Board)"
	desc = "The circuit board for an electrolyzer."
	id = "electrolyzer"
	build_path = /obj/item/circuitboard/machine/electrolyzer
	category = list ("Инженерное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/smes
	name = "Оборудование (SMES Board)"
	desc = "The circuit board for a SMES."
	id = "smes"
	build_path = /obj/item/circuitboard/machine/smes
	category = list ("Инженерное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/circulator
	name = "Оборудование (Circulator Board)"
	desc = "The circuit board for a circulator."
	id = "circulator"
	build_path = /obj/item/circuitboard/machine/circulator
	category = list ("Инженерное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/teg
	name = "Оборудование (TEG Board)"
	desc = "The circuit board for a TEG."
	id = "teg"
	build_path = /obj/item/circuitboard/machine/generator
	category = list ("Инженерное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/announcement_system
	name = "Оборудование (Automated Announcement System Board)"
	desc = "The circuit board for an automated announcement system."
	id = "automated_announcement"
	build_path = /obj/item/circuitboard/machine/announcement_system
	category = list("Подпространственная связь")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/turbine_computer
	name = "Дизайн консоли (Power Turbine Console Board)"
	desc = "The circuit board for a power turbine console."
	id = "power_turbine_console"
	build_path = /obj/item/circuitboard/computer/turbine_computer
	category = list ("Инженерное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/emitter
	name = "Оборудование (Emitter Board)"
	desc = "The circuit board for an emitter."
	id = "emitter"
	build_path = /obj/item/circuitboard/machine/emitter
	category = list ("Инженерное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/power_compressor
	name = "Оборудование (Power Compressor Board)"
	desc = "The circuit board for a power compressor."
	id = "power_compressor"
	build_path = /obj/item/circuitboard/machine/power_compressor
	category = list ("Инженерное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/power_turbine
	name = "Оборудование (Power Turbine Board)"
	desc = "The circuit board for a power turbine."
	id = "power_turbine"
	build_path = /obj/item/circuitboard/machine/power_turbine
	category = list ("Инженерное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/thermomachine
	name = "Оборудование (Freezer/Heater Board)"
	desc = "The circuit board for a freezer/heater."
	id = "thermomachine"
	build_path = /obj/item/circuitboard/machine/thermomachine
	category = list ("Инженерное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/space_heater
	name = "Оборудование (Space Heater Board)"
	desc = "The circuit board for a space heater."
	id = "space_heater"
	build_path = /obj/item/circuitboard/machine/space_heater
	category = list ("Инженерное оборудование")
	departmental_flags = ALL

/datum/design/board/teleport_station
	name = "Оборудование (Teleportation Station Board)"
	desc = "The circuit board for a teleportation station."
	id = "tele_station"
	build_path = /obj/item/circuitboard/machine/teleporter_station
	category = list ("Телепортация")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/teleport_hub
	name = "Оборудование (Teleportation Hub Board)"
	desc = "The circuit board for a teleportation hub."
	id = "tele_hub"
	build_path = /obj/item/circuitboard/machine/teleporter_hub
	category = list ("Телепортация")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/quantumpad
	name = "Оборудование (Quantum Pad Board)"
	desc = "The circuit board for a quantum telepad."
	id = "quantumpad"
	build_path = /obj/item/circuitboard/machine/quantumpad
	category = list ("Телепортация")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/launchpad
	name = "Оборудование (Bluespace Launchpad Board)"
	desc = "The circuit board for a bluespace Launchpad."
	id = "launchpad"
	build_path = /obj/item/circuitboard/machine/launchpad
	category = list ("Телепортация")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/launchpad_console
	name = "Оборудование (Bluespace Launchpad Console Board)"
	desc = "The circuit board for a bluespace launchpad Console."
	id = "launchpad_console"
	build_path = /obj/item/circuitboard/computer/launchpad_console
	category = list ("Телепортация")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/teleconsole
	name = "Дизайн консоли (Teleporter Console)"
	desc = "Allows for the construction of circuit boards used to build a teleporter control console."
	id = "teleconsole"
	build_path = /obj/item/circuitboard/computer/teleporter
	category = list("Телепортация")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/cryotube
	name = "Оборудование (Cryotube Board)"
	desc = "The circuit board for a cryotube."
	id = "cryotube"
	build_path = /obj/item/circuitboard/machine/cryo_tube
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_MEDICAL
	category = list ("Медицинское оборудование")

/datum/design/board/chem_dispenser
	name = "Оборудование (Portable Chem Dispenser Board)"
	desc = "The circuit board for a portable chem dispenser."
	id = "chem_dispenser"
	build_path = /obj/item/circuitboard/machine/chem_dispenser
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_MEDICAL
	category = list ("Медицинское оборудование")

/datum/design/board/chem_master
	name = "Оборудование (Chem Master Board)"
	desc = "The circuit board for a Chem Master 3000."
	id = "chem_master"
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_MEDICAL
	build_path = /obj/item/circuitboard/machine/chem_master
	category = list ("Медицинское оборудование")

/datum/design/board/chem_heater
	name = "Оборудование (Chemical Heater Board)"
	desc = "The circuit board for a chemical heater."
	id = "chem_heater"
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_MEDICAL
	build_path = /obj/item/circuitboard/machine/chem_heater
	category = list ("Медицинское оборудование")

/datum/design/board/smoke_machine
	name = "Оборудование (Smoke Machine)"
	desc = "The circuit board for a smoke machine."
	id = "smoke_machine"
	build_path = /obj/item/circuitboard/machine/smoke_machine
	category = list ("Медицинское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/board/reagentgrinder
	name = "Оборудование (All-In-One Grinder)"
	desc = "The circuit board for an All-In-One Grinder."
	id = "reagentgrinder"
	build_path = /obj/item/circuitboard/machine/reagentgrinder
	category = list ("Медицинское оборудование")

/datum/design/board/hypnochair
	name = "Оборудование (Enhanced Interrogation Chamber)"
	desc = "Allows for the construction of circuit boards used to build an Enhanced Interrogation Chamber."
	id = "hypnochair"
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
	build_path = /obj/item/circuitboard/machine/hypnochair
	category = list("Различное оборудование")

/datum/design/board/biogenerator
	name = "Оборудование (Biogenerator Board)"
	desc = "The circuit board for a biogenerator."
	id = "biogenerator"
	build_path = /obj/item/circuitboard/machine/biogenerator
	category = list ("Оборудование гидропоники")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/board/hydroponics
	name = "Оборудование (Hydroponics Tray Board)"
	desc = "The circuit board for a hydroponics tray."
	id = "hydro_tray"
	build_path = /obj/item/circuitboard/machine/hydroponics
	category = list ("Оборудование гидропоники")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/board/destructive_analyzer
	name = "Оборудование (Destructive Analyzer Board)"
	desc = "The circuit board for a destructive analyzer."
	id = "destructive_analyzer"
	build_path = /obj/item/circuitboard/machine/destructive_analyzer
	category = list("Исследовательское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/experimentor
	name = "Оборудование (E.X.P.E.R.I-MENTOR Board)"
	desc = "The circuit board for an E.X.P.E.R.I-MENTOR."
	id = "experimentor"
	build_path = /obj/item/circuitboard/machine/experimentor
	category = list("Исследовательское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/bepis
	name = "Оборудование (B.E.P.I.S. Board)"
	desc = "The circuit board for a B.E.P.I.S."
	id = "bepis"
	build_path = /obj/item/circuitboard/machine/bepis
	category = list("Исследовательское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/board/protolathe
	name = "Оборудование (Protolathe Board)"
	desc = "The circuit board for a protolathe."
	id = "protolathe"
	build_path = /obj/item/circuitboard/machine/protolathe
	category = list("Исследовательское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/circuit_imprinter
	name = "Оборудование (Circuit Imprinter Board)"
	desc = "The circuit board for a circuit imprinter."
	id = "circuit_imprinter"
	build_path = /obj/item/circuitboard/machine/circuit_imprinter
	category = list("Исследовательское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/rdservercontrol
	name = "Дизайн консоли (R&D Server Control Console Board)"
	desc = "The circuit board for an R&D Server Control Console."
	id = "rdservercontrol"
	build_path = /obj/item/circuitboard/computer/rdservercontrol
	category = list("Исследовательское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/rdserver
	name = "Оборудование (R&D Server Board)"
	desc = "The circuit board for an R&D Server."
	id = "rdserver"
	build_path = /obj/item/circuitboard/machine/rdserver
	category = list("Исследовательское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/mechfab
	name = "Оборудование (Exosuit Fabricator Board)"
	desc = "The circuit board for an Exosuit Fabricator."
	id = "mechfab"
	build_path = /obj/item/circuitboard/machine/mechfab
	category = list("Исследовательское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/cyborgrecharger
	name = "Оборудование (Cyborg Recharger Board)"
	desc = "The circuit board for a Cyborg Recharger."
	id = "cyborgrecharger"
	build_path = /obj/item/circuitboard/machine/cyborgrecharger
	category = list("Исследовательское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/mech_recharger
	name = "Оборудование (Mechbay Recharger Board)"
	desc = "The circuit board for a Mechbay Recharger."
	id = "mech_recharger"
	build_path = /obj/item/circuitboard/machine/mech_recharger
	category = list("Исследовательское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/nanite_chamber
	name = "Оборудование (Nanite Chamber Board)"
	desc = "The circuit board for a Nanite Chamber."
	id = "nanite_chamber"
	build_path = /obj/item/circuitboard/machine/nanite_chamber
	category = list("Исследовательское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/public_nanite_chamber
	name = "Оборудование (Public Nanite Chamber Board)"
	desc = "The circuit board for a Public Nanite Chamber."
	id = "public_nanite_chamber"
	build_path = /obj/item/circuitboard/machine/public_nanite_chamber
	category = list("Исследовательское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/nanite_programmer
	name = "Оборудование (Nanite Programmer Board)"
	desc = "The circuit board for a Nanite Programmer."
	id = "nanite_programmer"
	build_path = /obj/item/circuitboard/machine/nanite_programmer
	category = list("Исследовательское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/nanite_program_hub
	name = "Оборудование (Nanite Program Hub Board)"
	desc = "The circuit board for a Nanite Program Hub."
	id = "nanite_program_hub"
	build_path = /obj/item/circuitboard/machine/nanite_program_hub
	category = list("Исследовательское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/dnascanner
	name = "Оборудование (DNA Scanner)"
	desc = "The circuit board for a DNA Scanner."
	id = "dnascanner"
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE
	build_path = /obj/item/circuitboard/machine/dnascanner
	category = list("Исследовательское оборудование")

/datum/design/board/destructive_scanner
	name = "Machine Design (Destructive Scanner Board)"
	desc = "The circuit board for an experimental destructive scanner."
	id = "destructive_scanner"
	build_path = /obj/item/circuitboard/machine/destructive_scanner
	category = list("Исследовательское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/doppler_array
	name = "Machine Design (Tachyon-Doppler Research Array Board)"
	desc = "The circuit board for a tachyon-doppler research array"
	id = "doppler_array"
	build_path = /obj/item/circuitboard/machine/doppler_array
	category = list("Исследовательское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/microwave
	name = "Оборудование (Microwave Board)"
	desc = "The circuit board for a microwave."
	id = "microwave"
	build_path = /obj/item/circuitboard/machine/microwave
	category = list ("Различное оборудование")


/datum/design/board/gibber
	name = "Оборудование (Gibber Board)"
	desc = "The circuit board for a gibber."
	id = "gibber"
	build_path = /obj/item/circuitboard/machine/gibber
	category = list ("Различное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/board/smartfridge
	name = "Оборудование (Smartfridge Board)"
	desc = "The circuit board for a smartfridge."
	id = "smartfridge"
	build_path = /obj/item/circuitboard/machine/smartfridge
	category = list ("Различное оборудование")


/datum/design/board/monkey_recycler
	name = "Оборудование (Monkey Recycler Board)"
	desc = "The circuit board for a monkey recycler."
	id = "monkey_recycler"
	build_path = /obj/item/circuitboard/machine/monkey_recycler
	category = list ("Различное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_SERVICE

/datum/design/board/seed_extractor
	name = "Оборудование (Seed Extractor Board)"
	desc = "The circuit board for a seed extractor."
	id = "seed_extractor"
	build_path = /obj/item/circuitboard/machine/seed_extractor
	category = list ("Оборудование гидропоники")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/board/processor
	name = "Оборудование (Food/Slime Processor Board)"
	desc = "The circuit board for a processing unit. Screwdriver the circuit to switch between food (default) or slime processing."
	id = "processor"
	build_path = /obj/item/circuitboard/machine/processor
	category = list ("Различное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_SERVICE

/datum/design/board/soda_dispenser
	name = "Оборудование (Portable Soda Dispenser Board)"
	desc = "The circuit board for a portable soda dispenser."
	id = "soda_dispenser"
	build_path = /obj/item/circuitboard/machine/chem_dispenser/drinks
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE
	category = list ("Различное оборудование")

/datum/design/board/beer_dispenser
	name = "Оборудование (Portable Booze Dispenser Board)"
	desc = "The circuit board for a portable booze dispenser."
	id = "beer_dispenser"
	build_path = /obj/item/circuitboard/machine/chem_dispenser/drinks/beer
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE
	category = list ("Различное оборудование")

/datum/design/board/recycler
	name = "Оборудование (Recycler Board)"
	desc = "The circuit board for a recycler."
	id = "recycler"
	build_path = /obj/item/circuitboard/machine/recycler
	category = list ("Различное оборудование")


/datum/design/board/scanner_gate
	name = "Оборудование (Scanner Gate)"
	desc = "The circuit board for a scanner gate."
	id = "scanner_gate"
	build_path = /obj/item/circuitboard/machine/scanner_gate
	category = list ("Различное оборудование")


/datum/design/board/holopad
	name = "Оборудование (AI Holopad Board)"
	desc = "The circuit board for a holopad."
	id = "holopad"
	build_path = /obj/item/circuitboard/machine/holopad
	category = list ("Различное оборудование")


/datum/design/board/autolathe
	name = "Оборудование (Autolathe Board)"
	desc = "The circuit board for an autolathe."
	id = "autolathe"
	build_path = /obj/item/circuitboard/machine/autolathe
	category = list ("Различное оборудование")


/datum/design/board/recharger
	name = "Оборудование (Weapon Recharger Board)"
	desc = "The circuit board for a Weapon Recharger."
	id = "recharger"
	materials = list(/datum/material/glass = 1000, /datum/material/gold = 2000)
	build_path = /obj/item/circuitboard/machine/recharger
	category = list("Различное оборудование")


/datum/design/board/vendor
	name = "Оборудование (Vendor Board)"
	desc = "The circuit board for a Vendor."
	id = "vendor"
	build_path = /obj/item/circuitboard/machine/vendor
	category = list ("Различное оборудование")


/datum/design/board/ore_redemption
	name = "Оборудование (Ore Redemption Board)"
	desc = "The circuit board for an Ore Redemption machine."
	id = "ore_redemption"
	build_path = /obj/item/circuitboard/machine/ore_redemption
	category = list ("Различное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO | DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/mining_equipment_vendor
	name = "Оборудование (Mining Rewards Vendor Board)"
	desc = "The circuit board for a Mining Rewards Vendor."
	id = "mining_equipment_vendor"
	build_path = /obj/item/circuitboard/machine/mining_equipment_vendor
	category = list ("Различное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/board/exploration_equipment_vendor
	name = "Machine Design (Exploration Rewards Vendor Board)"
	desc = "The circuit board for an Exploration Rewards Vendor."
	id = "exploration_equipment_vendor"
	build_path = /obj/item/circuitboard/machine/exploration_equipment_vendor
	category = list ("Различное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/board/tesla_coil
	name = "Оборудование (Tesla Coil Board)"
	desc = "The circuit board for a tesla coil."
	id = "tesla_coil"
	build_path = /obj/item/circuitboard/machine/tesla_coil
	category = list ("Различное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/rad_collector
	name = "Оборудование (Radiation Collector Board)"
	desc = "The circuit board for a radiation collector array."
	id = "rad_collector"
	build_path = /obj/item/circuitboard/machine/rad_collector
	category = list ("Различное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/grounding_rod
	name = "Оборудование (Grounding Rod Board)"
	desc = "The circuit board for a grounding rod."
	id = "grounding_rod"
	build_path = /obj/item/circuitboard/machine/grounding_rod
	category = list ("Различное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/ntnet_relay
	name = "Оборудование (NTNet Relay Board)"
	desc = "The circuit board for a wireless network relay."
	id = "ntnet_relay"
	build_path = /obj/item/circuitboard/machine/ntnet_relay
	category = list("Подпространственная связь")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/limbgrower
	name = "Оборудование (Limb Grower Board)"
	desc = "The circuit board for a limb grower."
	id = "limbgrower"
	build_path = /obj/item/circuitboard/machine/limbgrower
	category = list("Медицинское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/board/harvester
	name = "Оборудование (Organ Harvester Board)"
	desc = "The circuit board for an organ harvester."
	id = "harvester"
	build_path = /obj/item/circuitboard/machine/harvester
	category = list("Медицинское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/board/deepfryer
	name = "Оборудование (Deep Fryer)"
	desc = "The circuit board for a Deep Fryer."
	id = "deepfryer"
	build_path = /obj/item/circuitboard/machine/deep_fryer
	category = list ("Различное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/board/griddle
	name = "Machine Design (Griddle)"
	desc = "The circuit board for a Griddle."
	id = "griddle"
	build_path = /obj/item/circuitboard/machine/griddle
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/board/donksofttoyvendor
	name = "Оборудование (Donksoft Toy Vendor Board)"
	desc = "The circuit board for a Donksoft Toy Vendor."
	id = "donksofttoyvendor"
	build_path = /obj/item/circuitboard/machine/vending/donksofttoyvendor
	category = list ("Различное оборудование")


/datum/design/board/cell_charger
	name = "Оборудование (Cell Charger Board)"
	desc = "The circuit board for a cell charger."
	id = "cell_charger"
	build_path = /obj/item/circuitboard/machine/cell_charger
	category = list ("Различное оборудование")


/datum/design/board/dish_drive
	name = "Оборудование (Dish Drive)"
	desc = "The circuit board for a dish drive."
	id = "dish_drive"
	build_path = /obj/item/circuitboard/machine/dish_drive
	category = list ("Различное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/board/stacking_unit_console
	name = "Оборудование (Stacking Machine Console)"
	desc = "The circuit board for a Stacking Machine Console."
	id = "stack_console"
	build_path = /obj/item/circuitboard/machine/stacking_unit_console
	category = list ("Различное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO | DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/stacking_machine
	name = "Оборудование (Stacking Machine)"
	desc = "The circuit board for a Stacking Machine."
	id = "stack_machine"
	build_path = /obj/item/circuitboard/machine/stacking_machine
	category = list ("Различное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO | DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/ore_silo
	name = "Оборудование (Ore Silo)"
	desc = "The circuit board for an ore silo."
	id = "ore_silo"
	build_path = /obj/item/circuitboard/machine/ore_silo
	category = list ("Исследовательское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/board/paystand
	name = "Оборудование (Pay Stand)"
	desc = "The circuit board for a paystand."
	id = "paystand"
	build_path = /obj/item/circuitboard/machine/paystand
	category = list ("Различное оборудование")


/datum/design/board/fat_sucker
	name = "Оборудование (Lipid Extractor)"
	desc = "The circuit board for a lipid extractor."
	id = "fat_sucker"
	build_path = /obj/item/circuitboard/machine/fat_sucker
	category = list ("Различное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/board/stasis
	name = "Оборудование (Lifeform Stasis Unit)"
	desc = "The circuit board for a stasis unit."
	id = "stasis"
	build_path = /obj/item/circuitboard/machine/stasis
	category = list("Медицинское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/board/medical_kiosk
	name = "Оборудование (Medical Kiosk)"
	desc = "The circuit board for a Medical Kiosk."
	id = "medical_kiosk"
	build_path = /obj/item/circuitboard/machine/medical_kiosk
	category = list ("Медицинское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/board/medipen_refiller
	name = "Оборудование (Medipen Refiller)"
	desc = "The circuit board for a Medipen Refiller."
	id = "medipen_refiller"
	build_path = /obj/item/circuitboard/machine/medipen_refiller
	category = list ("Медицинское оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/board/plumbing_receiver
	name = "Оборудование (Chemical Recipient)"
	desc = "The circuit board for a Chemical Recipient."
	id = "plumbing_receiver"
	build_path = /obj/item/circuitboard/machine/plumbing_receiver
	category = list ("Телепортация")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL


/datum/design/board/sheetifier
	name = "Оборудование (Sheet-meister 2000)"
	desc = "The circuit board for a Sheet-meister 2000."
	id = "sheetifier"
	build_path = /obj/item/circuitboard/machine/sheetifier
	category = list ("Различное оборудование")


/datum/design/board/restaurant_portal
	name = "Machine Design (Restaurant Portal)"
	desc = "The circuit board for a restaurant portal"
	id = "restaurant_portal"
	build_path = /obj/item/circuitboard/machine/restaurant_portal
	category = list ("Misc. Machinery")

/datum/design/board/vendatray
	name = "Оборудование (Vend-a-Tray)"
	desc = "The circuit board for a Vend-a-Tray."
	id = "vendatray"
	build_path = /obj/item/circuitboard/machine/vendatray
	category = list ("Различное оборудование")

/datum/design/board/bountypad
	name = "Оборудование (Civilian Bounty Pad)"
	desc = "The circuit board for a Civilian Bounty Pad."
	id = "bounty_pad"
	build_path = /obj/item/circuitboard/machine/bountypad
	category = list ("Различное оборудование")

/datum/design/board/skill_station
	name = "Оборудование (Skill station)"
	desc = "The circuit board for Skill station."
	id = "skill_station"
	build_path = /obj/item/circuitboard/machine/skill_station
	category = list ("Различное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO | DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SERVICE

/datum/design/board/accounting
	name = "Оборудование (Account Registration Device)"
	desc = "The circuit board for a Account Registration Device."
	id = "accounting"
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
	build_path = /obj/item/circuitboard/machine/accounting
	category = list ("Различное оборудование")

//Hypertorus fusion reactor designs

/datum/design/board/HFR_core
	name = "Machine Design (HFR Core)"
	desc = "The circuit board for an HFR Core."
	id = "HFR_core"
	build_path = /obj/item/circuitboard/machine/HFR_core
	category = list ("Инженерное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/HFR_fuel_input
	name = "Machine Design (HFR fuel input)"
	desc = "The circuit board for a freezer/heater."
	id = "HFR_fuel_input"
	build_path = /obj/item/circuitboard/machine/HFR_fuel_input
	category = list ("Инженерное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/HFR_waste_output
	name = "Machine Design (HFR waste output)"
	desc = "The circuit board for a freezer/heater."
	id = "HFR_waste_output"
	build_path = /obj/item/circuitboard/machine/HFR_waste_output
	category = list ("Инженерное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/HFR_moderator_input
	name = "Machine Design (HFR moderator input)"
	desc = "The circuit board for a freezer/heater."
	id = "HFR_moderator_input"
	build_path = /obj/item/circuitboard/machine/HFR_moderator_input
	category = list ("Инженерное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/HFR_corner
	name = "Machine Design (HFR corner)"
	desc = "The circuit board for a freezer/heater."
	id = "HFR_corner"
	build_path = /obj/item/circuitboard/machine/HFR_corner
	category = list ("Инженерное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/HFR_interface
	name = "Machine Design (HFR interface)"
	desc = "The circuit board for a freezer/heater."
	id = "HFR_interface"
	build_path = /obj/item/circuitboard/machine/HFR_interface
	category = list ("Инженерное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/crystallizer
	name = "Machine Design (Crystallizer)"
	desc = "The circuit board for a crystallizer."
	id = "crystallizer"
	build_path = /obj/item/circuitboard/machine/crystallizer
	category = list ("Инженерное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/exoscanner
	name = "Machine Design (Scanner Array)"
	desc = "The circuit board for scanner array."
	id = "exoscanner"
	build_path = /obj/item/circuitboard/machine/exoscanner
	category = list ("Инженерное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/board/exodrone_launcher
	name = "Machine Design (Exploration Drone Launcher)"
	desc = "The circuit board for exodrone launcher."
	id = "exodrone_launcher"
	build_path = /obj/item/circuitboard/machine/exodrone_launcher
	category = list ("Инженерное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/board/component_printer
	name = "Machine Design (Component Printer)"
	desc = "The circuit board for a component printer"
	id = "component_printer"
	build_path = /obj/item/circuitboard/machine/component_printer
	category = list("Различное оборудование")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE
