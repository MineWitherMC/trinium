-- Chemical Casing
minetest.register_node("trinium:casing_chemical", {
	tiles = {"chemical_casing.png"},
	description = S("Chemical Casing"),
	groups = {harvested_by_pickaxe = 2},
})

-- Corrosion Proof Casing
minetest.register_node("trinium:casing_corrosive", {
	tiles = {"fluoro_casing.png"},
	description = S("Corrosion Proof Casing"),
	groups = {harvested_by_pickaxe = 2},
})

-- Cupronickel Heating Ring
minetest.register_node("trinium:casing_cupronickel_heating_ring", {
	tiles = {"cupronickel_heating_ring.png"},
	description = S("Cupronickel Heating Ring"),
	groups = {harvested_by_pickaxe = 2},
})