/*
Realistic chem by qwaszx000
*/

//TODO set correct valences and other data
#define LANTAN 19
#define ACTIN 20
#define Solid SOLID

#define NON_OXYDE 0
#define BASE_OXYDE 1
#define ACID_OXYDE 2

#define IS_ORGANIC 0
#define SIMPLE 0
#define BASE 1
#define ACID 2

#define COLOR_SILVER "#c0c0c0"
#define COLOR_NA "#e6e6e6"
#define COLOR_YELLOW "#b3b300"
#define COLOR_GRAY "#a6a6a6"
#define COLOR_COPPER "#B87333"
#define COLOR_RED "#cc0000"
#define COLOR_BLACK "#000000"
/datum/reagent/tru
	color = COLOR_SILVER
	taste_description = "true cheam"
	var/isMetal = true
	var/list/formula = list()
	var/valence = 1
	var/period= 1
	var/M = 1//gramm/mol
	var/group = 1
	var/oxyde_type = NON_OXYDE
	var/non_organic_type = SIMPLE
	var/toxic_rate = 0
	var/explosive_rate = 0
	var/isSimple = 1
	var/isOxydizer = 0
	var/ph = 6//neutral

/datum/reagent/tru/proc/create_data()
	/*
	data["isMetal"] 		  = isMetal
	data["formula"] 		  = formula
	data["valence"] 		  = valence
	data["period"]  		  = period
	data["M"] 				  = M
	data["group"] 			  = group
	data["color"]			  = color
	data["name"]			  = name
	data["id"]				  = id
	data["taste_description"] = taste_description
	*/
	data = list("isMetal" = isMetal, "formula" = formula, "valence" = valence, "period" = period, "M" = M, "group" = group,
			"color" = color, "name" = name, "id" = id, "taste_description" = taste_description, "ph" = ph,
			"isSimple" = isSimple, "oxyde_type" = oxyde_type, "non_organic_type" = non_organic_type, "toxic_rate" = toxic_rate,
			"explosive_rate" = explosive_rate)

/datum/reagent/tru/proc/update_params()
	isMetal 		  = data["isMetal"]
	formula 		  = data["formula"]
	valence 		  = data["valence"]
	period 			  = data["period"]
	M 				  = data["M"]
	group 			  = data["group"]
	color 			  = data["color"]
	name 			  = data["name"]
	id 				  = data["id"]
	taste_description = data["taste_description"]
	explosive_rate = data["explosive_rate"]
	isSimple = data["isSimple"]
	oxyde_type = data["oxyde_type"]
	non_organic_type = data["non_organic_type"]
	ph = data["ph"]
	toxic_rate = data["toxic_rate"]
/*
/datum/substance
	var/name = "Reagent"
	var/id = "reagent"
	var/description = ""
	var/specific_heat = SPECIFIC_HEAT_DEFAULT		//J/(K*mol)
	var/taste_description = "metaphorical salt"
	var/taste_mult = 1 //how this taste compares to others. Higher values means it is more noticable
	var/glass_name = "glass of ...what?" // use for specialty drinks.
	var/glass_desc = "You can't really tell what this is."
	var/glass_icon_state = null // Otherwise just sets the icon to a normal glass with the mixture of the reagents in the glass.
	var/shot_glass_icon_state = null
	var/datum/reagents/holder = null
	var/reagent_state = LIQUID
	var/list/data
	var/current_cycle = 0
	var/volume = 0									//pretend this is moles
	var/color = "#000000" // rgb: 0, 0, 0
	var/can_synth = TRUE // can this reagent be synthesized? (for example: odysseus syringe gun)
	var/metabolization_rate = REAGENTS_METABOLISM //how fast the reagent is metabolized by the mob
	var/overrides_metab = 0
	var/overdose_threshold = 0
	var/addiction_threshold = 0
	var/addiction_stage = 0
	var/overdosed = 0 // You fucked up and this is now triggering its overdose effects, purge that shit quick.
	var/self_consuming = FALSE
	var/formula = ""
	var/M = 1*/
//---------------------------------------------------------

//-----------Not metals-------------------
/datum/reagent/tru/Hidrogen
	color = COLOR_NA
	isMetal = false
	name = "Hidrogen"
	id = "Hidrogen"
	formula = list("H" = 1)
	group = 1
	valence = 1
	period = 1
	M = 1
	reagent_state = GAS
	data = list("id" = "Hidrogen")
//-----------

/datum/reagent/tru/Boron
	color = COLOR_BLACK
	isMetal = false
	name = "Boron"
	id = "Boron"
	formula = list("B" = 1)
	group = 13
	valence = 13
	period = 2
	M = 11
	reagent_state = Solid
	data = list("id" = "Boron")

//-----------------

/datum/reagent/tru/Carbon
	color = COLOR_BLACK
	isMetal = false
	name = "Carbon"
	id = "Carbon"
	formula = list("C" = 1)
	group = 14
	valence = 4
	period = 2
	M = 12
	isOxydizer = 0
	reagent_state = Solid
	data = list("isMetal" = false,
				"formula" = list("C" = 1),
				"valence" = 4,
				"period" = 2,
				"M" = 12,
				"group" = 14,
				"name" = "Carbon",
				"id" = "Carbon",
				"isOxydizer" = 0,
				"color" = "#000000")

/datum/reagent/tru/Sillicon
	color = COLOR_GRAY
	isMetal = false
	name = "Sillicon"
	id = "Sillicon"
	formula = list("Si" = 1)
	group = 14
	valence = 14
	period = 3
	M = 28
	reagent_state = Solid
	data = list("id" = "Sillicon")

/datum/reagent/tru/Germanium
	color = COLOR_GRAY
	isMetal = false
	name = "Germanium"
	id = "Germanium"
	formula = list("Ge" = 1)
	group = 14
	valence = 14
	period = 4
	M = 73
	reagent_state = Solid
	data = list("id" = "Germanium")

//-----------------

/datum/reagent/tru/Nitrogen
	color = COLOR_NA
	isMetal = false
	name = "Nitrogen"
	id = "Nitrogen"
	formula = list("N" = 1)
	group = 15
	valence = 15
	period = 2
	M = 14
	reagent_state = GAS
	data = list("id" = "Nitrogen")

/datum/reagent/tru/Phosphorus
	color = COLOR_NA
	isMetal = false
	name = "Phosphorus"
	id = "Phosphorus"
	formula = list("P" = 1)
	group = 15
	valence = 15
	period = 3
	M = 31
	reagent_state = Solid
	data = list("id" = "Phosphorus")

/datum/reagent/tru/Arsenic
	color = COLOR_SILVER
	isMetal = false
	name = "Arsenic"
	id = "Arsenic"
	formula = list("As" = 1)
	group = 15
	valence = 15
	period = 4
	M = 75
	reagent_state = Solid
	data = list("id" = "Arsenic")

/datum/reagent/tru/Antimony
	isMetal = false
	name = "Antimony"
	id = "Antimony"
	formula = list("Sb" = 1)
	group = 15
	valence = 15
	period = 5
	M = 122
	reagent_state = Solid
	data = list("id" = "Antimony")

//------------------

