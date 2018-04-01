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
		local cs = meta:get_int"current_space"
		meta:set_int("current_space", cs + 30)
		trinium.initialize_inventory(meta:get_inventory(), {pulsenet = cs + 30})
	end,
	
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos)
		local ctrlpos = minetest.deserialize(meta:get_string"controller_pos")
		if not ctrlpos or minetest.get_node(ctrlpos).name ~= "trinium:pulsenet_controller" then return true end
		local ctrlmeta = minetest.get_meta(ctrlpos)
		return ctrlmeta:get_int("current_space") - 30 >= ctrlmeta:get_int("current_used_space")
	end,
	
	after_dig_node = function(pos, oldnode, oldmeta, digger)
		local ctrlpos = oldmeta.fields.controller_pos
		local dsp = minetest.deserialize(ctrlpos)
		if ctrlpos and minetest.get_node(dsp).name == "trinium:pulsenet_controller" then
			local ctrlmeta = minetest.get_meta(dsp)
			local cs = ctrlmeta:get_int"current_space"
			ctrlmeta:set_int("current_space", cs - 30)
			local inv = ctrlmeta:get_inventory()
			for i = cs - 29, cs do
				local s = inv:get_stack("pulsenet", i)
				inv:set_stack("pulsenet", i, "")
				inv:add_item("pulsenet", s)
			end
			trinium.initialize_inventory(inv, {pulsenet = cs - 30})
			pulse.update_controller(dsp)
		end
	end,
})