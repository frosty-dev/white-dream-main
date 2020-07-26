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
			MC.say("Рынок [SSspm.crypto] обрушился.")
			MC.need_rework = TRUE
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
	desc = "Конвертирует энергию в деньги."
	icon = 'white/valtos/icons/miner.dmi'
	icon_state = "miner-off"

	anchored = FALSE
	density = TRUE

	use_power = NO_POWER_USE
	idle_power_usage = 80
	active_power_usage = 80000

	var/coins = 0
	var/tier = 1
	var/mining = FALSE
	var/need_rework = FALSE

/obj/machinery/power/spaceminer/examine(mob/user)
	. = ..()

	var/datum/gas_mixture/env = loc.return_air()

	. += "<span class='notice'>Датчик температуры: [round(env.return_temperature()-T0C, 0.01)]°C</span>"
	if(need_rework)
		. += "<span class='notice'>Возможно <b>мультитул</b> поможет перенастроить его.</span>"

/obj/machinery/power/spaceminer/Initialize()
	. = ..()
	if(anchored)
		connect_to_network()
	name = "[SSspm.crypto] майнер"

/obj/machinery/power/spaceminer/connect_to_network()
	var/to_return = ..()
	if(powernet)
		SSspm.miners |= src
	return to_return

/obj/machinery/power/spaceminer/disconnect_from_network()
	..()
	SSspm.miners.Remove(src)

/obj/machinery/power/spaceminer/attack_ai(mob/user)
	interact(user)

/obj/machinery/power/spaceminer/attack_paw(mob/user)
	interact(user)

/obj/machinery/power/spaceminer/proc/update()
	if(!mining || (!powernet && active_power_usage))
		return

	if(need_rework)
		icon_state = "miner-off"
		idle_power_usage = 40
		playsound(src, 'white/valtos/sounds/down.ogg', 100, 1)
		mining = FALSE
		return

	if(mining)
		if(!active_power_usage || surplus() >= active_power_usage)
			add_load(active_power_usage)
		else
			say("Недостаточно энергии. Прекращаем майнинг.")
			icon_state = "miner-off"
			idle_power_usage = 40
			playsound(src, 'white/valtos/sounds/down.ogg', 100, 1)
			mining = FALSE
			return
		playsound(src, 'white/valtos/sounds/ping.ogg', 100, 1)

		var/datum/gas_mixture/env = loc.return_air()

		env.set_temperature(env.return_temperature() + (40 * tier))
		air_update_turf()

		if(round(env.return_temperature()-T0C, 1) > 250)
			explosion(src, 1, 2, 3, 5)
			if(src)
				qdel(src)
			return

		coins += (tier * SSspm.convertprice)

/obj/machinery/power/spaceminer/attackby(obj/item/O, mob/user, params)
	if(!mining)
		if(O.tool_behaviour == TOOL_WRENCH)
			if(!anchored && !isinspace())
				to_chat(user, "<span class='notice'>Прикручиваю майнер к полу.</span>")
				anchored = TRUE
				connect_to_network()
				update_cable_icons_on_turf(get_turf(src))
			else if(anchored)
				to_chat(user, "<span class='notice'>Откручиваю майнер от пола.</span>")
				anchored = FALSE
				disconnect_from_network()
				update_cable_icons_on_turf(get_turf(src))

			playsound(src, 'sound/items/deconstruct.ogg', 50, 1)
			return
		if(O.tool_behaviour == TOOL_MULTITOOL)
			if(need_rework)
				to_chat(user, "<span class='notice'>Начинаю перенастраивать майнер...</span>")
				if(do_after(user, 30 SECONDS, target = src))
					to_chat(user, "<span class='notice'>Готово. Теперь он майнит <b>[SSspm.crypto]</b></span>")
					name = "[SSspm.crypto] майнер"
					need_rework = FALSE
			else
				to_chat(user, "<span class='notice'>Он и так в отличном состоянии!</span>")
	return ..()

/obj/machinery/power/spaceminer/proc/eject_money()
	say("Снято $[coins].")
	new /obj/item/holochip(drop_location(), coins)
	coins = 0

/obj/machinery/power/spaceminer/ui_interact(mob/user)
	if(!anchored)
		return
	. = ..()

	var/datum/gas_mixture/env = loc.return_air()

	var/dat = "Баланс: [coins] SC<br>"
	dat += "Датчик температуры: [round(env.return_temperature()-T0C, 0.01)]°C<br>"
	dat += "Конверсия: $[SSspm.convertprice]<br>"
	dat += "Потребление: [active_power_usage] W<br>"

	if(!mining)
		dat += "<A href='?src=[REF(src)];mine=1'>ВКЛЮЧИТЬ</A><br>"
	else
		dat += "<A href='?src=[REF(src)];stop=1'>ОТКЛЮЧИТЬ</A><br>"

	dat += "<A href='?src=[REF(src)];money=1'>Вывести деньги</A><br>"

	var/datum/browser/popup = new(user, "miner", "[SSspm.crypto] Майнер: класс [tier]", 300, 200)
	popup.set_content("<center>[dat]</center>")
	popup.set_title_image(usr.browse_rsc_icon(src.icon, src.icon_state))
	popup.open()

/obj/machinery/power/spaceminer/Topic(href, href_list)
	if(..())
		return
	if(href_list["mine"])
		say("Стартуем...")
		icon_state = "miner-on"
		playsound(src, 'white/valtos/sounds/up.ogg', 100, 1)
		active_power_usage = 80000 * tier
		mining = TRUE
		src.updateUsrDialog()
	if(href_list["stop"])
		say("Выключаемся...")
		icon_state = "miner-off"
		playsound(src, 'white/valtos/sounds/down.ogg', 100, 1)
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

/datum/supply_pack/misc/spaceminer2
	name = "Spacecoin Miner Tier 2"
	desc = "Ping!"
	cost = 180000
	contains = list(/obj/machinery/power/spaceminer/tier2,
					/obj/item/wrench)
	crate_name = "coinminer tier 2 crate"

/datum/supply_pack/misc/spaceminer3
	name = "Spacecoin Miner Tier 3"
	desc = "Ping!"
	cost = 300000
	contains = list(/obj/machinery/power/spaceminer/tier3,
					/obj/item/wrench)
	crate_name = "coinminer tier 3 crate"

/datum/supply_pack/misc/spaceminer4
	name = "Spacecoin Miner Tier 4"
	desc = "Pong!"
	cost = 800000
	contains = list(/obj/machinery/power/spaceminer/tier4,
					/obj/item/wrench)
	crate_name = "coinminer tier 4 crate"

/datum/supply_pack/misc/minerchallenge
	name = "You can do it! The Miner Challenge"
	desc = "Pong!"
	cost = 70000069
	contains = list(/obj/item/gun/energy/pulse/prize)
	crate_name = "coinminer tier 4 crate"