/datum/reagent/tru/Oxygen
	color = COLOR_NA
	isMetal = false
	name = "Oxygen"
	id = "Oxygen"
	formula = list("O" = 1)
	group = 16
	valence = 2
	period = 2
	M = 16
	reagent_state = GAS
	isOxydizer = 1
	data = list("isMetal" = false,
				"formula" = list("O" = 1),
				"valence" = 2,
				"period" = 2,
				"M" = 16,
				"group" = 16,
				"name" = "Oxygen",
				"id" = "Oxygen",
				"isOxydizer" = 1,
				"color" = "#000000")

/datum/reagent/tru/Sulfur
	color = COLOR_YELLOW
	isMetal = false
	name = "Sulfur"
	id = "Sulfur"
	formula = list("S" = 1)
	group = 16
	valence = 3
	period = 3
	M = 32
	reagent_state = SOLID
	data = list("id" = "Sulfur")

/datum/reagent/tru/Selenium
	isMetal = false
	name = "Selenium"
	id = "Selenium"
	formula = list("Se" = 1)
	group = 16
	valence = 16
	period = 4
	M = 79
	reagent_state = SOLID
	data = list("id" = "Selenium")

/datum/reagent/tru/Tellurium
	isMetal = false
	name = "Tellurium"
	id = "Tellurium"
	formula = list("Te" = 1)
	group = 16
	valence = 16
	period = 5
	M = 128
	reagent_state = SOLID
	data = list("id" = "Tellurium")

//-----------------

/datum/reagent/tru/Fluorine
	color = COLOR_NA
	isMetal = false
	name = "Fluorine"
	id = "Fluorine"
	formula = list("F" = 1)
	group = 17
	valence = 17
	period = 2
	M = 19
	reagent_state = GAS
	isOxydizer = 1
	data = list("id" = "Fluorine")

/datum/reagent/tru/Chlorine
	color = COLOR_YELLOW
	isMetal = false
	name = "Chlorine"
	id = "Chlorine"
	formula = list("Cl" = 1)
	group = 17
	valence = 17
	period = 2
	M = 36
	reagent_state = GAS
	isOxydizer = 1
	data = list("id" = "Chlorine")

/datum/reagent/tru/Bromine
	color = COLOR_RED
	isMetal = false
	name = "Bromine"
	id = "Bromine"
	formula = list("Br" = 1)
	group = 17
	valence = 17
	period = 4
	M = 80
	isOxydizer = 1
	reagent_state = LIQUID
	isOxydizer = 1
	data = list("id" = "Bromine")

/datum/reagent/tru/Iodine
	color = COLOR_GRAY
	isMetal = false
	name = "Iodine"
	id = "Iodine"
	formula = list("I" = 1)
	group = 17
	valence = 17
	period = 5
	M = 127
	reagent_state = SOLID
	data = list("id" = "Iodine")

/datum/reagent/tru/Astatine
	isMetal = false
	name = "Astatine"
	id = "Astatine"
	formula = list("At" = 1)
	group = 17
	valence = 17
	period = 6
	M = 210
	reagent_state = SOLID
	data = list("id" = "Astatine")

//----------------

/datum/reagent/tru/Helium
	color = COLOR_NA
	isMetal = false
	name = "Helium"
	id = "Helium"
	formula = list("He" = 1)
	group = 18
	valence = 18
	period = 1
	M = 4
	reagent_state = GAS
	data = list("id" = "Helium")

/datum/reagent/tru/Neon
	color = COLOR_NA
	isMetal = false
	name = "Neon"
	id = "Neon"
	formula = list("Ne" = 1)
	group = 18
	valence = 18
	period = 2
	M = 20
	reagent_state =  GAS
	data = list("id" = "Neon")

/datum/reagent/tru/Argon
	color = COLOR_NA
	isMetal = false
	name = "Argon"
	id = "Argon"
	formula = list("Ar" = 1)
	group = 18
	valence = 18
	period = 3
	M = 40
	reagent_state = GAS
	data = list("id" = "Argon")

/datum/reagent/tru/Krypton
	color = COLOR_NA
	isMetal = false
	name = "Krypton"
	id = "Krypton"
	formula = list("Kr" = 1)
	group = 18
	valence = 18
	period = 4
	M = 84
	reagent_state = GAS
	data = list("id" = "Krypton")

/datum/reagent/tru/Xenon
	color = COLOR_NA
	isMetal = false
	name = "Xenon"
	id = "Xenon"
	formula = list("Xe" = 1)
	group = 18
	valence = 18
	period = 5
	M = 131
	reagent_state = GAS
	data = list("id" = "Xenon")

/datum/reagent/tru/Radon
	color = COLOR_NA
	isMetal = false
	name = "Radon"
	id = "Radon"
	formula = list("Rn" = 1)
	group = 18
	valence = 18
	period = 6
	M = 222
	reagent_state = GAS
	data = list("id" = "Radon")

//----------------------------------------
//-----------Metals-----------------------

/datum/reagent/tru/Lithium
	isMetal = true
	name = "Lithium"
	id = "Lithium"
	formula = list("Li" = 1)
	group = 1
	valence = 1
	period = 2
	M = 7
	reagent_state = Solid
	data = list("id" = "Lithium")

/datum/reagent/tru/Natrium
	isMetal = true
	name = "Sodium"
	id = "Sodium"
	formula = list("Na" = 1)
	group = 1
	valence = 1
	period = 3
	M = 23
	reagent_state = Solid
	data = list("id" = "Natrium")

/datum/reagent/tru/Kalium
	isMetal = true
	name = "Potassium"
	id = "Potassium"
	formula = list("K" = 1)
	group = 1
	valence = 1
	period = 4
	M = 39
	reagent_state = Solid
	data = list("id" = "Kalium")

/datum/reagent/tru/Rubidium
	isMetal = true
	name = "Rubidium"
	id = "Rubidium"
	formula = list("Rb" = 1)
	group = 1
	valence = 1
	period = 5
	M = 85
	reagent_state = Solid
	data = list("id" = "Rubidium")

/datum/reagent/tru/Caesium
	isMetal = true
	name = "Caesium"
	id = "Caesium"
	formula = list("Cs" = 1)
	group = 1
	valence = 1
	period = 6
	M = 133
	reagent_state = Solid
	data = list("id" = "Caesium")

/datum/reagent/tru/Francium
	isMetal = true
	name = "Francium"
	id = "Francium"
	formula = list("Fr" = 1)
	group = 1
	valence = 1
	period = 7
	M = 223
	reagent_state = Solid
	data = list("id" = "Francium")
//-----------
/datum/reagent/tru/Beryllium
	isMetal = true
	name = "Beryllium"
	id = "Beryllium"
	formula = list("Be" = 1)
	group = 2
	valence = 2
	period = 2
	M = 9
	reagent_state = Solid
	data = list("id" = "Beryllium")

/datum/reagent/tru/Magnesium
	isMetal = true
	name = "Magnesium"
	id = "Magnesium"
	formula = list("Mg" = 1)
	group = 2
	valence = 2
	period = 3
	M = 24
	reagent_state = Solid
	data = list("id" = "Magnesium")

/datum/reagent/tru/Calcium
	isMetal = true
	name = "Calcium"
	id = "Calcium"
	formula = list("Ca" = 1)
	group = 2
	valence = 2
	period = 4
	M = 40
	reagent_state = Solid
	data = list("id" = "Calcium")

