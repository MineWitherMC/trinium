local research = trinium.res
local S = trinium.S

local randomizer_formspec = ([=[
	size[8,6]
	bgcolor[#080808BB;true]
	background[5,5;1,1;gui_formbg.png;true]
	list[context;rhenium-titanium;0.5,0.5;1,1;]
	list[context;upgrade;1.5,0.5;1,1;]
	list[context;press;6.5,0.5;1,1;]
	list[current_player;main;0,2;8,4;]
	button[3.5,0.5;2,1;trinium~research~assemble_press;%s]
]=]):format(S"Assemble")
local tire_amount = 16

minetest.register_node("trinium:press_randomizer", {
	tiles = {"research_chassis.png"},
	description = S"Press Randomizer",
	groups = {harvested_by_pickaxe = 2},
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

			{-0.15, -0.3, -0.15, 0.15, -0.22, -0.1},
			{-0.15, -0.3, 0.15, 0.15, -0.22, 0.1},
			{-0.025, -0.3, -0.1, 0.025, -0.18, 0.1},
			{-0.15, 0.3, -0.15, 0.15, 0.22, -0.1},
			{-0.15, 0.3, 0.15, 0.15, 0.22, 0.1},
			{-0.025, 0.3, -0.1, 0.025, 0.18, 0.1},
		}
	},
	after_place_node = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		trinium.initialize_inventory(inv, {["rhenium-titanium"] = 1, upgrade = 1, press = 1})
		meta:set_string("infotext", is_constructed and "" or "Multiblock is not assembled!")
	end,
	allow_metadata_inventory_move = function(pos, list1, index1, list2, index2, stacksize, player)
		return 0
	end,
	allow_metadata_inventory_put = function(pos, list, index, stack, player)
		local name,size = stack:get_name(), stack:get_count()
		return ((list == "rhenium-titanium" and name == "trinium:ingot_titanium_rhenium") or (list == "upgrade" and minetest.get_item_group(name, "lens_upgrade") ~= 0)) and size or 0
	end,
	on_receive_fields = function(pos, formname, fields, player)
		if not fields["trinium~research~assemble_press"] then return end

		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local tire, upgrade, press1 = inv:get_stack("rhenium-titanium", 1), inv:get_stack("upgrade", 1), inv:get_stack("press", 1)
		if tire:get_count() < tire_amount then
			cmsg.push_message_player(player, S"Too few Titanium-Rhenium!")
			return
		end
		if not press1:is_empty() then
			cmsg.push_message_player(player, S"Extract press before continuing!")
			return
		end

		local press = ItemStack("trinium:lens_band_press")
		local pressmeta = press:get_meta()
		local upg = minetest.get_item_group(upgrade:get_name(), "lens_upgrade") + 1
		local shape = table.remap(table.filter(research.lens_forms.shapes, function(x) return research.lens_forms.shapes_by_mintier[x] <= upg end))
		local gem, metal, shape, tier =
			math.random(research.lens_forms.min_gem, research.lens_forms.max_gem), math.random(research.lens_forms.min_metal, research.lens_forms.max_metal),
			shape[math.random(1, #shape)], math.random(upg, research.lens_forms.max_tier)
		pressmeta:set_int("gem", gem)
		pressmeta:set_int("metal", metal)
		pressmeta:set_string("shape", shape)
		pressmeta:set_int("tier", tier)

		pressmeta:set_string("description", S("Band Press\nGem required: @1\nMetal Required: @2\nShape: @3\nTier: @4", gem, metal, S(shape), tier))
		tire:take_item(16)
		inv:set_stack("rhenium-titanium", 1, tire)
		inv:set_stack("press", 1, press)
		inv:set_stack("upgrade", 1, "")
	end,
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		if minetest.get_meta(pos):get_int("assembled") == 0 then
			cmsg.push_message_player(player, "Multiblock is not assembled!")
		end
	end,
})

trinium.register_multiblock("press randomizer", {
	width = 0,
	height_d = 0,
	height_u = 1,
	depth_b = 1,
	depth_f = 0,
	controller = "trinium:press_randomizer",
	activator = function(rg)
		local ctrl = table.exists(rg.region, function(x) return x.x == 0 and x.y == 1 and x.z == 1 and x.name == "trinium:research_node" end)
		return ctrl and minetest.get_meta(rg.region[ctrl].actual_pos):get_int("assembled") == 1
	end,
	after_construct = function(pos, is_constructed)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", is_constructed and randomizer_formspec or "")
		meta:set_string("infotext", is_constructed and "" or "Multiblock is not assembled!")
	end,
})