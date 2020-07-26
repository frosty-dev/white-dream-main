/*
By qwaszx000
*/
#define true TRUE
#define false FALSE

#include "formulas_n_constants.dm"
#include "true_reagents.dm"

//On adding reagent in holder
/datum/reagent/tru/on_merge(list/new_data)
	on_new(new_data)

/datum/reagent/tru/on_new(list/new_data)

	var/datum/reagent/tru/R = holder.has_reagent(new_data["id"])
	R.create_data()
	new_data = R.data

	var/all_data = list()
	for(var/datum/reagent/tru/i in holder.reagent_list)
		i.create_data()
		i.update_params()
		all_data[i.id] = i.data

	if(canReactWithSome(all_data))
		to_chat(usr, "Reaction!")
		for(var/datum/reagent/tru/i in (holder.reagent_list - src))
			//need to remove some wrong reactions
			var/list/loc_data = list()
			loc_data[i.id] = i.data
			loc_data["reagent_id"] = i.id
			to_chat(usr, "[loc_data[i.id]["id"]]")
			if(can_react_with(loc_data))
				react_with(loc_data)

				create_data()//update data
				update_params()
	//-------------------------------

/*
Computes reaction with this reagent and reagent with data
"reagent_id" = id
{
	"id" = id,
	"M"  = M,
	"name" = name,
	...
	see true_reagents.dm
}
*/
/datum/reagent/tru/proc/react_with(var/list/new_data)
	var/new_id = new_data["reagent_id"]
	var/list/my_data = list()
	my_data[id] = data
	my_data["reagent_id"] = id
	var/datum/reagent/tru/R = holder.has_reagent(new_id)
	R.create_data()
	create_data()

	var/list/coefs = calculateCoefficientsAtomaric(new_data, my_data)

	if(is_oxyding_reaction(new_data))//holdere.chem_temp - holder temperature
		if(isOxydizer)
			to_chat(usr, "I am Oxydizer")
			to_chat(usr, "New_data id: [new_data[new_id]["id"]]")
			new_data[new_id]["M"] += M
			new_data[new_id]["formula"] = addFormulasElementsByCoefs(formula, new_data[new_id]["formula"], coefs)
			new_data[new_id]["name"] += " oxyde"
			new_data[new_id]["isSimple"] = 0
			holder.set_data(new_id, new_data[new_id])
			R.update_params()
			var/_moles = count_max_reagent_moles(new_data[new_id]["formula"])//holder.get_reagent_amount(id)
			holder.remove_reagent(id, coefs[id]["need_atoms"]*_moles)
		else
			//not calls. Need fix
			to_chat(usr, "Oxydation")
			to_chat(usr, "New_data id: [new_data[new_id]["id"]]")
			to_chat(usr, "New_data M: [new_data[new_id]["M"]]")
			data["M"] += new_data[new_id]["M"]
			data["formula"] = addFormulasElementsByCoefs(new_data[new_id]["formula"], formula, coefs)
			data["name"] += " oxyde"
			data["isSimple"] = 0
			update_params()
			var/_moles = count_max_reagent_moles(formula)//holder.get_reagent_amount(new_id)
			holder.remove_reagent(new_id, coefs[new_id]["need_atoms"]*_moles)


//counts max moles of substance in holder.
//Example:
//CO2
//C = 6
//O = 12
//Return 6

//note min(6/1, 12/2)
/datum/reagent/tru/proc/count_max_reagent_moles(var/list/formula)
	to_chat(usr, "formula.len = [formula.len]")
	var/all_list[formula.len]
	var/n = 1
	var/pre = 0
	var/i_c = 1
	for(var/i in formula)
		var/list/local_formula = list("[i]" = formula[i])
		to_chat(usr, "i = [i]")
		to_chat(usr, "getIdByFormulaInaccurate(local_formula) = [getIdByFormulaInaccurate(local_formula)]")
		to_chat(usr, "holder reagent amount = [holder.get_reagent_amount(getIdByFormulaInaccurate(local_formula))]")
		all_list[n] = holder.get_reagent_amount(getIdByFormulaInaccurate(local_formula))//list index out of bounds
		n += 1

	if(all_list.len == 1)
		return all_list[1]

	pre = min(all_list[1], all_list[2])
	while(i_c <= all_list.len)
		pre = min(pre, all_list[i_c])
		i_c += 1

	return pre

//Add formulas reagents to this or target reagent formulas reagents
/datum/reagent/tru/proc/add_formulas_elements(var/list/formula_new, var/list/formulaTarget)

	if(formulaTarget.len == 0)
		for(var/i in formula_new)
			if(i in formula)
				formula[i] += formula_new[i]
			else
				formula += list(i = formula_new[i])
	else
		for(var/i in formula_new)
			if(i in formulaTarget)
				formulaTarget[i] += formula_new[i]
			else
				formulaTarget += list(i = formula_new[i])
		return formulaTarget

