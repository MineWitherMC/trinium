local S = trinium.S

-- Recipe Pattern
minetest.register_craftitem("trinium:recipe_pattern", {
	inventory_image = "recipe_pattern.png",
	description = S"item.pattern",
})
minetest.register_craftitem("trinium:recipe_pattern_encoded", {
	inventory_image = "recipe_pattern_encoded.png",
	description = S"item.pattern.invalid",
	stack_max = 1,
	groups = {hidden_from_irp = 1},
	on_place = function(item, player, pointed_thing)
		return ItemStack"trinium:recipe_pattern"
	end,
})

-- Encoder
local encoder_formspec = ([=[
	size[8,8]
	bgcolor[#080808BB;true]
	label[2.5,0;%s]
	background[5,5;1,1;gui_formbg.png;true]
	list[context;recipe_patterns;0,0.5;1,1;]
	list[context;recipe_encoded;7,0.5;1,1;]
	list[context;recipe_components;0,1.5;6,2;]
	button[6,2;2,1;trinium~recencoder~encode;%s]
	list[current_player;main;0,4;8,4;]
]=]):format(S"gui.machine.recipe_encoder", S"gui.encode")

minetest.register_node("trinium:recipe_encoder", {
	stack_max = 1,
	tiles = {"recipe_encoder_top.png", "research_table_wall.png"},
	description = S"node.machine.recipe_encoder",
	groups = {harvested_by_pickaxe = 1},
	after_place_node = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		trinium.initialize_inventory(inv, {recipe_patterns = 1, recipe_encoded = 1, recipe_components = 12})
		meta:set_string("formspec", encoder_formspec)
	end,
	allow_metadata_inventory_move = function(pos, list1, index1, list2, index2, stacksize, player)
		return 0
	end,
	allow_metadata_inventory_put = function(pos, list, index, stack, player)
		return (list == "recipe_components" or 
			(list == "recipe_patterns" and stack:get_name() == "trinium:recipe_pattern")
		) and stack:get_count() or 0
	end,

	on_receive_fields = function(pos, formname, fields, player)
		if not fields["trinium~recencoder~encode"] then return end
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()

		-- Crutch for fast checking emptiness of slots
		if inv:room_for_item("recipe_patterns", "trinium:research_casing") then
			cmsg.push_message_player(player, S"gui.info.no_patterns")
			return
		end
		if not inv:room_for_item("recipe_encoded", "trinium:research_casing") then
			cmsg.push_message_player(player, S"gui.info.extract_pattern")
			return
		end

		local s = inv:get_stack("recipe_patterns", 1)
		s:take_item()
		inv:set_stack("recipe_patterns", 1, s)
		local pattern = ItemStack"trinium:recipe_pattern_encoded"
		local pmeta = pattern:get_meta()
		local cmp = inv:get_lists().recipe_components
		table.walk(cmp, function(v, k)
			cmp[k] = v:to_string()
		end)
		pmeta:set_string("inputs", minetest.serialize(cmp))
		pmeta:set_string("description", S"item.pattern.encoded".."\n"..table.concat(
			table.filter(cmp, function(a) return a ~= "" end), "\n"
		))
		inv:set_stack("recipe_encoded", 1, pattern)
	end,
})