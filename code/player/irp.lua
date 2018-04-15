local sfinv = trinium.sfinv

local irp = trinium.irp
irp = {}
irp.player_stuff = {}
local S = trinium.S

local S1 = {S"gui.irp_mode.recipe", S"gui.irp_mode.usage", S"gui.irp_mode.cheat"}

local function get_formspec_array(searchstring, mode)
	local ss, items = searchstring:lower()
	local formspec, lengthPerPage, i, j = {}, 56, 0, 1
	items = table.filter(minetest.registered_items, function(v)
			return (
				v.mod_origin ~= "*builtin*" and 
				not (v.groups or {}).hidden_from_irp and 
				((v.description and v.description:lower():find(ss)) or v.name:lower():find(ss))
			)
	end)
	local x, y
	local page_amount = math.max(math.ceil(table.count(items) / lengthPerPage), 1)
	local pa = math.ceil(table.count(items) / lengthPerPage)
	for j = 1, page_amount do
		formspec[j] = ([=[
			field[0.25,8.8;6,0;irp~search;;%s]
			field_close_on_enter[irp~search;false]
			button[6,8.1;1,1;irp~search_use;>>]
			button[7,8.1;1,1;irp~search_clear;X]
			label[1,0.2;%s]
			button[0,0.2;1,0.5;irp~pageopen~-1;<]
			button[7,0.2;1,0.5;irp~pageopen~+1;>]
			button[5,0.2;2,0.5;irp~changemode;%s]
			tooltip[irp~changemode;%s]
		]=]):format(searchstring, S("gui.irp_page @1@2", math.min(j, pa), pa), S"gui.irp_mode.change", 
			S("gui.irp_mode.current @1", S1[mode]))
	end
	j = 1
	local tbl = {}
	for _,iter in pairs(items) do
		tbl[#tbl+1] = iter
	end
	table.sort(tbl, trinium.sortByParam"name")
	for k,v in ipairs(tbl) do
		if v.type ~= "none" then
			x = i % 8
			y = (i - x) / 8
			formspec[j] = formspec[j]..([=[
				item_image_button[%s,%s;1,1;%s;irp~view_recipe~%s;]
			]=]):format(x, y + 1, v.name, v.name)
			i = i + 1
			if i >= lengthPerPage then
				i = 0
				j = j + 1
			end
		end
	end

	if i == 0 then j = j - 1 end
	return formspec, j
end

local function irp_on_join(player)
	local pn = player:get_player_name()
	irp.player_stuff[pn] = {}
	irp.player_stuff[pn].page = 1
	irp.player_stuff[pn].search = ""
	irp.player_stuff[pn].formspecs_array, irp.player_stuff[pn].page_amount = get_formspec_array("", 1)
end

minetest.after(0.1, function()
	for _,player in pairs(minetest.get_connected_players()) do
		irp_on_join(player)
	end
	minetest.register_on_joinplayer(irp_on_join)
end)

local itempanel = {title = S"gui.inventory.irp"}

function itempanel:get(player, context)
	local pn = player:get_player_name()
	return sfinv.make_formspec(player, context, irp.player_stuff[pn].formspecs_array[irp.player_stuff[pn].page], false)
end

function trinium.absolute_draw_recipe(recipes, rec_id)
	local max = #recipes
	if max == 0 then return "", 0, 0, 0 end
	local id = trinium.modulate(rec_id or 1, max)
	local recipe = trinium.recipes.recipe_registry[recipes[id]]
	local method = trinium.recipes.craft_methods[recipe.type]

	local formspec = ("%slabel[0,0;%s]"):format(method.formspec_begin(recipe.data), method.formspec_name)
	local itemname, amount, x, y, arr, chance
	for i = 1, method.input_amount do
		amount = nil
		if recipe.inputs[i] then
			arr = recipe.inputs[i]:split" "
			itemname, amount = unpack(arr)
		else
			itemname = ""
		end
		x, y = method.get_input_coords(i)
		formspec = formspec..("item_image_button[%s,%s;1,1;%s;irp~view_recipe~%s;%s]"):format(x, y, 
				itemname, itemname, amount ~= 1 and amount ~= "1" and amount or "" or "")
	end
	for i = 1, method.output_amount do
		chance, amount = nil, nil
		if recipe.outputs[i] then
			arr = recipe.outputs[i]:split" "
			itemname, amount, chance = unpack(arr)
		else
			itemname = ""
		end
		x, y = method.get_output_coords(i)
		formspec = formspec..("item_image_button[%s,%s;1,1;%s;irp~view_recipe~%s;%s]"):format(x, y, itemname, itemname, 
				table.fconcat({amount ~= 1 and amount ~= "1" and amount or nil, chance and chance.." %" or nil}, "\n"))
	end

	return formspec, method.formspec_width, method.formspec_height, max, id
end

function trinium.draw_recipe(item, player, rec_id, tbl1, rec_method, tbl)
	local recipes = tbl1[item]
	if not recipes then return "", 0, 0, 0 end
	recipes = table.remap(table.filter(recipes, function(v1)
		local v = trinium.recipes.recipe_registry[v1]
		return v.type == (rec_method or v.type) and trinium.recipes.craft_methods[v.type].can_perform(player, v.data)
	end))
	return trinium.absolute_draw_recipe(recipes, rec_id)
end

local R = trinium.recipes.recipes
function trinium.draw_research_recipe(item, num)
	local x = {trinium.absolute_draw_recipe(R[item], num or 1)}
	return x[1], x[2], x[3]
end

local function get_formspec(player, id, item, mode)
	if mode < 3 then
		local formspec, width, height, number, new_id = 
				trinium.draw_recipe(item, player, tonumber(id), mode == 1 and trinium.recipes.recipes or trinium.recipes.usages)
		if not formspec or width == 0 or height == 0 then return end
		formspec = ([=[
			size[%s,%s]
			bgcolor[#080808BB;true]
			background[-0.25,-0.25;%s,%s;gui_formbg.png;]
			%s
			label[0,%s;%s]
		]=]):format(width, height + 0.25, width + 0.5, height + 0.5, 
				formspec, height + 0.2, S("gui.irp_recipe @1@2", new_id, number))

		if number > 1 then
			formspec = formspec..([=[
				button[%s,0;1,0.5;irp~view_recipe~%s~%s;<]
				button[%s,0;1,0.5;irp~view_recipe~%s~%s;>]
			]=]):format(width - 2, item, new_id - 1, width - 1, item, new_id + 1)
		end

		return formspec
	else
		local stack = minetest.registered_items[item].stack_max
		local pn = player
		local player = minetest.get_player_by_name(pn)
		player:get_inventory():add_item("main", item.." "..stack)
		cmsg.push_message_player(player, S("gui.info.given @1@2@3", stack, item, pn))
	end
end

function itempanel:on_player_receive_fields(player, context, fields)
	if fields.quit then return end
	if fields.key_enter then
		fields["irp~search_use"] = 1
	end
	context.irpmode = context.irpmode or 1
	local pn = player:get_player_name()
	for k,v in pairs(fields) do
		local ksplit = k:split("~") -- Module, action, parameters
		if ksplit[1] == "irp" then
			local a = ksplit[2]
			if a == "search_use" then
				irp.player_stuff[pn].formspecs_array, irp.player_stuff[pn].page_amount =
					get_formspec_array(fields["irp~search"], context.irpmode)
			elseif a == "search_clear" then
				irp.player_stuff[pn].formspecs_array, irp.player_stuff[pn].page_amount = 
					get_formspec_array("", context.irpmode)
			elseif a == "pageopen" then
				irp.player_stuff[pn].page = 
					trinium.modulate(irp.player_stuff[pn].page + tonumber(ksplit[3]), irp.player_stuff[pn].page_amount)
			elseif a == "changemode" then
				context.irpmode = context.irpmode % (trinium.creative_mode and 3 or 2) + 1
				irp.player_stuff[pn].formspecs_array, irp.player_stuff[pn].page_amount = 
					get_formspec_array(fields["irp~search"], context.irpmode)
			elseif a == "view_recipe" then
				local fs = get_formspec(pn, ksplit[4] or 1, ksplit[3], context.irpmode)
				if not fs then return end
				minetest.show_formspec(pn, "trinium:irp:recipe_view", fs)
			end
		end
	end
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "" then return end
	local pn = player:get_player_name()
	for k,v in pairs(fields) do
		local ksplit = k:split"~" -- Module, action, parameters
		if ksplit[1] == "irp" then
			local a = ksplit[2]
			if a == "view_recipe" then
				local fs = get_formspec(pn, ksplit[4] or 1, ksplit[3], trinium.sfinv.contexts[pn].irpmode)
				if not fs then return end
				minetest.show_formspec(pn, "trinium:irp:recipe_view", fs)
			end
		end
	end
end)

sfinv.register_page("trinium:itempanel", itempanel)