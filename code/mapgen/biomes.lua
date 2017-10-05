minetest.register_biome{
	name = "plains",
	node_top = "mapgen_dirt_with_grass",
	node_filler = "mapgen_dirt",
	node_water = "mapgen_water_source",
	node_dust = "air",
	node_dust_water = "mapgen_water_source",

	depth_top = 1,
	depth_filler = 3,
	height_min = 0,
	height_max = 30,
	heat_point = 55,
	humidity_point = 38,
}

minetest.register_biome{
	name = "mountains",
	node_top = "mapgen_dirt_with_grass",
	node_filler = "mapgen_dirt",
	node_water = "mapgen_water_source",
	node_dust = "air",
	node_dust_water = "mapgen_water_source",

	depth_top = 1,
	depth_filler = 3,
	height_min = 0,
	height_max = 75,
	heat_point = 40,
	humidity_point = 50,
}

minetest.register_biome{
	name = "desert",
	node_top = "mapgen_sand",
	node_filler = "mapgen_sand",
	node_water = "mapgen_water_source",
	node_dust = "air",
	node_dust_water = "mapgen_water_source",

	depth_top = 1,
	depth_filler = 3,
	height_min = 0,
	height_max = 30,
	heat_point = 90,
	humidity_point = 25,
}

minetest.register_biome{
	name = "jungle",
	node_top = "mapgen_dirt_with_grass",
	node_filler = "mapgen_sand",
	node_water = "mapgen_water_source",
	node_dust = "air",
	node_dust_water = "mapgen_water_source",

	depth_top = 1,
	depth_filler = 5,
	height_min = 0,
	height_max = 30,
	heat_point = 90,
	humidity_point = 90,
}