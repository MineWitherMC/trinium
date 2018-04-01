local sfinv = trinium.sfinv
local S = trinium.S

trinium.res = {}
local res = trinium.res
res.player_stuff = {}

local function res_on_join(player)
	local pn = player:get_player_name()
	res.player_stuff[pn] = {}
	res.player_stuff[pn].data = trinium.get_data_pointer(pn, "research_data")
	res.player_stuff[pn].data.aspects = res.player_stuff[pn].data.aspects or {}
	res.player_stuff[pn].data.ink = res.player_stuff[pn].data.ink or 0
	res.player_stuff[pn].data.paper = res.player_stuff[pn].data.paper or 0
	res.player_stuff[pn].data.warp = res.player_stuff[pn].data.warp or 0
	res.player_stuff[pn].researches = trinium.get_data_pointer(pn, "researches")
	res.player_stuff[pn].research_array = {}
end

minetest.after(0.1, function()
	for _,player in pairs(minetest.get_connected_players()) do
		res_on_join(player)
	end
	minetest.register_on_joinplayer(res_on_join)
end)

local function get_book_fs(pn)
	local buttons, texture = ""
	for k,v in pairs(res.chapters) do
		if table.every(v.requirements, function(b,a) return res.player_stuff[pn].researches[a] end) then
			texture = v.texture:gsub(":", "__")
			buttons = ("%sitem_image_button[%s,%s;1,1;trinium:researchicon___%s___%s;research~chapter_open~%s;]")
				:format(buttons, v.x, v.y, texture, v.number, k)
		end
	end
	return buttons
end

local function cut_coordinates(x1, x2, y1, y2)
	if y1 == y2 then return math.min(math.max(x1, x2), 8), math.max(math.min(x1, x2), -0.5), y1, y1 end
	if x1 == x2 then return x1, x1, math.min(math.max(y1, y2), 8), math.max(math.min(y1, y2), -0.5) end
	--[[
		define line (x1,y1) => (x2,y2) as y = kx + b
		then, kx1 + b = y1 and kx2 + b = y2
		k(x2-x1) = (y2-y1)
		k = (y2-y1)/(x2-x1)
		b = y1 - kx1 = (x2y1 - x1y2)/(x2-x1)
	]]--
	local k, b = (y2 - y1) / (x2 - x1), (x2 * y1 - x1 * y2) / (x2 - x1)
	-- then, intersect y = kx + b with line x = -0.5, then y = -0.5k + b
	if x1 < -0.5 then x1 = -0.5; y1 = -0.5 * k + b end
	if x2 < -0.5 then x2 = -0.5; y2 = -0.5 * k + b end
	-- then, with x = 8, then y = 8k + b
	if x1 > 8 then x1 = 8; y1 = 8 * k + b end
	if x2 > 8 then x2 = 8; y2 = 8 * k + b end
	-- then, with y = -0.5, then x = -(b+0.5)/k
	if y1 < -0.5 then y1 = -0.5; x1 = -(b + 0.5) / k end
	if y2 < -0.5 then y2 = -0.5; x2 = -(b + 0.5) / k end
	-- finally, with y = 8, then x = (8-b)/k
	if y1 > 8 then y1 = 8; x1 = (8 - b) / k end
	if y2 > 8 then y2 = 8; x2 = (8 - b) / k end
	
	return x1, x2, y1, y2
end

local function draw_connection(x1, y1, x2, y2)
	if x1 == x2 and y1 == y2 then return "" end
	if ((x1 < 0 or x1 > 7) and (x2 < 0 or x2 > 7)) or ((y1 < 0 or y1 > 7) and (y2 < 0 or y2 > 7)) then return "" end
	x1, x2, y1, y2 = cut_coordinates(x1, x2, y1, y2)
	if x1 == x2 then
		if y1 > y2 then y1, y2 = y2, y1 end
		return ("background[%s,%s;1,%s;research_connector_v.png]"):format(x1, y1 + 0.5, y2 - y1)
	elseif y1 == y2 then
		if x1 > x2 then x1, x2 = x2, x1 end
		return ("background[%s,%s;%s,1;research_connector_h.png]"):format(x1 + 0.5, y1, x2 - x1)
	elseif (x1 > x2) == (y1 > y2) then
		if x1 > x2 then x1, x2, y1, y2 = x2, x1, y2, y1 end
		return ("background[%s,%s;%s,%s;research_connector_sd.png]"):format(x1 + 0.5, y1 + 0.5, x2 - x1, y2 - y1)
	else
		if x1 > x2 then
			x1, x2 = x2, x1
		else
			y1, y2 = y2, y1
		end
		return ("background[%s,%s;%s,%s;research_connector_dd.png]"):format(x1 + 0.5, y2 + 0.5, x2 - x1, y1 - y2)
	end
end

