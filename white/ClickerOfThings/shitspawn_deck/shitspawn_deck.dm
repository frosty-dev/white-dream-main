/obj/item/jobanyj_rot
	name = "Ebaniy rot etogo kazino"
	desc = "Ebaniy rot etogo kazino blyat. Ti kto takoi suka, chtob eto sdelat?"
	icon = 'white/ClickerOfThings/shitspawn_deck/kazino.dmi'
	icon_state = "kazino"
	w_class = WEIGHT_CLASS_SMALL


/obj/item/toy/cards/deck/shitspawn_deck
	name = "shitspawn deck of cards"
	desc = "A deck of space-grade playing cards with some shitspawn in it."
	icon = 'icons/obj/toy.dmi'
	deckstyle = "nanotrasen"
	icon_state = "deck_nanotrasen_full"
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 1
	hitsound = 'white/ClickerOfThings/shitspawn_deck/cardinsult.ogg'




/obj/item/toy/cards/deck/shitspawn_deck/attack_hand(mob/user)
	var/choice = null
	if(cards.len == 0)
		to_chat(user, "<span class='warning'>There are no more cards to draw!</span>")
		return
	var/obj/item/toy/cards/singlecard/H = new/obj/item/toy/cards/singlecard(user.loc)
	if(holo)
		holo.spawned += H // track them leaving the holodeck
	choice = cards[1]
	H.cardname = choice
	H.parentdeck = src
	var/O = src
	H.apply_card_vars(H,O)
	src.cards -= choice
	H.pickup(user)
	user.put_in_hands(H)
	playsound(src, 'white/ClickerOfThings/shitspawn_deck/pullcard.ogg', 50, 1)
	user.visible_message("[user] draws a card from the deck. Karta razlozhena v drugom poryadke, blyat!", "<span class='notice'>You draw a card from the deck. Karta razlozhena v drugom poryadke, blyat!</span>")
	update_icon()


/obj/item/toy/cards/deck/shitspawn_deck/attack_self(mob/user)
	if(cooldown < world.time - 50)
		cards = shuffle(cards)
		playsound(src, 'sound/items/cardshuffle.ogg', 50, 1)
		playsound(src, 'white/ClickerOfThings/shitspawn_deck/cardshuffle2.ogg', 50, 1)
		user.visible_message("[user] shuffles the deck. Karti razlozheni v drugom poryadke, blyat!", "<span class='notice'>You shuffle the deck. Karti razlozheni v drugom poryadke, blyat!</span>")
		cooldown = world.time


/obj/item/toy/cards/deck/shitspawn_deck/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/toy/cards/singlecard))
		var/obj/item/toy/cards/singlecard/SC = I
		if(SC.parentdeck == src)
			if(!user.temporarilyRemoveItemFromInventory(SC))
				to_chat(user, "<span class='warning'>The card is stuck to your hand, you can't add it to the deck!</span>")
				return
			cards += SC.cardname
			playsound(src, 'white/ClickerOfThings/shitspawn_deck/diler_est.ogg', 50, 1)
			user.visible_message("[user] adds a card to the bottom of the deck. Karta razlozhena v nuzhnom poryadke.","<span class='notice'>You add the card to the bottom of the deck. Karta razlozhena v nuzhnom poryadke.</span>")
			cooldown = world.time
			qdel(SC)
		else
			playsound(src, 'white/ClickerOfThings/shitspawn_deck/durak.ogg', 50, 1)
			to_chat(user, "<span class='warning'>You can't mix cards from other decks! Ti che durak blyat?!</span>")
		update_icon()
	else if(istype(I, /obj/item/toy/cards/cardhand))
		var/obj/item/toy/cards/cardhand/CH = I
		if(CH.parentdeck == src)
			if(!user.temporarilyRemoveItemFromInventory(CH))
				to_chat(user, "<span class='warning'>The hand of cards is stuck to your hand, you can't add it to the deck!</span>")
				return
			cards += CH.currenthand
			playsound(src, 'white/ClickerOfThings/shitspawn_deck/diler_est.ogg', 50, 1)
			user.visible_message("[user] puts [user.p_their()] hand of cards in the deck. Ti to che delaesh?!", "<span class='notice'>You put the hand of cards in the deck. Ti to che delaesh?!</span>")
			qdel(CH)
		else
			playsound(src, 'white/ClickerOfThings/shitspawn_deck/durak.ogg', 50, 1)
			to_chat(user, "<span class='warning'>You can't mix cards from other decks! Ti che durak blyat?!</span>")
		update_icon()
	else if(istype(I, /obj/item/jobanyj_rot))
		var/obj/item/jobanyj_rot = I
		del(jobanyj_rot)
		playsound(src, 'white/ClickerOfThings/shitspawn_deck/sluchai_v_kazino_full.ogg', 50, 1)
		user.visible_message("[user] zamechaet, chto koloda raspolozhena v drugom poryadke. Yobaniy rot etogo kazino blyat!")
	else
		return ..()
