-- Paper - used in Node.
materials.register_material("paper", {
	name = S"Paper",
	color = {224, 224, 224},
	types = {"sheet"},
})

-- Carton - created via compression of paper, used in better paper usage in Node.
materials.register_material("carton", {
	name = S"Carton",
	color = {160, 112, 64},
	types = {"sheet"},
})

-- Ink - used in Node.
materials.register_material("ink", {
	name = S"Ink", 
	color = {0, 0, 0},
	types = {"cell"},
})

-- Water
materials.register_material("water", {
	name = S"Water",
	color = {0, 0, 220},
	types = {"cell"},
	formula = "H2O",
})