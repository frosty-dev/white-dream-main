GLOBAL_LIST_INIT(dwarf_first, world.file2list("strings/names/dwarf_first.txt"))
GLOBAL_LIST_INIT(dwarf_last, world.file2list("strings/names/dwarf_last.txt"))

/proc/dwarf_name()
	return "[pick(GLOB.dwarf_first)] [pick(GLOB.dwarf_last)]"
// this code feels rancid but is taken straight from the tg file.