/datum/reagent/tru/Strontium
	isMetal = true
	name = "Strontium"
	id = "Strontium"
	formula = list("Sr" = 1)
	group = 2
	valence = 2
	period = 5
	M = 88
	reagent_state = Solid
	data = list("id" = "Strintium")

/datum/reagent/tru/Barium
	isMetal = true
	name = "Barium"
	id = "Barium"
	formula = list("Ba" = 1)
	group = 2
	valence = 2
	period = 6
	M = 137
	reagent_state = Solid
	data = list("id" = "Barium")

/datum/reagent/tru/Radium
	isMetal = true
	name = "Radium"
	id = "Radium"
	formula = list("Ra" = 1)
	group = 2
	valence = 2
	period = 7
	M = 226
	reagent_state = Solid
	data = list("id" = "Radium")

//----------

/datum/reagent/tru/Scandium
	isMetal = true
	name = "Scandium"
	id = "Scandium"
	formula = list("Sc" = 1)
	group = 3
	valence = 3
	period = 4
	M = 45
	reagent_state = Solid
	data = list("id" = "Scandium")

/datum/reagent/tru/Yttrium
	isMetal = true
	name = "Yttrium"
	id = "Yttrium"
	formula = list("Y" = 1)
	group = 3
	valence = 3
	period = 5
	M = 89
	reagent_state = Solid
	data = list("id" = "Yttrium")

/datum/reagent/tru/Lanthanum
	isMetal = true
	name = "Lanthanum"
	id = "Lanthanum"
	formula = list("La" = 1)
	group = 3
	valence = 3
	period = 6
	M = 139
	reagent_state = Solid
	data = list("id" = "Lanthanum")

/datum/reagent/tru/Actinium
	isMetal = true
	name = "Actinium"
	id = "Actinium"
	formula = list("Ac" = 1)
	group = 3
	valence = 3
	period = 7
	M = 227
	reagent_state = Solid
	data = list("id" = "Actinum")

//-------

/datum/reagent/tru/Titanium
	isMetal = true
	name = "Titanium"
	id = "Titanium"
	formula = list("Ti" = 1)
	group = 4
	valence = 4
	period = 4
	M = 48
	reagent_state = Solid
	data = list("id" = "Titanium")

/datum/reagent/tru/Zirconium
	isMetal = true
	name = "Zirconium"
	id = "Zirconium"
	formula = list("Zr" = 1)
	group = 4
	valence = 4
	period = 5
	M = 91
	reagent_state = Solid
	data = list("id" = "Zirconium")

/datum/reagent/tru/Hafnium
	isMetal = true
	name = "Hafnium"
	id = "Hafnium"
	formula = list("Hf" = 1)
	group = 4
	valence = 4
	period = 6
	M = 178
	reagent_state = Solid
	data = list("id" = "Hafnium")

/datum/reagent/tru/Rutherfordium
	isMetal = true
	name = "Rutherfordium"
	id = "Rutherfordium"
	formula = list("Rf" = 1)
	group = 4
	valence = 4
	period = 7
	M = 267
	reagent_state = Solid
	data = list("id" = "Rutherfordium")

//--------

/datum/reagent/tru/Vanadium
	isMetal = true
	name = "Vanadium"
	id = "Vanadium"
	formula = list("V" = 1)
	group = 5
	valence = 5
	period = 4
	M = 51
	reagent_state = Solid
	data = list("id" = "Vanadium")

/datum/reagent/tru/Niobium
	isMetal = true
	name = "Niobium"
	id = "Niobium"
	formula = list("Nb" = 1)
	group = 5
	valence = 5
	period = 5
	M = 93
	reagent_state = Solid
	data = list("id" = "Niobium")

/datum/reagent/tru/Tantalum
	isMetal = true
	name = "Tantalum"
	id = "Tantalum"
	formula = list("Ta" = 1)
	group = 5
	valence = 5
	period = 6
	M = 181
	reagent_state = Solid
	data = list("id" = "Tantalum")

/datum/reagent/tru/Dubnium
	isMetal = true
	name = "Dubnium"
	id = "Dubnium"
	formula = list("Db" = 1)
	group = 5
	valence = 5
	period = 7
	M = 268
	reagent_state = Solid
	data = list("id" = "Dubnium")

/datum/reagent/tru/Chromium
	isMetal = true
	name = "Chromium"
	id = "Chromium"
	formula = list("Cr" = 1)
	group = 6
	valence = 6
	period = 4
	M = 52
	reagent_state = Solid
	data = list("id" = "Chromium")

/datum/reagent/tru/Molybdenum
	isMetal = true
	name = "Molybdenum"
	id = "Molybdenum"
	formula = list("Mo" = 1)
	group = 6
	valence = 6
	period = 5
	M = 96
	reagent_state = Solid
	data = list("id" = "Molybdenum")

/datum/reagent/tru/Tungsten
	isMetal = true
	name = "Tungsten"
	id = "Tungsten"
	formula = list("W" = 1)
	group = 6
	valence = 6
	period = 6
	M = 184
	reagent_state = Solid
	data = list("id" = "Tungsten")

/datum/reagent/tru/Seaborgium
	isMetal = true
	name = "Seaborgium"
	id = "Seaborgium"
	formula = list("Sg" = 1)
	group = 6
	valence = 6
	period = 7
	M = 269
	reagent_state = Solid
	data = list("id" = "Seaborgium")

/datum/reagent/tru/Manganese
	isMetal = true
	name = "Manganese"
	id = "Manganese"
	formula = list("Mn" = 1)
	group = 7
	valence = 7
	period = 4
	M = 55
	reagent_state = Solid
	data = list("id" = "Manganese")

/datum/reagent/tru/Technetium
	isMetal = true
	name = "Technetium"
	id = "Technetium"
	formula = list("Tc" = 1)
	group = 7
	valence = 7
	period = 5
	M = 98
	reagent_state = Solid
	data = list("id" = "Technetium")

/datum/reagent/tru/Rhenium
	isMetal = true
	name = "Rhenium"
	id = "Rhenium"
	formula = list("Re" = 1)
	group = 7
	valence = 7
	period = 6
	M = 186
	reagent_state = Solid
	data = list("id" = "Rhenium")

/datum/reagent/tru/Bohrium
	isMetal = true
	name = "Bohrium"
	id = "Bohrium"
	formula = list("Bh" = 1)
	group = 7
	valence = 7
	period = 7
	M = 270
	reagent_state = Solid
	data = list("id" = "Bohrium")

/datum/reagent/tru/Iron
	isMetal = true
	name = "Iron"
	id = "Iron"
	formula = list("Fe" = 1)
	group = 8
	valence = 8
	period = 4
	M = 56
	reagent_state = Solid
	data = list("id" = "Iron")

/datum/reagent/tru/Ruthenium
	isMetal = true
	name = "Ruthenium"
	id = "Ruthenium"
	formula = list("Ru" = 1)
	group = 8
	valence = 8
	period = 5
	M = 101
	reagent_state = Solid
	data = list("id" = "Ruthenium")

