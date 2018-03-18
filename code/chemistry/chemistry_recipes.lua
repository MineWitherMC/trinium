-- Ammonia
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_hydrogen 3", "trinium:material_cell_nitrogen 1"}, {"trinium:material_cell_ammonia 2", "trinium:material_cell_empty 2"}, {catalyst = "ammonia_catalyst", time = 4})

-- Hydrogen Cyanide
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_ammonia 2", "trinium:material_cell_methane 2", "trinium:material_cell_empty", "trinium:material_cell_oxygen 3"}, {"trinium:material_cell_hydrogen_cyanide 2", "trinium:material_cell_water 6"}, {catalyst = "platinum", time = 35})

-- Acetylene
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_methane 4", "trinium:material_cell_oxygen 3"}, {"trinium:material_cell_acetylene 2", "trinium:material_cell_water 3", "trinium:material_cell_empty 2"}, {time = 15}) -- remake for pyrolysis

-- Acrylonitrile
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_acetylene", "trinium:material_cell_hydrogen_cyanide"}, {"trinium:material_cell_acrylonitrile", "trinium:material_cell_empty"}, {time = 55})

-- Butadiene
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_butane", "trinium:material_cell_empty 2"}, {"trinium:material_cell_butadiene", "trinium:material_cell_hydrogen 2"}, {catalyst = "chromium_aluminium_oxide", time = 40})

-- Chloroethane
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_hydrogen_chloride", "trinium:material_cell_ethylene"}, {"trinium:material_cell_chloroethane", "trinium:material_cell_empty"}, {time = 12})

-- Ethylbenzene
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_chloroethane", "trinium:material_cell_benzene"}, {"trinium:material_cell_ethylbenzene", "trinium:material_cell_hydrogen_chloride"}, {time = 37.5, catalyst = "aluminium_chloride"})

-- Styrene
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_ethylbenzene", "trinium:material_cell_empty"}, {"trinium:material_cell_styrene", "trinium:material_cell_hydrogen"}, {time = 85, catalyst = "chromium_iron_oxide"})

-- ABS Compound
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_styrene 8", "trinium:material_cell_butadiene 4", "trinium:material_cell_acrylonitrile 5"}, {"trinium:material_cell_abs_plastic_compound 17"}, {time = 20})

-- Desulf Oil - Temp
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_raw_oil 14", "trinium:material_cell_hydrogen"}, {"trinium:material_cell_hydrogen_sulfide", "trinium:material_cell_desulfurized_oil 14"}, {time = 35, research = "OilDesulf"})

-- Distillation - Temp
trinium.register_recipe("trinium:chemical_reactor", {"trinium:material_cell_desulfurized_oil 36"}, {"trinium:material_cell_natural_gas 14", "trinium:material_cell_naphtha 12", "trinium:material_cell_kerosene 5", "trinium:material_cell_diesel 5"}, {time = 60, research = "OilDistillation"})