local function get_book_chapter_fs(chapterid, pn, cx, cy)
	local buttons, texture = "button[7,8;1,1;research~book;"..S("gui.research_book.back").."]"
	if res.chapters[chapterid].create_map then
		buttons = ("%sbutton[5,8;2,1;research~get_map;%s]tooltip[research~get_map;%s]"):format(buttons, S"gui.get_chapter_map", S"gui.about_chapter_map")
	end
	if not res.researches_by_chapter[chapterid] then return end
	local frc = table.filter(res.researches_by_chapter[chapterid], function(v) 
		return v.x - cx >= 0 and v.x - cx <= 7 and v.y - cy >= 0 and v.y - cy <= 7
	end)

	for k,v in pairs(res.researches_by_chapter[chapterid]) do
		if res.player_stuff[pn].researches[k] or v.pre_unlock then
			
			for k1,v1 in pairs(v.requirements) do
				if res.researches_by_chapter[chapterid][v1] then
					local v2 = res.researches[v1]
					buttons = buttons..draw_connection(v.x - cx, v.y - cy, v2.x - cx, v2.y - cy)
				end
			end
			
			if frc[k] then
				texture = v.texture:gsub(":", "__")
				buttons = ("%sitem_image_button[%s,%s;1,1;trinium:researchicon___%s___%s;research~research_open~%s;]")
					:format(buttons, v.x - cx, v.y - cy, texture, v.number, k)
			end
		elseif table.every(v.requirements, function(a) return res.player_stuff[pn].researches[a] end) and not v.hidden then
			for k1,v1 in pairs(v.requirements) do
				if res.researches_by_chapter[chapterid][v1] then
					local v2 = res.researches[v1]
					buttons = buttons..draw_connection(v.x - cx, v.y - cy, v2.x - cx, v2.y - cy)
				end
			end
			
			if frc[k] then
				texture = v.texture:gsub(":", "__")
				buttons = buttons..
					("background[%s,%s;1,1;research_glowing_underlay.png]item_image_button[%s,%s;1,1;trinium:researchicon___%s___%s;research~get_sheet~%s;]")
						:format(v.x - cx, v.y - cy, v.x - cx, v.y - cy, texture, v.number, k)
			end
		end
	end
	return buttons
end

