local function get_drive_formspec_base(priority)
	return ([=[
		size[8,7.5]
		bgcolor[#080808BB;true]
		background[5,5;1,1;gui_formbg.png;true]
		list[current_player;main;0,3.5;8,4;]
		list[context;cells;0,0;4,3;]
		label[5,0;Priority: %d]
		button[5,1;1,1;mndrv~inc;↑]
		button[6,1;1,1;mndrv~dec;↓]
	]=]):format(priority)
end

minetest.register_node("trinium:mn_drive", {
	tiles = {"research_table_wall.png", "research_table_wall.png", "research_chassis.png", "research_chassis.png", "research_chassis.png", "mn_drive.png"},
	description = S"MN Drive",
	groups = {harvested_by_pickaxe = 2, mn_part = 1},
	paramtype2 = "facedir",
	on_construct = trinium.update_cable,
	on_destruct = trinium.downgrade_network,
	after_dig_node = function(pos, oldnode, oldmeta, digger)
		local inv = oldmeta.inventory.cells
		for index = 1, 12 do
			local s = inv[index]
			if not s:is_empty() then
				minetest.item_drop(s, digger, pos)
				trinium.remove_mn_storage(minetest.deserialize(meta:get_string("ctrlpos")), meta:get_int("priority") * 12 + 13 - index, pos, "cell_"..index)
			end
		end
	end,
	after_place_node = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		trinium.initialize_inventory(inv, {["cells"] = 12})
		meta:set_string("formspec", get_drive_formspec_base(0))
		meta:set_int("priority", 0)
	end,
	allow_metadata_inventory_put = function(pos, list, index, stack, player)
		return minetest.get_item_group(stack:get_name(), "mn_storage_cell")
	end,
	on_metadata_inventory_put = function(pos, list, index, stack, player)
		local meta = minetest.get_meta(pos)
		local imeta = stack:get_meta()
		trinium.add_mn_storage(minetest.deserialize(meta:get_string("ctrlpos")), meta:get_int("priority") * 12 + 13 - index, pos, "cell_"..index, 63, minetest.deserialize(imeta:get_string("items")) or {})
	end,
	on_metadata_inventory_take = function(pos, list, index, stack, player)
		local meta = minetest.get_meta(pos)
		local imeta = stack:get_meta()
		trinium.remove_mn_storage(minetest.deserialize(meta:get_string("ctrlpos")), meta:get_int("priority") * 12 + 13 - index, pos, "cell_"..index)
	end,

	on_receive_fields = function(pos, formname, fields, player)
		if fields.quit then return end
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		for k,v in pairs(fields) do
			local ks = k:split("~")
			if ks[1] == "mndrv" then
				local pr, cp, ks2 = meta:get_int("priority"), meta:get_string("ctrlpos"), ks[2]
				local op = pr * 12 + 13 - i
				if ks2 == "inc" then
					meta:set_int("priority", pr + 1)
					for i = 1, 12 do
						if inv:get_stack("cells", i):is_empty() then
							trinium.update_priority(cp, pos, "cell_"..i, op, op + 12)
						end
					end
				elseif ks2 == "dec" then
					meta:set_int("priority", pr - 1)
					for i = 1, 12 do
						if inv:get_stack("cells", i):is_empty() then
							trinium.update_priority(cp, pos, "cell_"..i, op, op - 12)
						end
					end
				end
			end
		end
	end,
})