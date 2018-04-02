materials.vanilla_elements = {}
local V = materials.vanilla_elements

-- Elements
do
	V.hydrogen = materials.register_element("hydrogen", {
		formula = "H",
		melting_point = 14,
		color = {0, 0, 150},	
	})

	V.carbon = materials.register_element("carbon", {
		formula = "C",
		melting_point = -1,
		color = {16, 16, 16},	
	})

	V.nitrogen = materials.register_element("nitrogen", {
		formula = "N",
		melting_point = -1,
		color = {185, 240, 240},	
	})

	V.oxygen = materials.register_element("oxygen", {
		formula = "O",
		melting_point = 55,
		color = {185, 185, 240},	
	})

	V.fluorine = materials.register_element("fluorine", {
		formula = "F",
		melting_point = 53,
		color = {0, 60, 120},	
	})

	V.aluminium = materials.register_element("aluminium", {
		formula = "Al",
		melting_point = 933,
		color = {128, 200, 240},
	})

	V.phosphorus = materials.register_element("phosphorus", {
		formula = "P",
		melting_point = 317,
		color = {250, 250, 235},	
	})

	V.sulfur = materials.register_element("sulfur", {
		formula = "S",
		melting_point = 386,
		color = {250, 250, 110},	
	})

	V.chlorine = materials.register_element("chlorine", {
		formula = "Cl",
		melting_point = 172,
		color = {0, 120, 145},	
	})

	V.potassium = materials.register_element("potassium", {
		formula = "K",
		melting_point = 336,
		color = {225, 225, 225},	
	})

	V.titanium = materials.register_element("titanium", {
		formula = "Ti",
		melting_point = 1941,
		color = {220, 160, 240},
	})

	V.chromium = materials.register_element("chromium", {
		formula = "Cr",
		melting_point = 2130,
		color = {255, 230, 230},
	})

	V.iron = materials.register_element("iron", {
		formula = "Fe",
		melting_point = 1811,
		color = {200, 200, 200},
	})

	V.nickel = materials.register_element("nickel", {
		formula = "Ni",
		melting_point = 1728,
		color = {200, 200, 255},
	})

	V.copper = materials.register_element("copper", {
		formula = "Cu",
		melting_point = 1357,
		color = {255, 100, 0},
	})

	V.arsenic = materials.register_element("arsenic", {
		formula = "As",
		melting_point = -1,
		color = {135, 165, 144},
	})

	V.rubidium = materials.register_element("rubidium", {
		formula = "Rb",
		melting_point = 312,
		color = {90, 55, 40},	
	})

	V.iodine = materials.register_element("iodine", {
		formula = "I",
		melting_point = -1,
		color = {150, 60, 170},	
	})

	V.silver = materials.register_element("silver", {
		formula = "Ag",
		melting_point = 1234,
		color = {220, 220, 255},	
	})

	V.caesium = materials.register_element("caesium", {
		formula = "Cs",
		melting_point = 301,
		color = {150, 240, 235},	
	})

	V.rhenium = materials.register_element("rhenium", {
		formula = "Re",
		melting_point = 3459,
		color = {80, 80, 88},
	})

	V.platinum = materials.register_element("platinum", {
		formula = "Pt",
		melting_point = 2041,
		color = {255, 255, 200},
	})

	V.naquadah = materials.register_element("naquadah", {
		formula = "Nq",
		melting_point = 6553,
		color = {16, 45, 16},	
	})

	V.extrium = materials.register_element("extrium", {
		formula = "X",
		melting_point = 4200,
		color = {90, 90, 80},	
	})
end

-- Pseudo-Materials
do
	materials.new_material("iodine_acid_ion", {
		formula = {{"iodine", 1}, {"oxygen", 6}},
		types = {},
	})

	materials.new_material("phosphoric_acid_ion", {
		formula = {{"phosphorus", 1}, {"oxygen", 4}},
		types = {},
	})

	materials.new_material("forcirium_induced_ion", {
		formula = {{"iron", 1}, {"extrium", 1}, {"caesium", 2}, {"rubidium", 1}},
		types = {},
	})
end

-- Items that are in materials namespace are also here
do
	minetest.register_craftitem("trinium:material_cell_a_empty", {
		description = S"material.item.empty_cell",
		inventory_image = "(materials_cell.png^[colorize:#404040C0)^materials_cell_overlay.png"
	})

	minetest.register_craftitem("trinium:material_dust_stardust", {
		description = S"material.item.stardust"..minetest.colorize("#CCC", "\nHe2X"),
		inventory_image = "(materials_dust.png^[colorize:#AAD200C0)^materials_dust_overlay.png"
	})
end

-- Finally, materials W/ no formula
do
	materials.new_material("paper", {
		types = {"sheet"},
		color = {224, 224, 224},
		description = S"material.paper",
	})

	materials.new_material("carton", {
		types = {"sheet"},
		color = {160, 112, 64},
		description = S"material.carton",
	})

	materials.new_material("parchment", {
		types = {"sheet"},
		color = {226, 190, 190},
		description = S"material.parchment",
	})

	materials.new_material("ink", {
		types = {"cell"},
		color = {0, 0, 0},
		description = S"material.ink", 
	})

	materials.new_material("oil_raw", {
		types = {"cell"},
		color = {24, 24, 12},
		description = S"material.oil.raw", 
	})

	materials.new_material("oil_desulfurized", {
		types = {"cell"},
		color = {12, 12, 12},
		description = S"material.oil.desulf", 
	})
	trinium.register_recipe("trinium:chemical_reactor", 
		{"trinium:material_cell_oil_raw 14", "trinium:material_cell_m_hydrogen"}, 
		{"trinium:material_cell_hydrogen_sulfide", "trinium:material_cell_oil_desulfurized 14"}, 
		{time = 35, research = "OilDesulf"})
	
	materials.new_material("fraction_gas", {
		types = {"cell"},
		color = {240, 250, 250},
		description = S"material.oil.gas",
	})
	trinium.register_recipe("trinium:chemical_reactor", 
		{"trinium:material_cell_oil_desulfurized 36"}, 
		{"trinium:material_cell_fraction_gas 14", "trinium:material_cell_fraction_naphtha 12", 
			"trinium:material_cell_fraction_kerosene 5", "trinium:material_cell_fraction_diesel 5"}, 
		{time = 60, research = "OilDistillation"})
	
	materials.new_material("fraction_naphtha", {
		types = {"cell"},
		color = {250, 250, 80},
		description = S"material.oil.naphtha",
	})
	
	materials.new_material("fraction_kerosene", {
		types = {"cell"},
		color = {250, 250, 140},
		description = S"material.oil.kerosene",
	})
	
	materials.new_material("fraction_diesel", {
		types = {"cell"},
		color = {128, 128, 64},
		description = S"material.oil.diesel",
	})
end