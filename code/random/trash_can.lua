local research = trinium.res
local S = trinium.S

local trashcan_formspec = [=[
	size[8,6]
	bgcolor[#080808BB;true]
	background[5,5;1,1;gui_formbg.png;true]
	list[current_name;trash;0,0;8,1;]
	list[current_player;main;0,2;8,4;]
	listring[]
]=]

minetest.register_node("trinium:machine_trash_can", {
	description = S"Trash Can",
	tiles = {"research_casing.png"},
	groups = {harvested_by_pickaxe = 3},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
			{-0.5, -0.5, -0.5, -0.4375, 0.5, 0.5},
			{-0.5, -0.5, -0.5, 0.5, 0.5, -0.4375},
			{-0.5, -0.5, 0.4375, 0.5, 0.5, 0.5},
			{0.4375, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		meta:set_string("formspec", trashcan_formspec)
		trinium.initialize_inventory(inv, {trash = 8})
	end,
	on_receive_fields = function(pos, formname, fields, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		for i = 1, 8 do
			inv:set_stack("trash", i, "")
		end
	end,
})