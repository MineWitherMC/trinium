-- Non-organic chemicals and pure elements
do
	materials.new_material("water", {
		formula = {{"hydrogen", 2}, {"oxygen", 1}},
		types = {"cell"},
		color = {0, 0, 220},
		description = S"material.water", 
	})

	materials.new_material("m_hydrogen", {
		formula = {{"hydrogen", 2}},
		types = {"cell"},
		description = S"material.hydrogen", 
	})

	materials.new_material("m_nitrogen", {
		formula = {{"nitrogen", 2}},
		types = {"cell"},
		description = S"material.nitrogen", 
	})

	materials.new_material("m_oxygen", {
		formula = {{"oxygen", 2}},
		types = {"cell"},
		description = S"material.oxygen", 
	})

	materials.new_material("m_chlorine", {
		formula = {{"chlorine", 2}},
		types = {"cell"},
		description = S"material.chlorine", 
	})

	materials.new_material("hydrogen_chloride", {
		formula = {{"hydrogen", 1}, {"chlorine", 1}},
		types = {"cell"},
		color = {190, 190, 190},
		description = S"material.hcl", 
	})

	materials.new_material("ammonia", {
		formula = {{"nitrogen", 1}, {"hydrogen", 3}},
		types = {"cell"},
		description = S"material.ammonia", 
	})
	trinium.register_recipe("trinium:chemical_reactor", 
		{"trinium:material_cell_m_hydrogen 3", "trinium:material_cell_m_nitrogen 1"}, 
		{"trinium:material_cell_ammonia 2", "trinium:material_cell_a_empty 2"}, 
		{catalyst = "ipa_compound", time = 24})

	materials.new_material("hydrogen_cyanide", {
		formula = {{"hydrogen", 1}, {"carbon", 1}, {"nitrogen", 1}},
		types = {"cell"},
		color = {180, 100, 215},
		description = S"material.hcn", 
	})
	trinium.register_recipe("trinium:chemical_reactor", 
		{"trinium:material_cell_ammonia 2", "trinium:material_cell_methane 2", 
			"trinium:material_cell_a_empty", "trinium:material_cell_m_oxygen 3"}, 
		{"trinium:material_cell_hydrogen_cyanide 2", "trinium:material_cell_water 6"}, 
		{catalyst = "platinum", time = 35, research = "HydrogenCyanide"})

	materials.new_material("hydrogen_sulfide", {
		formula = {{"hydrogen", 2}, {"sulfur", 1}},
		types = {"cell"},
		color = {180, 100, 0},
		description = S"material.h2s", 
	})
end

