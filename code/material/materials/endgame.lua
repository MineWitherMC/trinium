-- Stardust - needed for Sheet Enlightener, generated from Supernova Dynamo on material mode {TODO}
materials.register_material("stardust", {
	name = S"Star",
	color = {170, 210, 0},
	types = {"dust"},
	formula = "He2X",
})

-- Pyrolysis Catalyst - needed for SE, done by mixing {TODO}
materials.register_material("pyrocatalyst", {
	name = S"Pyrolysis Catalyst",
	color = {255, 134, 0},
	types = {"dust"},
	formula = "(C2Nq)X",
})

-- Bifrost - needed for SE, generated in chemical reactor with Shimmering Catalyst via Extrium and Iodine Acid {TODO}
materials.register_material("bifrost", {
	name = S"Bifrost",
	color = {50, 0, 95},
	types = {"dust"},
	formula = "X5(IO6)6",
})

-- Experience Catalyst - needed for SE, generated via cracking Liquid XP with Extrium {TODO}
materials.register_material("experience", {
	name = S"Experience Catalyst",
	color = {70, 250, 85},
	types = {"dust"},
	formula = "X(PO4)2",
})

-- Imbued Forcirium - needed for SE and some lenses, obtained via Reverse Inducing Forcirium with usage of Rubidium and Naquadah {TODO}
materials.register_material("imbued_forcirium", {
	name = S"Imbued Forcirium",
	color = {220, 155, 0},
	types = {"ingot", "gem", "dust"},
	data = {melting_point = 4107},
	formula = "(FeXCs2Rb)4Nq",
})

-- Parchment - needed for SE, obtained {TODO}
materials.register_material("parchment", {
	name = S"Parchment",
	color = {226, 190, 190},
	types = {"sheet"},
})

-- Forcirium - obtained in Warp Tunnel {TODO}, used in lots of applications
materials.register_material("forcirium", {
	name = S"Forcirium",
	color = {220, 239, 4},
	types = {"ingot", "gem", "dust", "water_cell"},
	data = {melting_point = 2963, water_mix_velocity = 750},
	formula = "FeXCs2F",
})