local research = trinium.res
local S = trinium.S

local randomizer_formspec = ([=[
	size[8,6.7]
	bgcolor[#080808BB;true]
	background[5,5;1,1;gui_formbg.png;true]
	item_image[0.5,0;1,1;trinium:material_ingot_rhenium_alloy]
	list[context;rhenium_alloy;0.5,1;1,1;]
	image[1.5,0;1,1;research_lens_upgrade_2.png^[brighten]
	list[context;upgrade;1.5,1;1,1;]
	image[6.5,0;1,1;research_lens_press.png^[brighten]
	list[context;press;6.5,1;1,1;]
	list[current_player;main;0,2.7;8,4;]
	button[3.5,1;2,1;trinium~research~assemble_press;%s]
]=]):format(S"gui.press_randomizer.assemble")
local press_cost = 8

minetest.register_node("trinium:machine_press_randomizer", {
	stack_max = 1,
	tiles = {"research_chassis.png"},
	description = S"node.machine.press_randomizer",
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
			{-0.15, 0.4, -0.15, 0.15, 0.32, -0.1},
			{-0.15, 0.4, 0.15, 0.15, 0.32, 0.1},
			{-0.025, 0.4, -0.1, 0.025, 0.28, 0.1},
		}
	},
	after_place_node = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		trinium.initialize_inventory(inv, {rhenium_alloy = 1, upgrade = 1, press = 1})
	end,
	allow_metadata_inventory_move = function(pos, list1, index1, list2, index2, stacksize, player)
		return 0
	end,
	allow_metadata_inventory_put = function(pos, list, index, stack, player)
		local name,size = stack:get_name(), stack:get_count()
		return ((list == "rhenium_alloy" and name == "trinium:material_ingot_rhenium_alloy") or 
				(list == "upgrade" and minetest.get_item_group(name, "lens_upgrade") ~= 0)) and size or 0
	end,
	on_receive_fields = function(pos, formname, fields, player)
		if not fields["trinium~research~assemble_press"] then return end

		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local alloy, upgrade, press1 = 
				inv:get_stack("rhenium_alloy", 1), 
				inv:get_stack("upgrade", 1), 
				inv:get_stack("press", 1)
		if alloy:get_count() < press_cost then
			cmsg.push_message_player(player, S"gui.info.no_rhenium")
			return
		end
		if not press1:is_empty() then
			cmsg.push_message_player(player, S"gui.info.extract_press")
			return
		end

		local press = ItemStack"trinium:research_lens_band_press"
		local pressmeta = press:get_meta()
		local upg = minetest.get_item_group(upgrade:get_name(), "lens_upgrade") + 1
		local shape = table.remap(table.filter(research.lens_forms.shapes, function(x)
				return research.lens_forms.shapes_by_mintier[x] <= upg 
			end))
		local gem, metal, shape, tierexp =
			trinium.lograndom(research.lens_forms.min_gem, research.lens_forms.max_gem), 
			trinium.lograndom(research.lens_forms.min_metal, research.lens_forms.max_metal),
			shape[math.random(1, #shape)], math.random(1, 2^(research.lens_forms.max_tier - upg + 1) - 1)
			
		local tier = 5 - math.floor(0.01 + math.log(tierexp) / trinium.ln2)
		pressmeta:set_int("gem", gem)
		pressmeta:set_int("metal", metal)
		pressmeta:set_string("shape", shape)
		pressmeta:set_int("tier", tier)

		pressmeta:set_string("description", S("item.band_press @1@2@3@4", 
				gem, metal, S("gui.research_lens_shape."..shape), tier))
		alloy:take_item(press_cost)
		inv:set_stack("rhenium_alloy", 1, alloy)
		inv:set_stack("press", 1, press)
		inv:set_stack("upgrade", 1, "")
	end,
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		if minetest.get_meta(pos):get_int("assembled") == 0 then
			cmsg.push_message_player(player, S"gui.info.multiblock_not_assembled")
		end
	end,
})

trinium.register_multiblock("press randomizer", {
	width = 0,
	height_d = 0,
	height_u = 1,
	depth_b = 1,
	depth_f = 0,
	controller = "trinium:machine_press_randomizer",
	activator = function(rg)
		local ctrl = table.exists(rg.region, function(x) 
			return x.x == 0 and x.y == 1 and x.z == 1 and x.name == "trinium:machine_research_node"
		end)
		return ctrl and minetest.get_meta(rg.region[ctrl].actual_pos):get_int("assembled") == 1
	end,
	after_construct = function(pos, is_constructed)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", is_constructed and randomizer_formspec or "")
		meta:set_string("infotext", is_constructed and "" or S"gui.info.multiblock_not_assembled")
	end,
})