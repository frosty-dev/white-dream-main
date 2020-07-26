//Gun crafting parts til they can be moved elsewhere

// PARTS //

/obj/item/weaponcrafting/receiver
	name = "модульный приёмник"
	desc = "Прототип модульного приёмника, который может послужить как спусковой крючок для огнестрела."
	icon = 'icons/obj/improvised.dmi'
	icon_state = "receiver"

/obj/item/weaponcrafting/stock
	name = "приклад"
	desc = "Классический приклад от винтовки, так же служит как ручка. Грубо выструган из дерева."
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT * 6)
	icon = 'icons/obj/improvised.dmi'
	icon_state = "riflestock"
