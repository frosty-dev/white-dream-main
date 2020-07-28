/area/engine/engineering/poweralert(state, source)
	if (state != poweralm)
		investigate_log("имеет проблемы с электроэнергией!", INVESTIGATE_SINGULO)
	..()
