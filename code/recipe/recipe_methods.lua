local S = trinium.S
local SS = trinium.materials.S

-- Furnace
trinium.register_recipe_handler("trinium:furnace", {
	input_amount = 1,
	output_amount = 4,
	get_input_coords = function(n)
		return 1, 1.5
	end,
	get_output_coords = function(n)
		return trinium.modulate(n, 2) + 2, math.ceil(n / 2)
	end,
	formspec_width = 6,
	formspec_height = 4,
	formspec_name = S("Furnace"),
	formspec_begin = function(data)
		return ("label[0,3.7;%s]"):format(S("@1 seconds", data.time or 10))
	end,
})

-- Block Drop
trinium.register_recipe_handler("trinium:drop", {
	input_amount = 1,
	output_amount = 9,
	get_input_coords = function(n)
		return 1, 2
	end,
	get_output_coords = function(n)
		return trinium.modulate(n, 3) + 2.5, math.ceil(n / 3)
	end,
	formspec_width = 7,
	formspec_height = 5,
	formspec_name = S("Block Drop"),
	formspec_begin = function(data)
		return ("label[0,4.7;%s]"):format(S("@1 max", data.max_items))
	end,
})

-- Grinder
trinium.register_recipe_handler("trinium:grinder", {
	input_amount = 1,
	output_amount = 6,
	get_input_coords = function(n)
		return 1, 1.5
	end,
	get_output_coords = function(n)
		return trinium.modulate(n, 3) + 2, math.ceil(n / 3)
	end,
	formspec_width = 7,
	formspec_height = 4,
	formspec_name = S("Grinder"),
})

-- Blast Furnace
local function get_bf_coords(add_x, add_y, n)
	return trinium.modulate(n, 2) + add_x, math.ceil(n / 2) + add_y
end
trinium.register_recipe_handler("trinium:blast_furnace", {
	input_amount = 4,
	output_amount = 4,
	get_input_coords = function(n)
		return get_bf_coords(0, 0, n)
	end,
	get_output_coords = function(n)
		return get_bf_coords(3, 0, n)
	end,
	formspec_width = 7,
	formspec_height = 5,
	formspec_name = S("Blast Furnace"),
	formspec_begin = function(data)
		return ("label[2,3.5;%s]"):format(S("Melting Point - @1 K", data.melting_point or "???"))
	end,
})

-- Alloysmelting Tower
trinium.register_recipe_handler("trinium:alloysmelting_tower", {
	input_amount = 12,
	output_amount = 4,
	get_input_coords = function(n)
		return trinium.modulate(n, 3), math.ceil(n / 3)
	end,
	get_output_coords = function(n)
		return get_bf_coords(4, 1, n)
	end,
	formspec_width = 8,
	formspec_height = 7,
	formspec_name = S("Alloysmelting Tower"),
	formspec_begin = function(data)
		return ("label[2,5.5;%s]"):format(S("Temperature - @1 K", data.temperature or "???"))
	end,
})

-- Implosion
trinium.register_recipe_handler("trinium:implosion", {
	input_amount = 2,
	output_amount = 1,
	get_input_coords = function(n)
		return n == 1 and 1 or 2, 1
	end,
	get_output_coords = function(n)
		return 5, 1
	end,
	formspec_width = 7,
	formspec_height = 3,
	formspec_name = S("Implosion"),
})

-- Metal Former
trinium.register_recipe_handler("trinium:metal_former", {
	input_amount = 1,
	output_amount = 1,
	get_input_coords = function(n)
		return 1.5, 1
	end,
	get_output_coords = function(n)
		return 4.5, 1
	end,
	formspec_width = 7,
	formspec_height = 3,
	formspec_name = S("Metal Former"),
	formspec_begin = function(data)
		return "label[0,2;"..S("Method: @1", S(trinium.adequate_text(data.type))).."]"
	end,
})

-- Mixer
trinium.register_recipe_handler("trinium:mixer", {
	input_amount = 7,
	output_amount = 1,
	get_input_coords = function(n)
		if n == 7 then
			return 1, 3
		else
			return (n - 1) % 3, math.ceil(n / 3) - 0.5
		end
	end,
	get_output_coords = function(n)
		return 4, 1
	end,
	formspec_width = 5,
	formspec_height = 4.5,
	formspec_name = S("Mixer"),
	formspec_begin = function(data)
		return "label[0,4;"..S("Minimum Velocity: @1 RPM", data.velocity or 400).."]"
	end,
})

-- Molecular Reconstructor
trinium.register_recipe_handler("trinium:molecular_reconstructor", {
	input_amount = 1,
	output_amount = 1,
	get_input_coords = function(n)
		return 1.5, 1
	end,
	get_output_coords = function(n)
		return 4.5, 1
	end,
	formspec_width = 7,
	formspec_height = 3,
	formspec_name = S("Molecular Reconstructor"),
	formspec_begin = function(data)
		return "label[0,2;"..S("Type: @1\nBase Stargates per Tick: @2\nTier: @3", S(data.type), data.base_sg_per_tick, data.tier).."]"
	end,
})

-- Chemical Reactor
trinium.register_recipe_handler("trinium:chemical_reactor", {
	input_amount = 4,
	output_amount = 4,
	get_input_coords = function(n)
		return get_bf_coords(0, 0, n)
	end,
	get_output_coords = function(n)
		return get_bf_coords(3, 0, n)
	end,
	formspec_width = 7,
	formspec_height = 5,
	formspec_name = S("Chemical Reactor"),
	formspec_begin = function(data)
		return ("label[2,3.5;%s]"):format(S("Catalyst - @1 \nTime (seconds): @2", (SS(data.catalyst) == "" and S"None" or SS(data.catalyst)), data.time))
	end,
	can_perform = function(player_encoded, recipe_data)
		local x = recipe_data.research
		local pn = player_encoded:get_meta():get_string("player")
		local y = trinium.res.player_stuff[pn]
		return not x or y.researches[x]
	end,
	test = function(recipe_data, actual_data)
		if not recipe_data.catalyst then return true end
		local inv = actual_data.catalyst_inv
		local catalyst = "trinium:material_catalyst_"..recipe_data.catalyst
		return inv:contains_item("catalysts", catalyst)
	end,
})

-- Chemical Cracker
trinium.register_recipe_handler("trinium:cracker", {
	input_amount = 2,
	output_amount = 12,
	get_input_coords = function(n)
		return 0, n + 1
	end,
	get_output_coords = function(n)
		return trinium.modulate(n, 3) + 1, math.ceil(n / 3)
	end,
	formspec_width = 5,
	formspec_height = 5,
	formspec_name = S("Cracker"),
})