//Add formulas reagents to this or target reagent formulas reagents
//creates formula:{
//"O" = 1, "C" = 1
//but need "C" = 1, "O" = 2
//}
/datum/reagent/tru/proc/addFormulasElementsByCoefs(var/list/formula_new, var/list/formulaTarget, var/list/coefs)
	for(var/i in formula_new)
		to_chat(usr, "[i] = [formula_new[i]]")
		var/list/local_formula = list("[i]" = formula_new[i])
		var/IdFromFormula = getIdByFormula(local_formula)
		to_chat(usr, "[i]:[IdFromFormula]:[coefs[IdFromFormula]["need_atoms"]]")//O:Oxygen:1 - Work good
		if(i in formulaTarget)
			to_chat(usr, "[formulaTarget[i]] = [coefs[IdFromFormula]["need_atoms"]]")
			formulaTarget[i] = coefs[IdFromFormula]["need_atoms"]
		else
			to_chat(usr, "[formulaTarget]:[i]:[formulaTarget[i]] += list([i] = [coefs[IdFromFormula]["need_atoms"]])")
			formulaTarget += list("[i]" = coefs[IdFromFormula]["need_atoms"])// /list:O:[null] += list(O = 1)
	return formulaTarget

//Returns true if reagent can react with at last one reagent in all_data
//For list of reagent datas
/datum/reagent/tru/proc/canReactWithSome(var/list/all_data)
	var/can_counter = 0

	for(var/i in all_data)
		if(i != "reagent_id")
			if(group == 18)
				break

			if(formula.len == null)
				holder.del_reagent(id)
				break

			if(all_data[i]["formula"] == null)
				holder.del_reagent(all_data[i]["id"])
				continue

			if(formula == all_data[i]["formula"])
				continue

			if(all_data[i]["group"] == 18)
				continue

			if(formula.len != all_data[i]["formula"].len)
				can_counter++
				continue

			if(formula != all_data[i]["formula"])
				can_counter++
				continue

	if(can_counter >= 1)
		return TRUE
	else
		return FALSE

//Returns true if reagent can react with reagent in new_data
//For one reagent data
/datum/reagent/tru/proc/can_react_with(var/list/new_data)
	var/new_id = new_data["reagent_id"]

	if(group == 18)
		return FALSE

	if(formula == null)
		holder.del_reagent(id)//this reagent is empty. Remove it
		return FALSE

	if(new_data[new_id]["formula"] == null)//bad index
		holder.del_reagent(new_data[new_id]["id"])//Target reagent is empty. Remove it
		return FALSE

	if(formula == new_data[new_id]["formula"])
		return FALSE

	if(new_data[new_id]["group"] == 18)
		return FALSE

	if(formula.len != new_data[new_id]["formula"].len)
		return TRUE

	if(formula != new_data[new_id]["formula"])
		return TRUE

//returns true if this reaction is oxyding
//rework!
/datum/reagent/tru/proc/is_oxyding_reaction(var/list/new_data)
	var/new_id = new_data["reagent_id"]
	if(!isOxydizer && new_data[new_id]["isOxydizer"])
		return TRUE
	else if (isOxydizer && !new_data[new_id]["isOxydizer"])
		return TRUE
	else if (!isOxydizer && !new_data[new_id]["isOxydizer"])
		return FALSE
	else if (isOxydizer && new_data[new_id]["isOxydizer"])
		return FALSE
	else
		return FALSE

/*
"reagent_id" = id1
{
	"id" 	  = id1,
	"M"  	  = M1,
	"name" 	  = name1,
	"valence" = valence1,
	...
	see true_reagents.dm
}
and
"reagent_id" = id2
{
	"id" 	  = id2,
	"M"  	  = M2,
	"name"    = name2,
	"valence" = valence2,
	...
	see true_reagents.dm
}
calculates coefficients of two reagents in add. Only add. Nothing harder(

returns:
{
	"id0":[
		"need_atoms" = int,
		...
	],
	"id1":[
		"need_atoms" = int,
		...
	]
}
*/
/proc/calculateCoefficientsAtomaric(var/list/data0, var/list/data1)
	var/list/data = list()
	var/new_id0 = data0["reagent_id"]
	var/new_id1 = data1["reagent_id"]
	var/valence0 = data0[new_id0]["valence"]
	var/valence1 = data1[new_id1]["valence"]

	if(valence0 % valence1 == 0)//4 2 or etc
		/*work*/
		data[new_id1] = list("need_atoms" = valence0/valence1)
		data[new_id0] = list("need_atoms" = 1)

	else if(valence1 % valence0 == 0)//2 4 or etc
		/*work*/
		data[new_id0] = list("need_atoms" = valence1/valence0)
		data[new_id1] = list("need_atoms" = 1)

	else//4 3 or etc
		/*work*/
		data[new_id1] = list("need_atoms" = valence0)
		data[new_id0] = list("need_atoms" = valence1)

	return data//TODO

#undef true
#undef false