local function get_book_research_fs(researchid, pn, page, update)
	if update == 1 or update == "1" then
		local research = res.researches[researchid]
		local text, label = research.text
		res.player_stuff[pn].research_array[1], res.player_stuff[pn].research_array[2] = {}, {}
		for k,v in ipairs(text) do
			if type(v) == "string" then v = res.label_escape(v) end
			if #v == 1 then v = {v[1], 8, 8, nil, nil} end
			local w, h = math.max(v[2], 8), math.max(v[3], 8.6)
			res.player_stuff[pn].research_array[1][k] = {
				text = ("label[0,%s;%s]button[%s,0.25;1,0.5;research~research_turn~%s;<]button[%s,0.25;1,0.5;research~research_turn~%s;>]%sbutton[%s,%s;1,1;research~chapter_open~%s;%s]")
				:format(h - 0.4, S("gui.research_book.pagenum @1@2@3", research.name, k, #text), w - 2, k - 1, w - 1, k + 1, v[1], w - 1, h - 0.6, research.chapter, S("gui.research_book.back")),
				size = ("size[%s,%s]"):format(w, h),
			}
			if v[5] and v[5] ~= 0 and not res.player_stuff[pn].researches[researchid.."__"..k] then
				res.player_stuff[pn].research_array[2][k] = {
					text = ("label[0,%s;%s]button[%s,0.25;1,0.5;research~research_turn~%s;<]button[%s,0.25;1,0.5;research~research_turn~%s;>]button[0,0;%s,1;research~unlock~%s;%s]"..
					"button[%s,%s;1,1;research~chapter_open~%s;%s]")
					:format(h - 0.4, S("gui.research_book.pagenum @1@2@3", research.name, k, #text), w - 2, k - 1, w - 1, k + 1, w, k, S("Unlock"), w - 1, h - 0.6, research.chapter, S("Back")),
					size = ("size[%s,%s]"):format(w, h),
					reqs = {},
				}
				label = v[4]
				for k2,v2 in pairs(v[5]) do
					label = label..S("gui.research_book.sub_research @1@2@3", trinium.adequate_text(k2), v2, res.player_stuff[pn].data.aspects[k2] or 0)
					res.player_stuff[pn].research_array[2][k].reqs[k2] = v2
				end
				res.player_stuff[pn].research_array[2][k].text = res.player_stuff[pn].research_array[2][k].text.."textarea[0,1;8,7;;;"..label.."]"
			end
		end
	end
	local page = tonumber(page)
	return (res.player_stuff[pn].research_array[2][page] or {}).text or res.player_stuff[pn].research_array[1][page].text, res.player_stuff[pn].research_array[1][page].size, 
		--("bgcolor[#080808BB;true]background[0,0;1,1;research_bg_tier_%s.png;true]"):format(res.chapters[res.researches[researchid].chapter].tier)
		"bgcolor[#080808BB;true]background[0,0;1,1;research_bg_tier_1.png;true]"
end

local function get_book_bg(pn)
	local w = res.player_stuff[pn].researches._strings
	return ("bgcolor[#080808BB;true]background[0,0;1,1;research_bg_tier_%s.png;true]")
		:format(w["CognFission"] and 4 or w["CognVoid"] and 3 or w["CognWarp"] and 2 or 1)
end

local function get_book_chapter_bg(chapterid)
	local w = res.chapters[chapterid]
	return ("bgcolor[#080808BB;true]background[0,0;1,1;research_bg_tier_%s.png;true]"):format(w.tier)
end

local book = {title = S("gui.inventory.research_book")}
function book:get(player, context)
	local pn = player:get_player_name()
	context.book = context.book or "defaultbg"
	context.book_x = context.book_x or 0
	context.book_y = context.book_y or 0
	local split = context.book:split("~")
	if split[1] == "defaultbg" then
		return sfinv.make_formspec(player, context, get_book_fs(pn), false, false, get_book_bg(pn))
	elseif split[1] == "chapter" then
		return sfinv.make_formspec(player, context, 
				get_book_chapter_fs(split[2], pn, context.book_x, context.book_y), false, false, get_book_chapter_bg(split[2]))
	elseif split[1] == "research" then
		local t,s,bg = get_book_research_fs(split[2], pn, split[3], split[4])
		return sfinv.make_formspec(player, context, t, false, s, bg)
	end
end

function book:on_player_receive_fields(player, context, fields)
	if fields.quit then return end
	local pn = player:get_player_name()
	for k,v in pairs(fields) do
		if k == "key_up" then
			context.book_y = context.book_y - 1
		elseif k == "key_down" then
			context.book_y = context.book_y + 1
		else
			local ksplit = k:split("~") -- Module, action, parameters
			if ksplit[1] == "research" then
				local a = ksplit[2]
				if a == "chapter_open" then
					context.book = "chapter~"..ksplit[3]
				elseif a == "book" then
					context.book = "defaultbg"
					context.book_x = 0
					context.book_y = 0
				elseif a == "research_open" then
					context.book = ("research~%s~1~1"):format(ksplit[3])
				elseif a == "research_turn" then
					local newp = tonumber(ksplit[3])
					if newp > 0 and #res.player_stuff[pn].research_array[1] >= newp then
						context.book = ("research~%s~%s~0"):format(context.book:split("~")[2], ksplit[3])
					end
				elseif a == "unlock" then
					local k1 = tonumber(ksplit[3])
					if not table.every(res.player_stuff[pn].research_array[2][k1].reqs, function(v, k) return res.player_stuff[pn].data.aspects[k] and res.player_stuff[pn].data.aspects[k] >= v end) then
						cmsg.push_message_player(player, S("gui.info.no_aspects"))
						return
					end
					table.exists(res.player_stuff[pn].research_array[2][k1].reqs, function(v, k) res.player_stuff[pn].data.aspects[k] = res.player_stuff[pn].data.aspects[k] - v end)
					res.player_stuff[pn].research_array[2][k1] = nil
					res.player_stuff[pn].researches[context.book:split("~")[2].."__"..ksplit[3]] = 1
					context.book = ("research~%s~%s~1"):format(context.book:split("~")[2], ksplit[3])
				elseif a == "get_sheet" then
					local inv = player:get_inventory()
					if inv:contains_item("main", "trinium:research_notes___"..ksplit[3]) or inv:contains_item("main", "trinium:discovery___"..ksplit[3]) then
						cmsg.push_message_player(player, S("gui.info.use_notes"))
						return
					elseif res.player_stuff[pn].data.ink < 3 then
						cmsg.push_message_player(player, S("gui.info.no_ink"))
						return
					elseif res.player_stuff[pn].data.paper < 1 then
						cmsg.push_message_player(player, S("gui.info.no_paper"))
						return
					end
					res.player_stuff[pn].data.ink = res.player_stuff[pn].data.ink - 3
					res.player_stuff[pn].data.paper = res.player_stuff[pn].data.paper - 1
					inv:add_item("main", "trinium:research_notes___"..ksplit[3])
				elseif a == "get_map" then
					if res.player_stuff[pn].data.ink < 500 then
						cmsg.push_message_player(player, S("gui.info.no_ink"))
						return
					end

					local inv = player:get_inventory()
					if not inv:contains_item("main", "trinium:material_dust_diamond 16") then
						cmsg.push_message_player(player, S("gui.info.no_diamond_dust"))
						return
					end

					inv:remove_item("main", "trinium:material_dust_diamond 16")
					res.player_stuff[pn].data.ink = res.player_stuff[pn].data.ink - 500
					inv:add_item("main", "trinium:chapter_map___"..context.book:split("~")[2])
				end
			end
		end
	end
end

sfinv.register_page("trinium:researchbook", book)