/datum/reagent/tru/Osmium
	isMetal = true
	name = "Osmium"
	id = "Osmium"
	formula = list("Os" = 1)
	group = 8
	valence = 8
	period = 6
	M = 190
	reagent_state = Solid
	data = list("id" = "Osmium")

/datum/reagent/tru/Hassium
	isMetal = true
	name = "Hassium"
	id = "Hassium"
	formula = list("Hs" = 1)
	group = 8
	valence = 8
	period = 7
	M = 270
	reagent_state = Solid
	data = list("id" = "Hassium")

/datum/reagent/tru/Cobalt
	isMetal = true
	name = "Cobalt"
	id = "Cobalt"
	formula = list("Co" = 1)
	group = 9
	valence = 2
	period = 4
	M = 59
	reagent_state = Solid
	data = list("id" = "Cobalt")

/datum/reagent/tru/Rhodium
	isMetal = true
	name = "Rhodium"
	id = "Rhodium"
	formula = list("Rh" = 1)
	group = 9
	valence = 9
	period = 5
	M = 103
	reagent_state = Solid
	data = list("id" = "Rhodium")

/datum/reagent/tru/Iridium
	isMetal = true
	name = "Iridium"
	id = "Iridium"
	formula = list("Ir" = 1)
	group = 9
	valence = 9
	period = 6
	M = 192
	reagent_state = Solid
	data = list("id" = "Iridium")

/datum/reagent/tru/Meitnerium
	isMetal = true
	name = "Meitnerium"
	id = "Meitnerium"
	formula = list("Mt" = 1)
	group = 9
	valence = 9
	period = 7
	M = 278
	reagent_state = Solid
	data = list("id" = "Meitnerium")

//---------------

/datum/reagent/tru/Nickel
	isMetal = true
	name = "Nickel"
	id = "Nickel"
	formula = list("Ni" = 1)
	group = 10
	valence = 10
	period = 4
	M = 59
	reagent_state = Solid
	data = list("id" = "Nikel")

/datum/reagent/tru/Palladium
	isMetal = true
	name = "Palladium"
	id = "Palladium"
	formula = list("Pd" = 1)
	group = 10
	valence = 10
	period = 5
	M = 106
	reagent_state = Solid
	data = list("id" = "Palladium")

/datum/reagent/tru/Platinum
	isMetal = true
	name = "Platinum"
	id = "Platinum"
	formula = list("Pt" = 1)
	group = 10
	valence = 10
	period = 6
	M = 195
	reagent_state = Solid
	data = list("id" = "Platinum")

/datum/reagent/tru/Darmstadtium
	isMetal = true
	name = "Darmstadtium"
	id = "Darmstadtium"
	formula = list("Ds" = 1)
	group = 10
	valence = 10
	period = 7
	M = 281
	reagent_state = Solid
	data = list("id" = "Darmstadtium")

/datum/reagent/tru/Copper
	isMetal = true
	name = "Copper"
	id = "Copper"
	formula = list("Cu" = 1)
	group = 11
	valence = 11
	period = 4
	M = 64
	reagent_state = Solid
	data = list("id" = "Copper")

/datum/reagent/tru/Silver
	isMetal = true
	name = "Silver"
	id = "Silver"
	formula = list("Ag" = 1)
	group = 11
	valence = 11
	period = 5
	M = 108
	reagent_state = Solid
	data = list("id" = "Silver")

/datum/reagent/tru/Gold
	color = "#FFD700"//gold
	isMetal = true
	name = "Gold"
	id = "Gold"
	formula = list("Au" = 1)
	group = 11
	valence = 11
	period = 6
	M = 197
	reagent_state = Solid
	data = list("id" = "Gold")

/datum/reagent/tru/Roentgenium
	isMetal = true
	name = "Roentgenium"
	id = "Roentgenium"
	formula = list("Rg" = 1)
	group = 11
	valence = 11
	period = 7
	M = 282
	reagent_state = Solid
	data = list("id" = "Roentgenium")

//----------------

/datum/reagent/tru/Zinc
	isMetal = true
	name = "Zinc"
	id = "Zinc"
	formula = list("Zn" = 1)
	group = 12
	valence = 12
	period = 4
	M = 65
	reagent_state = Solid
	data = list("id" = "Zinc")

/datum/reagent/tru/Cadmium
	isMetal = true
	name = "Cadmium"
	id = "Cadmium"
	formula = list("Cd" = 1)
	group = 12
	valence = 12
	period = 5
	M = 112
	reagent_state = Solid
	data = list("id" = "Cadmium")

/datum/reagent/tru/Mercury
	isMetal = true
	name = "Mercury"
	id = "Mercury"
	formula = list("Hg" = 1)
	group = 12
	valence = 12
	period = 6
	M = 201
	reagent_state = Solid
	data = list("id" = "Mercury")

/datum/reagent/tru/Copernicium
	isMetal = true
	name = "Copernicium"
	id = "Copernicium"
	formula = list("Cn" = 1)
	group = 12
	valence = 12
	period = 7
	M = 285
	reagent_state = Solid
	data = list("id" = "Copernicium")

//---------

/datum/reagent/tru/Aluminium
	isMetal = true
	name = "Aluminium"
	id = "Aluminium"
	formula = list("Al" = 1)
	group = 13
	valence = 13
	period = 3
	M = 27
	reagent_state = Solid
	data = list("id" = "Aluminium")

/datum/reagent/tru/Gallium
	isMetal = true
	name = "Gallium"
	id = "Gallium"
	formula = list("Ga" = 1)
	group = 13
	valence = 13
	period = 4
	M = 70
	reagent_state = Solid
	data = list("id" = "Gallium")

/datum/reagent/tru/Indium
	isMetal = true
	name = "Indium"
	id = "Indium"
	formula = list("In" = 1)
	group = 13
	valence = 13
	period = 5
	M = 115
	reagent_state = Solid
	data = list("id" = "Indium")

/datum/reagent/tru/Thallium
	isMetal = true
	name = "Thallium"
	id = "Thallium"
	formula = list("Tl" = 1)
	group = 13
	valence = 13
	period = 6
	M = 204
	reagent_state = Solid
	data = list("id" = "Thallium")

/datum/reagent/tru/Nihonium
	isMetal = true
	name = "Nihonium"
	id = "Nihonium"
	formula = list("Nh" = 1)
	group = 13
	valence = 13
	period = 7
	M = 286
	reagent_state = Solid
	data = list("id" = "Nihonium")

//------------

/datum/reagent/tru/Tin
	isMetal = true
	name = "Tin"
	id = "Tin"
	formula = list("Sn" = 1)
	group = 14
	valence = 14
	period = 5
	M = 119
	reagent_state = Solid
	data = list("id" = "Tin")

/datum/reagent/tru/Lead
	color = COLOR_GRAY
	isMetal = true
	name = "Lead"
	id = "Lead"
	formula = list("Pb" = 1)
	group = 14
	valence = 14
	period = 6
	M = 207
	reagent_state = Solid
	data = list("id" = "Lead")

//------------

/datum/reagent/tru/Bismuth
	color = COLOR_GRAY
	isMetal = true
	name = "Bismuth"
	id = "Bismuth"
	formula = list("Bi" = 1)
	group = 15
	valence = 15
	period = 6
	M = 209
	reagent_state = Solid
	data = list("id" = "Bismuth")

