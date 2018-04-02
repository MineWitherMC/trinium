minetest.register_node("trinium:block_fir_log", {
	tiles = {"wood_fir_top.png", "wood_fir_top.png", "wood_fir_bark.png"},
	description = S"node.woodlog.fir",
	groups = {wood = 1, harvested_by_axe = 2},
})

minetest.register_node("trinium:block_fir_leaves", {
	tiles = {"leaves_fir.png"},
	description = S"node.leaves.fir",
	groups = {harvested_by_hand = 3},
	drop = "",
})

minetest.register_decoration({
	name = "tree_fir",
	deco_type = "schematic",
	place_on = {"trinium:block_dirt_with_grass", "trinium:block_dirt_with_snow", "trinium:block_dirt_with_podzol"},
	sidelen = 8,
	noise_params = {
		offset = 0.0,
		scale = 0.0025,
		spread = {x = 250, y = 250, z = 250},
		seed = 2685,
		octaves = 4,
		persist = 0.7
	},
	biomes = {"taiga", "coniferous_forest"},
	y_max = 31000,
	y_min = 1,
	schematic = minetest.get_modpath("trinium") .. "/schematics/tree_fir.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_node("trinium:block_acacia_log", {
	tiles = {"wood_acacia_top.png", "wood_acacia_top.png", "wood_acacia_bark.png"},
	description = S"node.woodlog.acacia",
	groups = {wood = 1, harvested_by_axe = 2},
})

minetest.register_node("trinium:block_acacia_leaves", {
	tiles = {"leaves_acacia.png"},
	description = S"node.leaves.acacia",
	groups = {harvested_by_hand = 3},
	drop = "",
})

minetest.register_decoration({
	name = "acacia_tree",
	deco_type = "schematic",
	place_on = {"trinium:block_dirt_with_dry_grass"},
	sidelen = 8,
	noise_params = {
		offset = 0.0,
		scale = 0.0025,
		spread = {x = 250, y = 250, z = 250},
		seed = 2686,
		octaves = 4,
		persist = 0.7
	},
	biomes = {"savanna"},
	y_max = 31000,
	y_min = 1,
	schematic = minetest.get_modpath("trinium") .. "/schematics/tree_acacia.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_node("trinium:block_maple_log", {
	tiles = {"wood_maple_top.png", "wood_maple_top.png", "wood_maple_bark.png"},
	description = S"node.woodlog.maple",
	groups = {wood = 1, harvested_by_axe = 2},
})
minetest.register_alias("trinium:block_wood", "trinium:block_maple_log")

minetest.register_node("trinium:block_maple_leaves", {
	tiles = {"leaves_maple.png"},
	description = S"node.leaves.maple",
	groups = {harvested_by_hand = 3},
	drop = "",
})
minetest.register_alias("trinium:block_leaves", "trinium:block_maple_leaves")

minetest.register_decoration({
	name = "maple_tree",
	deco_type = "schematic",
	place_on = {"trinium:block_dirt_with_grass"},
	sidelen = 8,
	noise_params = {
		offset = 0.0,
		scale = 0.0025,
		spread = {x = 250, y = 250, z = 250},
		seed = 2687,
		octaves = 4,
		persist = 0.7
	},
	biomes = {"basic_forest", "grassland"},
	y_max = 31000,
	y_min = 1,
	schematic = minetest.get_modpath("trinium") .. "/schematics/tree_maple.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})