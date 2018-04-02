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