local S = trinium.S

local function get_terminal_formspec(ctrlpos, index) -- needs search... but i'm lazy
	return ([[
		size[8,10.5]
		bgcolor[#080808BB;true]
		background[5,5;1,1;gui_formbg.png;true]
		list[nodemeta:%s;pulsenet;0,0;8,5;%s]
		button[3,5;1,1;pulseterm~up;↑]
		button[4,5;1,1;pulseterm~down;↓]
		list[current_player;main;0,6.5;8,4;]
		listring[]
	]]):format(vector.stringify(ctrlpos), index)
end

minetest.register_node("trinium:pulsenet_terminal", {
	stack_max = 16,
	tiles = {"pulsenet_terminal_top.png", "pulsenet_terminal_bottom.png", "pulsenet_terminal_right.png", "pulsenet_terminal_left.png", "pulsenet_terminal_back.png", "pulsenet_terminal_front.png"},
	description = S"node.machine.pulsenet_terminal",
	groups = {harvested_by_pickaxe = 1, pulsenet_slave = 1},
	paramtype2 = "facedir",
	on_pulsenet_connection = function(pos, ctrlpos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_terminal_formspec(ctrlpos, 0))
		meta:set_int("index", 0)
	end,
	
	on_pulsenet_update = function(pos, ctrlpos)
		local meta = minetest.get_meta(pos)
		local ctrlmeta = minetest.get_meta(ctrlpos)
		meta:set_int("current_space", ctrlmeta:get_int"current_space")
	end,
	
	on_receive_fields = function(pos, formname, fields, player)
		if fields.quit then return end
		local meta = minetest.get_meta(pos)
		local ctrlpos = minetest.deserialize(meta:get_string"controller_pos")
		for k,v in pairs(fields) do
			local ksplit = k:split"~"
			if ksplit[1] == "pulseterm" then
				local a = ksplit[2]
				if a == "down" then
					local key = meta:get_int"index"
					key = math.min(key + 8, math.ceil(meta:get_int"current_space" / 8) * 8 - 40)
					meta:set_int("index", key)
					meta:set_string("formspec", get_terminal_formspec(ctrlpos, key))
				elseif a == "up" then
					local key = meta:get_int"index"
					key = math.max(key - 8, 0)
					meta:set_int("index", key)
					meta:set_string("formspec", get_terminal_formspec(ctrlpos, key))
				end
			end
		end
	end,
})