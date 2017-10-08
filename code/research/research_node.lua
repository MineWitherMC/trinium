local res_data = trinium.res.player_stuff

minetest.register_node("trinium:machine_research_node", {
	tiles = {"node_controller.png"},
	description = S("Research Node Controller"),
	groups = {harvested_by_pickaxe = 1},
	paramtype2 = "facedir",
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_int("assembled", 0)
	end,
	on_rightclick = function(pos, node, player, itemstack, pt_th)
		local meta = minetest.get_meta(pos)
		if meta:get_int("assembled") == 0 then
			cmsg.push_message_player(player, "Multiblock is not assembled!")
			return
		end
		local pn = player:get_player_name()
		if itemstack:is_empty() then
			cmsg.push_message_player(player, ("Paper available: %d; Ink available: %d"):format(res_data[pn].data.paper, res_data[pn].data.ink))
		else
			local item = itemstack:get_name()
			if item == "trinium:material_sheet_paper" then
				res_data[pn].data.paper = res_data[pn].data.paper + itemstack:get_count() * 2
				itemstack:take_item(99)
			elseif item == "trinium:material_cell_ink" then
				res_data[pn].data.ink = res_data[pn].data.ink + 100
				itemstack:take_item(1)
			elseif item == "trinium:research_knowledge_charm" then
				trinium.res.random_aspects(pn, 30)
				itemstack:take_item(1)
			elseif item == "trinium:research_aspected_charm" then
				trinium.res.random_aspects(pn, 100)
				itemstack:take_item(1)
			elseif item == "trinium:research_focused_charm" then
				if itemstack:get_meta():get_string("focus") ~= "" then
					trinium.res.random_aspects(pn, 150, {itemstack:get_meta():get_string("focus")})
					itemstack:take_item(1)
				end
			elseif item == "trinium:research_abacus" then
				local label = ""
				for i = 1, #trinium.res.aspect_ids do
					local an = trinium.res.aspect_ids[i]
					label = ("%s%s aspect: %s\n"):format(label, trinium.adequate_text(an), res_data[pn].data.aspects[an] or 0)
				end
				cmsg.push_message_player(player, label)
			end
		end
	end,
})

local node_mb = {
	width = 3,
	height_d = 1,
	height_u = 1,
	depth_b = 4,
	depth_f = 0,
	controller = "trinium:machine_research_node",
	map = {
		{x = 0, y = -1, z = 0, name = "trinium:research_casing"},
		{x = 0, y = -1, z = 2, name = "trinium:research_casing"},
		{x = 1, y = -1, z = 1, name = "trinium:research_casing"},
		{x = -1, y = -1, z = 1, name = "trinium:research_casing"},
		{x = 0, y = -1, z = 1, name = "trinium:research_chassis"},

		{x = 1, y = -1, z = 2, name = "trinium:research_chassis"},
		{x = -1, y = -1, z = 2, name = "trinium:research_chassis"},
		{x = 1, y = -1, z = 0, name = "trinium:research_chassis"},
		{x = -1, y = -1, z = 0, name = "trinium:research_chassis"},

		{x = 0, y = -1, z = 3, name = "trinium:research_chassis"},
		{x = 0, y = -1, z = 4, name = "trinium:research_chassis"},

		{x = 2, y = -1, z = 1, name = "trinium:research_chassis"},
		{x = 3, y = -1, z = 1, name = "trinium:research_chassis"},
		{x = -2, y = -1, z = 1, name = "trinium:research_chassis"},
		{x = -3, y = -1, z = 1, name = "trinium:research_chassis"},

		{x = -1, y = 0, z = 1, name = "trinium:research_chassis"},
		{x = 1, y = 0, z = 1, name = "trinium:research_chassis"},
		{x = 0, y = 0, z = 2, name = "trinium:research_chassis"},

		{x = -1, y = 1, z = 1, name = "trinium:research_casing"},
		{x = 1, y = 1, z = 1, name = "trinium:research_casing"},
		{x = 0, y = 1, z = 2, name = "trinium:research_casing"},
		{x = 0, y = 1, z = 0, name = "trinium:research_casing"},
		{x = 0, y = 1, z = 1, name = "trinium:research_chassis"}
	},
}

trinium.register_multiblock("research node", node_mb)