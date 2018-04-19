local M = trinium.materials.materials
minetest.register_craftitem("trinium:module_power", {
	inventory_image = "module_power.png",
	description = S"item.module_power",
	stack_max = 16,
})
trinium.register_recipe("trinium:precision_assembler",
	{M.pulsating_alloy:get("plate"), M.forcirium:get("gem", 4), M.endium:get("foil", 6),
		M.silver_alloy:get("wire", 8)},
	{"trinium:module_power 2"},
	{tier = 1, pressure = 200, time = 320})

minetest.register_craftitem("trinium:module_wireless", {
	inventory_image = "module_wireless.png",
	description = S"item.module_wireless",
	stack_max = 16,
})
trinium.register_recipe("trinium:precision_assembler",
	{M.pulsating_alloy:get("plate"), M.fluixine:get("gem", 4), M.endium:get("foil", 6),
		M.silver_alloy:get("wire", 8)},
	{"trinium:module_wireless"},
	{tier = 1, pressure = 200, time = 320})

minetest.register_craftitem("trinium:module_storage", {
	inventory_image = "module_storage.png",
	description = S"item.module_storage",
	stack_max = 16,
})
trinium.register_recipe("trinium:precision_assembler",
	{M.pulsating_alloy:get("plate"), M.sodiumfluix:get("gem", 4), M.endium:get("foil", 6),
		M.silver_alloy:get("wire", 8)},
	{"trinium:module_storage 4"},
	{tier = 1, pressure = 200, time = 320})

minetest.register_craftitem("trinium:module_display", {
	inventory_image = "module_display.png",
	description = S"item.module_display",
	stack_max = 16,
})
trinium.register_recipe("trinium:precision_assembler",
	{M.silver:get("plate"), M.diamond:get("gem"), M.silver_alloy:get("wire", 8)},
	{"trinium:module_display 4"},
	{tier = 1, pressure = 50, time = 75})

minetest.register_craftitem("trinium:item_scanner", {
	inventory_image = "scanner.png",
	description = S"item.scanner",
	stack_max = 1,
    on_place = function(item, player, pointed_thing)
        local node = minetest.get_node(pointed_thing.under)
		cmsg.push_message_player(player, "Name: "..node.name.."\nParam1: "..node.param1.."\nParam2: "..node.param2)
	end,
})