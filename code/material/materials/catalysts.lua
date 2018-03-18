--[[ Catalyst Components ]]--
-- Aluminium Trioxide
materials.register_material("aluminium_oxide", {
	name = S"Aluminium Trioxide",
	color = {160, 160, 100},
	types = {"dust", "brick"},
	data = {},
	formula = "Al2O3",
})

-- Iron Trioxide
materials.register_material("iron_trioxide", {
	name = S"Iron Trioxide",
	color = {100, 100, 155},
	types = {"dust", "brick"},
	data = {},
	formula = "Fe2O3",
})

-- Chromium(III) Oxide
materials.register_material("chromium_oxide", {
	name = S"Chromium Trioxide",
	color = {160, 100, 100},
	types = {"dust", "brick"},
	data = {},
	formula = "Cr2O3",
})

-- Potassium Oxide
materials.register_material("potassium_oxide", {
	name = S"Potassium Oxide",
	color = {250, 250, 235},
	types = {"dust", "brick"},
	data = {},
	formula = "K2O",
})

--[[ Actual Catalysts ]]--
-- Aluminium Trichloride - used in production of ethylbenzene
materials.register_material("aluminium_chloride", {
	name = S"Aluminium Trichloride",
	color = {100, 160, 160},
	types = {"dust", "catalyst", "brick"},
	data = {},
	formula = "AlCl3",
})

-- Chromium-Aluminium Trioxide - used in production of butadiene
materials.register_material("chromium_aluminium_oxide", {
	name = S"Chromium-Aluminium Oxide",
	color = {230, 225, 195},
	types = {"catalyst", "ingot"},
	data = {},
	formula = "CrAlO3",
})
trinium.register_recipe("trinium:alloysmelting_tower", {"trinium:material_brick_aluminium_oxide", "trinium:material_brick_chromium_oxide"}, {"trinium:material_ingot_chromium_aluminium_oxide 2"}, {temperature = 1554})

-- Chromium-Iron Trioxide - used in production of styrene
materials.register_material("chromium_iron_oxide", {
	name = S"Chromium-Iron Oxide",
	color = {230, 205, 195},
	types = {"catalyst", "ingot"},
	data = {},
	formula = "CrFeO3",
})
trinium.register_recipe("trinium:alloysmelting_tower", {"trinium:material_brick_iron_trioxide", "trinium:material_brick_chromium_oxide"}, {"trinium:material_ingot_chromium_iron_oxide 2"}, {temperature = 1656})

-- IPA Compound - used in production of Ammonia
materials.register_material("ammonia_catalyst", {
	name = S"IPA Compound",
	color = {205, 210, 180},
	types = {"ingot", "catalyst"},
	data = {},
	formula = "Fe7(K2O)(Al2O3)",
})
trinium.register_recipe("trinium:alloysmelting_tower", {"trinium:material_ingot_iron 7", "trinium:material_brick_potassium_oxide", "trinium:material_brick_aluminium_oxide"}, {"trinium:material_ingot_ammonia_catalyst 9"}, {temperature = 2100})