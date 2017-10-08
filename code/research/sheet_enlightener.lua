local research = trinium.res
local S = trinium.S

local enlightener_formspec = ([=[
	size[8,8.5]
	bgcolor[#080808BB;true]
	label[2.5,0;%s]
	background[5,5;1,1;gui_formbg.png;true]
	list[context;catalysts;1.5,0.5;5,1;]
	list[context;parchment;2,2.5;1,1;]
	list[context;lens;3,2;1,1;]
	list[context;chapter_core;3,3;1,1;]
	list[context;output;5,2.5;1,1;]
	list[current_player;main;0,4.5;8,4;]
	button[4.5,1.5;2,1;trinium~enlightener~infuse;%s]
]=]):format(S"Sheet Enlightener", S"Infuse")

minetest.register_node("trinium:machine_sheet_enlightener", {
	tiles = {"research_table_wall.png"},
	description = S"Sheet Enlightener",
	groups = {harvested_by_pickaxe = 1},
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {
		["type"] = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.3, 0.5},
			{-0.5, 0.4, -0.5, 0.5, 0.5, 0.5},
			{-0.5, -0.3, 0.35, 0.5, 0.4, 0.5},
			{-0.5, -0.3, -0.5, -0.35, 0.4, 0.35},
			{0.35, -0.3, -0.5, 0.5, 0.4, 0.35},

			{-0.2, -0.3, -0.2, 0.2, -0.22, 0.2},
			{-0.1, 0.4, -0.2, 0.1, 0.32, 0.2},
			{-0.2, 0.4, -0.1, 0.2, 0.32, 0.1},
			{-0.1, 0.32, -0.1, 0.1, 0.29, 0.1},
		}
	},
	after_place_node = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		trinium.initialize_inventory(inv, {catalysts = 5, parchment = 1, lens = 1, chapter_core = 1, output = 1})
		meta:set_string("infotext", is_constructed and "" or "Multiblock is not assembled!")
	end,
	allow_metadata_inventory_move = function(pos, list1, index1, list2, index2, stacksize, player)
		return 0
	end,
	allow_metadata_inventory_put = function(pos, list, index, stack, player)
		local name,size = stack:get_name(), stack:get_count()
		return ((list == "parchment" and name == "trinium:material_sheet_parchment") or (list == "chapter_core" and minetest.get_item_group(name, "chapter_map") > 0) or
			(list == "lens" and name == "trinium:research_lens") or (list == "catalysts" and ((index == 1 and name == "trinium:material_dust_stardust") or
			(index == 2 and name == "trinium:material_dust_pyrocatalyst") or (index == 3 and name == "trinium:material_dust_bifrost") or (index == 4 and name == "trinium:material_dust_experience") or 
			(index == 5 and name == "trinium:material_dust_imbued_forcirium")))) and size or 0
	end,

	on_receive_fields = function(pos, formname, fields, player)
		if not fields["trinium~enlightener~infuse"] then return end
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()

		-- Crutch for fast checking emptiness of slots
		if inv:room_for_item("catalysts", "trinium:research_casing") then
			cmsg.push_message_player(player, S"Insufficient catalysts!")
			return
		end
		if inv:room_for_item("parchment", "trinium:sheet_parchment 63") then
			cmsg.push_message_player(player, S"Insufficient parchment!")
			return
		end
		local lens, map = inv:get_stack("lens", 1), inv:get_stack("chapter_core", 1)
		if lens:is_empty() then
			cmsg.push_message_player(player, S"Abscent lens!")
			return
		end
		if map:is_empty() then
			cmsg.push_message_player(player, S"Abscent map!")
			return
		end
		if not inv:room_for_item("output", "trinium:research_casing") then
			cmsg.push_message_player(player, S"Extract sheet before continuing!")
			return
		end

		local map_data = research.bound_to_maps[inv:get_stack("chapter_core", 1):get_name():split("___")[2]]
		if not map_data then return end

		for i = 1, 5 do
			local s = inv:get_stack("catalysts", i)
			s:take_item()
			inv:set_stack("catalysts", i, s)
		end

		local lens = inv:get_stack("lens", 1)
		local lmeta = lens:get_meta()
		local map_res = table.exists(map_data, function(x)
			return 	(x.band_material or lmeta:get_string("metal")) == lmeta:get_string("metal") and
					(x.lens_core or lmeta:get_string("gem")) == lmeta:get_string("gem") and
					(x.band_tier or 0) <= lmeta:get_int("tier") and
					(x.band_shape or lmeta:get_string("shape")) == lmeta:get_string("shape")
		end)
		if not map_res then
			cmsg.push_message_player(player, S"Catalysts observed nothing!")
			return
		end

		local s = inv:get_stack("parchment", 1)
		s:take_item(2)
		inv:set_stack("parchment", 1, s)
		local res = map_data[map_res].apply
		inv:set_stack("output", 1, "trinium:research_notes___"..res)
	end,
})

