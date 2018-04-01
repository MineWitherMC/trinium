local research = trinium.res
local S = trinium.S

local function get_table_formspec(mode, pn, real_research, aspect_key)
	aspect_key = aspect_key or 0
	if mode == 1 or mode == "1" then
		return ([=[
			size[11.5,9]
			bgcolor[#080808BB;true]
			background[5,5;1,1;gui_formbg.png;true]
			list[context;aspect_panel;0,2;4,6;%s]
			button[1,8;1,1;research_table~up;↑]
			button[2,8;1,1;research_table~down;↓]
			%s
			list[context;research_notes;0,0.25;1,1;]
			list[context;lens;1,0.25;1,1;]
			list[context;trash;10.5,0.25;1,1;]
			image[9.5,0.25;1,1;gui_trash.png]
			label[2,0.25;%s]
			tabheader[0,0;research_table~change_fs;%s,%s;1;true;false]
		]=]):format(aspect_key, real_research and "list[context;map;4.5,2;7,7;]" or "",
			S("gui.research_table.player_data @1@2@3", research.player_stuff[pn].data.ink, 
				research.player_stuff[pn].data.paper, research.player_stuff[pn].data.warp),
			S"gui.research_table.tab.map", S"gui.research_table.tab.inventory")
	elseif mode == 2 or mode == "2" then
		return ([=[
			size[12.5,7]
			bgcolor[#080808BB;true]
			background[5,5;1,1;gui_formbg.png;true]
			list[context;aspect_panel;0,0;4,6;%s]
			button[1,6;1,1;research_table~up;↑]
			button[2,6;1,1;research_table~down;↓]
			list[context;aspect_inputs;7,0.5;1,2;]
			button[8,1;1,1;research_table~add_aspects;+]
			list[context;r2m;10,1.5;1,1;]
			image[10,0.4;1,1;gui_trash.png]
			list[context;research_notes;4.5,1.5;1,1;]
			image[4.5,0.4;1,1;(research_notes_overlay.png^research_notes_colorer.png)^[brighten]
			list[context;lens;5.5,1.5;1,1;]
			image[5.5,0.4;1,1;research_lens.png^[brighten]
			list[current_player;main;4.5,3;8,4;]
			tabheader[0,0;research_table~change_fs;%s,%s;2;true;false]
		]=]):format(aspect_key, S"gui.research_table.tab.map", S"gui.research_table.tab.inventory")
	end
end

local function is_correct_research(inv)
	local research_notes, lens = inv:get_stack("research_notes", 1), inv:get_stack("lens", 1)
	if research_notes:is_empty() or research_notes:get_name():split("___")[1] == "trinium:discovery" then return false end
	local lens_req = research.researches[research_notes:get_name():split("___")[2]:gsub("__", ".")].requires_lens
	if lens:is_empty() and lens_req.requirement then return false end
	if not lens_req.requirement then return true end
	lens = lens:get_meta()
	return  (not lens_req.band_shape or lens:get_string("shape") == lens_req.band_shape) and
			(not lens_req.band_tier or lens:get_int("tier") >= lens_req.band_tier) and
			(not lens_req.core or lens:get_string("gem") == lens_req.core) and
			(not lens_req.band_material or lens:get_string("metal") == lens_req.band_material)
end

local function recalc_aspects(pn, inv)
	for i = 1, #research.sorted_aspect_ids do
		local gs = inv:get_stack("aspect_panel", i)
		local cur_ammount, name
		if gs:is_empty() then
			cur_ammount, name = 0, "trinium:aspect___"..research.sorted_aspect_ids[i]
		else
			cur_ammount, name = gs:get_count(), gs:get_name()
		end
		local nonitem = name:sub(18)
		local asp = research.player_stuff[pn].data.aspects[nonitem]
		if asp then
			local new_ammount = math.min(64, asp + cur_ammount)
			local add_ammount = new_ammount - cur_ammount
			research.player_stuff[pn].data.aspects[nonitem] = asp - add_ammount
			inv:set_stack("aspect_panel", i, ("%s %s"):format(name, new_ammount))
		end
	end
end

local function can_connect(inv, index1, index2)
	if index1 < 1 or index1 > 49 or index2 < 1 or index2 > 49 then return false end
	local an1 = inv:get_stack("map", index1):get_name():sub(18)
	local an2 = inv:get_stack("map", index2):get_name():sub(18)
	if an1 == "" or an2 == "" or not an1 or not an2 then return end
	local ad1 = research.known_aspects[an1]
	local ad2 = research.known_aspects[an2]
	return ad1.req1 == an2 or ad1.req2 == an2 or ad2.req1 == an1 or ad2.req2 == an1
end

minetest.register_privilege("resreveal", {
	description = "Reveal glowing underlay w/out research",
	give_to_singleplayer = false,
})

local function add_light(meta, index, pn)
	local inv = meta:get_inventory()
	if index < 1 or index > 49 then return false end
	local s1 = inv:get_stack("research_notes", 1)
	if s1:is_empty() then return false end
	local m1 = s1:get_meta()
	local mstr = minetest.deserialize(m1:get_string("map_l"))
	if table.exists(mstr, function(x) return x == index end) then return false end -- already enlightened

	if (can_connect(inv, index, index - 7) and table.exists(mstr, function(x) return x == index - 7 end)) or
		((index - 1) % 7 > 0 and can_connect(inv, index, index - 1) and table.exists(mstr, function(x) return x == index - 1 end)) or
		(index % 7 > 0 and can_connect(inv, index, index + 1) and table.exists(mstr, function(x) return x == index + 1 end)) or
		(can_connect(inv, index, index + 7) and table.exists(mstr, function(x) return x == index + 7 end)) then
			table.insert(mstr, index)
	else
		return false
	end

	local r = research.researches[s1:get_name():split("___")[2]].map
	if table.every(r, function(x) return table.exists(mstr, function(y) return x.x + (x.y - 1) * 7 == y end) end) then -- all aspects in map enlightened
		return true
	end
	m1:set_string("map_l", minetest.serialize(mstr))
	inv:set_stack("research_notes", 1, s1)
	
	if minetest.check_player_privs(pn, "resreveal") or research.check_player_res(pn, "ResearchRevealing") then
		local add_fs = minetest.deserialize(meta:get_string("formspec_additional_arr")) or {}
		add_fs[index] = ("background[%s,%s;1,1;research_glowing_underlay.png]"):format(3.5 + trinium.modulate(index, 7), 1 + math.ceil(index / 7))
		meta:set_string("formspec_additional_arr", minetest.serialize(add_fs))
		meta:set_string("formspec_additional", table.fconcat(add_fs))
		meta:set_string("formspec", get_table_formspec(1, pn, is_correct_research(inv), meta:get_int("aspect_key") or 0)..table.fconcat(add_fs))
	end
	
	return add_light(meta, index - 7, pn) or 
			((index - 1) % 7 > 0 and add_light(meta, index - 1, pn)) or 
			(index % 7 > 0 and add_light(meta, index + 1, pn)) or 
			add_light(meta, index + 7, pn)
end

local function delete_light(meta, index, pn)
	local inv = meta:get_inventory()
	local s1 = inv:get_stack("research_notes", 1)
	if s1:is_empty() then return end
	local m1 = s1:get_meta()
	local mstr = minetest.deserialize(m1:get_string("map_l"))
	local fnd = table.exists(mstr, function(x) return x == index end)
	if fnd then
		table.remove(mstr, fnd)
		if minetest.check_player_privs(pn, "resreveal") or research.check_player_res(pn, "ResearchRevealing") then
			local add_fs = minetest.deserialize(meta:get_string("formspec_additional_arr")) or {}
			add_fs[index] = nil
			meta:set_string("formspec_additional_arr", minetest.serialize(add_fs))
			meta:set_string("formspec_additional", table.fconcat(add_fs))
			meta:set_string("formspec", get_table_formspec(1, pn, is_correct_research(inv), meta:get_int("aspect_key") or 0)..table.fconcat(add_fs))
		end
	end
	m1:set_string("map_l", minetest.serialize(mstr))
	inv:set_stack("research_notes", 1, s1)
end

minetest.register_node("trinium:machine_research_table", {
	stack_max = 1,
	tiles = {"research_chassis.png"},
	description = S"node.machine.research_table",
	groups = {harvested_by_pickaxe = 2},
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {
		["type"] = "fixed",
		fixed = {
			{-0.45, -0.5, -0.45, 0.45, -0.4, 0.45}, -- platform
			{-0.1, -0.4, 0.2, 0.1, 0.455, 0.4}, -- tube
			{-0.075, 0.45, -0.1, 0.075, 0.455, 0.2}, -- connector
			{-0.15, 0.38, -0.4, 0.15, 0.455, -0.1}, -- lens
			{-0.075, 0.34, -0.325, 0.075, 0.38, -0.175}, -- lens bottom
		}
	},

	after_place_node = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local pn = player:get_player_name()
		trinium.initialize_inventory(inv, {map = 49, aspect_panel = 4 * math.ceil(#research.aspect_ids / 4), research_notes = 1, lens = 1, trash = 1, aspect_inputs = 2, r2m = 1})
		meta:set_string("infotext", S"gui.info.multiblock_not_assembled")
		meta:set_string("current_mode", 2)
		meta:set_string("owner", pn)
		meta:set_int("aspect_key", 0)

		recalc_aspects(pn, inv)
	end,

	allow_metadata_inventory_move = function(pos, list1, index1, list2, index2, stacksize, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if (list1 == "map" and list2 == "trash") then
			local x, y = trinium.modulate(index1, 7), math.floor(index1 / 7) + 1
			local res = research.researches[inv:get_stack("research_notes", 1):get_name():split("___")[2]:gsub("__", ".")]
			return table.every(res.map, function(z) return z.x ~= x or z.y ~= y end) and 1 or 0
		end
		if list2 == "r2m" then return stacksize end
		if not (list1 == "aspect_panel" and (list2 == "map" or list2 == "aspect_inputs")) then return 0 end
		return inv:get_stack(list2, index2):get_count() > 0 and 0 or 1
	end,

	allow_metadata_inventory_put = function(pos, list, index, stack, player)
		local name,size = stack:get_name(), stack:get_count()
		return ((list == "research_notes" and name:split("___")[1] == "trinium:research_notes") or (list == "lens" and name == "trinium:research_lens")) and 1 or 0
	end,

	allow_metadata_inventory_take = function(pos, list, index, stack, player)
		local name,size = stack:get_name(), stack:get_count()
		return (list == "research_notes" or list == "lens") and size or 0
	end,

	on_receive_fields = function(pos, formname, fields, player)
		if fields.quit then return end
		local pn = player:get_player_name()
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		for k,v in pairs(fields) do
			local ksplit = k:split"~"
			if ksplit[1] == "research_table" then
				local a = ksplit[2]
				if a == "change_fs" then
					local tnb = tonumber(v)
					meta:set_string("formspec", get_table_formspec(tnb, pn, is_correct_research(inv), meta:get_int("aspect_key")))
					meta:set_string("current_mode", tnb)
				elseif a == "down" then
					local key = meta:get_int("aspect_key")
					key = math.min(key + 4, math.ceil(#research.aspect_ids / 4) * 4 - 24)
					meta:set_int("aspect_key", key)
					local m = meta:get_string("current_mode")
					local nfs = get_table_formspec(m, pn, is_correct_research(inv), key)
					if m == "1" then nfs = nfs..meta:get_string("formspec_additional") end
					meta:set_string("formspec", nfs)
				elseif a == "up" then
					local key = meta:get_int("aspect_key")
					key = math.max(key - 4, 0)
					meta:set_int("aspect_key", key)
					local m = meta:get_string("current_mode")
					local nfs = get_table_formspec(m, pn, is_correct_research(inv), key)
					if m == "1" then nfs = nfs..meta:get_string("formspec_additional") end
					meta:set_string("formspec", nfs)
				elseif a == "add_aspects" then
					local a1, a2 = inv:get_stack("aspect_inputs", 1):get_name():sub(18), inv:get_stack("aspect_inputs", 2):get_name():sub(18)
					if not a1 or a1 == "" or not a2 or a2 == "" then return end

					local a,b 
					a = table.exists(research.sorted_aspect_ids, function(v,k) return v == a1 end)
					b = table.exists(research.sorted_aspect_ids, function(v,k) return v == a2 end)
					local s = inv:get_stack("aspect_panel", a)
					s:take_item()
					inv:set_stack("aspect_panel", a, s)
					s = inv:get_stack("aspect_panel", b)
					s:take_item()
					inv:set_stack("aspect_panel", b, s)

					if inv:get_stack("aspect_panel", a):is_empty() then
						inv:set_stack("aspect_inputs", 1, "")
					end
					if inv:get_stack("aspect_panel", b):is_empty() then
						inv:set_stack("aspect_inputs", 2, "")
					end

					local newaspect
					newaspect = table.exists(research.known_aspects, function(v) return (v.req1 == a1 and v.req2 == a2) or (v.req2 == a1 and v.req1 == a2) end)
					if newaspect then
						research.player_stuff[pn].data.aspects[newaspect] = (research.player_stuff[pn].data.aspects[newaspect] or 0) + 1
						minetest.sound_play("experience", {
							to_player = pn,
							gain = 4.0
						})
					end

					recalc_aspects(pn, inv)
				end
			end
		end
	end,

	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		if minetest.get_meta(pos):get_int("assembled") == -1 then
			cmsg.push_message_player(player, S"gui.info.multiblock_not_assembled")
		else
			recalc_aspects(player:get_player_name(), minetest.get_meta(pos):get_inventory())
		end
	end,

	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local oldinv = oldmetadata.inventory.aspect_panel
		local pn = digger:get_player_name()
		for i = 1, #research.sorted_aspect_ids do
			local st = oldinv[i]
			if not st:is_empty() then
				local ct = st:get_count()
				research.player_stuff[pn].data.aspects[research.sorted_aspect_ids[i]] = research.player_stuff[pn].data.aspects[research.sorted_aspect_ids[i]] + ct
			end
		end

		local sh, l = oldmetadata.inventory.research_notes[1], oldmetadata.inventory.lens[1]
		if not sh:is_empty() then
			minetest.item_drop(sh, digger, pos)
		end
		if not l:is_empty() then
			minetest.item_drop(l, digger, pos)
		end
	end,

	can_dig = function(pos, player)
		return minetest.get_meta(pos):get_string("owner") == player:get_player_name()
	end,

	on_metadata_inventory_move = function(pos, list1, index1, list2, index2, stacksize, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local pn = player:get_player_name()
		if list2 == "trash" then
			inv:set_stack("trash", 1, "")
			local s1 = inv:get_stack("research_notes", 1)
			local m1 = s1:get_meta()
			local mstr = minetest.deserialize(m1:get_string("map2")) or {}
			local fnd = table.exists(mstr, function(x) return x.num == index1 end)
			if fnd then
				table.remove(mstr, fnd)
			end
			m1:set_string("map2", minetest.serialize(mstr))
			inv:set_stack("research_notes", 1, s1)
			delete_light(meta, index1, pn)
		elseif list2 == "r2m" then
			local a = inv:get_stack("r2m", 1):get_name():sub(18)
			research.player_stuff[pn].data.aspects[a] = research.player_stuff[pn].data.aspects[a] + inv:get_stack("r2m", 1):get_count()
			inv:set_stack("r2m", 1, "")
		elseif list2 == "map" then
			local s1 = inv:get_stack("research_notes", 1)
			local m1 = s1:get_meta()
			local mstr = minetest.deserialize(m1:get_string("map2")) or {}
			table.insert(mstr, {num = index2, aspect = inv:get_stack(list2, index2):get_name()})
			m1:set_string("map2", minetest.serialize(mstr))
			inv:set_stack("research_notes", 1, s1)
			if add_light(meta, index2, pn) then
				inv:set_stack("research_notes", 1, "trinium:discovery___"..s1:get_name():split("___")[2])
				meta:set_string("formspec_additional_arr", "")
				meta:set_string("formspec_additional", "")
				meta:set_string("formspec", get_table_formspec(1, pn, false, meta:get_int("aspect_key")))
			end
		end

		recalc_aspects(pn, inv)
	end,

	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if listname == "research_notes" then
			for i = 1, 49 do
				inv:set_stack("map", i, "")
			end
		end
	end,

	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local pn = player:get_player_name()
		if listname == "research_notes" then
			local resname = research.researches[stack:get_name():split("___")[2]]
			for i = 1, #resname.map do
				inv:set_stack("map", resname.map[i].x + (resname.map[i].y - 1) * 7, "trinium:aspect___"..resname.map[i].aspect) 
			end
			local map2 = minetest.deserialize(stack:get_meta():get_string("map2"))
			if map2 then
				for i = 1, #map2 do
					inv:set_stack("map", map2[i].num, map2[i].aspect)
				end
			end

			local meta1 = stack:get_meta()
			if meta1:get_string("map_l") == "" then
				meta1:set_string("map_l", minetest.serialize({resname.map[1].x + (resname.map[1].y - 1) * 7}))
				inv:set_stack("research_notes", 1, stack)
				
				if minetest.check_player_privs(pn, "resreveal") or research.check_player_res(pn, "ResearchRevealing") then
					local add_fs = {}
					add_fs[resname.map[1].x + (resname.map[1].y - 1) * 7] = 
						("background[%s,%s;1,1;research_glowing_underlay.png]"):format(3.5 + resname.map[1].x, 1 + resname.map[1].y)
					meta:set_string("formspec_additional_arr", minetest.serialize(add_fs))
					meta:set_string("formspec_additional", table.fconcat(add_fs))
				end
			end
		end
	end,
})

trinium.register_multiblock("research table", {
	width = 0,
	height_d = 2,
	height_u = 0,
	depth_b = 0,
	depth_f = 1,
	controller = "trinium:machine_research_table",
	activator = function(rg)
		local ctrl = table.exists(rg.region, function(x) return x.x == 0 and x.y == -2 and x.z == -1 and x.name == "trinium:machine_research_node" end)
		return ctrl and minetest.get_meta(rg.region[ctrl].actual_pos):get_int("assembled") == 1
	end,
	after_construct = function(pos, is_constructed)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local r = meta:get_string("current_mode")
		if r ~= "1" and r ~= "2" then
			meta:set_string("current_mode", 2)
		end
		local fs = ""
		if is_constructed then
			fs = get_table_formspec(r, meta:get_string("owner"), is_correct_research(inv), meta:get_int("aspect_key") or 0)
			if r == "1" then
				fs = fs..meta:get_string("formspec_additional")
			end
		end
		meta:set_string("formspec", fs)
		meta:set_string("infotext", is_constructed and "" or S"gui.info.multiblock_not_assembled")
	end,
})