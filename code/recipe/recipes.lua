trinium.register_recipe("trinium:furnace", {"trinium:block_cobble"}, {"trinium:block_stone"}, {time = 5})

-- Fe7(K2O)(Al2O3)
trinium.register_recipe("trinium:alloysmelting_tower", {"trinium:material_ingot_iron 7", "trinium:material_brick_potassium_oxide", "trinium:material_brick_aluminium_oxide"}, {"trinium:material_ingot_ammonia_catalyst 9"}, {temperature = 2100})

-- CrAlO3
trinium.register_recipe("trinium:alloysmelting_tower", {"trinium:material_brick_aluminium_oxide", "trinium:material_brick_chromium_oxide"}, {"trinium:material_ingot_chromium_aluminium_oxide 2"}, {temperature = 1554})

-- CrFeO3
trinium.register_recipe("trinium:alloysmelting_tower", {"trinium:material_brick_iron_trioxide", "trinium:material_brick_chromium_oxide"}, {"trinium:material_ingot_chromium_iron_oxide 2"}, {temperature = 1656})