local S = trinium.S
local pulse = trinium.pulsenet

minetest.register_node("trinium:pulsenet_storage_cell", {
	stack_max = 16,
	tiles = {"pulsenet_storage_cell.png"},
	description = S"node.machine.pulsenet_storage_cell",
	groups = {harvested_by_pickaxe = 1, pulsenet_slave = 1},
	paramtype2 = "facedir",
	on_pulsenet_connection = function(pos, ctrlpos)
		local meta = minetest.get_meta(ctrlpos)
		local cs = meta:get_int"capacity_types"
		local items = meta:get_int"capacity_items"
		meta:set_int("capacity_types", cs + 30)
		meta:set_int("capacity_items", items + 5000)
	end,
	
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos)
		local ctrlpos = minetest.deserialize(meta:get_string"controller_pos")
		if not ctrlpos or minetest.get_node(ctrlpos).name ~= "trinium:pulsenet_controller" then return true end
		local ctrlmeta = minetest.get_meta(ctrlpos)
		return ctrlmeta:get_int"capacity_types" - 30 >= ctrlmeta:get_int"used_types" and
			ctrlmeta:get_int"capacity_items" - 5000 >= ctrlmeta:get_int"used_items"
	end,
	
	after_dig_node = function(pos, oldnode, oldmeta, digger)
		local ctrlpos = oldmeta.fields.controller_pos
		local dsp = minetest.deserialize(ctrlpos)
		if ctrlpos and minetest.get_node(dsp).name == "trinium:pulsenet_controller" then
			local ctrlmeta = minetest.get_meta(dsp)
			local cs = ctrlmeta:get_int"capacity_types"
			local items = ctrlmeta:get_int"capacity_items"
			ctrlmeta:set_int("capacity_types", cs - 30)
			ctrlmeta:set_int("capacity_items", items - 5000)
		end
	end,
})