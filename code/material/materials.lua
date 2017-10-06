local materials = trinium.materials

materials.register_material("carton", {
	name = S"Carton",
	color = {160, 112, 64},
	types = {"sheet"},
})
materials.register_material("ink", {
	name = S"Ink", 
	color = {0, 0, 0},
	types = {"cell"},
})
materials.register_material("empty", {
	name = S"Empty", 
	color = {64, 64, 64},
	types = {"cell"},
})
materials.register_material("paper", {
	name = S"Paper",
	color = {224, 224, 224},
	types = {"sheet"},
})
materials.register_material("parchment", {
	name = S"Parchment",
	color = {226, 190, 190},
	types = {"sheet"},
})
materials.register_material("water", {
	name = S"Water",
	color = {0, 0, 220},
	types = {"cell"},
	formula = "H2O",
})
materials.register_material("forcirium", {
	name = S"Forcirium",
	color = {220, 239, 4},
	types = {"ingot", "gem", "dust", "water_cell"},
	data = {melting_point = 2963, water_mix_velocity = 750},
	formula = "FeXCs2F",
})
materials.register_material("diamond", {
	name = S"Diamond",
	color = {200, 255, 255},
	types = {"gem", "dust"},
	formula = "C60",
})
materials.register_material("imbued_forcirium", {
	name = S"Imbued Forcirium",
	color = {220, 155, 0},
	types = {"ingot", "gem", "dust"},
	data = {melting_point = 4107},
	formula = "(FeXCs2Rb)4Nq",
})
materials.register_material("titanium_rhenium", {
	name = S"Titanium-Rhenium",
	color = {190, 180, 200},
	types = {"ingot", "dust"},
	data = {melting_point = 2093},
	formula = "ReTi9",
})
materials.register_material("stardust", {
	name = S"Star",
	color = {170, 210, 0},
	types = {"dust"},
	formula = "He2X",
})
materials.register_material("pyrocatalyst", {
	name = S"Pyrolysis Catalyst",
	color = {255, 134, 0},
	types = {"dust"},
	formula = "(C2Nq)X",
})
materials.register_material("bifrost", {
	name = S"Bifrost",
	color = {50, 0, 95},
	types = {"dust"},
	formula = "X5(IO6)8",
})
materials.register_material("experience", {
	name = S"Experience Catalyst",
	color = {70, 250, 85},
	types = {"dust"},
	formula = "X(PO4)2",
})