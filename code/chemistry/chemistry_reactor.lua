local research = trinium.res
local S = trinium.S
local T = function(timer)
	if not timer:is_started() then timer:start(15) end
end

local chemical_reactor_formspec = ([=[
	size[8,6.5]
	bgcolor[#080808BB;true]
	label[3,0;%s]
	background[5,5;1,1;gui_formbg.png;true]
	list[context;knowledge_encoded;3,0.5;1,1;]
	list[context;recipe_encoded;4,0.5;1,1;]
	list[current_player;main;0,2.5;8,4;]
]=]):format(S"gui.machine.chemreactor")

minetest.register_node("trinium:machine_chemical_reactor", {
	stack_max = 1,
	tiles = {"casing_chemical.png", "casing_chemical.png", "casing_chemical.png", "casing_chemical.png", "casing_chemical.png", "casing_chemical.png^chemical_reactor_overlay.png"},
	description = S"node.machine.chemreactor",
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
		return ((list == "knowledge_encoded" and stack:get_name() == "trinium:knowledge_crystal") or (list == "recipe_encoded" and stack:get_name() == "trinium:recipe_pattern_encoded")) and 1 or 0
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
	
	on_destruct = function(pos)
		local meta = minetest.get_meta(pos)
		local status = vector.destringify(meta:get_string("status_crd"))
		if not status.z then return end
		trinium.recolor_facedir(status, 3)
	end,
	
	on_timer = function(pos, elapsed)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local activity = meta:get_int("active")
		local timer = minetest.get_node_timer(pos)
		local status = vector.destringify(meta:get_string("status_crd"))
		if activity == 1 then
			local items = meta:get_string("output"):split(";")
			local output = vector.destringify(meta:get_string("output_crd"))
			local output_inv = minetest.get_meta(output):get_inventory()
			table.walk(items, function(item)
				if output_inv:room_for_item("output", item) then
					output_inv:add_item("output", item)
				else
					trinium.recolor_facedir(status, 0)
					meta:set_int("active", -1)
					timer:stop()
					timer:start(15)
				end
			end)
		end
		if activity ~= -1 then
			local recipe = inv:get_stack("recipe_encoded", 1)
			if recipe:is_empty() then
				meta:set_int("active", 0)
				meta:set_string("output", "")
				trinium.recolor_facedir(status, 2)
				T(timer)
				return
			end
			local catalyst = vector.destringify(meta:get_string("catalyst_crd"))
			local catalyst_inv = minetest.get_meta(catalyst):get_inventory()
			local rec = trinium.valid_recipe(recipe, "trinium:chemical_reactor", {catalyst_inv = catalyst_inv}) -- done
			if not rec then
				meta:set_int("active", 0)
				meta:set_string("output", "")
				trinium.recolor_facedir(status, 2)
				T(timer)
				return
			end
			local player = inv:get_stack("knowledge_encoded", 1)
			if player:is_empty() or not trinium.can_perform(player, rec, "trinium:chemical_reactor") then
				meta:set_int("active", 0)
				meta:set_string("output", "")
				trinium.recolor_facedir(status, 2)
				T(timer)
				return
			end -- done
			local input = vector.destringify(meta:get_string("input_crd"))
			local input_inv = minetest.get_meta(input):get_inventory()
			if not trinium.has_inputs_for_recipe(recipe, input_inv, "input") then
				meta:set_int("active", 0)
				meta:set_string("output", "")
				trinium.recolor_facedir(status, 2)
				T(timer)
				return
			end -- done
			local recipe_output = trinium.draw_inputs_for_recipe(recipe, input_inv, "input", rec) -- done
			meta:set_string("output", recipe_output)
			meta:set_int("active", 1)
			trinium.recolor_facedir(status, 1)
			timer:stop()
			timer:start(trinium.recipes.recipe_registry[rec].data.time)
		else
			meta:set_int("active", 0)
			trinium.recolor_facedir(status, 2)
			meta:set_string("output", "")
		end
		T(timer)
	end,
})

local chemical_reactor_mb = {
	map = {
		{x = 1, y = -1, z = 0, name = "trinium:casing_chemical"},
		{x = 0, y = -1, z = 0, name = "trinium:casing_chemical"},
		{x = -1, y = -1, z = 0, name = "trinium:casing_chemical"},
		{x = 1, y = -1, z = 1, name = "trinium:casing_chemical"},
		{x = 0, y = -1, z = 1, name = "trinium:casing_chemical"},
		{x = -1, y = -1, z = 1, name = "trinium:casing_chemical"},
		{x = 1, y = -1, z = 2, name = "trinium:casing_chemical"},
		{x = 0, y = -1, z = 2, name = "trinium:casing_chemical"},
		{x = -1, y = -1, z = 2, name = "trinium:casing_chemical"},
		
		{x = 1, y = 0, z = 0, name = "trinium:casing_chemical"},
		{x = -1, y = 0, z = 0, name = "trinium:casing_chemical"},
		{x = 1, y = 0, z = 1, name = "trinium:machine_hatch_output"},
		-- {x = 0, y = 0, z = 1, name = "air"},
		{x = -1, y = 0, z = 1, name = "trinium:machine_hatch_input"},
		{x = 1, y = 0, z = 2, name = "trinium:casing_chemical"},
		{x = 0, y = 0, z = 2, name = "trinium:casing_chemical"},
		{x = -1, y = 0, z = 2, name = "trinium:casing_chemical"},
		
		{x = 1, y = 1, z = 0, name = "trinium:casing_chemical"},
		{x = 0, y = 1, z = 0, name = "trinium:machine_hatch_catalyst"},
		{x = -1, y = 1, z = 0, name = "trinium:casing_chemical"},
		{x = 1, y = 1, z = 1, name = "trinium:casing_chemical"},
		{x = 0, y = 1, z = 1, name = "trinium:casing_chemical"},
		{x = -1, y = 1, z = 1, name = "trinium:casing_chemical"},
		{x = 1, y = 1, z = 2, name = "trinium:casing_chemical"},
		{x = 0, y = 1, z = 2, name = "trinium:casing_chemical"},
		{x = -1, y = 1, z = 2, name = "trinium:casing_chemical"},
		
		{x = 0, y = -1, z = -1, name = "trinium:machine_status_panel"},
	},
	width = 1,
	height_d = 1,
	height_u = 1,
	depth_b = 2,
	depth_f = 1,
	controller = "trinium:machine_chemical_reactor",
	after_construct = function(pos, is_constructed, rg)
		local meta = minetest.get_meta(pos)
		local region = rg.region
		if not is_constructed then
			local status = table.exists(region, function(r) return r.name == "trinium:machine_status_panel" end)
			if status then
				trinium.recolor_facedir(region[status].actual_pos, 3)
			end
			meta:set_string("formspec", "")
			return
		end
		
		local input, output, catalyst, status = table.exists(region, function(r) return r.name == "trinium:machine_hatch_input" end), table.exists(region, function(r) return r.name == "trinium:machine_hatch_output" end), table.exists(region, function(r) return r.name == "trinium:machine_hatch_catalyst" end), table.exists(region, function(r) return r.name == "trinium:machine_status_panel" end)
		meta:set_string("input_crd", vector.stringify(region[input].actual_pos))
		meta:set_string("output_crd", vector.stringify(region[output].actual_pos))
		meta:set_string("catalyst_crd", vector.stringify(region[catalyst].actual_pos))
		meta:set_string("status_crd", vector.stringify(region[status].actual_pos))
		if trinium.get_color_facedir(region[status].actual_pos) == 3 then
			trinium.recolor_facedir(region[status].actual_pos, 4)
		end
		meta:set_string("formspec", chemical_reactor_formspec)
		
		T(minetest.get_node_timer(pos))
	end,
}
trinium.register_multiblock("chemical reactor", chemical_reactor_mb)
trinium.mbcr("trinium:machine_chemical_reactor", chemical_reactor_mb.map)