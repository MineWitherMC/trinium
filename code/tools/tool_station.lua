local ts = trinium.tool_system

minetest.register_tool("trinium:dynamic_tool", {
	description = "Fallback Tool",
	inventory_image = "tool_fallback.png",
	groups = {hidden_from_irp = 1},
	max_stack = 1,
})

local tool_station_formspec = [[
	size[9,9.5]
	bgcolor[#080808BB;true]
	background[5,5;1,1;gui_formbg.png;true]
	list[context;inputs;1,0;5,5;]
	list[context;output;7,2;1,1;]
	image[7,3;1,1;tool_fallback.png^[brighten]
	list[current_player;main;0.5,5.5;8,4;]
	listring[]
]]

local function avg_quadratical(arr)
	local arr1 = table.copy(arr[1])
	for k,v in pairs(arr1) do
		if type(v) ~= "string" then
			local sum, count = 0, #arr
			for i = 1, #arr do
				sum = sum + arr[i][k] * arr[i][k]
			end
			arr1[k] = math.sqrt(sum / count)
		end
	end
	return arr1
end

local function arr_multiplication(arr1, arr2)
	arr1 = table.copy(arr1)
	for k,v in pairs(arr1) do
		if type(v) ~= "string" then
			arr1[k] = math.floor(0.5 + arr1[k] * arr2[k])
		end
	end
	return arr1
end

local function recalculate(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	inv:set_stack("output", 1, "")
	table.exists(ts.templates, function(v, k)
		local schematic = v.schematic
		local H, V = 0, 0
		local rods, materials = {}, {}
		for i = 1, #schematic do
			local sym = schematic:sub(i, i)
			if sym == " " then
				V = V + 1
				H = 0
			else
				H = H + 1
				if sym == "_" and not inv:get_stack("inputs", V * 5 + H):is_empty() then return end
				if sym ~= "_" and inv:get_stack("inputs", V * 5 + H):is_empty() then return end
				
				if minetest.get_item_group(inv:get_stack("inputs", V * 5 + H):get_name(), "_tool_rod") > 0 then
					if sym ~= "R" then return end
					table.insert(rods, ts.rods[inv:get_stack("inputs", V * 5 + H):get_name()])
				end
				if minetest.get_item_group(inv:get_stack("inputs", V * 5 + H):get_name(), "_tool_mat") > 0 then
					if sym ~= "M" then return end
					table.insert(materials, ts.materials[inv:get_stack("inputs", V * 5 + H):get_name()])
				end
			end
		end
		
		local idealrod = avg_quadratical(rods)
		local idealmaterial = avg_quadratical(materials)
		local stack = ItemStack("trinium:dynamic_"..k)
		local meta = stack:get_meta()
		meta:set_string("description", v.name(idealmaterial.name))
		stack = v.apply(stack, arr_multiplication(idealmaterial, idealrod))
		inv:set_stack("output", 1, stack)
		
		return true
	end)
end

minetest.register_node("trinium:tool_station", {
	description = S"node.tool_station",
	tiles = {"tool_station_top.png", "tool_station_bottom.png", "tool_station_side.png"},
	drawtype = "nodebox",
	node_box = {
		["type"] = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, -0.25, 0.25, -0.25},
			{0.5, -0.5, -0.5, 0.25, 0.25, -0.25},
			{-0.5, -0.5, 0.5, -0.25, 0.25, 0.25},
			{0.5, -0.5, 0.5, 0.25, 0.25, 0.25},
			{-0.5, 0.25, -0.5, 0.5, 0.5, 0.5},
		}
	},
	groups = {harvested_by_axe = 2},
	after_place_node = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		trinium.initialize_inventory(inv, {inputs = 25, output = 1})
		meta:set_string("formspec", tool_station_formspec)
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		return listname == "inputs" and 
			minetest.get_item_group(stack:get_name(), "usable_in_station") ~= 0
			and stack:get_count() or 0
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		return to_list ~= "output" and count or 0
	end,
	
	on_metadata_inventory_move = recalculate,
	on_metadata_inventory_put = recalculate,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if listname == "output" then
			for i = 1, 25 do
				local stack = inv:get_stack("inputs", i)
				stack:take_item()
				inv:set_stack("inputs", i, stack)
			end
		end
		recalculate(pos)
	end,
})