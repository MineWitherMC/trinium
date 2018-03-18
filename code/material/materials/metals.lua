--[[ Basis ]]--
-- Titanium
materials.register_material("titanium", {
	name = S"Titanium",
	color = {220, 160, 240},
	types = {"ingot", "dust"},
	data = {melting_point = 1941},
	formula = "Ti",
})

-- Rhenium
materials.register_material("rhenium", {
	name = S"Rhenium",
	color = {80, 80, 88},
	types = {"ingot", "dust"},
	data = {melting_point = 3459},
	formula = "Re",
})

-- Iron
materials.register_material("iron", {
	name = S"Iron",
	color = {200, 200, 200},
	types = {"dust", "ingot"},
	data = {melting_point = 1811},
	formula = "Fe",
})

-- Platinum
materials.register_material("platinum", {
	name = S"Platinum",
	color = {255, 255, 200},
	types = {"ingot", "catalyst", "dust"},
	data = {melting_point = 2041},
	formula = "Pt",
})

-- Copper
materials.register_material("copper", {
	name = S"Copper",
	color = {255, 100, 0},
	types = {"ingot", "dust"},
	data = {melting_point = 1357},
	formula = "Cu",
})

-- Nickel
materials.register_material("nickel", {
	name = S"Nickel",
	color = {200, 200, 250},
	types = {"ingot", "dust"},
	data = {melting_point = 1728},
	formula = "Ni",
})

--[[ Compounds ]]--
-- Titanium-Rhenium - needed for some lenses and lens presses, obtained via direct alloying of Rhenium and Titanium in AST
materials.register_material("titanium_rhenium", {
	name = S"Titanium-Rhenium",
	color = {190, 180, 200},
	types = {"ingot", "dust"},
	data = {melting_point = 2093},
	formula = "Ti9Re",
})
trinium.register_recipe("trinium:alloysmelting_tower", {"trinium:material_ingot_titanium 9", "trinium:material_ingot_rhenium"}, {"trinium:material_ingot_titanium_rhenium 10"}, {temperature = 3500})

-- Cupronickel - needed for coils, obtained via direct alloying of Copper and Nickel in AST
materials.register_material("cupronickel", {
	name = S"Cupronickel",
	color = {227, 150, 128},
	types = {"ingot", "dust"},
	data = {melting_point = 1543},
	formula = "CuNi",
})
trinium.register_recipe("trinium:alloysmelting_tower", {"trinium:material_ingot_nickel", "trinium:material_ingot_copper"}, {"trinium:material_ingot_cupronickel 2"}, {temperature = 1750})