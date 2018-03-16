local research = trinium.res
local S = trinium.S

local chemical_reactor_formspec = ([=[
	size[8,6.5]
	bgcolor[#080808BB;true]
	label[2.5,0;%s]
	background[5,5;1,1;gui_formbg.png;true]
	list[context;knowledge_encoded;3,0.5;1,1;]
	list[context;recipe_encoded;4,0.5;1,1;]
	list[current_player;main;0,2.5;8,4;]
]=]):format(S"Chemical Reactor")

minetest.register_node("trinium:machine_chemical_reactor", {
	stack_max = 1,
	tiles = {"chemical_casing.png", "chemical_casing.png", "chemical_casing.png", "chemical_casing.png", "chemical_casing.png", "chemical_casing.png^chemical_reactor_overlay.png"},
	description = S"Chemical Reactor",
	groups = {harvested_by_pickaxe = 1},
	paramtype2 = "facedir",
	after_place_node = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		trinium.initialize_inventory(inv, {knowledge_encoded = 1, recipe_encoded = 1})
		
		meta:set_int("active", 0)
		local timer = minetest.get_node_timer(pos)
		timer:start(15)
	end,

	allow_metadata_inventory_move = function() return 0 end,
	allow_metadata_inventory_put = function(pos, list, index, stack, player)
		return ((list == "knowledge_encoded" and stack:get_name == "trinium:knowledge_crystal") or (list == "recipe_encoded" and stack:get_name == "trinium:recipe_pattern_encoded")) and 1 or 0
	end,

	allow_metadata_inventory_take = function(pos, list, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		return (list == "recipe_encoded" or inv:room_for_item("recipe_encoded", "trinium:research_chassis")) and 1 or 0
	end,

	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.get_node_timer(pos):stop()
		local meta = minetest.get_meta(pos)
		meta:set_int("active", 0) -- 0: Idle. 1: Working. -1: Force-Stopped.
		meta:set_string("output", "")
	end,
	
	on_timer = function(pos, elapsed)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local activity = meta:get_int("active")
		if activity == 1 then
			local item = meta:get_string("output")
			local output = vector.destringify(meta:get_string("output_crd"))
			local output_inv = minetest.get_meta(output):get_inventory()
			if output_inv:has_room_for_item("output", item) then
				output_inv:add_item("output", item)
			else
				meta:set_int("active", -1)
			end
		end
		if activity ~= -1 then
			local recipe = inv:get_stack("recipe_encoded", 1)
			if recipe:is_empty() then return end
			local player = inv:get_stack("knowledge_encoded", 1)
			if player:is_empty() or not trinium.can_perform(player, recipe) then return end -- code "trinium.can_perform"
			local input = vector.destringify(meta:get_string("input_crd"))
			local input_inv = minetest.get_meta(input):get_inventory()
			if not trinium.has_inputs_for_recipe(recipe, input_inv, "input", 12) then return end -- code this function
			local recipe_output = trinium.draw_inputs_for_recipe(recipe, input_inv, "input", 12) -- code this function
			meta:set_string("output", recipe_output)
			meta:set_int("active", 1)
		end
	end,
})

trinium.register_multiblock("chemical reactor", {
	map = {
		{x = 1, y = -1, z = 0, name = "trinium:chemical_casing"},
		{x = 0, y = -1, z = 0, name = "trinium:chemical_casing"},
		{x = -1, y = -1, z = 0, name = "trinium:chemical_casing"},
		{x = 1, y = -1, z = 1, name = "trinium:chemical_casing"},
		{x = 0, y = -1, z = 1, name = "trinium:chemical_casing"},
		{x = -1, y = -1, z = 1, name = "trinium:chemical_casing"},
		{x = 1, y = -1, z = 2, name = "trinium:chemical_casing"},
		{x = 0, y = -1, z = 2, name = "trinium:chemical_casing"},
		{x = -1, y = -1, z = 2, name = "trinium:chemical_casing"},
		
		{x = 1, y = 0, z = 0, name = "trinium:chemical_casing"},
		{x = -1, y = 0, z = 0, name = "trinium:chemical_casing"},
		{x = 1, y = 0, z = 1, name = "trinium:output_hatch"},
		-- {x = 0, y = 0, z = 1, name = "air"},
		{x = -1, y = 0, z = 1, name = "trinium:input_hatch"},
		{x = 1, y = 0, z = 2, name = "trinium:chemical_casing"},
		{x = 0, y = 0, z = 2, name = "trinium:chemical_casing"},
		{x = -1, y = 0, z = 2, name = "trinium:chemical_casing"},
		
		{x = 1, y = 1, z = 0, name = "trinium:chemical_casing"},
		{x = 0, y = 1, z = 0, name = "trinium:catalyst_hatch"},
		{x = -1, y = 1, z = 0, name = "trinium:chemical_casing"},
		{x = 1, y = 1, z = 1, name = "trinium:chemical_casing"},
		{x = 0, y = 1, z = 1, name = "trinium:chemical_casing"},
		{x = -1, y = 1, z = 1, name = "trinium:chemical_casing"},
		{x = 1, y = 1, z = 2, name = "trinium:chemical_casing"},
		{x = 0, y = 1, z = 2, name = "trinium:chemical_casing"},
		{x = -1, y = 1, z = 2, name = "trinium:chemical_casing"},
	},
	width = 1,
	height_d = 1,
	height_u = 1,
	depth_b = 2,
	depth_f = 0,
	controller = "trinium:machine_chemical_reactor",
	after_construct = function(pos, is_constructed, rg)
		if not is_constructed then
			meta:set_string("formspec", "")
			return
		end
		local meta = minetest.get_meta(pos)
		local region = rg.region
		
		local input, output = region.exists(function(r) return r.name == "trinium:input_hatch" end), region.exists(function(r) return r.name == "trinium:output_hatch" end)
		meta:set_string("input_crd", vector.stringify(region[input].actual_pos))
		meta:set_string("output_crd", vector.stringify(region[output].actual_pos))
		meta:set_string("catalyst_crd", vector.stringify(vector.add({x = 0, y = 1, z = 0}, pos)))
		meta:set_string("formspec", chemical_reactor_formspec)
	end,
})