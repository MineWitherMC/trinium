local sfinv = trinium.sfinv
local bi = trinium.bound_inventories
local S = trinium.S 

minetest.register_on_joinplayer(function(player)
	local pn = player:get_player_name()
	local dp = trinium.get_data_pointer(pn, "bound_inventories")
	bi[pn] = minetest.create_detached_inventory("bound~"..pn, {
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			return to_list == "crafting" and from_list ~= "trash" and count or 0
		end,
		
		allow_take = function(inv, listname, index, stack, player)
			return stack:get_count() -- this might change
		end,
		
		on_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			if not dp[from_list] then dp[from_list] = {} end
			if not dp[to_list] then dp[to_list] = {} end
			dp[from_list][from_index] = inv:get_stack(from_list, from_index):to_string()
			dp[to_list][to_index] = inv:get_stack(to_list, to_index):to_string()
			if to_list == "crafting" then trinium.try_craft(player)
			end
		end,
		
		on_put = function(inv, listname, index, stack, player)
			if not dp[listname] then dp[listname] = {} end
			dp[listname][index] = inv:get_stack(listname, index):to_string()
			if listname == "trash" then 
				inv:set_stack("trash", 1, "")
				dp["trash"] = {}
			elseif listname == "crafting" then trinium.try_craft(player)
			end
		end,
		
		on_take = function(inv, listname, index, stack, player)
			if not dp[listname] then dp[listname] = {} end
			dp[listname][index] = inv:get_stack(listname, index):to_string()
			if listname == "crafting" then trinium.try_craft(player)
			end
		end,
	})
	trinium.initialize_inventory(bi[pn], {trash = 1, crafting = 9, output = 1})
	for k,v in pairs(dp._strings) do
		for k1,v1 in pairs(v) do
			bi[pn]:set_stack(k, k1, v1)
		end
	end
end)

-- Utility
sfinv.register_page("trinium:utility", {
	title = S("gui.inventory.utility"),
	get = function(self, player, context)
		local pn = player:get_player_name()
		return sfinv.make_formspec(player, context, ([[
				list[detached:bound~%s;trash;0.5,0.5;1,1]
				image[0.5,1.5;1,1;gui_trash.png]
				image[0,4.75;1,1;gui_hb_bg.png]
				image[1,4.75;1,1;gui_hb_bg.png]
				image[2,4.75;1,1;gui_hb_bg.png]
				image[3,4.75;1,1;gui_hb_bg.png]
				image[4,4.75;1,1;gui_hb_bg.png]
				image[5,4.75;1,1;gui_hb_bg.png]
				image[6,4.75;1,1;gui_hb_bg.png]
				image[7,4.75;1,1;gui_hb_bg.png]
				listring[current_player;main]listring[detached:bound~%s;trash]
			]]):format(pn, pn), true)
	end
})