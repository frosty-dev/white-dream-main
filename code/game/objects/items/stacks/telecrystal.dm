/obj/item/stack/telecrystal
	name = "телекристаллы"
	desc = "Кажется, он пульсирует подозрительно соблазнительными энергиями."
	singular_name = "телекристалл"
	icon = 'icons/obj/telescience.dmi'
	icon_state = "telecrystal"
	dye_color = DYE_SYNDICATE
	w_class = WEIGHT_CLASS_TINY
	max_amount = 50
	item_flags = NOBLUDGEON

/obj/item/stack/telecrystal/attack(mob/target, mob/user)
	if(target == user) //You can't go around smacking people with crystals to find out if they have an uplink or not.
		for(var/obj/item/implant/uplink/I in target)
			if(I && I.imp_in)
				var/datum/component/uplink/hidden_uplink = I.GetComponent(/datum/component/uplink)
				if(hidden_uplink)
					hidden_uplink.telecrystals += amount
					use(amount)
					to_chat(user, "<span class='notice'>Сдавливаю <b>[src]</b> и заряжаю свой скрытый аплинк.</span>")
	else
		return ..()

/obj/item/stack/telecrystal/five
	amount = 5

/obj/item/stack/telecrystal/twenty
	amount = 20
