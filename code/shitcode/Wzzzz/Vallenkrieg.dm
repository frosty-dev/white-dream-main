/obj/item/clothing/under/wzzzz/m35jacket
	desc = "Uniform of the German Imperial Army. Life for the Kaiser!"
	name = "m35 uniform"
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/uniform.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/uniforms.dmi'
	icon_state = "m35_jacket"
	item_state = "m35_jacket"
	armor = list("melee" = 10, "bullet" = 10, "laser" = 20,"energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 10)
	can_adjust = FALSE

/obj/item/clothing/under/wzzzz/m35jacket/officer
	desc = "Officer's uniform of the German Imperial Army. Life for the Kaiser and God!"
	name = "m35 officer uniform"
	icon_state = "m35_jacket_officer"
	item_state = "m35_jacket_officer"
	armor = list("melee" = 10, "bullet" = 10, "laser" = 20,"energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 10)

/obj/item/clothing/under/wzzzz/m35jacket/black
	icon_state = "m35_elite_jacket"
	item_state = "m35_elite_jacket"
	desc = "Black uniform of the Geheimpolizei. Life for the Kaiser!"
	name = "m35 black uniform"
	armor = list("melee" = 15, "bullet" = 15, "laser" = 15,"energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 5, "acid" = 10)
	siemens_coefficient = 0.9

/obj/item/clothing/under/wzzzz/m35jacket/elite/super
	icon_state = "m35_super_elite_jacket"
	desc = "Black uniform of the Geheimpolizei. Looks robust!"
	name = "m35 dark general uniform"
	item_state = "m35_super_elite_jacket"
	armor = list("melee" = 25, "bullet" = 25, "laser" = 25,"energy" = 10, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 5)

/obj/item/clothing/under/wzzzz/magistrate
	name = "magistrate's uniform"
	desc = "Regal as you can afford."
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/uniform.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/uniforms.dmi'
	icon_state = "magistrate"
	item_state = "magistrate"
	can_adjust = FALSE
	armor = list("melee" = 10, "bullet" = 10, "laser" = 20,"energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 00, "acid" = 10)

/obj/item/clothing/under/wzzzz/arbiter
	name = "arbiter uniform"
	desc = "Somebody saw description?"
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/uniform.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/uniforms.dmi'
	icon_state = "arbiter"
	item_state = "arbiter"
	can_adjust = FALSE
	armor = list("melee" = 15, "bullet" = 15, "laser" = 15,"energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 5, "acid" = 10)

/obj/item/clothing/suit/armor/wzzzz/opvest
	name = "armored vest"
	desc = "It provides some armor and some storage. Not really the best at either though."
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/suit.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/suits.dmi'
	icon_state = "opvest"

	armor = list("melee" = 40, "bullet" = 35, "laser" = 40,"energy" = 35, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 30)

/obj/item/clothing/suit/armor/vest/wzzzz/arbiter
	icon_state = "arbiter"

/obj/item/clothing/suit/armor/vest/wzzzz/m35
	icon_state = "army_coat"
	armor = list("melee" = 40, "bullet" = 50, "laser" = 40,"energy" = 35, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/suit.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/suits.dmi'
	heat_protection = CHEST|GROIN|LEGS|ARMS

/obj/item/clothing/suit/armor/vest/wzzzz/m35/black
	icon_state = "elite_army_coat"
	armor = list("melee" = 40, "bullet" = 50, "laser" = 40,"energy" = 35, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/suit.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/suits.dmi'

/obj/item/clothing/suit/armor/vest/wzzzz/m35/officer
	icon_state = "super_elite_army_coat"
	armor = list("melee" = 50, "bullet" = 55, "laser" = 45,"energy" = 35, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 40)
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/suit.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/suits.dmi'
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS

/obj/item/clothing/suit/wzzzz/cowl
	name = "cowl"
	desc = "Stulish thing."
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/suit.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/suits.dmi'
	icon_state = "cowl"

/obj/item/clothing/suit/wzzzz/cowl/robe
	name = "robe"
	icon_state = "robe"

//gloves

/obj/item/clothing/gloves/combat/wzzzz/arbiter
	name = "arbiter gloves"
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/glove.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/gloves.dmi'
	icon_state = "arbiter"

/obj/item/clothing/gloves/combat/wzzzz/arbiter/undertaker
	name = "undertaker gloves"
	icon_state = "undertaker"

//hats

/obj/item/clothing/head/helmet/wzzzz/arbiter
	name = "arbiter helmet"
	desc = "Somebody saw description?"
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/hat.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/hats.dmi'
	icon_state = "arbiter"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR
	armor = list("melee" = 20, "bullet" = 20, "laser" = 20,"energy" = 20, "bomb" = 30, "bio" = 100, "rad" = 0, "fire" = 50, "acid" = 40)

/obj/item/clothing/head/helmet/wzzzz/arbiter/inquisitor
	name = "inquisitor helmet"
	icon_state = "inquisitor"

/obj/item/clothing/head/helmet/wzzzz/izanhelm
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/hat.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/hats.dmi'
	icon_state = "officer_cap"
	name = "officer hat"
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/hat.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/hats.dmi'
	desc = "Officer's cap. It is obviously used by the officers of the Kaiser Army."

/obj/item/clothing/head/cap/wzzzz/elite
	name = "black officer hat"
	desc = "Officer's cap is of dark color. In addition, the cockade depicts a symbol of the secret police."
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/hat.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/hats.dmi'
	icon_state = "m35_elite_cap"

/obj/item/clothing/head/helmet/wzzzz/m35
	name = "stahlhelm"
	desc = "An ordinary steel helmet. Used by the Kaiser Army."
	icon_state = "m35_helmet"
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/hat.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/hats.dmi'
	armor = list(melee = 35, bullet = 20, laser = 20, energy = 35, bomb = 15, bio = 2, rad = 0)

/obj/item/clothing/head/helmet/wzzzz/elite
	name = "black stahlhelm"
	desc = "A typical germany steel helmet. Black color and it seems instead of steel here used a strong alloy"
	icon_state = "m35_elite_helmet"
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/hat.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/hats.dmi'
	armor = list("melee" = 35, "bullet" = 40, "laser" = 40,"energy" = 25, "bomb" = 45, "bio" = 2, "rad" = 0, "fire" = 30, "acid" = 20)

/obj/item/clothing/head/helmet/wzzzz/pickelhelm
	name = "pickelhaube"
	desc = "A spiked helmet.On the front is an eagle of gold color. Inspires respect for the Kaiser"
	armor = list(melee = 65, bullet = 60, laser = 60, energy = 60, bomb = 60, bio = 2, rad = 0, "fire" = 30, "acid" = 20)
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/hat.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/hats.dmi'
	icon_state = "pickelhelm"

/obj/item/clothing/head/helmet/wzzzz/richard
	name = "richard's head"
	desc = "Legendary petuch."
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/mask.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/hats.dmi'
	icon_state = "richard"
	dynamic_fhair_suffix = ""
	dynamic_hair_suffix = ""
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR
	armor = list("melee" = 10, "bullet" = 0, "laser" = 9,"energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 10)

/obj/item/clothing/mask/gas/wzzzz/germanfull
	name = "old style gas mask"
	desc = "С›РјРј. вЂ™Р°Р№Р»СЊ В¬Р°Р№С‚."
	flags_inv = HIDEHAIR|HIDEEARS|HIDEFACE|HIDEFACIALHAIR
	visor_flags_inv = HIDEHAIR|HIDEEARS|HIDEFACE|HIDEFACIALHAIR
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/mask.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/masks.dmi'
	icon_state = "fullgas"

/obj/item/clothing/mask/gas/wzzzz/german
	name = "german gas mask"
	icon_state = "german_gasmask"
	flags_inv = HIDEFACE|HIDEFACIALHAIR
	dynamic_fhair_suffix = ""
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/mask.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/masks.dmi'
	dynamic_fhair_suffix = ""

/obj/item/clothing/mask/gas/wzzzz/germanalt
	name = "gas mask"
	icon_state = "gas_alt"
	flags_inv = HIDEFACE|HIDEFACIALHAIR
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR
	dynamic_fhair_suffix = ""
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/mask.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/masks.dmi'

/obj/item/clothing/mask/gas/wzzzz/respirator
	name = "respirator mask"
	icon_state = "respirator"
	flags_inv = HIDEFACE|HIDEFACIALHAIR
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/mask.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/masks.dmi'
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR
	dynamic_fhair_suffix = ""

/obj/item/clothing/mask/wzzzz/balaclavager
	name = "balaclava"
	desc = "German balaclava."
	dynamic_fhair_suffix = ""
	dynamic_hair_suffix = ""
	flags_inv = HIDEFACE|HIDEFACIALHAIR
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/mask.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/masks.dmi'
	icon_state = "balaclava"
	flags_inv = HIDEHAIR|HIDEEARS
	visor_flags_inv = HIDEHAIR|HIDEEARS

/obj/item/clothing/shoes/combat/wzzzz/arbiter
	name = "arbiter boots"
	desc = "Somebody saw description?"
	mob_overlay_icon = 'code/shitcode/Wzzzz/Valya/clothing/mob/shoe.dmi'
	icon = 'code/shitcode/Wzzzz/Valya/clothing/shoes.dmi'
	icon_state = "arbiter"
