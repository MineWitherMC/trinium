minetest.register_node("trinium:block_signal_lamp", {
    description = S"node.signal_lamp",
    tiles = {
        {name = "lamp_core_single.png"},
    },
    overlay_tiles = {
        {name = "lamp_frame_single.png", color = "white"},
    },
    color = "yellow",
    paramtype2 = "color",
    palette = "palette_signal_lamp.png",
    groups = {harvested_by_pickaxe = 2, signals_element = 1, signals_use_key = 2},
    after_place_node = trinium.rebuild_signals,
    after_dig_node = trinium.rebuild_signals,
	-- drawtype = "glasslike",
	light_source = 14,
})