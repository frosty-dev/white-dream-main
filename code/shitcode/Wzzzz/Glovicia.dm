//masks

/obj/item/clothing/mask/wzzzz/swatclava
	name = "SWAT balaclava"
	desc = "Baba Clava"
	mob_overlay_icon = 'code/shitcode/Wzzzz/icons/clothing/mob1/mask.dmi'
	icon = 'code/shitcode/Wzzzz/icons/clothing/masks.dmi'
	icon_state = "swatclava"
	item_state = "swatclava"
	flags_inv = HIDEHAIR|HIDEEARS
	visor_flags_inv = HIDEHAIR|HIDEEARS

/obj/item/clothing/shoes/combat/wzzzz/blackger
	name = "black Boots"
	desc = "Looks stylish"
	mob_overlay_icon = 'code/shitcode/Wzzzz/icons/clothing/mob1/feet.dmi'
	icon = 'code/shitcode/Wzzzz/icons/clothing/shoes.dmi'
	icon_state = "black_boots"
	item_state = "black_boots"

/obj/item/clothing/shoes/wzzzz/slippers
	name = "slippers"
	desc = "I think you understand all yourself"
	mob_overlay_icon = 'code/shitcode/Wzzzz/icons/clothing/mob1/feet.dmi'
	icon = 'code/shitcode/Wzzzz/icons/clothing/shoes.dmi'
	icon_state = "slippers"
	item_state = "slippers"

/obj/item/clothing/shoes/wzzzz/digiboots
	name = "dig boots"
	desc = "I hope you understand all yourself"
	mob_overlay_icon = 'code/shitcode/Wzzzz/icons/clothing/mob1/feet.dmi'
	icon = 'code/shitcode/Wzzzz/icons/clothing/shoes.dmi'
	icon_state = "digiboots"
	item_state = "digiboots"

/obj/item/clothing/shoes/wzzzz/flippers
	name = "flippers"
	desc = "I think you understand all yourself"
	mob_overlay_icon = 'code/shitcode/Wzzzz/icons/clothing/mob1/feet.dmi'
	icon = 'code/shitcode/Wzzzz/icons/clothing/shoes.dmi'
	icon_state = "flippers"
	item_state = "flippers"

/obj/item/clothing/mask/gas/wzzzz/full
	name = "gas mask"
	desc = "A face-covering mask that can be connected to an air supply. Filters harmful gases from the air."
	icon_state = "fullgas"
	mob_overlay_icon = 'code/shitcode/Wzzzz/icons/clothing/mob1/mask.dmi'
	icon = 'code/shitcode/Wzzzz/icons/clothing/clothing/masks.dmi'
	flags_inv = HIDEEARS|HIDEFACE|HIDEFACIALHAIR
	visor_flags_inv = HIDEEARS|HIDEFACE|HIDEFACIALHAIR
	dynamic_fhair_suffix = ""
	clothing_flags = STOPSPRESSUREDAMAGE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	resistance_flags = NONE
	item_state = "fullgas"
	armor = list(melee = 5, bullet = 5, laser = 5, energy = 0, bomb = 0, bio = 75, rad = 0)


/obj/item/clothing/mask/breath/wzzzz/half
	name = "face mask"
	desc = "A compact, durable gas mask that can be connected to an air supply."
	icon_state = "halfgas"
	item_state = "halfgas"
	mob_overlay_icon = 'code/shitcode/Wzzzz/icons/clothing/mob1/mask.dmi'
	icon = 'code/shitcode/Wzzzz/icons/clothing/clothing/masks.dmi'
	dynamic_fhair_suffix = ""
	armor = list(melee = 10, bullet = 10, laser = 10, energy = 0, bomb = 0, bio = 55, rad = 0)
