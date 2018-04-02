local S = trinium.S

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
	formspec_name = S"gui.recipe_method.furnace",
	formspec_begin = function(data)
		return ("label[0,3.7;%s]"):format(S("gui.furnace.time @1", data.time or 10))
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
	formspec_name = S"gui.recipe_method.block_drop",
	formspec_begin = function(data)
		return ("label[0,4.7;%s]"):format(S("gui.max_drop @1", data.max_items))
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
	formspec_name = S"gui.recipe_method.grinder",
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
	formspec_name = S"gui.recipe_method.blast_furnace",
	formspec_begin = function(data)
		return ("label[2,3.5;%s]"):format(S("gui.blast_furnace.temperature @1", data.melting_point or "???"))
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
	formspec_name = S"gui.recipe_method.alloy_tower",
	formspec_begin = function(data)
		return ("label[2,5.5;%s]"):format(S("gui.alloy_tower.temperature @1", data.temperature or "???"))
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
	formspec_name = S"gui.recipe_method.implosion",
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
	formspec_name = S"gui.recipe_method.metal_former",
	formspec_begin = function(data)
		return ("label[0,2;%s]")
			:format(S("gui.metal_former.type @1", S("gui.metal_former_type."..data.type)))
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
	formspec_name = S"gui.recipe_method.mixer",
	formspec_begin = function(data)
		return ("label[0,4;%s]")
			:format(S("gui.minimum_velocity @1", data.velocity or 400))
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
	formspec_name = S"gui.recipe_method.reconstructor",
	formspec_begin = function(data)
		return ("label[0,2;%s\n%s\n%s]"):format(
			S("gui.reconstructor.type @1", S("gui.reconstructor.type."..data.type)),
			S("gui.base_sg_t @1", data.base_sg_per_tick),
			S("gui.tier @1", data.tier)
		)
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
	formspec_name = S"gui.recipe_method.chemreactor",
	formspec_begin = function(data)
		local catalyst
		if not data.catalyst then
			catalyst = S"gui.no_catalyst"
		else
			local catalyst_item = minetest.registered_items["trinium:material_catalyst_"..data.catalyst]
			if not catalyst_item then
				catalyst = "This recipe is broken, blame author of "..data.author_mod
			else
				catalyst = catalyst_item.description:split("\n")[1]
			end
		end
		return ("label[1,3.5;%s\n%s]"):format(catalyst, S("gui.chemreactor.time @1", data.time))
	end,
	can_perform = function(pn, recipe_data)
		local x = recipe_data.research
		local y = trinium.res.player_stuff[pn]
		return not x or (y and y.researches[x])
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
	formspec_name = S"gui.recipe_method.cracker",
})

-- Polymerizer
trinium.register_recipe_handler("trinium:polymerizer", {
	input_amount = 2,
	output_amount = 1,
	get_input_coords = function(n)
		return 0, n
	end,
	get_output_coords = function(n)
		return 2, 1.5
	end,
	formspec_width = 3,
	formspec_height = 3.5,
	formspec_name = S"gui.recipe_method.polymerizer",
})

-- Crafting
trinium.register_recipe_handler("trinium:crafting", {
	input_amount = 9,
	output_amount = 1,
	get_input_coords = function(n)
		return trinium.modulate(n, 3) - 0.5, math.ceil(n / 3)
	end,
	get_output_coords = function(n)
		return 4.5, 2
	end,
	formspec_width = 6,
	formspec_height = 4.5,
	formspec_name = S"gui.recipe_method.crafting",
})