//----------

/datum/reagent/tru/Polonium
	isMetal = true
	name = "Polonium"
	id = "Polonium"
	formula = list("Po" = 1)
	group = 16
	valence = 16
	period = 6
	M = 209
	reagent_state = Solid
	data = list("id" = "Polonium")

//------------------------------------------------------
//--------------Lanthanums------------------------------
/datum/reagent/tru/Cerium
	isMetal = true
	name = "Cerium"
	id = "Cerium"
	formula = list("Ce" = 1)
	group = LANTAN
	valence = LANTAN
	period = 6
	M = 140
	reagent_state = Solid
	data = list("id" = "Cerium")

/datum/reagent/tru/Praseodymium
	isMetal = true
	name = "Praseodymium"
	id = "Praseodymium"
	formula = list("Pr" = 1)
	group = LANTAN
	valence = LANTAN
	period = 6
	M = 141
	reagent_state = Solid
	data = list("id" = "Praseodymium")

/datum/reagent/tru/Neodymium
	isMetal = true
	name = "Neodymium"
	id = "Neodymium"
	formula = list("Nd" = 1)
	group = LANTAN
	valence = LANTAN
	period = 6
	M = 144
	reagent_state = Solid
	data = list("id" = "Neodimium")

/datum/reagent/tru/Promethium
	isMetal = true
	name = "Promethium"
	id = "Promethium"
	formula = list("Pm" = 1)
	group = LANTAN
	valence = LANTAN
	period = 6
	M = 145
	reagent_state = Solid
	data = list("id" = "Promethium")

/datum/reagent/tru/Samarium
	isMetal = true
	name = "Samarium"
	id = "Samarium"
	formula = list("Sm" = 1)
	group = LANTAN
	valence = LANTAN
	period = 6
	M = 150
	reagent_state = Solid
	data = list("id" = "Samarium")

/datum/reagent/tru/Europium
	isMetal = true
	name = "Europium"
	id = "Europium"
	formula = list("Eu" = 1)
	group = LANTAN
	valence = LANTAN
	period = 6
	M = 152
	reagent_state = Solid
	data = list("id" = "Europium")

/datum/reagent/tru/Gadolinium
	isMetal = true
	name = "Gadolinium"
	id = "Gadolinium"
	formula = list("Gd" = 1)
	group = LANTAN
	valence = LANTAN
	period = 6
	M = 157
	reagent_state = Solid
	data = list("id" = "Gadolinium")

/datum/reagent/tru/Terbium
	isMetal = true
	name = "Terbium"
	id = "Terbium"
	formula = list("Tb" = 1)
	group = LANTAN
	valence = LANTAN
	period = 6
	M = 159
	reagent_state = Solid
	data = list("id" = "Terbium")

/datum/reagent/tru/Dysposium
	isMetal = true
	name = "Dysposium"
	id = "Dysposium"
	formula = list("Dy" = 1)
	group = LANTAN
	valence = LANTAN
	period = 6
	M = 163
	reagent_state = Solid
	data = list("id" = "Dysposium")

/datum/reagent/tru/Holmium
	isMetal = true
	name = "Holmium"
	id = "Holmium"
	formula = list("Ho" = 1)
	group = LANTAN
	valence = LANTAN
	period = 6
	M = 165
	reagent_state = Solid
	data = list("id" = "Holmium")

/datum/reagent/tru/Erbium
	isMetal = true
	name = "Erbium"
	id = "Erbium"
	formula = list("Er" = 1)
	group = LANTAN
	valence = LANTAN
	period = 6
	M = 167
	reagent_state = Solid
	data = list("id" = "Erbium")

/datum/reagent/tru/Thulium
	isMetal = true
	name = "Thulium"
	id = "Thulium"
	formula = list("Tm" = 1)
	group = LANTAN
	valence = LANTAN
	period = 6
	M = 169
	reagent_state = Solid
	data = list("id" = "Thulium")

/datum/reagent/tru/Ytterbium
	isMetal = true
	name = "Ytterbium"
	id = "Ytterbium"
	formula = list("Yb" = 1)
	group = LANTAN
	valence = LANTAN
	period = 6
	M = 173
	reagent_state = Solid
	data = list("id" = "Ytterbium")

/datum/reagent/tru/Lutetium
	isMetal = true
	name = "Lutetium"
	id = "Lutetium"
	formula = list("Lu" = 1)
	group = LANTAN
	valence = LANTAN
	period = 6
	M = 175
	reagent_state = Solid
	data = list("id" = "Lutetium")

//------------ACTINIUMS-------------

/datum/reagent/tru/Thorium
	isMetal = true
	name = "Thorium"
	id = "Thorium"
	formula = list("Th" = 1)
	group = ACTIN
	valence = ACTIN
	period = 7
	M = 232
	reagent_state = Solid
	data = list("id" = "Thorium")

/datum/reagent/tru/Protactinium
	isMetal = true
	name = "Protactinium"
	id = "Protactinium"
	formula = list("Pa" = 1)
	group = ACTIN
	valence = ACTIN
	period = 7
	M = 231
	reagent_state = Solid
	data = list("id" = "Protactinium")

/datum/reagent/tru/Uranium
	isMetal = true
	name = "Uranium"
	id = "Uranium"
	formula = list("U" = 1)
	group = ACTIN
	valence = ACTIN
	period = 7
	M = 238
	reagent_state = Solid
	data = list("id" = "Uranium")

/datum/reagent/tru/Neptunium
	isMetal = true
	name = "Neptunium"
	id = "Neptunium"
	formula = list("Np" = 1)
	group = ACTIN
	valence = ACTIN
	period = 7
	M = 237
	reagent_state = Solid
	data = list("id" = "Neptunium")

/datum/reagent/tru/Plutonium
	isMetal = true
	name = "Plutonium"
	id = "Plutonium"
	formula = list("Pu" = 1)
	group = ACTIN
	valence = ACTIN
	period = 7
	M = 244
	reagent_state = Solid
	data = list("id" = "Plutonium")

/datum/reagent/tru/Americium
	isMetal = true
	name = "Americium"
	id = "Americium"
	formula = list("Am" = 1)
	group = ACTIN
	valence = ACTIN
	period = 7
	M = 243
	reagent_state = Solid
	data = list("id" = "Americium")

/datum/reagent/tru/Curium
	isMetal = true
	name = "Curium"
	id = "Curium"
	formula = list("Cm" = 1)
	group = ACTIN
	valence = ACTIN
	period = 7
	M = 247
	reagent_state = Solid
	data = list("id" = "Curium")

/datum/reagent/tru/Berkelium
	isMetal = true
	name = "Berkelium"
	id = "Berkelium"
	formula = list("Bk" = 1)
	group = ACTIN
	valence = ACTIN
	period = 7
	M = 247
	reagent_state = Solid
	data = list("id" = "Berkelium")

/datum/reagent/tru/Californium
	isMetal = true
	name = "Californium"
	id = "Californium"
	formula = list("Cf" = 1)
	group = ACTIN
	valence = ACTIN
	period = 7
	M = 251
	reagent_state = Solid
	data = list("id" = "Californium")

