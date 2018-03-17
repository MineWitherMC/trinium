trinium.register_recipe("trinium:furnace", {"trinium:block_cobble"}, {"trinium:block_stone"}, {time = 5})

-- Fe7(K2O)(Al2O3)
trinium.register_recipe("trinium:blast_furnace", {"trinium:material_ingot_iron 7", "trinium:material_brick_potassiumoxide", "trinium:material_brick_aluminiumoxide"}, {"trinium:material_ingot_ammoniacatalyst 9"}, {melting_point = 2100})

-- CrAlO3
trinium.register_recipe("trinium:blast_furnace", {"trinium:material_brick_aluminiumoxide", "trinium:material_brick_chromiumoxide"}, {"trinium:material_ingot_chromiumaluminiumoxide 2"}, {melting_point = 1554})

-- CrFeO3
trinium.register_recipe("trinium:blast_furnace", {"trinium:material_brick_irontrioxide", "trinium:material_brick_chromiumoxide"}, {"trinium:material_ingot_chromiumironoxide 2"}, {melting_point = 1656})

-- Ammonia
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_hydrogen 3", "trinium:material_cell_nitrogen 1"}, {"trinium:material_cell_ammonia 2", "trinium:material_cell_empty 2"}, {catalyst = "ammoniacatalyst", time = 4})

-- Hydrogen Cyanide
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_ammonia 2", "trinium:material_cell_methane 2", "trinium:material_cell_empty", "trinium:material_cell_oxygen 3"}, {"trinium:material_cell_hydrogencyanide 2", "trinium:material_cell_water 6"}, {catalyst = "platinum", time = 35})

-- Acetylene
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_methane 4", "trinium:material_cell_oxygen 3"}, {"trinium:material_cell_acetylene 2", "trinium:material_cell_water 3", "trinium:material_cell_empty 2"}, {time = 15}) -- remake for pyrolysis

-- Acrylonitrile
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_acetylene", "trinium:material_cell_hydrogencyanide"}, {"trinium:material_cell_acrylonitrile", "trinium:material_cell_empty"}, {time = 55})

-- Butadiene
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_butane", "trinium:material_cell_empty 2"}, {"trinium:material_cell_butadiene", "trinium:material_cell_hydrogen 2"}, {catalyst = "chromiumaluminiumoxide", time = 40})

-- Chloroethane
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_hydrochloride", "trinium:material_cell_ethylene"}, {"trinium:material_cell_chloroethane", "trinium:material_cell_empty"}, {time = 12})

-- Ethylbenzene
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_chloroethane", "trinium:material_cell_benzene"}, {"trinium:material_cell_ethylbenzene", "trinium:material_cell_hydrochloride"}, {time = 37.5, catalyst = "aluminiumchloride"})

-- Styrene
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_ethylbenzene", "trinium:material_cell_empty"}, {"trinium:material_cell_styrene", "trinium:material_cell_hydrogen"}, {time = 85, catalyst = "chromiumironoxide"})

-- ABS Compound
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_styrene 8", "trinium:material_cell_butadiene 4", "trinium:material_cell_acrylonitrile 5"}, {"trinium:material_cell_abs_plastic_compound 17"}, {time = 20})