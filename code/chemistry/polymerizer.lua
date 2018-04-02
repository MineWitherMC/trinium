local S = trinium.S
local T = function(timer)
	if not timer:is_started() then timer:start(15) end
end

minetest.register_node("trinium:machine_polymerizer", {
	stack_max = 1,
	tiles = {"casing_chemical.png", "casing_chemical.png", "casing_chemical.png", 
			"casing_chemical.png", "casing_chemical.png", "casing_chemical.png^polymerizer_overlay.png"},
	description = S"node.machine.polymerizer",
	groups = {harvested_by_pickaxe = 1},
	paramtype2 = "facedir",
	after_place_node = function(pos, player)
		local meta = minetest.get_meta(pos)
		meta:set_int("active", 0)
		local timer = minetest.get_node_timer(pos)
		timer:start(15)
	end,
	
	on_destruct = function(pos)
		local meta = minetest.get_meta(pos)
		local status = vector.destringify(meta:get_string"status_crd")
		if not status.z then return end
		trinium.recolor_facedir(status, 3)
	end,
	
	on_timer = function(pos, elapsed)
		local meta = minetest.get_meta(pos)
		local activity = meta:get_int"active"
		local timer = minetest.get_node_timer(pos)
		local status = vector.destringify(meta:get_string"status_crd")
		if activity == 1 then
			local items = meta:get_string"output":split";"
			local output = vector.destringify(meta:get_string"output_crd")
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
			local input = vector.destringify(meta:get_string"input_crd")
			local input_inv = minetest.get_meta(input):get_inventory()
			local catalyst = vector.destringify(meta:get_string"catalyst_crd")
			local catalyst_inv = minetest.get_meta(catalyst):get_inventory()
			
			local other = {}
			for i = 1, 12 do
				local stack = input_inv:get_stack("input", i)
				if not stack:is_empty() then
					other[#other + 1] = stack:get_name()
				end
			end
			
			local recipe_selected = nil
			local recipes_poly = trinium.recipes.recipes_by_method["trinium:polymerizer"]
			local reg = trinium.recipes.recipe_registry
			for i = 1, #other do
				local rec = table.exists(recipes_poly, function(v)
					return reg[v].inputs[1]:split(" ")[1] == other[i]
				end)
				if rec then
					rec = recipes_poly[rec]
					local j = reg[rec].inputs
					if input_inv:contains_item("input", j[1]) and catalyst_inv:contains_item("catalysts", j[2]) then
						recipe_selected = rec
						break
					end
				end
			end
			if not recipe_selected then
				meta:set_int("active", 0)
				meta:set_string("output", "")
				trinium.recolor_facedir(status, 2)
				T(timer)
				return
			end
			local i = reg[recipe_selected]
			local j, k = i.inputs, i.outputs
			input_inv:remove_item("input", j[1])
			if math.random(1, 500) == 500 then catalyst_inv:remove_item("catalysts", j[2]) end
			
			meta:set_string("output", table.concat(k, ";"))
			meta:set_int("active", 1)
			trinium.recolor_facedir(status, 1)
			timer:stop()
			timer:start(90)
		else
			meta:set_int("active", 0)
			trinium.recolor_facedir(status, 2)
			meta:set_string("output", "")
		end
		T(timer)
	end,
})

local polymerizer_mb = {
	map = {
		{x = -1, y = -2, z = 2, name = "trinium:casing_cupronickel_heating_ring"},
		{x = -1, y = -2, z = 3, name = "trinium:casing_cupronickel_heating_ring"},
		{x = -1, y = -2, z = 4, name = "trinium:casing_cupronickel_heating_ring"},
		{x = 0, y = -2, z = 2, name = "trinium:casing_cupronickel_heating_ring"},
		{x = 0, y = -2, z = 3, name = "trinium:casing_cupronickel_heating_ring"},
		{x = 0, y = -2, z = 4, name = "trinium:casing_cupronickel_heating_ring"},
		{x = 1, y = -2, z = 2, name = "trinium:casing_cupronickel_heating_ring"},
		{x = 1, y = -2, z = 3, name = "trinium:casing_cupronickel_heating_ring"},
		{x = 1, y = -2, z = 4, name = "trinium:casing_cupronickel_heating_ring"},
		
		{x = 2, y = -2, z = 4, name = "trinium:casing_chemical"},
		{x = 2, y = -2, z = 3, name = "trinium:casing_chemical"},
		{x = 2, y = -2, z = 2, name = "trinium:casing_chemical"},
		{x = -2, y = -2, z = 4, name = "trinium:casing_chemical"},
		{x = -2, y = -2, z = 3, name = "trinium:casing_chemical"},
		{x = -2, y = -2, z = 2, name = "trinium:casing_chemical"},
		{x = -1, y = -2, z = 1, name = "trinium:casing_chemical"},
		{x = 0, y = -2, z = 1, name = "trinium:casing_chemical"},
		{x = 1, y = -2, z = 1, name = "trinium:casing_chemical"},
		{x = -1, y = -2, z = 5, name = "trinium:casing_chemical"},
		{x = 0, y = -2, z = 5, name = "trinium:casing_chemical"},
		{x = 1, y = -2, z = 5, name = "trinium:casing_chemical"},
		
		{x = 3, y = -1, z = 4, name = "trinium:casing_chemical"},
		{x = 3, y = -1, z = 3, name = "trinium:casing_chemical"},
		{x = 3, y = -1, z = 2, name = "trinium:casing_chemical"},
		{x = -3, y = -1, z = 4, name = "trinium:casing_chemical"},
		{x = -3, y = -1, z = 3, name = "trinium:casing_chemical"},
		{x = -3, y = -1, z = 2, name = "trinium:casing_chemical"},
		{x = -1, y = -1, z = 0, name = "trinium:casing_chemical"},
		{x = 0, y = -1, z = 0, name = "trinium:machine_hatch_catalyst"},
		{x = 1, y = -1, z = 0, name = "trinium:casing_chemical"},
		{x = -1, y = -1, z = 6, name = "trinium:casing_chemical"},
		{x = 0, y = -1, z = 6, name = "trinium:casing_chemical"},
		{x = 1, y = -1, z = 6, name = "trinium:casing_chemical"},
		{x = 2, y = -1, z = 1, name = "trinium:casing_chemical"},
		{x = -2, y = -1, z = 1, name = "trinium:casing_chemical"},
		{x = 2, y = -1, z = 5, name = "trinium:casing_chemical"},
		{x = -2, y = -1, z = 5, name = "trinium:casing_chemical"},
		
		{x = 3, y = 0, z = 4, name = "trinium:casing_chemical"},
		{x = 3, y = 0, z = 3, name = "trinium:casing_chemical"},
		{x = 3, y = 0, z = 2, name = "trinium:casing_chemical"},
		{x = -3, y = 0, z = 4, name = "trinium:casing_chemical"},
		{x = -3, y = 0, z = 3, name = "trinium:casing_chemical"},
		{x = -3, y = 0, z = 2, name = "trinium:casing_chemical"},
		{x = -1, y = 0, z = 0, name = "trinium:casing_chemical"},
		{x = 1, y = 0, z = 0, name = "trinium:casing_chemical"},
		{x = -1, y = 0, z = 6, name = "trinium:casing_chemical"},
		{x = 0, y = 0, z = 6, name = "trinium:casing_chemical"},
		{x = 1, y = 0, z = 6, name = "trinium:casing_chemical"},
		{x = 2, y = 0, z = 1, name = "trinium:machine_hatch_output"},
		{x = -2, y = 0, z = 1, name = "trinium:machine_hatch_input"},
		{x = 2, y = 0, z = 5, name = "trinium:casing_chemical"},
		{x = -2, y = 0, z = 5, name = "trinium:casing_chemical"},
		
		{x = 3, y = 1, z = 4, name = "trinium:casing_chemical"},
		{x = 3, y = 1, z = 3, name = "trinium:casing_chemical"},
		{x = 3, y = 1, z = 2, name = "trinium:casing_chemical"},
		{x = -3, y = 1, z = 4, name = "trinium:casing_chemical"},
		{x = -3, y = 1, z = 3, name = "trinium:casing_chemical"},
		{x = -3, y = 1, z = 2, name = "trinium:casing_chemical"},
		{x = -1, y = 1, z = 0, name = "trinium:casing_chemical"},
		{x = 0, y = 1, z = 0, name = "trinium:casing_chemical"},
		{x = 1, y = 1, z = 0, name = "trinium:casing_chemical"},
		{x = -1, y = 1, z = 6, name = "trinium:casing_chemical"},
		{x = 0, y = 1, z = 6, name = "trinium:casing_chemical"},
		{x = 1, y = 1, z = 6, name = "trinium:casing_chemical"},
		{x = 2, y = 1, z = 1, name = "trinium:casing_chemical"},
		{x = -2, y = 1, z = 1, name = "trinium:casing_chemical"},
		{x = 2, y = 1, z = 5, name = "trinium:casing_chemical"},
		{x = -2, y = 1, z = 5, name = "trinium:casing_chemical"},
		
		{x = -1, y = 2, z = 2, name = "trinium:casing_corrosive"},
		{x = -1, y = 2, z = 3, name = "trinium:casing_corrosive"},
		{x = -1, y = 2, z = 4, name = "trinium:casing_corrosive"},
		{x = 0, y = 2, z = 2, name = "trinium:casing_corrosive"},
		{x = 0, y = 2, z = 3, name = "trinium:casing_corrosive"},
		{x = 0, y = 2, z = 4, name = "trinium:casing_corrosive"},
		{x = 1, y = 2, z = 2, name = "trinium:casing_corrosive"},
		{x = 1, y = 2, z = 3, name = "trinium:casing_corrosive"},
		{x = 1, y = 2, z = 4, name = "trinium:casing_corrosive"},
		
		{x = 2, y = 2, z = 4, name = "trinium:casing_chemical"},
		{x = 2, y = 2, z = 3, name = "trinium:casing_chemical"},
		{x = 2, y = 2, z = 2, name = "trinium:casing_chemical"},
		{x = -2, y = 2, z = 4, name = "trinium:casing_chemical"},
		{x = -2, y = 2, z = 3, name = "trinium:casing_chemical"},
		{x = -2, y = 2, z = 2, name = "trinium:casing_chemical"},
		{x = -1, y = 2, z = 1, name = "trinium:casing_chemical"},
		{x = 0, y = 2, z = 1, name = "trinium:casing_chemical"},
		{x = 1, y = 2, z = 1, name = "trinium:casing_chemical"},
		{x = -1, y = 2, z = 5, name = "trinium:casing_chemical"},
		{x = 0, y = 2, z = 5, name = "trinium:casing_chemical"},
		{x = 1, y = 2, z = 5, name = "trinium:casing_chemical"},
		
		{x = 0, y = 1, z = -1, name = "trinium:machine_status_panel"},
	},
	width = 3,
	height_d = 2,
	height_u = 2,
	depth_b = 6,
	depth_f = 1,
	controller = "trinium:machine_polymerizer",
	after_construct = function(pos, is_constructed, rg)
		local meta = minetest.get_meta(pos)
		local region = rg.region
		if not is_constructed then
			local status = table.exists(region, function(r) return r.name == "trinium:machine_status_panel" end)
			if status then
				trinium.recolor_facedir(region[status].actual_pos, 3)
			end
			return
		end
		
		local input, output, catalyst, status = 
				table.exists(region, function(r) return r.name == "trinium:machine_hatch_input" end), 
				table.exists(region, function(r) return r.name == "trinium:machine_hatch_output" end), 
				table.exists(region, function(r) return r.name == "trinium:machine_hatch_catalyst" end), 
				table.exists(region, function(r) return r.name == "trinium:machine_status_panel" end)
		meta:set_string("input_crd", vector.stringify(region[input].actual_pos))
		meta:set_string("output_crd", vector.stringify(region[output].actual_pos))
		meta:set_string("catalyst_crd", vector.stringify(region[catalyst].actual_pos))
		meta:set_string("status_crd", vector.stringify(region[status].actual_pos))
		if trinium.get_color_facedir(region[status].actual_pos) == 3 then
			trinium.recolor_facedir(region[status].actual_pos, 4)
		end
		
		T(minetest.get_node_timer(pos))
	end,
}
trinium.register_multiblock("polymerizer", polymerizer_mb)
trinium.mbcr("trinium:machine_polymerizer", polymerizer_mb.map)