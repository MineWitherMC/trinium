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
			buttons = ("%sitem_image_button[%s,%s;1,1;trinium:researchicon___%s___%s;research~chapter_open~%s;]"):format(buttons, v.x, v.y, texture, v.number, k)
		end
	end
	return buttons
end

local function get_book_chapter_fs(chapterid, pn)
	local buttons, texture = "button[7,8;1,1;research~book;"..S("Back").."]"
	if not res.researches_by_chapter[chapterid] then return end
	for k,v in pairs(res.researches_by_chapter[chapterid]) do
		if res.player_stuff[pn].researches[k] or v.pre_unlock then
			texture = v.texture:gsub(":", "__")
			buttons = ("%sitem_image_button[%s,%s;1,1;trinium:researchicon___%s___%s;research~research_open~%s;]"):format(buttons, v.x, v.y, texture, v.number, k)
		elseif table.every(v.requirements, function(a) return res.player_stuff[pn].researches[a] end) then
			texture = v.texture:gsub(":", "__")
			buttons = ("%simage[%s,%s;1,1;research_glowing_underlay.png]item_image_button[%s,%s;1,1;trinium:researchicon___%s___%s;research~get_sheet~%s;]")
				:format(buttons, v.x, v.y, v.x, v.y, texture, v.number, k)
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
			local w, h = math.max(v[2], 8), math.max(v[3], 8.6)
			res.player_stuff[pn].research_array[1][k] = {
				text = ("label[0,%s;%s]button[%s,0.25;1,0.5;research~research_turn~%s;<]button[%s,0.25;1,0.5;research~research_turn~%s;>]%sbutton[%s,%s;1,1;research~chapter_open~%s;%s]")
				:format(h - 0.4, S("Research @1 - page @2", research.name, k), w - 2, k - 1, w - 1, k + 1, v[1], w - 1, h - 0.6, research.chapter, S("Back")),
				size = ("size[%s,%s]"):format(w, h),
			}
			if v[5] and not res.player_stuff[pn].researches[researchid.."__"..k] then
				res.player_stuff[pn].research_array[2][k] = {
					text = ("label[0,%s;%s]button[%s,0.25;1,0.5;research~research_turn~%s;<]button[%s,0.25;1,0.5;research~research_turn~%s;>]button[0,0;%s,1;research~unlock~%s;%s]"..
					"button[%s,%s;1,1;research~chapter_open~%s;%s]")
					:format(h - 0.4, S("Research @1 - page @2", research.name, k), w - 2, k - 1, w - 1, k + 1, w, k, S("Unlock"), w - 1, h - 0.6, research.chapter, S("Back")),
					size = ("size[%s,%s]"):format(w, h),
					reqs = {},
				}
				label = v[4]
				for k2,v2 in pairs(v[5]) do
					label = ("%s\n%s aspect (%s required, %s available)"):format(label, trinium.adequate_text(k2), v2, res.player_stuff[pn].data.aspects[k2] or 0)
					res.player_stuff[pn].research_array[2][k].reqs[k2] = v2
				end
				res.player_stuff[pn].research_array[2][k].text = res.player_stuff[pn].research_array[2][k].text.."label[0,1;"..label.."]"
			end
		end
	end
	local page = tonumber(page)
	return (res.player_stuff[pn].research_array[2][page] or {}).text or res.player_stuff[pn].research_array[1][page].text, res.player_stuff[pn].research_array[1][page].size, 
		("bgcolor[#080808BB;true]background[0,0;1,1;research_bg_tier_%s.png;true]"):format(res.chapters[res.researches[researchid].chapter].tier)
end

local function get_book_bg(pn)
	local w = res.player_stuff[pn].researches._strings
	return ("bgcolor[#080808BB;true]background[0,0;1,1;research_bg_tier_%s.png;true]"):format(w["CognFission"] and 4 or w["CognVoid"] and 3 or w["CognWarp"] and 2 or 1)
end

local function get_book_chapter_bg(chapterid)
	local w = res.chapters[chapterid]
	return ("bgcolor[#080808BB;true]background[0,0;1,1;research_bg_tier_%s.png;true]"):format(w.tier)
end

local book = {title = S("Research Book")}
function book:get(player, context)
	local pn = player:get_player_name()
	context.book = context.book or "defaultbg"
	local split = context.book:split("~")
	if split[1] == "defaultbg" then
		return sfinv.make_formspec(player, context, get_book_fs(pn), false, false, get_book_bg(pn))
	elseif split[1] == "chapter" then
		return sfinv.make_formspec(player, context, get_book_chapter_fs(split[2], pn), false, false, get_book_chapter_bg(split[2]))
	elseif split[1] == "research" then
		local t,s,bg = get_book_research_fs(split[2], pn, split[3], split[4])
		return sfinv.make_formspec(player, context, t, false, s, bg)
	end
end

function book:on_player_receive_fields(player, context, fields)
	if fields.quit then return end
	local pn = player:get_player_name()
	for k,v in pairs(fields) do
		local ksplit = k:split("~") -- Module, action, parameters
		if ksplit[1] == "research" then
			local a = ksplit[2]
			if a == "chapter_open" then
				context.book = "chapter~"..ksplit[3]
			elseif a == "book" then
				context.book = "defaultbg"
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
					cmsg.push_message_player(player, S("Insufficient aspects!"))
					return
				end
				table.exists(res.player_stuff[pn].research_array[2][k1].reqs, function(v, k) res.player_stuff[pn].data.aspects[k] = res.player_stuff[pn].data.aspects[k] - v end)
				res.player_stuff[pn].research_array[2][k1] = nil
				res.player_stuff[pn].researches[context.book:split("~")[2].."__"..ksplit[3]] = 1
				context.book = ("research~%s~%s~1"):format(context.book:split("~")[2], ksplit[3])
			elseif a == "get_sheet" then
				local inv = player:get_inventory()
				if inv:contains_item("main", "trinium:research_notes___"..ksplit[3]) or inv:contains_item("main", "trinium:discovery___"..ksplit[3]) then
					cmsg.push_message_player(player, S("You already have these research notes!"))
					return
				elseif res.player_stuff[pn].data.ink < 3 then
					cmsg.push_message_player(player, S("Insufficient Ink!"))
					return
				elseif res.player_stuff[pn].data.paper < 1 then
					cmsg.push_message_player(player, S("Insufficient Paper!"))
					return
				end
				res.player_stuff[pn].data.ink = res.player_stuff[pn].data.ink - 3
				res.player_stuff[pn].data.paper = res.player_stuff[pn].data.paper - 3
				inv:add_item("main", "trinium:research_notes___"..ksplit[3])
			end
		end
	end
end

sfinv.register_page("trinium:researchbook", book)