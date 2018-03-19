--[[ Base Materials ]]--
-- Raw Oil - to be desulfurized. Obtained from several processes.
materials.register_material("raw_oil", {
	name = S"Raw Oil",
	color = {24, 24, 12},
	types = {"cell"},
	data = {},
})

-- Desulfurized oil - obtained from Raw Oil, to be distilled.
materials.register_material("desulfurized_oil", {
	name = S"Desulfurized Oil",
	color = {12, 12, 12},
	types = {"cell"},
	data = {},
})
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_raw_oil 14", "trinium:material_cell_hydrogen"}, {"trinium:material_cell_hydrogen_sulfide", "trinium:material_cell_desulfurized_oil 14"}, {time = 35, research = "OilDesulf"})

--[[ After distillation ]]--
-- Natural Gas - lightest fraction of Desulf. Oil. Can be cracked or burned.
materials.register_material("natural_gas", {
	name = S"Natural Gas",
	color = {240, 250, 250},
	types = {"cell"},
	data = {},
})
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_desulfurized_oil 36"}, {"trinium:material_cell_natural_gas 14", "trinium:material_cell_naphtha 12", "trinium:material_cell_kerosene 5", "trinium:material_cell_diesel 5"}, {time = 60, research = "OilDistillation"})

-- Naphtha - lighter fraction of Desulf. Oil. Can be cracked or burned.
materials.register_material("naphtha", {
	name = S"Naphtha",
	color = {250, 250, 80},
	types = {"cell"},
	data = {},
})

-- Kerosene - heavier fraction of Desulf. Oil. Can be cracked or burned.
materials.register_material("kerosene", {
	name = S"Kerosene",
	color = {250, 250, 140},
	types = {"cell"},
	data = {},
})

-- Diesel - heaviest fraction of Desulf. Oil. Can be cracked or burned.
materials.register_material("diesel", {
	name = S"Diesel",
	color = {128, 128, 64},
	types = {"cell"},
	data = {},
})

--[[ After cracking ]]--
-- Methane - has a wide usage. Obtained from cracking Natural Gas.
materials.register_material("methane", {
	name = S"Methane",
	color = {240, 90, 240},
	types = {"cell"},
	data = {},
	formula = "CH4",
})
trinium.register_recipe("trinium:cracker", {"trinium:material_cell_natural_gas 10", "trinium:material_cell_empty 11"}, {"trinium:material_cell_methane 12", "trinium:material_cell_ethylene 4", "trinium:material_cell_propene 2", "trinium:material_cell_butane 3"}, {})


-- Ethylene - has a wide usage. Obtained from cracking Natural Gas.
materials.register_material("ethylene", {
	name = S"Ethylene",
	color = {190, 175, 235},
	types = {"cell"},
	data = {},
	formula = "C2H4",
})

-- Propene - has a wide usage. Obtained from cracking Natural Gas.
materials.register_material("propene", {
	name = S"Propene",
	color = {235, 235, 55},
	types = {"cell"},
	data = {},
	formula = "C3H6",
})

-- Butane - used for Butadiene production. Obtained from cracking Naphtha or Natural Gas.
materials.register_material("butane", {
	name = S"Butane",
	color = {160, 90, 0},
	types = {"cell"},
	data = {},
	formula = "C4H10",
})

-- Benzene - has a wide usage. Obtained from cracking Naphtha.
materials.register_material("benzene", {
	name = S"Benzene",
	color = {40, 40, 50},
	types = {"cell"},
	data = {},
	formula = "C6H6",
})
trinium.register_recipe("trinium:cracker", {"trinium:material_cell_naphtha 10", "trinium:material_cell_empty 8"}, {"trinium:material_cell_butane 8", "trinium:material_cell_benzene 5", "trinium:material_cell_toluene 3", "trinium:material_cell_octane 2"}, {})

-- Toluene - has a wide usage. Obtained from cracking Naphtha.
materials.register_material("toluene", {
	name = S"Toluene",
	color = {90, 85, 50},
	types = {"cell"},
	data = {},
	formula = "C7H8",
})

