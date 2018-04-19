local sfinv = trinium.sfinv
local bi = trinium.bound_inventories
local S = trinium.S

-- Crafting
sfinv.register_page("trinium:default", {
	title = S"gui.inventory.crafting",
	get = function(self, player, context)
		local pn = player:get_player_name()
		local inv2 = bi[pn]
		local str = inv2 and inv2:get_stack("output", 1):to_string() or ""
		return sfinv.make_formspec(player, context, ([[
				list[detached:bound~%s;crafting;1.75,0.5;3,3;]
				item_image_button[5.75,1.5;1,1;%s;inventory~craft;]
				image[4.75,1.5;1,1;gui_arrow.png]
				image[0,4.75;1,1;gui_hb_bg.png]
				image[1,4.75;1,1;gui_hb_bg.png]
				image[2,4.75;1,1;gui_hb_bg.png]
				image[3,4.75;1,1;gui_hb_bg.png]
				image[4,4.75;1,1;gui_hb_bg.png]
				image[5,4.75;1,1;gui_hb_bg.png]
				image[6,4.75;1,1;gui_hb_bg.png]
				image[7,4.75;1,1;gui_hb_bg.png]
				listring[current_player;main]listring[detached:bound~%s;crafting]
			]]):format(pn, str, pn), true)
	end,
	on_player_receive_fields = function(self, player, context, fields)
		if fields.quit then return end
		local pn = player:get_player_name()
		local inv1, inv2 = player:get_inventory(), bi[pn]
		for k,v in pairs(fields) do
			local ksplit = k:split"~" -- Module, action, parameters
			if ksplit[1] == "inventory" then
				local a = ksplit[2]
				if a == "craft" then
					local s = inv2:get_stack("output", 1):to_string()
					if s ~= "" then
						if not inv1:room_for_item("main", s) then
							cmsg.push_message_player(player, S"gui.info.full_inv")
						else
							inv1:add_item("main", s)
							for i = 1, 9 do
								local s1 = inv2:get_stack("crafting", i)
								s1:take_item()
								inv2:set_stack("crafting", i, s1)
							end
							trinium.try_craft(player)
						end
					end
				end
			end
		end
	end,
})

function trinium.try_craft(player)
	local pn = player:get_player_name()
	local inv = bi[pn]
	local list = inv:get_list"crafting"
	for i = 1, 9 do
		list[i] = list[i]:get_name()
	end
	list = trinium.recipe_stringify(9, list)
	local rr = trinium.recipes.recipe_registry
	local rbm = trinium.recipes.recipes_by_method["trinium:crafting"]
	
	local recipe, output = table.exists(rbm, function(v) return rr[v].inputs_string == list end)
	if not recipe then
		output = ""
	else
		output = rr[rbm[recipe]].outputs[1]
	end
	inv:set_stack("output", 1, output)
	sfinv.set_player_inventory_formspec(player, sfinv.contexts[pn])
end