local S = trinium.S
local pulse = trinium.pulsenet
local M = trinium.materials.materials

local function generate_buttons(ctrlpos, index, search)
	local meta = minetest.get_meta(ctrlpos)
	local str = ""
	local inv = minetest.deserialize(meta:get_string"inventory")
	local acquired = 0
	for c, k, v in table.asort(inv, function(a, b) return a > b end) do -- K is item, V is amount
		if c > index + 40 then break end
		if c > index and (k:lower():find(search:lower()) or 
				minetest.registered_items[k].description:lower():find(search:lower())) then
			acquired = acquired + 1
			str = str..([=[
				item_image_button[%s,%s;1,1;%s;pulseterm~take_items~%s;%s]
			]=]):format(trinium.modulate(acquired, 8) - 1, math.ceil(acquired / 8) - 1, k:split(" ")[1], 
					minetest.formspec_escape(k), v)
		end
	end
	local max = math.min(meta:get_int"capacity_types" - index, 40)
	if acquired < max then
		for i = acquired + 1, max do
			str = str..([=[
				item_image_button[%s,%s;1,1;;;]
			]=]):format(trinium.modulate(i, 8) - 1, math.ceil(i / 8) - 1)
		end
	end
	return str
end

local function get_terminal_formspec(ctrlpos, index, searchstring)
	local meta = minetest.get_meta(ctrlpos)
	local CI, UI, CT, UT = meta:get_int"capacity_items", meta:get_int"used_items", meta:get_int"capacity_types", meta:get_int"used_types" 
	return ([[
		size[8,12]
		bgcolor[#080808BB;true]
		background[5,5;1,1;gui_formbg.png;true]
		list[context;input;0,5.5;1,1]
		button[3,5.5;1,1;pulseterm~up;↑]
		button[4,5.5;1,1;pulseterm~down;↓]
		list[current_player;main;0,7;8,4;]
		listring[]
		field[0.25,11.33;6,1;pulseterm~search;;%s]
		button[7,11;1,1;pulseterm~empty_search;X]
		button[6,11;1,1;pulseterm~send_search;>>]
		field_close_on_enter[pulseterm~search;false]
		%s
		textarea[5.25,5.7;3,1;;;%s]
	]]):format(searchstring, generate_buttons(ctrlpos, index, searchstring), 
			S("gui.terminal.types @1@2", UT, CT).."\n"..S("gui.terminal.items @1@2", UI, CI))
end

minetest.register_node("trinium:pulsenet_terminal", {
	stack_max = 16,
	tiles = {"pulsenet_terminal_top.png", "pulsenet_terminal_bottom.png", "pulsenet_terminal_right.png",
			"pulsenet_terminal_left.png", "pulsenet_terminal_back.png", "pulsenet_terminal_front.png"},
	description = S"node.machine.pulsenet_terminal",
	groups = {harvested_by_pickaxe = 1, pulsenet_slave = 1},
	paramtype2 = "facedir",
	on_pulsenet_connection = function(pos, ctrlpos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_terminal_formspec(ctrlpos, 0, ""))
		meta:set_int("index", 0)
		trinium.initialize_inventory(meta:get_inventory(), {input = 1})
	end,
	
	on_pulsenet_update = function(pos, ctrlpos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_terminal_formspec(ctrlpos, meta:get_int"index", meta:get_string"search"))
	end,
	
	on_metadata_inventory_put = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local ctrlpos = minetest.deserialize(meta:get_string"controller_pos")
		local ctrlmeta = minetest.get_meta(ctrlpos)
		local ctrlinv = ctrlmeta:get_inventory()
		if not ctrlinv:get_stack("input", 1):is_empty() then return end
		ctrlinv:set_stack("input", 1, inv:get_stack("input", 1))
		inv:set_stack("input", 1, "")
		pulse.import_to_controller(ctrlpos)
		meta:set_string("formspec", get_terminal_formspec(ctrlpos, meta:get_int"index", meta:get_string"search"))
	end,
	
	on_receive_fields = function(pos, formname, fields, player)
		if fields.quit then return end
		if fields.key_enter then
			fields["pulseterm~send_search"] = 1
		end
		local meta = minetest.get_meta(pos)
		local ctrlpos = minetest.deserialize(meta:get_string"controller_pos")
		local ctrlmeta = minetest.get_meta(ctrlpos)
		for k,v in pairs(fields) do
			local ksplit = k:split"~"
			if ksplit[1] == "pulseterm" then
				local a = ksplit[2]
				if a == "down" then
					local key = meta:get_int"index"
					key = math.min(key + 8, math.ceil(ctrlmeta:get_int"capacity_types" / 8) * 8 - 40)
					meta:set_int("index", key)
					meta:set_string("formspec", get_terminal_formspec(ctrlpos, key, meta:get_string"search"))
				elseif a == "up" then
					local key = meta:get_int"index"
					key = math.max(key - 8, 0)
					meta:set_int("index", key)
					meta:set_string("formspec", get_terminal_formspec(ctrlpos, key, meta:get_string"search"))
				elseif a == "empty_search" then
					meta:set_string("search", "")
					meta:set_string("formspec", get_terminal_formspec(ctrlpos, meta:get_int"index", ""))
				elseif a == "send_search" then
					meta:set_string("search", fields["pulseterm~search"])
					meta:set_string("formspec", 
							get_terminal_formspec(ctrlpos, meta:get_int"index", fields["pulseterm~search"]))
				elseif a == "take_items" then
					local id = trinium.formspec_restore(ksplit[3])
					local inv = minetest.deserialize(ctrlmeta:get_string"inventory")
					local ksplit2 = id:split(" ")
					local tester = ItemStack(ksplit2[1])
					if not tester:is_known() then
						inv[id] = nil
					else
						local ss = minetest.registered_items[ksplit2[1]].stack_max
						ss = math.min(ss, inv[id])
						local name
						if #ksplit2 == 1 then
							name = ("%s %s"):format(ksplit2[1], ss)
						else
							name = ("%s %s 0 %s"):format(ksplit2[1], ss, table.concat(table.tail(ksplit2), " "))
						end
						local s = ItemStack(name)
						player:get_inventory():add_item("main", s)
						inv[id] = inv[id] - ss
						ctrlmeta:set_int("used_items", ctrlmeta:get_int"used_items" - ss)
						if inv[id] == 0 then
							inv[id] = nil
							ctrlmeta:set_int("used_types", ctrlmeta:get_int"used_types" - 1)
						end
					end
					
					ctrlmeta:set_string("inventory", minetest.serialize(inv))
					pulse.import_to_controller(ctrlpos)
					meta:set_string("formspec", get_terminal_formspec(ctrlpos, meta:get_int"index", meta:get_string"search"))
				end
			end
		end
	end,
})

trinium.register_recipe("trinium:crafting_wizard",
	{"PMP SCS PWP", P = M.abs:get("plate"), M = "trinium:module_display", W = "trinium:module_wireless",
		C = "trinium:casing_pulsenet", S = "trinium:module_storage"},
	{"trinium:pulsenet_terminal"})