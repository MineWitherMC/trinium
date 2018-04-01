-- Catalyst Hatch
local catalyst_hatch_formspec = [=[
	size[8,8]
	bgcolor[#080808BB;true]
	background[5,5;1,1;gui_formbg.png;true]
	list[current_name;catalysts;2,0;4,3;]
	list[current_player;main;0,4;8,4;]
	listring[]
]=]

minetest.register_node("trinium:machine_hatch_catalyst", {
	description = S"node.hatch.catalyst",
	tiles = {"casing_chemical.png", "casing_chemical.png", "casing_chemical.png", "casing_chemical.png", "casing_chemical.png", "casing_chemical.png^hatch_overlay.png"},
	groups = {harvested_by_pickaxe = 1},
	paramtype = "light",
	paramtype2 = "facedir",
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		meta:set_string("formspec", catalyst_hatch_formspec)
		trinium.initialize_inventory(inv, {catalysts = 12})
	end,
	allow_metadata_inventory_put = function(pos, list, index, stack, player)
		return minetest.get_item_group(stack:get_name(), "chemical_reactor_catalyst") ~= 0 and 1 or 0
	end,
})

-- Data Access Hatch
local data_hatch_formspec = [=[
	size[8,8]
	bgcolor[#080808BB;true]
	background[5,5;1,1;gui_formbg.png;true]
	list[current_name;patterns;2,0;4,3;]
	list[current_player;main;0,4;8,4;]
	listring[]
]=]

minetest.register_node("trinium:machine_hatch_data", {
	description = S"node.hatch.data",
	tiles = {"casing_chemical.png", "casing_chemical.png", "casing_chemical.png", "casing_chemical.png", "casing_chemical.png", "casing_chemical.png^hatch_overlay.png"},
	groups = {harvested_by_pickaxe = 1},
	paramtype = "light",
	paramtype2 = "facedir",
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		meta:set_string("formspec", data_hatch_formspec)
		trinium.initialize_inventory(inv, {patterns = 12})
	end,
	allow_metadata_inventory_put = function(pos, list, index, stack, player)
		return stack:get_name() == "trinium:recipe_pattern_encoded" and 1 or 0
	end,
})

-- Input Hatch
local input_hatch_formspec = [=[
	size[8,8]
	bgcolor[#080808BB;true]
	background[5,5;1,1;gui_formbg.png;true]
	list[current_name;input;2,0;4,3;]
	list[current_player;main;0,4;8,4;]
	listring[]
]=]

minetest.register_node("trinium:machine_hatch_input", {
	description = S"node.hatch.input",
	tiles = {"casing_corrosive.png", "casing_corrosive.png", "casing_corrosive.png", "casing_corrosive.png", "casing_corrosive.png", "casing_corrosive.png^hatch_overlay.png"},
	groups = {harvested_by_pickaxe = 1},
	paramtype = "light",
	paramtype2 = "facedir",
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		meta:set_string("formspec", input_hatch_formspec)
		trinium.initialize_inventory(inv, {input = 12})
	end,
})

-- Output Hatch
local output_hatch_formspec = [=[
	size[8,8]
	bgcolor[#080808BB;true]
	background[5,5;1,1;gui_formbg.png;true]
	list[current_name;output;2,0;4,3;]
	list[current_player;main;0,4;8,4;]
	listring[]
]=]

minetest.register_node("trinium:machine_hatch_output", {
	description = S"node.hatch.output",
	tiles = {"casing_corrosive.png", "casing_corrosive.png", "casing_corrosive.png", "casing_corrosive.png", "casing_corrosive.png", "casing_corrosive.png^hatch_overlay.png"},
	groups = {harvested_by_pickaxe = 1},
	paramtype = "light",
	paramtype2 = "facedir",
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		meta:set_string("formspec", output_hatch_formspec)
		trinium.initialize_inventory(inv, {output = 12})
	end,
	allow_metadata_inventory_put = function() return 0 end,
})

-- Status Panel
minetest.register_node("trinium:machine_status_panel", {
	description = S"node.machine.status_panel",
	tiles = {"casing_corrosive.png", "casing_corrosive.png", "casing_corrosive.png", "casing_corrosive.png", "casing_corrosive.png", "research_table_wall.png"},
	groups = {harvested_by_pickaxe = 2},
	paramtype = "light",
	paramtype2 = "colorfacedir",
	drop = "trinium:machine_status_panel",
	palette = "palette_status_panel.png",
	drawtype = "nodebox",
	node_box = {
		["type"] = "fixed",
		fixed = {{-0.3, -0.3, 0.5, 0.3, 0.3, 0.35}},
	},
	after_place_node = function(pos)
		local node = minetest.get_node(pos)
		node.param2 = node.param2 + 96
		minetest.set_node(pos, node)
	end,
})