/datum/reagent/tru/Einstenium
	isMetal = true
	name = "Einstenium"
	id = "Einstenium"
	formula = list("Es" = 1)
	group = ACTIN
	valence = ACTIN
	period = 7
	M = 252
	reagent_state = Solid
	data = list("id" = "Einstenium")

/datum/reagent/tru/Fermium
	isMetal = true
	name = "Fermium"
	id = "Fermium"
	formula = list("Fm" = 1)
	group = ACTIN
	valence = ACTIN
	period = 7
	M = 257
	reagent_state = Solid
	data = list("id" = "Fermium")

/datum/reagent/tru/Mendelevium
	isMetal = true
	name = "Mendelevium"
	id = "Mendelevium"
	formula = list("Md" = 1)
	group = ACTIN
	valence = ACTIN
	period = 7
	M = 258
	reagent_state = SOLID
	data = list("id" = "Mendelevium")

/datum/reagent/tru/Nobelium
	isMetal = true
	name = "Nobelium"
	id = "Nobelium"
	formula = list("No" = 1)
	group = ACTIN
	valence = ACTIN
	period = 7
	M = 259
	reagent_state = SOLID
	data = list("id" = "Nobelium")

/datum/reagent/tru/Lawrencium
	isMetal = true
	name = "Lawrencium"
	id = "Lawrencium"
	formula = list("Lr" = 1)
	group = ACTIN
	valence = ACTIN
	period = 7
	M = 266
	reagent_state = SOLID
	data = list("id" = "Lawrencium")

//---------utils----------------
//returns object class
//use new(getElemByFormula(f))
/proc/getElemByFormula(var/list/f)
	var/list/rl = subtypesof(/datum/reagent/tru) - /datum/reagent/tru
	for(var/r in rl)
		var/datum/reagent/tru/R = new(r)
		if(AsocListCmp(R.formula, f) == 0)
			return r
		del(R)

/proc/getIdByFormula(var/list/f)
	var/list/rl = subtypesof(/datum/reagent/tru) - /datum/reagent/tru
	for(var/r in rl)
		var/datum/reagent/tru/R = new r
		if(!AsocListCmp(R.formula, f))
			//to_chat(usr, "[R.id]")
			return R.id
		del(R)

/proc/getIdByFormulaInaccurate(var/list/f)
	var/list/rl = subtypesof(/datum/reagent/tru) - /datum/reagent/tru
	for(var/r in rl)
		var/datum/reagent/tru/R = new r
		if(!AsocListCmpInaccurate(R.formula, f))
			//to_chat(usr, "[R.id]")
			return R.id
		del(R)

//returns list of string.
//string is name(/datum/reagent/tru/*)
//to work with elem do new(name)
/proc/getMetalElements()
	var/list/rl = subtypesof(/datum/reagent/tru) - /datum/reagent/tru
	for(var/r in rl)
		var/datum/reagent/tru/R = new r
		R.create_data()
		if(R.isMetal)
			GLOB.metals += r
		del(R)
	return

//returns list of string.
//string is name(/datum/reagent/tru/*)
//to work with elem do new(name)
/proc/getNonMetalElements()
	var/list/rl = subtypesof(/datum/reagent/tru)
	for(var/r in rl)
		var/datum/reagent/tru/R = new(r)
		R.create_data()
		if(!R.isMetal)
			GLOB.nonMetals += r
		del(R)
	return

//-----------------------------------------------
GLOBAL_LIST_EMPTY(metals) 	 = getMetalElements()
GLOBAL_LIST_EMPTY(nonMetals) = getNonMetalElements()
//-------------conteiners-----------------
/obj/item/reagent_containers/glass/bottle/carbon_tru
	name = "Carbon bottle"
	list_reagents = list("Carbon" = 30)

/obj/item/reagent_containers/glass/bottle/oxygen_tru
	name = "Oxygen bottle"
	list_reagents = list("Oxygen" = 30)

/obj/item/reagent_containers/glass/bottle/hidrogen_tru
	name = "Hidrogen bottle"
	list_reagents = list("Hidrogen" = 30)

/obj/item/reagent_containers/glass/bottle/boron_tru
	name = "Boron bottle"
	list_reagents = list("Boron" = 30)

/obj/item/reagent_containers/glass/bottle/sillicon_tru
	name = "Sillicon bottle"
	list_reagents = list("Sillicon" = 30)

/obj/item/reagent_containers/glass/bottle/helium_tru
	name = "Helium bottle"
	list_reagents = list("Helium" = 30)

/obj/item/reagent_containers/glass/bottle/lithium_tru
	name = "Lithium bottle"
	list_reagents = list("Lithium" = 30)

/obj/item/reagent_containers/glass/bottle/carbon_tru
	name = "Carbon bottle"
	list_reagents = list("Carbon" = 30)

/obj/item/reagent_containers/glass/bottle/beryllium_tru
	name = "Beryllium bottle"
	list_reagents = list("Beryllium" = 30)

/obj/item/reagent_containers/glass/bottle/nitrogen_tru
	name = "Nitrogen bottle"
	list_reagents = list("Nitrogen" = 30)

/obj/item/reagent_containers/glass/bottle/fluorine_tru
	name = "Fluorine bottle"
	list_reagents = list("Fluorine" = 30)

/obj/item/reagent_containers/glass/bottle/neon_tru
	name = "Neon bottle"
	list_reagents = list("Neon" = 30)

/obj/item/reagent_containers/glass/bottle/potassium_tru
	name = "Potassium bottle"
	list_reagents = list("Potassium" = 30)

/obj/item/reagent_containers/glass/bottle/sodium_tru
	name = "Sodium bottle"
	list_reagents = list("Sodium" = 30)

/obj/item/reagent_containers/glass/bottle/magnesium_tru
	name = "Magnesium bottle"
	list_reagents = list("Magnesium" = 30)

/obj/item/reagent_containers/glass/bottle/aluminium_tru
	name = "Aluminium bottle"
	list_reagents = list("Aluminium" = 30)

/obj/item/reagent_containers/glass/bottle/phosphorus_tru
	name = "Phosphorus bottle"
	list_reagents = list("Phosphorus" = 30)

/obj/item/reagent_containers/glass/bottle/sulfur_tru
	name = "Sulfur bottle"
	list_reagents = list("Sulfur" = 30)

/obj/item/reagent_containers/glass/bottle/chlorine_tru
	name = "Chlorine bottle"
	list_reagents = list("Chlorine" = 30)

/obj/item/reagent_containers/glass/bottle/argon_tru
	name = "Argon bottle"
	list_reagents = list("Argon" = 30)

/obj/item/reagent_containers/glass/bottle/calcium_tru
	name = "Calcium bottle"
	list_reagents = list("Calcium" = 30)

/obj/item/reagent_containers/glass/bottle/scandium_tru
	name = "Scandium bottle"
	list_reagents = list("Scandium" = 30)

/obj/item/reagent_containers/glass/bottle/titanium_tru
	name = "Titanium bottle"
	list_reagents = list("Titanium" = 30)

/obj/item/reagent_containers/glass/bottle/vanadium_tru
	name = "Vanadium bottle"
	list_reagents = list("Vanadium" = 30)

/obj/item/reagent_containers/glass/bottle/chromium_tru
	name = "Chromium bottle"
	list_reagents = list("Chromium" = 30)

