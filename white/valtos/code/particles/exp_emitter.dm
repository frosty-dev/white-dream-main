/particles/exp_emitter
	icon = 'white/valtos/icons/particles.dmi'
	icon_state = "exp_emitter"
	width = 100
	height = 500
	count = 1000
	spawning = 40
	lifespan = 15
	fade = 10
	grow = -0.01
	velocity = list(0, 0)
	position = generator("circle", 0, 16, NORMAL_RAND)
	drift = generator("vector", list(0, -0.2), list(0, 0.2))
	gravity = list(0, 0.95)
	scale = generator("vector", list(0.3, 0.3), list(1,1), NORMAL_RAND)
	rotation = 30
	spin = generator("num", -20, 20)

/obj/exp_emitter
	particles = new/particles/exp_emitter
