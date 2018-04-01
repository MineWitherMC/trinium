local S = trinium.S
trinium.pulsenet = {}
local pulse = trinium.pulsenet

function pulse.update_controller(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory():get_list("pulsenet")
	local k = 0
	table.walk(inv, function(r) if r ~= "" and not r:is_empty() then k = k + 1 end end)
	meta:set_int("current_used_space", k)
end

minetest.register_node("trinium:pulsenet_controller", {
	stack_max = 1,
	tiles = {"pulsenet_controller_side.png", "pulsenet_controller_side.png", "pulsenet_controller_side.png", "pulsenet_controller_side.png", "pulsenet_controller_side.png", "pulsenet_controller.png"},
	description = S"node.machine.pulsenet_controller",
	groups = {harvested_by_pickaxe = 1},
	paramtype2 = "facedir",
	after_place_node = function(pos, player)
		local meta = minetest.get_meta(pos)
		meta:set_int("current_space", 0)
		meta:set_int("current_used_space", 0)
		meta:set_string("connected_devices", minetest.serialize{})
	end,
	
	on_metadata_inventory_put = pulse.update_controller,
	on_metadata_inventory_take = pulse.update_controller,
	on_metadata_inventory_move = pulse.update_controller,
	
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		if itemstack:is_empty() then
			local meta = minetest.get_meta(pos)
			cmsg.push_message_player(clicker, S("gui.info.current_space @1@2", meta:get_int"current_used_space", meta:get_int"current_space"))
		end
	end,
})

minetest.register_craftitem("trinium:pulsenet_connector", {
	inventory_image = "pulsenet_connector.png",
	description = S("item.pulsenet.connector"),
	stack_max = 1,
	on_place = function(item, player, pointed_thing)
		local node = pointed_thing.under
		local name = minetest.get_node(node).name
		if name == "trinium:pulsenet_controller" then
			local meta = item:get_meta()
			meta:set_string("controller_pos", minetest.serialize(pointed_thing.under))
			cmsg.push_message_player(player, S"gui.info.connector.connected")
			return item
		elseif minetest.get_item_group(name, "pulsenet_slave") > 0 then
			local meta = item:get_meta()
			if meta:get_string"controller_pos" == "" or 
					minetest.get_node(minetest.deserialize(meta:get_string"controller_pos")).name ~= "trinium:pulsenet_controller" then
				cmsg.push_message_player(player, S"gui.info.connector.wrong_data")
			else
				local meta1 = minetest.get_meta(node)
				if meta1:get_string("controller_pos") ~= "" then
					cmsg.push_message_player(player, S"gui.info.connector.already_connected")
				else
					local controller_pos = minetest.deserialize(meta:get_string"controller_pos")
					meta1:set_string("controller_pos", meta:get_string("controller_pos"))
					local meta2 = minetest.get_meta(controller_pos)
					local cd = minetest.deserialize(meta2:get_string"connected_devices")
					table.insert(cd, node)
					if minetest.registered_items[name].on_pulsenet_connection then
						minetest.registered_items[name].on_pulsenet_connection(node, controller_pos)
					end
					for i = 1, #cd do
						local name1 = minetest.get_node(cd[i]).name
						if minetest.registered_items[name1].on_pulsenet_update then
							minetest.registered_items[name1].on_pulsenet_update(cd[i], controller_pos)
						end
					end
					meta2:set_string("connected_devices", minetest.serialize(cd))
					cmsg.push_message_player(player, S"gui.info.connector.slave_connected")
				end
			end
		else
			cmsg.push_message_player(player, S"gui.info.connector.incorrect_target")
		end
	end,
})