/obj/item/reagent_containers/glass/bottle/manganese_tru
	name = "Manganese bottle"
	list_reagents = list("Manganese" = 30)

/obj/item/reagent_containers/glass/bottle/iron_tru
	name = "Iron bottle"
	list_reagents = list("Iron" = 30)

/obj/item/reagent_containers/glass/bottle/cobalt_tru
	name = "Cobalt bottle"
	list_reagents = list("Cobalt" = 30)

/obj/item/reagent_containers/glass/bottle/nickel_tru
	name = "Nickel bottle"
	list_reagents = list("Nickel" = 30)

/obj/item/reagent_containers/glass/bottle/copper_tru
	name = "Copper bottle"
	list_reagents = list("Copper" = 30)

/obj/item/reagent_containers/glass/bottle/zinc_tru
	name = "Zinc bottle"
	list_reagents = list("Zinc" = 30)

/obj/item/reagent_containers/glass/bottle/gallium_tru
	name = "Gallium bottle"
	list_reagents = list("Gallium" = 30)

/obj/item/reagent_containers/glass/bottle/germanium_tru
	name = "Germanium bottle"
	list_reagents = list("Germanium" = 30)

/obj/item/reagent_containers/glass/bottle/arsenic_tru
	name = "Arsenic bottle"
	list_reagents = list("Arsenic" = 30)

/obj/item/reagent_containers/glass/bottle/selenium_tru
	name = "Selenium bottle"
	list_reagents = list("Selenium" = 30)

/obj/item/reagent_containers/glass/bottle/bromine_tru
	name = "Bromine bottle"
	list_reagents = list("Bromine" = 30)

/obj/item/reagent_containers/glass/bottle/krypton_tru
	name = "Krypton bottle"
	list_reagents = list("Krypton" = 30)

/obj/item/reagent_containers/glass/bottle/rubidium_tru
	name = "Rubidium bottle"
	list_reagents = list("Rubidium" = 30)

/obj/item/reagent_containers/glass/bottle/strontium_tru
	name = "Strontium bottle"
	list_reagents = list("Strontium" = 30)

/obj/item/reagent_containers/glass/bottle/yttrium_tru
	name = "Yttrium bottle"
	list_reagents = list("Yttrium" = 30)

/obj/item/reagent_containers/glass/bottle/zirconium_tru
	name = "Zirconium bottle"
	list_reagents = list("Zirconium" = 30)

/obj/item/reagent_containers/glass/bottle/niobium_tru
	name = "Niobium bottle"
	list_reagents = list("Niobium" = 30)

/obj/item/reagent_containers/glass/bottle/molybdenum_tru
	name = "Molybdenum bottle"
	list_reagents = list("Molybdenum" = 30)

/obj/item/reagent_containers/glass/bottle/technetium_tru
	name = "Technetium bottle"
	list_reagents = list("Technetium" = 30)

/obj/item/reagent_containers/glass/bottle/ruthenium_tru
	name = "Ruthenium bottle"
	list_reagents = list("Ruthenium" = 30)

/obj/item/reagent_containers/glass/bottle/rhodium_tru
	name = "Rhodium bottle"
	list_reagents = list("Rhodium" = 30)

/obj/item/reagent_containers/glass/bottle/palladium_tru
	name = "Palladium bottle"
	list_reagents = list("Palladium" = 30)

/obj/item/reagent_containers/glass/bottle/silver_tru
	name = "Silver bottle"
	list_reagents = list("Silver" = 30)

/obj/item/reagent_containers/glass/bottle/cadmium_tru
	name = "Cadmium bottle"
	list_reagents = list("Cadmium" = 30)

/obj/item/reagent_containers/glass/bottle/indium_tru
	name = "Indium bottle"
	list_reagents = list("Indium" = 30)

/obj/item/reagent_containers/glass/bottle/tin_tru
	name = "Tin bottle"
	list_reagents = list("Tin" = 30)

/obj/item/reagent_containers/glass/bottle/antimony_tru
	name = "Antimony bottle"
	list_reagents = list("Antimony" = 30)

/obj/item/reagent_containers/glass/bottle/tellurium_tru
	name = "Tellurium bottle"
	list_reagents = list("Tellurium" = 30)

/obj/item/reagent_containers/glass/bottle/iodine_tru
	name = "Iodine bottle"
	list_reagents = list("Iodine" = 30)

/obj/item/reagent_containers/glass/bottle/xenon_tru
	name = "Xenon bottle"
	list_reagents = list("Xenon" = 30)

/obj/item/reagent_containers/glass/bottle/caesium_tru
	name = "Caesium bottle"
	list_reagents = list("Caesium" = 30)

/obj/item/reagent_containers/glass/bottle/barium_tru
	name = "Barium bottle"
	list_reagents = list("Barium" = 30)

/obj/item/reagent_containers/glass/bottle/lanthanum_tru
	name = "Lanthanum bottle"
	list_reagents = list("Lanthanum" = 30)

/obj/item/reagent_containers/glass/bottle/cerium_tru
	name = "Cerium bottle"
	list_reagents = list("Cerium" = 30)

/obj/item/reagent_containers/glass/bottle/praseodymium_tru
	name = "Praseodymium bottle"
	list_reagents = list("Praseodymium" = 30)

/obj/item/reagent_containers/glass/bottle/neodymium_tru
	name = "Neodymium bottle"
	list_reagents = list("Neodymium" = 30)

/obj/item/reagent_containers/glass/bottle/promethium_tru
	name = "Promethium bottle"
	list_reagents = list("Promethium" = 30)

/obj/item/reagent_containers/glass/bottle/samarium_tru
	name = "Samarium bottle"
	list_reagents = list("Samarium" = 30)

/obj/item/reagent_containers/glass/bottle/europium_tru
	name = "Europium bottle"
	list_reagents = list("Europium" = 30)

/obj/item/reagent_containers/glass/bottle/gadolinium_tru
	name = "Gadolinium bottle"
	list_reagents = list("Gadolinium" = 30)

/obj/item/reagent_containers/glass/bottle/terbium_tru
	name = "Terbium bottle"
	list_reagents = list("Terbium" = 30)

/obj/item/reagent_containers/glass/bottle/dysprosium_tru
	name = "Dysprosium bottle"
	list_reagents = list("Dysprosium" = 30)

/obj/item/reagent_containers/glass/bottle/holmium_tru
	name = "Holmium bottle"
	list_reagents = list("Holmium" = 30)

/obj/item/reagent_containers/glass/bottle/erbium_tru
	name = "Erbium bottle"
	list_reagents = list("Erbium" = 30)

/obj/item/reagent_containers/glass/bottle/thulium_tru
	name = "Thulium bottle"
	list_reagents = list("Thulium" = 30)

/obj/item/reagent_containers/glass/bottle/ytterbium_tru
	name = "Ytterbium bottle"
	list_reagents = list("Ytterbium" = 30)

/obj/item/reagent_containers/glass/bottle/lutetium_tru
	name = "Lutetium bottle"
	list_reagents = list("Lutetium" = 30)

/obj/item/reagent_containers/glass/bottle/hafnium_tru
	name = "Hafnium bottle"
	list_reagents = list("Hafnium" = 30)

