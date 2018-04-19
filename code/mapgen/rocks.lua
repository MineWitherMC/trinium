minetest.register_node("trinium:rock_block", {
	tiles = {"rock.png", "rock.png", "invisible_texture.png"},
	description = S"node.rock",
	drawtype = "nodebox",
	node_box = {
		["type"] = "fixed",
		fixed = {{-0.5, -0.5, -0.5, 0.5, -0.42, 0.5}},
	},
	groups = {harvested_by_hand = 3, falling_node = 1, non_silkable = 1, hidden_from_irp = 1},
	drop = "trinium:rock",
	paramtype = "light",
})

minetest.register_craftitem("trinium:rock", {
	inventory_image = "rock.png",
	description = S"item.rock",
})

minetest.register_node("trinium:stick_block", {
	tiles = {"stick.png", "stick.png", "invisible_texture.png"},
	description = S"node.stick",
	drawtype = "nodebox",
	node_box = {
		["type"] = "fixed",
		fixed = {{-0.5, -0.5, -0.5, 0.5, -0.42, 0.5}},
	},
	groups = {harvested_by_hand = 3, falling_node = 1, non_silkable = 1, hidden_from_irp = 1},
	drop = "trinium:stick",
	paramtype = "light",
})

minetest.register_craftitem("trinium:stick", {
	inventory_image = "stick.png",
	description = S"item.stick",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"trinium:block_dirt_with_grass", "trinium:block_dirt_with_snow", 
		"trinium:block_dirt_with_podzol", "trinium:block_dirt_with_dry_grass"},
	sidelen = 8,
	fill_ratio = 0.0065,
	biomes = {"taiga", "coniferous_forest", "basic_forest", "savanna", "grassland"},
	decoration = "trinium:stick_block",
	height = 1,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"trinium:block_dirt_with_grass", "trinium:block_dirt_with_snow", 
		"trinium:block_dirt_with_podzol", "trinium:block_dirt_with_dry_grass"},
	sidelen = 8,
	fill_ratio = 0.008,
	biomes = {"taiga", "coniferous_forest", "basic_forest", "savanna", "grassland"},
	decoration = "trinium:rock_block",
	height = 1,
})