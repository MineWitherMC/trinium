-- Cobble
minetest.register_node("trinium:block_cobble", {
	tiles = {"cobblestone.png"},
	description = S("Cobblestone"),
	groups = {stone = 1, harvested_by_pickaxe = 3},
})
-- Basic Stone
minetest.register_node("trinium:block_stone", {
	tiles = {"stone.png"},
	description = S("Stone"),
	groups = {stone = 1, harvested_by_pickaxe = 4},
	drop = "trinium:block_cobble",
})
minetest.register_alias("mapgen_stone", "trinium:block_stone")

-- Dirt
minetest.register_node("trinium:block_dirt", {
	tiles = {"dirt.png"},
	description = S("Dirt"),
	groups = {soil = 1, harvested_by_shovel = 3},
})
minetest.register_alias("mapgen_dirt", "trinium:block_dirt")

-- Sand
minetest.register_node("trinium:block_sand", {
	tiles = {"sand.png"},
	description = S("Sand"),
	groups = {harvested_by_shovel = 4, falling_node = 1},
})
minetest.register_alias("mapgen_sand", "trinium:block_sand")

-- Grass Block
minetest.register_node("trinium:block_grass_block", {
	tiles = {"grasstop.png", "dirt.png", "dirt.png^grassoverlay.png"},
	description = S("Grass Block"),
	groups = {soil = 1, harvested_by_shovel = 3},
	drop = "trinium:block_dirt",
})
minetest.register_alias("mapgen_dirt_with_grass", "trinium:block_grass_block")

minetest.register_abm({
	label = "grass destruction",
	nodenames = {"trinium:block_grass_block"},
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
			minetest.set_node(pos, {name = "trinium:block_grass_block"})
		end
	end,
})

-- Gravel
minetest.register_node("trinium:block_gravel", {
	tiles = {"gravel.png"},
	description = S("Gravel"),
	groups = {harvested_by_shovel = 2, falling_node = 1},
})
minetest.register_alias("mapgen_gravel", "trinium:block_gravel")

-- Water
trinium.register_fluid("trinium:block_water_source", "trinium:block_water_flowing", S("Water Source"), S("Flowing Water"), "0000DC", {
	alpha = 160,
	liquid_viscosity = 1,
})
minetest.register_alias("mapgen_water_source", "trinium:block_water_source")

-- River Water
trinium.register_fluid("trinium:block_river_water_source", "trinium:block_river_water_flowing", S("River Water Source"), S("Flowing River Water"), "3399EC", {
	alpha = 160,
	liquid_viscosity = 1,
	liquid_range = 2,
})
minetest.register_alias("mapgen_river_water_source", "trinium:block_river_water_source")