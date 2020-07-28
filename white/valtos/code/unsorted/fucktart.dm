/client/proc/raspidoars()
	set name = " ? Raspidoars"
	set category = "Дбг"

	var/turf/where = get_turf(mob)
	if(!where)
		return

	var/rss = input("Raspidoars range (Tiles):") as num

	for(var/atom/A in spiral_range(rss, where))
		var/matrix/M = A.transform
		//A.transform = M.Scale(rand(1, 2), rand(1, 2))
		A.transform = M.Translate(rand(-2, 2), rand(-2, 2))
		A.transform = M.Turn(rand(0, 90))
		A.color = "#[random_short_color()]"
		animate(A, color = color_matrix_rotate_hue(rand(0, 360)), time = 200, loop = -1, easing = CIRCULAR_EASING)

