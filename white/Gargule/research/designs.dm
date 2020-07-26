/datum/design/cyberimp_surgical_alien
	name = "Alien Surgical Implant"
	desc = "A set of alien surgical tools hidden behind a concealed panel on the user's arm."
	id = "ci-aliensurgery"
	build_type = PROTOLATHE | MECHFAB
	materials = list (/datum/material/iron = 2500, /datum/material/glass = 1500, /datum/material/silver = 1500, /datum/material/plasma = 500, /datum/material/titanium = 1500)
	construction_time = 200
	build_path = /obj/item/organ/cyberimp/arm/surgery/alien
	category = list("Misc", "Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/circular_saw_folding
	name = "Folding Bone Saw"
	id = "circular_saw_folding"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/circular_saw/folding
	category = list("initial", "Medical")

/datum/design/optable_folding
	name = "Folding стол"
	id = "optable_folding"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 3000)
	build_path = /obj/item/optable
	category = list("initial", "Medical")

/datum/design/cyberimp_science_hud
	name = "Science HUD Implant"
	desc = "Cybernetic eye implants with an analyzer for scanning items and reagents."
	id = "ci-scihud"
	build_type = PROTOLATHE | MECHFAB
	construction_time = 50
	materials = list(/datum/material/iron = 600, /datum/material/glass = 600, /datum/material/silver = 500, /datum/material/gold = 500)
	build_path = /obj/item/organ/cyberimp/eyes/hud/science
	category = list("Misc", "Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/cyberimp_diagnostic_hud
	name = "Diagnostic HUD Implant"
	desc = "A heads-up display capable of analyzing the integrity and status of robotics and exosuits."
	id = "ci-diaghud"
	build_type = PROTOLATHE | MECHFAB
	construction_time = 50
	materials = list(/datum/material/iron = 600, /datum/material/glass = 600, /datum/material/silver = 500, /datum/material/gold = 500)
	build_path = /obj/item/organ/cyberimp/eyes/hud/diagnostic
	category = list("Misc", "Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL
