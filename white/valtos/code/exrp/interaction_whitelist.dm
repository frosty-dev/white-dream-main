#define WHITELISTEXRPFILE "[global.config.directory]/whitelist_exrp.txt"

GLOBAL_LIST(whitelist_exrp)
GLOBAL_PROTECT(whitelist_exrp)

/proc/load_whitelist_exrp()
	GLOB.whitelist_exrp = list()
	for(var/line in world.file2list(WHITELISTEXRPFILE))
		if(!line)
			continue
		if(findtextEx(line,"#",1,2))
			continue
		GLOB.whitelist_exrp += ckey(line)

	if(!GLOB.whitelist_exrp.len)
		GLOB.whitelist_exrp = null

/proc/check_whitelist_exrp(var/ckey)
	if(!GLOB.whitelist_exrp)
		return FALSE
	. = (ckey in GLOB.whitelist_exrp)

#undef WHITELISTEXRPFILE
