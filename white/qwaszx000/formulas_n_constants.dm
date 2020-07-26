//-----------------Constants-------------------------
#define V_M 22.4//liters/mol
//---------------------------------------------------
/proc/GetSubstanceMol(var/M, var/m)//gram/mol, gram
	return (m/M)

/proc/GetGasVolume(var/M, var/m)//gram/mol, gram
	var/mols = GetSubstanceMol(M, m)
	return (V_M*mols)

//returns 0 if asoc list a == asoc list b
/proc/AsocListCmp(var/list/a, var/list/b)
	if(a.len == b.len)
		var/count = a.len
		for(var/ia in a)
			if(a[ia] == b[ia])
				count -= 1
		return count
	return 1

//returns 0 if keys of a == keys of b
/proc/AsocListCmpInaccurate(var/list/a, var/list/b)
	if(a.len == b.len)
		var/count = a.len
		for(var/ia in a)
			if(b[ia] != null)
				count -= 1
		return count
	return 1
