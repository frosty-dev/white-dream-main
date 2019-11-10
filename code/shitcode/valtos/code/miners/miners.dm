SUBSYSTEM_DEF(spm)
	name = "Space Coin"
	wait = 25
	var/list/miners	= list()
	var/convertprice = 30
	var/crypto = "Space Coin"

/datum/controller/subsystem/spm/Initialize()
	. = ..()
	convertprice = rand (0,100)
	gen_new_crypto()

/datum/controller/subsystem/spm/stat_entry(msg)
	..("P:[miners.len]")

/datum/controller/subsystem/spm/fire()
	convertprice += rand (-30,30)

	for(var/obj/machinery/power/spaceminer/MC in miners)
		if(convertprice <= -100)
			MC.say("Рынок [SSspm.crypto] обрушился. Я больше не актуален...")
			spawn(30)
				explosion(MC, 1, 2, 3, 8)
		if(!MC.powernet)
			miners.Remove(MC)
			MC.update()
			continue
		MC.update()

	if(convertprice <= -100)
		gen_new_crypto()

/datum/controller/subsystem/spm/proc/gen_new_crypto()
	crypto = pick(GLOB.crypto_names)
	convertprice = 30

////////////////////////////////////////////
// SPACECOIN miners
// fuck this
/////////////////////////////////////

/obj/machinery/power/spaceminer
	name = "spacecoin miner"
	desc = "Converts energy into money."
	icon = 'code/shitcode/valtos/icons/miner.dmi'
	icon_state = "miner-off"

	anchored = FALSE
	density = TRUE

	use_power = NO_POWER_USE
	idle_power_usage = 80
	active_power_usage = 80000

	var/coins = 0
	var/tier = 1
	var/mining = FALSE

/obj/machinery/power/spaceminer/Initialize()
	. = ..()
	if(anchored)
		connect_to_network()
	name = "[SSspm.crypto] miner"

/obj/machinery/power/spaceminer/connect_to_network()
	var/to_return = ..()
	if(powernet)
		SSspm.miners |= src
	return to_return

/obj/machinery/power/solar_control/disconnect_from_network()
	..()
	SSspm.miners.Remove(src)

/obj/machinery/power/spaceminer/attack_ai(mob/user)
	interact(user)

/obj/machinery/power/spaceminer/attack_paw(mob/user)
	interact(user)

/obj/machinery/power/spaceminer/proc/update()
	if(!mining || (!powernet && active_power_usage))
		return
	if(mining)
		if(!active_power_usage || surplus() >= active_power_usage)
			add_load(active_power_usage)
		else
			say("Insufficient power. Halting mining.")
			icon_state = "miner-off"
			idle_power_usage = 40
			playsound(src, 'code/shitcode/valtos/sounds/down.ogg', 100, 1)
			mining = FALSE
			mining = FALSE
			return
		playsound(src, 'code/shitcode/valtos/sounds/ping.ogg', 100, 1)
		coins += (tier * SSspm.convertprice)

/obj/machinery/power/spaceminer/attackby(obj/item/O, mob/user, params)
	if(!mining)
		if(O.tool_behaviour == TOOL_WRENCH)
			if(!anchored && !isinspace())
				to_chat(user, "<span class='notice'>You secure the coinminer to the floor.</span>")
				anchored = TRUE
				connect_to_network()
				update_cable_icons_on_turf(get_turf(src))
			else if(anchored)
				to_chat(user, "<span class='notice'>You unsecure the coinminer from the floor.</span>")
				anchored = FALSE
				disconnect_from_network()
				update_cable_icons_on_turf(get_turf(src))

			playsound(src, 'sound/items/deconstruct.ogg', 50, 1)
			return
	return ..()

/obj/machinery/power/spaceminer/proc/eject_money()
	say("Withdrawed $[coins].")
	new /obj/item/holochip(drop_location(), coins)
	coins = 0

/obj/machinery/power/spaceminer/ui_interact(mob/user)
	if(!anchored)
		return
	. = ..()

	var/dat = "Current Balance: [coins] SC<br>"
	dat += "Current Conversion: $[SSspm.convertprice]<br>"
	dat += "Current Power Usage: [active_power_usage] W<br>"

	if(!mining)
		dat += "<A href='?src=[REF(src)];mine=1'>Turn ON</A><br>"
	else
		dat += "<A href='?src=[REF(src)];stop=1'>Turn OFF</A><br>"

	dat += "<A href='?src=[REF(src)];money=1'>Withdraw money</A><br>"

	var/datum/browser/popup = new(user, "miner", "[SSspm.crypto] Miner Tier [tier]", 300, 200)
	popup.set_content("<center>[dat]</center>")
	popup.set_title_image(usr.browse_rsc_icon(src.icon, src.icon_state))
	popup.open()

/obj/machinery/power/spaceminer/Topic(href, href_list)
	if(..())
		return
	if(href_list["mine"])
		say("Booting up...")
		icon_state = "miner-on"
		playsound(src, 'code/shitcode/valtos/sounds/up.ogg', 100, 1)
		active_power_usage = 80000 * tier
		mining = TRUE
		src.updateUsrDialog()
	if(href_list["stop"])
		say("Shutdown...")
		icon_state = "miner-off"
		playsound(src, 'code/shitcode/valtos/sounds/down.ogg', 100, 1)
		active_power_usage = 40
		mining = FALSE
		src.updateUsrDialog()
	if(href_list["money"])
		eject_money()
		src.updateUsrDialog()

/obj/machinery/power/spaceminer/tier2
	tier = 2

/obj/machinery/power/spaceminer/tier3
	tier = 3

/obj/machinery/power/spaceminer/tier4
	tier = 4

/datum/supply_pack/misc/spaceminer
	name = "Spacecoin Miner Tier 1"
	desc = "Ping!"
	cost = 80000
	contains = list(/obj/machinery/power/spaceminer,
					/obj/item/wrench)
	crate_name = "coinminer tier 1 crate"
/*
/datum/supply_pack/misc/spaceminer2
	name = "Spacecoin Miner Tier 2"
	desc = "Ping!"
	cost = 180000
	contains = list(/obj/machinery/spaceminer/tier2,
					/obj/item/wrench)
	crate_name = "coinminer tier 2 crate"

/datum/supply_pack/misc/spaceminer3
	name = "Spacecoin Miner Tier 3"
	desc = "Ping!"
	cost = 300000
	contains = list(/obj/machinery/spaceminer/tier3,
					/obj/item/wrench)
	crate_name = "coinminer tier 3 crate"

/datum/supply_pack/misc/spaceminer4
	name = "Spacecoin Miner Tier 4"
	desc = "Pong!"
	cost = 800000
	contains = list(/obj/machinery/spaceminer/tier4,
					/obj/item/wrench)
	crate_name = "coinminer tier 4 crate"
*/
/datum/supply_pack/misc/minerchallenge
	name = "You can do it! The Miner Challenge"
	desc = "Pong!"
	cost = 70000069
	contains = list(/obj/item/gun/energy/pulse/prize)
	crate_name = "coinminer tier 4 crate"
