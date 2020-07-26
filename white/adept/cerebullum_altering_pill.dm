/datum/reagent/drug/psychosis_drug
    name = "Cerebullum altering drug"
    description = "Makes you mad."
    reagent_state = LIQUID
    color = "#FAFAFA"
    overdose_threshold = 20
    addiction_threshold = 10
    taste_description = "соль"
    var/datum/martial_art/psychotic_brawling/pb

/datum/reagent/drug/psychosis_drug/on_mob_add(mob/M)
    ..()
    pb = new(null)
    if(ishuman(M))
        var/mob/living/carbon/human/H = M
        pb.teach(H, FALSE)
        //H.gain_trauma(/datum/brain_trauma/special/psychotic_brawling)

/obj/item/reagent_containers/pill/psychosis_drug_pill
	name = "Cerebullum altering pill"
	desc = "Makes you mad."
	icon_state = "pill5"
	list_reagents = list(/datum/reagent/drug/psychosis_drug = 1)


/datum/uplink_item/stealthy_weapons/psychosis_drug_pill
	name = "Cerebullum altering pill."
	desc = "Experimental syndicate technology that alters the user's brain inner mechanisms, allowing the agent to fight in an unpredictable manner."
	item = /obj/item/reagent_containers/pill/psychosis_drug_pill
	cost = 10

