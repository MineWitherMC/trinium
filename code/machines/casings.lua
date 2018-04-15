local M = trinium.materials.materials

-- Chemical Casing
minetest.register_node("trinium:casing_chemical", {
	tiles = {"casing_chemical.png"},
	description = S"node.casing.chemical",
	groups = {harvested_by_pickaxe = 2},
})

-- Corrosion Proof Casing
minetest.register_node("trinium:casing_corrosive", {
	tiles = {"casing_corrosive.png"},
	description = S"node.casing.corrosive",
	groups = {harvested_by_pickaxe = 2},
})

-- Cupronickel Heating Ring
minetest.register_node("trinium:casing_cupronickel_heating_ring", {
	tiles = {"casing_cupronickel_heating_ring.png"},
	description = S"node.casing.heating.cupronickel",
	groups = {harvested_by_pickaxe = 2},
})

-- Pulse-Net Casing
minetest.register_node("trinium:casing_pulsenet", {
	tiles = {"casing_pulsenet.png"},
	description = S"node.casing.pulsenet",
	groups = {harvested_by_pickaxe = 2},
})
trinium.register_recipe("trinium:crafting_wizard",
	{"APA PWP APA", A = M.abs:get("plate"), P = M.pulsating_alloy:get("plate"), W = "trinium:module_wireless"},
	{"trinium:casing_pulsenet 2"})

-- Heat-Resistant Casing
minetest.register_node("trinium:casing_heat1", {
	tiles = {"casing_heat_proof1.png"},
	description = S"node.casing.heat.1",
	groups = {harvested_by_pickaxe = 2},
})
trinium.register_recipe("trinium:crafting_wizard",
	{"_B_ BSB _B_", B = "trinium:material_brick", S = "trinium:block_stone"},
	{"trinium:casing_heat1"})