-- Organics
do
	materials.new_material("methane", {
		formula = {{"carbon", 1}, {"hydrogen", 4}},
		types = {"cell"},
		color = {240, 90, 240},
		description = S"material.methane", 
	})
	trinium.register_recipe("trinium:cracker", 
		{"trinium:material_cell_fraction_gas 10", "trinium:material_cell_a_empty 11"}, 
		{"trinium:material_cell_methane 12", "trinium:material_cell_ethylene 4", 
			"trinium:material_cell_propene 2", "trinium:material_cell_butane 3"})

	materials.new_material("ethylene", {
		formula = {{"carbon", 2}, {"hydrogen", 4}},
		types = {"cell"},
		color = {190, 175, 235},
		description = S"material.ethene", 
	})

	materials.new_material("propene", {
		formula = {{"carbon", 3}, {"hydrogen", 6}},
		types = {"cell"},
		color = {235, 235, 55},
		description = S"material.propene", 
	})

	materials.new_material("butane", {
		formula = {{"carbon", 4}, {"hydrogen", 10}},
		types = {"cell"},
		color = {160, 90, 0},
		description = S"material.butane", 
	})

	materials.new_material("benzene", {
		formula = {{"carbon", 6}, {"hydrogen", 6}},
		types = {"cell"},
		color = {40, 40, 50},
		description = S"material.benzene", 
	})
	trinium.register_recipe("trinium:cracker", 
		{"trinium:material_cell_fraction_naphtha 10", "trinium:material_cell_a_empty 8"}, 
		{"trinium:material_cell_butane 8", "trinium:material_cell_benzene 5", 
			"trinium:material_cell_toluene 3", "trinium:material_cell_isooctane 2"})

	materials.new_material("toluene", {
		formula = {{"carbon", 7}, {"hydrogen", 8}},
		types = {"cell"},
		color = {90, 85, 50},
		description = S"material.toluene", 
	})

	materials.new_material("isooctane", {
		formula = {{"carbon", 8}, {"hydrogen", 18}},
		types = {"cell"},
		color = {115, 85, 135},
		description = S"material.isooctane", 
	})

	materials.new_material("chloroethane", {
		formula = {{"carbon", 2}, {"hydrogen", 5}, {"chlorine", 1}},
		types = {"cell"},
		color = {190, 235, 230},
		description = S"material.chloroethane", 
	})
	trinium.register_recipe("trinium:chemical_reactor", 
		{"trinium:material_cell_hydrogen_chloride", "trinium:material_cell_ethylene"}, 
		{"trinium:material_cell_chloroethane", "trinium:material_cell_a_empty"}, 
		{time = 12, catalyst = "aluminium_trioxide", research = "HydrocarbonsChlorination"})

	materials.new_material("ethylbenzene", {
		formula = {{"carbon", 8}, {"hydrogen", 10}},
		types = {"cell"},
		color = {240, 240, 240},
		description = S"material.ethylbenzene", 
	})
	trinium.register_recipe("trinium:chemical_reactor", 
		{"trinium:material_cell_chloroethane", "trinium:material_cell_benzene"}, 
		{"trinium:material_cell_ethylbenzene", "trinium:material_cell_hydrogen_chloride"}, 
		{time = 37.5, catalyst = "aluminium_chloride", research = "Ethylbenzene"})
	
	materials.new_material("acetylene", {
		formula = {{"carbon", 2}, {"hydrogen", 2}},
		types = {"cell"},
		color = {255, 255, 240},
		description = S"material.ethyne", 
	})
	trinium.register_recipe("trinium:chemical_reactor", 
		{"trinium:material_cell_methane 4", "trinium:material_cell_m_oxygen 3"}, 
		{"trinium:material_cell_acetylene 2", "trinium:material_cell_water 3", "trinium:material_cell_a_empty 2"}, 
		{time = 15, research = "HydrocarbonsCrack"})
	
	materials.new_material("styrene", {
		formula = {{"carbon", 6}, {"hydrogen", 5}, {"carbon", 1}, {"hydrogen", 1}, {"carbon", 1}, {"hydrogen", 2}},
		types = {"cell"},
		color = {250, 230, 240},
		description = S"material.styrene", 
	})
	trinium.register_recipe("trinium:chemical_reactor", 
		{"trinium:material_cell_ethylbenzene", "trinium:material_cell_a_empty"}, 
		{"trinium:material_cell_styrene", "trinium:material_cell_m_hydrogen"}, 
		{time = 85, catalyst = "chromium_iron_oxide", research = "HydrocarbonsCrack__4"})
	
	materials.new_material("butadiene", {
		formula = {{"carbon", 4}, {"hydrogen", 6}},
		types = {"cell"},
		color = {50, 40, 40},
		description = S"material.butadiene",
	})
	trinium.register_recipe("trinium:chemical_reactor", 
		{"trinium:material_cell_butane", "trinium:material_cell_a_empty 2"}, 
		{"trinium:material_cell_butadiene", "trinium:material_cell_m_hydrogen 2"}, 
		{catalyst = "chromium_aluminium_oxide", time = 40, research = "HydrocarbonsCrack"})
	
	materials.new_material("acrylonitrile", {
		formula = {{"carbon", 1}, {"hydrogen", 2}, {"carbon", 1}, {"hydrogen", 1}, {"carbon", 1}, {"nitrogen", 1}},
		types = {"cell"},
		color = {240, 240, 225},
		description = S"material.acrylonitrile",
	})
	trinium.register_recipe("trinium:chemical_reactor", 
		{"trinium:material_cell_acetylene", "trinium:material_cell_hydrogen_cyanide"}, 
		{"trinium:material_cell_acrylonitrile", "trinium:material_cell_a_empty"}, 
		{time = 55, research = "Acrylonitrile"})
	
	materials.new_material("abs_plastic_compound", {
		formula = {{"styrene", 8}, {"butadiene", 5}, {"acrylonitrile", 5}},
		types = {"cell"},
		color = {250, 230, 210},
		description = S"material.abs.compound",
	})
	trinium.register_recipe("trinium:chemical_reactor", 
		{"trinium:material_cell_styrene 8", "trinium:material_cell_butadiene 4", "trinium:material_cell_acrylonitrile 5"}, 
		{"trinium:material_cell_abs_plastic_compound 17"}, 
		{time = 20, research = "ABSPC"})
	
	materials.new_material("abs_plastic", {
		formula = {{"abs_plastic_compound", 1}},
		types = {"cell", "pulp", "ingot"},
		color = {50, 50, 50},
		description = S"material.abs",
	}):generate_interactions()
	trinium.register_recipe("trinium:polymerizer", 
		{"trinium:material_cell_abs_plastic_compound", "trinium:material_catalyst_aluminium_chloride"}, 
		{"trinium:material_cell_abs_plastic"})
end