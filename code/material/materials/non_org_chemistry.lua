--[[ Base ]]--
-- Hydrogen
materials.register_material("hydrogen", {
	name = S"Hydrogen",
	color = {0, 0, 150},
	types = {"cell"},
	data = {},
	formula = "H2",
})

-- Nitrogen
materials.register_material("nitrogen", {
	name = S"Nitrogen",
	color = {185, 240, 240},
	types = {"cell"},
	data = {},
	formula = "N2",
})

-- Oxygen
materials.register_material("oxygen", {
	name = S"Oxygen",
	color = {185, 185, 240},
	types = {"cell"},
	data = {},
	formula = "O2",
})

-- Chlorine
materials.register_material("chlorine", {
	name = S"Chlorine",
	color = {0, 125, 145},
	types = {"cell"},
	data = {},
	formula = "Cl2",
})

--[[ Compounds ]]--
-- Hydrogen Chloride
materials.register_material("hydrogen_chloride", {
	name = S"Hydrogen Chloride",
	color = {190, 190, 190},
	types = {"cell"},
	data = {},
	formula = "HCl",
})

-- Ammonia
materials.register_material("ammonia", {
	name = S"Ammonia",
	color = {200, 145, 200},
	types = {"cell"},
	data = {},
	formula = "NH3",
})
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_hydrogen 3", "trinium:material_cell_nitrogen 1"}, {"trinium:material_cell_ammonia 2", "trinium:material_cell_empty 2"}, {catalyst = "ammonia_catalyst", time = 4})

-- Hydrogen Cyanide
materials.register_material("hydrogen_cyanide", {
	name = S"Hydrogen Cyanide",
	color = {180, 100, 215},
	types = {"cell"},
	data = {},
	formula = "HCN",
})
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_ammonia 2", "trinium:material_cell_methane 2", "trinium:material_cell_empty", "trinium:material_cell_oxygen 3"}, {"trinium:material_cell_hydrogen_cyanide 2", "trinium:material_cell_water 6"}, {catalyst = "platinum", time = 35})

-- Hydrogen Sulfide
materials.register_material("hydrogen_sulfide", {
	name = S"Hydrogen Sulfide",
	color = {180, 100, 0},
	types = {"cell"},
	data = {},
	formula = "H2S",
})