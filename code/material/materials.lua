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
materials.register_material("titanium_rhenium", {
	name = S"Titanium-Rhenium",
	color = {190, 180, 200},
	types = {"ingot", "dust"},
	data = {melting_point = 2093},
	formula = "ReTi9",
})