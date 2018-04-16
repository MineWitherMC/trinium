-- Cobble
minetest.register_node("trinium:block_cobble", {
	tiles = {"cobblestone.png"},
	description = S"node.cobble",
	groups = {stone = 1, harvested_by_pickaxe = 3},
})
-- Basic Stone
minetest.register_node("trinium:block_stone", {
	tiles = {"stone.png"},
	description = S"node.stone",
	groups = {stone = 1, harvested_by_pickaxe = 3},
	drop = "trinium:block_cobble",
})
minetest.register_alias("mapgen_stone", "trinium:block_stone")
trinium.register_recipe("trinium:furnace", 
	{"trinium:block_cobble"}, 
	{"trinium:block_stone"}, 
	{time = 5})

-- Dirt
minetest.register_node("trinium:block_dirt", {
	tiles = {"dirt.png"},
	description = S"node.dirt",
	groups = {soil = 1, harvested_by_shovel = 3},
})
minetest.register_alias("mapgen_dirt", "trinium:block_dirt")

-- Sand
minetest.register_node("trinium:block_sand", {
	tiles = {"sand.png"},
	description = S"node.sand",
	groups = {harvested_by_shovel = 3, falling_node = 1},
})
minetest.register_alias("mapgen_sand", "trinium:block_sand")

-- Dirt+Grass
minetest.register_node("trinium:block_dirt_with_grass", {
	tiles = {"dirt_grass_top.png", "dirt.png", "dirt.png^dirt_grass_overlay.png"},
	description = S"node.dirt.grass",
	groups = {soil = 1, harvested_by_shovel = 3, grass = 1},
	drop = "trinium:block_dirt",
})
minetest.register_alias("mapgen_dirt_with_grass", "trinium:block_dirt_with_grass")

-- Dirt+Snow
minetest.register_node("trinium:block_dirt_with_snow", {
	tiles = {"dirt_snow_top.png", "dirt.png", "dirt.png^dirt_snow_overlay.png"},
	description = S"node.dirt.snow",
	groups = {soil = 1, harvested_by_shovel = 3, grass = 1},
	drop = "trinium:block_dirt",
})

-- Dirt+Podzol
minetest.register_node("trinium:block_dirt_with_podzol", {
	tiles = {"dirt_podzol_top.png", "dirt.png", "dirt.png^dirt_podzol_overlay.png"},
	description = S"node.dirt.podzol",
	groups = {soil = 1, harvested_by_shovel = 3, grass = 1},
	drop = "trinium:block_dirt",
})

-- Dirt+Dry grass
minetest.register_node("trinium:block_dirt_with_dry_grass", {
	tiles = {"dirt_dry_grass_top.png", "dirt.png", "dirt.png^dirt_dry_grass_overlay.png"},
	description = S"node.dirt.savanna",
	groups = {soil = 1, harvested_by_shovel = 3, grass = 1},
	drop = "trinium:block_dirt",
})

-- Snow
minetest.register_node("trinium:block_snow", {
	tiles = {"snow.png"},
	description = S"node.snow",
	groups = {soil = 1, harvested_by_shovel = 3},
})

-- Snow Layer
minetest.register_node("trinium:block_minisnow", {
	tiles = {"snow.png"},
	description = S"node.snow_layer",
	groups = {soil = 1, harvested_by_shovel = 3},
	paramtype = "light",
	drawtype = "nodebox",
	buildable_to = true,
	node_box = {
		type = "fixed",
		fixed = {{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5}},
	},
})

minetest.register_abm({
	label = "grass destruction",
	nodenames = {"group:grass"},
	interval = 16,
	chance = 16,
	catch_up = false,
	action = function(pos, node)
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		local name = minetest.get_node(above).name
		local nodedef = minetest.registered_nodes[name]
		if name ~= "ignore" and nodedef and not nodedef.sunlight_propagates
				and nodedef.paramtype ~= "light"
				and nodedef.liquidtype == "none" then
			minetest.set_node(pos, {name = "trinium:block_dirt"})
		end
	end,
})

minetest.register_abm({
	label = "grass spread",
	nodenames = {"trinium:block_dirt"},
	interval = 32,
	chance = 32,
	catch_up = false,
	action = function(pos, node)
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		if (minetest.get_node_light(above) or 0) < 12 then return end
		local name = minetest.get_node(above).name
		local nodedef = minetest.registered_nodes[name]
		if name == "ignore" or not nodedef or nodedef.sunlight_propagates or
				nodedef.paramtype == "light" or
				nodedef.liquidtype ~= "none" then
			minetest.set_node(pos, {name = "trinium:block_dirt_with_grass"})
		end
	end,
})

-- Gravel
minetest.register_node("trinium:block_gravel", {
	tiles = {"gravel.png"},
	description = S"node.gravel",
	groups = {harvested_by_shovel = 2, falling_node = 1},
})
minetest.register_alias("mapgen_gravel", "trinium:block_gravel")

-- Water
trinium.register_fluid("trinium:block_water_source", "trinium:block_water_flowing", 
	S("node.fluid.water.source"), S("node.fluid.water.flowing"), 
	"0000DC", {
		alpha = 160,
		liquid_viscosity = 1,
	})
minetest.register_alias("mapgen_water_source", "trinium:block_water_source")

-- River Water
trinium.register_fluid("trinium:block_river_water_source", "trinium:block_river_water_flowing", 
	S("node.fluid.river_water.source"), S("node.fluid.river_water.flowing"), 
	"3399EC", {
		alpha = 160,
		liquid_viscosity = 1,
		liquid_range = 2,
	})
minetest.register_alias("mapgen_river_water_source", "trinium:block_river_water_source")

-- Clay
minetest.register_node("trinium:block_clay", {
	tiles = {"clay_block.png"},
	description = S"node.clay",
	groups = {harvested_by_shovel = 2},
	drop = {
		-- max_items = 3,
		items = {
			{items = {"trinium:material_ball_clay 3"}, rarity = 1}, 
			{items = {"trinium:material_ball_clay"}, rarity = 2}, 
			{items = {"trinium:material_ball_clay"}, rarity = 4},
		},
	},	
})