local enlightener_mb = {
	width = 2,
	height_d = 1,
	height_u = 3,
	depth_b = 3,
	depth_f = 0,
	controller = "trinium:machine_sheet_enlightener",
	map = {
		{x = 0, y = -1, z = 3, name = "trinium:research_casing"},
		{x = 0, y = 0, z = 3, name = "trinium:research_casing"},
		{x = 0, y = 1, z = 3, name = "trinium:research_casing"},
		{x = 1, y = 2, z = 3, name = "trinium:research_casing"},
		{x = -1, y = 2, z = 3, name = "trinium:research_casing"},
		{x = 1, y = 3, z = 3, name = "trinium:research_chassis"},
		{x = -1, y = 3, z = 3, name = "trinium:research_chassis"},
		{x = 2, y = 2, z = 3, name = "trinium:research_chassis"},
		{x = -2, y = 2, z = 3, name = "trinium:research_chassis"},
		
		{x = 0, y = -1, z = 2, name = "trinium:research_chassis"},
		{x = 0, y = 0, z = 2, name = "trinium:research_chassis"},
		{x = 0, y = 1, z = 2, name = "trinium:research_chassis"},
		{x = 1, y = -1, z = 2, name = "trinium:research_casing"},
		{x = 1, y = 0, z = 2, name = "trinium:research_casing"},
		{x = 1, y = 1, z = 2, name = "trinium:research_casing"},
		{x = -1, y = -1, z = 2, name = "trinium:research_casing"},
		{x = -1, y = 0, z = 2, name = "trinium:research_casing"},
		{x = -1, y = 1, z = 2, name = "trinium:research_casing"},
		{x = 1, y = 2, z = 2, name = "trinium:research_chassis"},
		{x = -1, y = 2, z = 2, name = "trinium:research_chassis"},
		{x = 1, y = 3, z = 2, name = "trinium:research_chassis"},
		{x = -1, y = 3, z = 2, name = "trinium:research_chassis"},
		{x = -2, y = 3, z = 2, name = "trinium:research_chassis"},
		{x = 2, y = 3, z = 2, name = "trinium:research_chassis"},
		{x = -2, y = 2, z = 2, name = "trinium:research_casing"},
		{x = 2, y = 2, z = 2, name = "trinium:research_casing"},
		{x = 0, y = 2, z = 2, name = "trinium:research_casing"},
		{x = 0, y = 3, z = 2, name = "trinium:research_casing"},

		{x = 0, y = -1, z = 1, name = "trinium:block_reflector_glass"},
		{x = 0, y = 0, z = 1, name = "trinium:block_forcirium_lamp"},
		{x = 0, y = 1, z = 1, name = "trinium:block_reflector_glass"},
		{x = 1, y = -1, z = 1, name = "trinium:research_chassis"},
		{x = 1, y = 0, z = 1, name = "trinium:research_chassis"},
		{x = 1, y = 1, z = 1, name = "trinium:research_chassis"},
		{x = 1, y = 2, z = 1, name = "trinium:research_casing"},
		{x = 1, y = 3, z = 1, name = "trinium:research_casing"},
		{x = -1, y = -1, z = 1, name = "trinium:research_chassis"},
		{x = -1, y = 0, z = 1, name = "trinium:research_chassis"},
		{x = -1, y = 1, z = 1, name = "trinium:research_chassis"},
		{x = -1, y = 2, z = 1, name = "trinium:research_casing"},
		{x = -1, y = 3, z = 1, name = "trinium:research_casing"},
		{x = 2, y = -1, z = 1, name = "trinium:research_casing"},
		{x = 2, y = 0, z = 1, name = "trinium:research_casing"},
		{x = 2, y = 1, z = 1, name = "trinium:research_casing"},
		{x = -2, y = -1, z = 1, name = "trinium:research_casing"},
		{x = -2, y = 0, z = 1, name = "trinium:research_casing"},
		{x = -2, y = 1, z = 1, name = "trinium:research_casing"},
		{x = 0, y = 3, z = 1, name = "trinium:block_reflector_glass"},

		{x = 0, y = -1, z = 0, name = "trinium:research_casing"},
		{x = 0, y = 1, z = 0, name = "trinium:research_chassis"},
		{x = 0, y = 2, z = 0, name = "trinium:research_casing"},
		{x = 0, y = 3, z = 0, name = "trinium:research_casing"},
		{x = 1, y = 2, z = 0, name = "trinium:research_chassis"},
		{x = 1, y = 3, z = 0, name = "trinium:research_chassis"},
		{x = -1, y = 2, z = 0, name = "trinium:research_chassis"},
		{x = -1, y = 3, z = 0, name = "trinium:research_chassis"},
		{x = 2, y = 2, z = 0, name = "trinium:research_casing"},
		{x = 2, y = 3, z = 0, name = "trinium:research_chassis"},
		{x = -2, y = 2, z = 0, name = "trinium:research_casing"},
		{x = -2, y = 3, z = 0, name = "trinium:research_chassis"},
		{x = 1, y = -1, z = 0, name = "trinium:research_casing"},
		{x = -1, y = -1, z = 0, name = "trinium:research_casing"},
		{x = 1, y = 0, z = 0, name = "trinium:research_casing"},
		{x = -1, y = 0, z = 0, name = "trinium:research_casing"},
		{x = 1, y = 1, z = 0, name = "trinium:research_casing"},
		{x = -1, y = 1, z = 0, name = "trinium:research_casing"},
	},
	after_construct = function(pos, is_constructed)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", is_constructed and enlightener_formspec or "")
		meta:set_string("infotext", is_constructed and "" or "Multiblock is not assembled!")
	end,
}

trinium.register_multiblock("sheet enlightener", enlightener_mb)