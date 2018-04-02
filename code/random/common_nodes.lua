-- Reflector Glass
minetest.register_node("trinium:block_reflector_glass", {
	tiles = {"reflector_glass.png"},
	description = S"node.reflector_glass",
	drawtype = "glasslike",
	sunlight_propagades = true,
	paramtype = "light",
	groups = {harvested_by_pickaxe = 1},
	light_source = 7,
})

-- Lamp Frame
minetest.register_node("trinium:block_lamp_frame", {
	tiles = {"lamp_frame_32.png"},
	description = S"node.lamp.frame",
	drawtype = "glasslike",
	groups = {harvested_by_pickaxe = 2},
})

-- Forcirium Lamp
minetest.register_node("trinium:block_forcirium_lamp", {
	tiles = {
		{
			name = "(lamp_core.png^[colorize:#DCEF04C0)^lamp_frame.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 32,
				aspect_h = 32,
				length = 2.5,
			},
		}
	},
	description = S"node.lamp.forcirium",
	drawtype = "glasslike",
	light_source = 14,
	groups = {harvested_by_pickaxe = 1},
})