-- Octane - used for enriching Gasoline {TODO}. Obtained from cracking Naphtha.
materials.register_material("octane", {
	name = S"Octane",
	color = {115, 85, 135},
	types = {"cell"},
	data = {},
	formula = "C8H18",
})

--[[ Intermediary Products ]]--
-- Ethylbenzene - used for Styrene production. Obtained from chemical process.
materials.register_material("ethylbenzene", {
	name = S"Ethylbenzene",
	color = {240, 240, 240},
	types = {"cell"},
	data = {},
	formula = "C8H10",
})
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_chloroethane", "trinium:material_cell_benzene"}, {"trinium:material_cell_ethylbenzene", "trinium:material_cell_hydrogen_chloride"}, {time = 37.5, catalyst = "aluminium_chloride"})

-- Chloroethane - used for Styrene production. Obtained via chlorinating Ethane {TODO} or Ethylene.
materials.register_material("chloroethane", {
	name = S"Chloroethane",
	color = {190, 235, 230},
	types = {"cell"},
	data = {},
	formula = "C2H5Cl",
})
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_hydrogen_chloride", "trinium:material_cell_ethylene"}, {"trinium:material_cell_chloroethane", "trinium:material_cell_empty"}, {time = 12})

-- Acetylene - used in portable fires {TODO} and ABS production. Obtained from dehydrating Methane via Oxygen.
materials.register_material("acetylene", {
	name = S"Acetylene",
	color = {240, 240, 240},
	types = {"cell"},
	data = {},
	formula = "C2H2",
})
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_methane 4", "trinium:material_cell_oxygen 3"}, {"trinium:material_cell_acetylene 2", "trinium:material_cell_water 3", "trinium:material_cell_empty 2"}, {time = 15}) -- remake for pyrolysis

--[[ Advanced Products ]]--
-- Styrene - used for ABS, Polystyrene, SBR. Obtained from dehydration of Ethylbenzene.
materials.register_material("styrene", {
	name = S"Styrene",
	color = {250, 230, 210},
	types = {"cell"},
	data = {},
	formula = "C8H8",
})
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_ethylbenzene", "trinium:material_cell_empty"}, {"trinium:material_cell_styrene", "trinium:material_cell_hydrogen"}, {time = 85, catalyst = "chromium_iron_oxide"})

-- Butadiene - used for ABS and SBR. Obtained from dehydration of Butane.
materials.register_material("butadiene", {
	name = S"Butadiene",
	color = {50, 40, 40},
	types = {"cell"},
	data = {},
	formula = "C4H6",
})
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_butane", "trinium:material_cell_empty 2"}, {"trinium:material_cell_butadiene", "trinium:material_cell_hydrogen 2"}, {catalyst = "chromium_aluminium_oxide", time = 40})

-- Acrylonitrile - used for ABS. Obtained from chemical process.
materials.register_material("acrylonitrile", {
	name = S"Acrylonitrile",
	color = {240, 240, 225},
	types = {"cell"},
	data = {},
	formula = "C3H3N",
})
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_acetylene", "trinium:material_cell_hydrogen_cyanide"}, {"trinium:material_cell_acrylonitrile", "trinium:material_cell_empty"}, {time = 55})

-- ABSPC - used for ABS, obtained from some organic chemicals.
materials.register_material("abs_plastic_compound", {
	name = S"ABS Plastic Compound",
	color = {250, 230, 210},
	types = {"cell"},
	data = {},
	formula = "(C8H8)8(C4H6)3(C3H3N)5",
})
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_styrene 8", "trinium:material_cell_butadiene 4", "trinium:material_cell_acrylonitrile 5"}, {"trinium:material_cell_abs_plastic_compound 17"}, {time = 20})

--[[ Ready for usage ]]--
-- ABS Plastic - useful middlegame material. Obtained via polymerizing ABSPC.
materials.register_material("abs_plastic", {
	name = S"ABS Plastic",
	color = {100, 100, 100},
	types = {"ingot", "pulp", "cell"},
	data = {},
	formula = "((C8H8)8(C4H6)3(C3H3N)5)n",
})
trinium.register_recipe("trinium:polymerizer", {"trinium:material_cell_abs_plastic_compound", "trinium:material_catalyst_aluminium_chloride"}, {"trinium:material_cell_abs_plastic"}, {})