/obj/item/reagent_containers/glass/bottle/tantalum_tru
	name = "Tantalum bottle"
	list_reagents = list("Tantalum" = 30)

/obj/item/reagent_containers/glass/bottle/tungsten_tru
	name = "Tungsten bottle"
	list_reagents = list("Tungsten" = 30)

/obj/item/reagent_containers/glass/bottle/rhenium_tru
	name = "Rhenium bottle"
	list_reagents = list("Rhenium" = 30)

/obj/item/reagent_containers/glass/bottle/osmium_tru
	name = "Osmium bottle"
	list_reagents = list("Osmium" = 30)

/obj/item/reagent_containers/glass/bottle/iridium_tru
	name = "Iridium bottle"
	list_reagents = list("Iridium" = 30)

/obj/item/reagent_containers/glass/bottle/platinum_tru
	name = "Platinum bottle"
	list_reagents = list("Platinum" = 30)

/obj/item/reagent_containers/glass/bottle/gold_tru
	name = "Gold bottle"
	list_reagents = list("Gold" = 30)

/obj/item/reagent_containers/glass/bottle/mercury_tru
	name = "Mercury bottle"
	list_reagents = list("Mercury" = 30)

/obj/item/reagent_containers/glass/bottle/thallium_tru
	name = "Thallium bottle"
	list_reagents = list("Thallium" = 30)

/obj/item/reagent_containers/glass/bottle/lead_tru
	name = "Lead bottle"
	list_reagents = list("Lead" = 30)

/obj/item/reagent_containers/glass/bottle/bismuth_tru
	name = "Bismuth bottle"
	list_reagents = list("Bismuth" = 30)

/obj/item/reagent_containers/glass/bottle/polonium_tru
	name = "Polonium bottle"
	list_reagents = list("Polonium" = 30)

/obj/item/reagent_containers/glass/bottle/astatine_tru
	name = "Astatine bottle"
	list_reagents = list("Astatine" = 30)

/obj/item/reagent_containers/glass/bottle/radon_tru
	name = "Radon bottle"
	list_reagents = list("Radon" = 30)

/obj/item/reagent_containers/glass/bottle/francium_tru
	name = "Francium bottle"
	list_reagents = list("Francium" = 30)

/obj/item/reagent_containers/glass/bottle/radium_tru
	name = "Radium bottle"
	list_reagents = list("Radium" = 30)

/obj/item/reagent_containers/glass/bottle/actinium_tru
	name = "Actinium bottle"
	list_reagents = list("Actinium" = 30)

/obj/item/reagent_containers/glass/bottle/thorium_tru
	name = "Thorium bottle"
	list_reagents = list("Thorium" = 30)

/obj/item/reagent_containers/glass/bottle/protactinium_tru
	name = "Protactinium bottle"
	list_reagents = list("Protactinium" = 30)

/obj/item/reagent_containers/glass/bottle/uranium_tru
	name = "Uranium bottle"
	list_reagents = list("Uranium" = 30)

/obj/item/reagent_containers/glass/bottle/neptunium_tru
	name = "Neptunium bottle"
	list_reagents = list("Neptunium" = 30)

/obj/item/reagent_containers/glass/bottle/plutonium_tru
	name = "Plutonium bottle"
	list_reagents = list("Plutonium" = 30)

/obj/item/reagent_containers/glass/bottle/americium_tru
	name = "Americium bottle"
	list_reagents = list("Americium" = 30)

/obj/item/reagent_containers/glass/bottle/curium_tru
	name = "Curium bottle"
	list_reagents = list("Curium" = 30)

/obj/item/reagent_containers/glass/bottle/berkelium_tru
	name = "Berkelium bottle"
	list_reagents = list("Berkelium" = 30)

/obj/item/reagent_containers/glass/bottle/californium_tru
	name = "Californium bottle"
	list_reagents = list("Californium" = 30)

/obj/item/reagent_containers/glass/bottle/einsteinium_tru
	name = "Einsteinium bottle"
	list_reagents = list("Einsteinium" = 30)

/obj/item/reagent_containers/glass/bottle/fermium_tru
	name = "Fermium bottle"
	list_reagents = list("Fermium" = 30)

/obj/item/reagent_containers/glass/bottle/mendelevium_tru
	name = "Mendelevium bottle"
	list_reagents = list("Mendelevium" = 30)

/obj/item/reagent_containers/glass/bottle/nobelium_tru
	name = "Nobelium bottle"
	list_reagents = list("Nobelium" = 30)

/obj/item/reagent_containers/glass/bottle/lawrencium_tru
	name = "Lawrencium bottle"
	list_reagents = list("Lawrencium" = 30)

/obj/item/reagent_containers/glass/bottle/rutherfordium_tru
	name = "Rutherfordium bottle"
	list_reagents = list("Rutherfordium" = 30)

/obj/item/reagent_containers/glass/bottle/dubnium_tru
	name = "Dubnium bottle"
	list_reagents = list("Dubnium" = 30)

/obj/item/reagent_containers/glass/bottle/seaborgium_tru
	name = "Seaborgium bottle"
	list_reagents = list("Seaborgium" = 30)

/obj/item/reagent_containers/glass/bottle/bohrium_tru
	name = "Bohrium bottle"
	list_reagents = list("Bohrium" = 30)

/obj/item/reagent_containers/glass/bottle/hassium_tru
	name = "Hassium bottle"
	list_reagents = list("Hassium" = 30)

/obj/item/reagent_containers/glass/bottle/meitnerium_tru
	name = "Meitnerium bottle"
	list_reagents = list("Meitnerium" = 30)

/obj/item/reagent_containers/glass/bottle/darmstadtium_tru
	name = "Darmstadtium bottle"
	list_reagents = list("Darmstadtium" = 30)

/obj/item/reagent_containers/glass/bottle/roentgenium_tru
	name = "Roentgenium bottle"
	list_reagents = list("Roentgenium" = 30)

/obj/item/reagent_containers/glass/bottle/copernicium_tru
	name = "Copernicium bottle"
	list_reagents = list("Copernicium" = 30)

/obj/item/reagent_containers/glass/bottle/nihonium_tru
	name = "Nihonium bottle"
	list_reagents = list("Nihonium" = 30)

/obj/item/reagent_containers/glass/bottle/flerovium_tru
	name = "Flerovium bottle"
	list_reagents = list("Flerovium" = 30)

/obj/item/reagent_containers/glass/bottle/moscovium_tru
	name = "Moscovium bottle"
	list_reagents = list("Moscovium" = 30)

/obj/item/reagent_containers/glass/bottle/livermorium_tru
	name = "Livermorium bottle"
	list_reagents = list("Livermorium" = 30)

/obj/item/reagent_containers/glass/bottle/tennessine_tru
	name = "Tennessine bottle"
	list_reagents = list("Tennessine" = 30)

/obj/item/reagent_containers/glass/bottle/oganesson_tru
	name = "Oganesson bottle"
	list_reagents = list("Oganesson" = 30)


//----------------------------------------
/*
/datum/substance/CarbonDiOx
	name = "carbon dioxyde"
	id = "co2"
	formula = "CO"
	*/
#undef true
#undef false
#undef Solid
#undef LANTAN
#undef ACTIN
