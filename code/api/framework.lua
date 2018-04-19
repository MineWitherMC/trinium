-- Insecure env things
local envir = ...
local function mkdir(name)
	if not io.open(name) then
		envir.os.execute("mkdir \""..name.."\"")
	end
end

-- Various table things
function table.copy(array)
	return minetest.deserialize(minetest.serialize(array))
end

function table.count(array)
	local a = 0
	for k,v in pairs(array) do
		a = a + 1
	end
	return a
end

function table.filter(array, callable)
	local array, j = table.copy(array)
	for k,v in pairs(array) do
		if not callable(v,k) then
			array[k] = nil
		end
	end
	return array
end

function table.exists(array, callable)
	for k,v in pairs(array) do
		if callable(v,k) then
			return k or true
		end
	end
	return false
end

function table.every(array, callable)
	return not table.exists(array, function(v,k) return not callable(v,k) end)
end

function table.walk(array, callable, cond)
	cond = cond or function() return end
	for k,v in pairs(array) do
		callable(v,k)
		if cond() then break end
	end
end

function table.map(array, callable)
	local array = table.copy(array)
	for k,v in pairs(array) do
		array[k] = callable(v,k)
	end
	return array
end

function table.remap(array)
	local array2 = {}
	for k,v in ipairs(array) do
		table.insert(array2, v)
	end
	return array2
end

function table.intersect_key_rev(arr1, arr2)
	return table.filter(arr1, function(v, k) return not arr2[k] end)
end

function table.keys(t)
	local keys = {}
	for k in pairs(t) do table.insert(keys, k) end
	return keys
end

local function iterator(callback)
	return function(max, current)
		if max == current then return end
		current = current + 1
		return callback(current)
	end
end

function table.asort(t, callable)
	callable = callable or function(a, b) return a < b end
	local k = table.keys(t)
	table.sort(k, function(a, b) return callable(t[a], t[b]) end)
	
	return iterator(function(current) return current, k[current], t[k[current]] end), #k, 0
end

function table.sum(t)
	local k = 0
	table.walk(t, function(v) k = k + v end)
	return k
end

function table.fconcat(t, x)
	x = x or ""
	local str = ""
	table.walk(t, function(v) str = str..x..v end)
	return str:sub(x:len())
end

function table.tail(t)
	local function helper(head, ...) return #{...} > 0 and {...} or nil end
	return helper((table.unpack or unpack)(t))
end

function table.mtail(t, mult)
	local k = t
	for i = 1, mult do k = table.tail(k) end
	return k
end

-- Basic functions
function trinium.sortByParam(param)
	return function(a, b)
		return a[param] < b[param]
	end
end

-- {{amount1, weight1}, {amount2, weight2}, ...}
function trinium.weighted_avg(t)
	local t1 = table.map(t, function(v) return v[1] * v[2] end)
	local t2 = table.map(t, function(v) return v[2] end)
	return table.sum(t1) / table.sum(t2)
end

function trinium.weighted_random(mas)
    local j = table.sum(mas)
    local k = math.random(1, j)
    local i = 1
    while k > mas[i] do
        k = k - mas[i]
        i = i + 1
    end
    return i
end

function trinium.roman_number(a)
	local one = {"", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"}
	local ten = {"", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"}
	local hun = {"", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"}
	local k = a
	local str = ""
	while k >= 1000 do
		k = k - 1000
		str = str.."M"
	end
	
	str = str..hun[(k - k % 100)/100 + 1]
	str = str..ten[(k % 100 - k % 10)/10 + 1]
	str = str..one[k % 10 + 1]
	return str
end

function trinium.dump(...)
	local string, add = ""
	for _,x in ipairs{...} do 
		if type(x) == type(nil) then
			add = "nil"
		elseif type(x) == "userdata" then
			add = "{userdata}"
		else
			add = minetest.serialize(x)
			if add:sub(1, 7) == "return " then
				add = add:sub(8)
			end
			if type(x) == "string" then
				add = add:sub(2, -2)
			end
		end
		string = string..add.."  " 
	end
	minetest.log("warning", string:sub(1, -3))
end

function trinium.modulate(num, max)
	while num < 1 do num = num + max end
	return (num - 1) % max + 1
end

function trinium.validate(array, def)
	for k,v in pairs(def) do
		if type(array[k]) ~= v then
			return nil, "Invalid type for "..k..": "..v.." expected, "..type(array[k]).." given"
		end
	end
	return array
end

function trinium.adequate_text(str)
	return str:sub(1,1):upper()..str:sub(2):lower()
	--return string.gsub(" "..str, "%W%l", string.upper):sub(2)
end

function trinium.adequate_text2(str)
	return trinium.adequate_text(str):gsub("_", " ")
end

function trinium.setting_get(name, default)
	local s = minetest.settings:get(name)
	if not s then
		minetest.settings:set(name, default)
		s = default
	end
	return s
end

function vector.stringify(v)
	return v.x..","..v.y..","..v.z
end

function vector.destringify(v)
	local s = v:split(",")
	return {x = s[1], y = s[2], z = s[3]}
end

trinium.ln2 = math.log(2)
function trinium.lograndom(a1, b1) -- more similar to normal
	if b1 then
		local lr, lr1 = 0, 0
		local a, b = a1 - 1, b1 + 1
		repeat
			lr = (trinium.lograndom() + 1) / 5.7 -- this probably has values from 0...1
			if lr < 0 then lr = 0 end; if lr > 1 then lr = 1 end
			lr1 = math.floor(a + (b - a) * lr)
		until lr1 > a and lr1 < b
		return lr1
	end
	return 2 + 0.33 * math.log(1 / math.random() - 1) / trinium.ln2
end

function trinium.formspec_restore(str)
	return str:gsub("\\\\", "\\"):gsub("\\%[", "["):gsub("\\%]", "]"):gsub("\\,", ","):gsub("\\;", ";")
end

-- Data
local datas = {}
function trinium.get_data_pointer(player, file)
	local x = {}
	datas[player] = datas[player] or {}
	datas[player][file] = x

	local dir1 = minetest.get_worldpath().."/data/"
	mkdir(dir1)

	local dir2 = dir1..player
	mkdir(dir2)

	local filename = dir2.."/"..file..".data"
	local handler = io.open(filename, "a+")
	if not handler then
		handler = assert(io.open(filename, "w"))
	end

	x._filename = filename
	x._strings = assert(minetest.deserialize("local p = {\n"..handler:read("*all").."\n}\nreturn p"))
	handler:close()

	function x:save()
		local handler = io.open(self._filename, "w")
		for k,v in pairs(self._strings) do
			handler:write("['"..k.."'] = "..minetest.serialize(v):sub(8)..",\n")
		end
		handler:close()
	end

	setmetatable(x, {__newindex = function(t,k,v) t._strings[k] = v end, __index = x._strings})
	return x
end

minetest.register_on_leaveplayer(function(player)
	if datas[player] then
		for k,v in pairs(datas[player]) do
			v:save()
		end
	end
end)

minetest.register_on_shutdown(function() 
	for k,v in pairs(datas) do
		for k2,v2 in pairs(v) do
			v2:save()
		end
	end
end)

-- Fluid-Api
function trinium.register_fluid(srcname, flname, srcdescr, fldescr, color, def)
	def = table.copy(def)
	def.paramtype = "light"
	def.walkable = false
	def.pointable = false
	def.diggable = false
	def.buildable_to = true
	def.is_ground_content = false
	def.drowning = 1
	def.drop = ""
	def.liquid_alternative_flowing = flname
	def.liquid_alternative_source = srcname
	def.groups = def.groups or {}
	def.groups.liquid = 3
	def.post_effect_color = {a = 103, r = 30, g = 60, b = 90}
	local def2 = table.copy(def)

	def.drawtype = "liquid"
	def.tiles = {
		{
			name = "fluid_source.png^[colorize:#"..color.."C0",
			animation = {
				type = "vertical_frames",
				aspect_w = 32,
				aspect_h = 32,
				length = 2.0,
			},
		}
	}
	def.liquidtype = "source"
	def.description = srcdescr
	minetest.register_node(srcname, def)

	def2.drawtype = "flowingliquid"
	def2.paramtype2 = "flowingliquid"
	def2.groups.hidden_from_irp = 1
	def2.tiles = {"fluid_basic.png^[colorize:#"..color.."C0"}
	def2.special_tiles = {
		{
			name = "fluid_flowing.png^[colorize:#"..color.."C0",
			animation = {
				type = "vertical_frames",
				aspect_w = 64,
				aspect_h = 64,
				length = 0.8,
			},
			backface_culling = false,
		},
		{
			name = "fluid_flowing.png^[colorize:#"..color.."C0",
			animation = {
				type = "vertical_frames",
				aspect_w = 64,
				aspect_h = 64,
				length = 0.8,
			},
			backface_culling = true,
		},
	}
	def2.liquidtype = "flowing"
	def2.description = fldescr
	minetest.register_node(flname, def2)
end
trinium.register_liquid = trinium.register_fluid

-- Recipes
trinium.recipes = {
	craft_methods = {},
	usages = {},
	recipes = {},
	recipes_by_method = {},
	recipe_registry = {},
}

function trinium.recipe_stringify(size, inputs)
	inputs = table.copy(inputs)
	for i = 1, size do
		inputs[i] = inputs[i] or ""
	end
	return table.concat(inputs, ":")
end

function trinium.register_recipe(method, inputs, outputs, data)
	-- Assertions
	data = data or {}
	assert(type(method) == "string", "Incorrect method type: "..type(method))
	local method_table = assert(trinium.recipes.craft_methods[method], "Method "..method.." not found!")

	-- Processing inputs (e.g., MC method of creating workbench recipes)
	inputs = method_table.process_inputs(inputs)
	outputs = method_table.process_outputs(outputs)
	data = method_table.process_data(data)
	
	if inputs == -1 or outputs == -1 or data == -1 then return end
	assert(trinium.validate({input = inputs, output = outputs, data = data}, {input = "table", output = "table", data = "table"}))

	-- Redoing all the redirects
	local redirects, method_string = {method = 1}
	while type(method_table.callback(inputs, outputs, data)) == "string" do
		method_string = method
		method = method_table.callback(inputs, outputs, data)
		assert(not redirects[method], "Infinite loop detected!")
		redirects[method] = 1
		method_table = assert(trinium.recipes.craft_methods[method], "Method "..method.." not found!")
	end

	assert(#inputs <= method_table.input_amount, "Too many inputs! Expected "..method_table.input_amount.." or less, got "..#inputs)
	assert(#outputs <= method_table.output_amount, "Too many outputs! Expected "..method_table.output_amount.." or less, got "..#outputs)
	assert(method_table.recipe_correct(data), "Recipe data incorrect!")
	
	data.author_mod = minetest.get_current_modname() or "???"

	-- Registering recipe
	local new_amount = #trinium.recipes.recipe_registry + 1
	trinium.recipes.recipe_registry[new_amount] = {
		["type"] = method,
		inputs = inputs,
		outputs = outputs,
		data = data,
		inputs_string = trinium.recipe_stringify(method_table.input_amount, inputs),
	}

	local k
	local cache = {}
	if not data.secret_recipe and method_table.callback(inputs, outputs, data) then
		for i,v in pairs(inputs) do
			k = v:split(" ")[1]
			if not cache[k] then
				cache[k] = 1
				trinium.recipes.usages[k] = trinium.recipes.usages[k] or {}
				table.insert(trinium.recipes.usages[k], new_amount)
			end
		end
		cache = {}
		for i,v in pairs(outputs) do
			k = v:split(" ")[1]
			if not cache[k] then
				cache[k] = 1
				trinium.recipes.recipes[k] = trinium.recipes.recipes[k] or {}
				table.insert(trinium.recipes.recipes[k], new_amount)
			end
		end
		table.insert(trinium.recipes.recipes_by_method[method], new_amount)
	end
end

function trinium.register_recipe_handler(method, table)
	assert(not trinium.recipes.craft_methods[method], "Method "..method.." already registered!")
	trinium.recipes.craft_methods[method] = table
	trinium.recipes.craft_methods[method].callback = trinium.recipes.craft_methods[method].callback or function(inputs, outputs, data) return true end
	trinium.recipes.craft_methods[method].recipe_correct = trinium.recipes.craft_methods[method].recipe_correct or function(data) return true end
	trinium.recipes.craft_methods[method].process_inputs = trinium.recipes.craft_methods[method].process_inputs or function(inputs) return inputs end
	trinium.recipes.craft_methods[method].process_outputs = trinium.recipes.craft_methods[method].process_outputs or function(outputs) return outputs end
	trinium.recipes.craft_methods[method].process_data = trinium.recipes.craft_methods[method].process_data or function(data) return data end
	trinium.recipes.craft_methods[method].formspec_begin = trinium.recipes.craft_methods[method].formspec_begin or function(data) return "" end
	trinium.recipes.craft_methods[method].test = trinium.recipes.craft_methods[method].test or function(recipe_data, actual_data) return true end
	trinium.recipes.craft_methods[method].can_perform = trinium.recipes.craft_methods[method].can_perform or function(pn, recipe_data) return true end
	trinium.recipes.recipes_by_method[method] = {}
end

function trinium.can_perform(player_encoded, recipe_id, recipe_method)
	local rec = trinium.recipes.recipe_registry[recipe_id]
	local method = trinium.recipes.craft_methods[recipe_method]
	return method.can_perform(player_encoded:get_meta():get_string("player"), rec.data)
end

function trinium.valid_recipe(pattern, recipe_method, data)
	local method, recipelist = trinium.recipes.craft_methods[recipe_method], table.copy(trinium.recipes.recipes_by_method[recipe_method])
	local rev = {}
	table.walk(recipelist, function(v, k)
		recipelist[k] = trinium.recipes.recipe_registry[v]
		rev[recipelist[k]] = v
	end)
	local pattern_inputs = minetest.deserialize(pattern:get_meta():get_string("inputs"))
	pattern_inputs = table.filter(pattern_inputs, function(k) return k ~= "" end)
	local recipe = table.exists(recipelist, function(v, k)
		return table.every(v.inputs, function(r)
			return table.exists(pattern_inputs, function(p)
				return p == r or p.." 1" == r or p == r.." 1"
			end)
		end) and table.every(pattern_inputs, function(p)
			return table.exists(v.inputs, function(r)
				return p == r or p.." 1" == r or p == r.." 1"
			end)
		end)
	end)

	if not recipe then return end
	recipe = recipelist[recipe]
	if not recipe then return end
	if not method.test(recipe.data, data) then return end
	return rev[recipe] or false
end

function trinium.has_inputs_for_recipe(recipe, inv, list)
	local inputs = minetest.deserialize(recipe:get_meta():get_string("inputs"))
	return table.every(inputs, function(r) return inv:contains_item(list, r) end)
end

function trinium.draw_inputs_for_recipe(recipe, inv, list, id)
	local inputs = minetest.deserialize(recipe:get_meta():get_string("inputs"))
	table.walk(inputs, function(r) inv:remove_item(list, r) end)
	return table.concat(trinium.recipes.recipe_registry[id].outputs, ";")
end

-- Multiblock API
for i = 3, 13, 2 do
	for j = 3, 13 do
		trinium.register_recipe_handler(("multiblock_%s_%s"):format(i,j), {
			input_amount = i * j,
			output_amount = 1,
			get_input_coords = function(n)
				return trinium.modulate(n, i) - 1, math.ceil(n / i)
			end,
			get_output_coords = function(n)
				return i + 1, (j + 1) / 2
			end,
			formspec_width = i + 2,
			formspec_height = j + 2,
			formspec_name = trinium.S"gui.recipe_method.multiblock",
			formspec_begin = function(data)
				return ("label[0,%s;%s]"):format(j + 1, trinium.S("gui.multiblock.height @1", data.h))
			end,
		})
	end
end

function trinium.register_multiblock(name, def)
	if not def.activator and def.map then
		def.activator = function(reg) return reg(def.map) end
	end

	def = assert(trinium.validate(def, {width = "number", height_d = "number", height_u = "number", depth_b = "number", depth_f = "number", activator = "function", controller = "string"}))
	if def.map and def.width < 7 and def.width > 0 and def.depth_b + def.depth_f < 13 and def.depth_b + def.depth_f > 1 then
		for i = -def.height_d, def.height_u do
			local newmap = table.filter(def.map, function(x) return x.y == i end)
			if i == 0 then
				table.insert(newmap, {x = 0, y = 0, z = 0, name = def.controller})
			end
			local map1 = {}
			for k = -def.depth_f, def.depth_b do
			for j = -def.width, def.width do
				local res = table.exists(newmap, function(a) return a.x == j and a.z == k end)
				if res then
					map1[j + def.width + (def.depth_b - k) * (def.width * 2 + 1) + 1] = newmap[res].name
				end
			end
			end
			trinium.register_recipe(("multiblock_%s_%s"):format(def.width * 2 + 1, def.depth_b + def.depth_f + 1), map1, {def.controller}, {h = i})
		end
	end

	minetest.register_abm({
		label = def.label,
		nodenames = def.controller,
		interval = 5,
		chance = 1,
		action = function(pos, node)
			local dir = vector.multiply(minetest.facedir_to_dir(node.param2), -1)
			local x_min, x_max, y_min, y_max, z_min, z_max = 
				dir.x == 0 and -def.width or dir.x == 1 and -def.depth_b or -def.depth_f,
				dir.x == 0 and def.width or dir.x == 1 and def.depth_f or def.depth_b,
				-def.height_d,
				def.height_u,
				dir.z == 0 and -def.width or dir.z == 1 and -def.depth_b or -def.depth_f,
				dir.z == 0 and def.width or dir.z == 1 and def.depth_f or def.depth_b

			local rg = {region = {}, counts = {}}

			for x = x_min, x_max do
			for y = y_min, y_max do
			for z = z_min, z_max do
				local crd = vector.add(pos, {x = x, y = y, z = z})
				local nn = minetest.get_node(crd).name
				if nn ~= "air" then
					local depth, rshift = -x * dir.x + -z * dir.z, z * dir.x - x * dir.z
					table.insert(rg.region, {x = rshift, y = y, z = depth, name = nn, actual_pos = crd})
					rg.counts[nn] = (rg.counts[nn] or 0) + 1
				end
			end
			end
			end

			setmetatable(rg, {__call = function(reg, def1)
				assert(type(def1) == "table", "The function must be called with table argument")
				return table.every(def1, function(d)
					return table.exists(rg.region, function(x)
						return x.x == d.x and x.y == d.y and x.z == d.z and x.name == d.name
					end)
				end)
			end})

			local meta = minetest.get_meta(pos)
			local is_active = def.activator(rg)
			meta:set_int("assembled", is_active and 1 or 0)
			if def.after_construct then
				def.after_construct(pos, is_active, rg)
			end
		end,
	})
end

function trinium.translate_requirements(tbl)
	local tbl1 = {}
	for c, k, v in table.asort(tbl, function(a, b) return a > b end) do
		tbl1[#tbl1 + 1] = "\n"..minetest.colorize("#CCC", v.." "..((minetest.registered_nodes[k] or {}).description or "???"))
	end
	return table.concat(tbl1, "")
end

function trinium.mbcr(node, def)
	local tbl = {}
	table.walk(def, function(v)
		if not tbl[v.name] then tbl[v.name] = 0 end
		tbl[v.name] = tbl[v.name] + 1
	end)
	minetest.override_item(node, {
		description = minetest.registered_nodes[node].description..trinium.translate_requirements(tbl)
	})
end

-- Various hacks
local mt_register_item_old = minetest.register_item
function minetest.register_item(name, def, ...)
	def.stack_max = def.stack_max or 72
	if def.drop and def.drop ~= "" then
		trinium.register_recipe("trinium:drop", {name},
			type(def.drop) == "table" and def.drop.items or {def.drop}, 
			{max_items = type(def.drop) == "table" and def.drop.max_items or 99}
		)
	end
	if def.max_stack and def.stack_max == 72 then
		def.stack_max = def.max_stack
		def.max_stack = nil
	end
	return mt_register_item_old(name, def, ...)
end

-- Inventory
function trinium.initialize_inventory(inv, def)
	for k,v in pairs(def) do
		inv:set_size(k,v)
	end
end

function trinium.get_item_identifier(stack)
	local s = stack:to_string():split(" ")
	return s[1]..(s[4] and " "..table.concat(table.mtail(s, 3), " ") or "")
end

-- Palettes
function trinium.recolor_facedir(pos, n) -- n from 0 to 7
	local node = minetest.get_node(pos)
	node.param2 = (node.param2 % 32) + (n * 32)
	minetest.set_node(pos, node)
end
function trinium.get_color_facedir(pos) -- n from 0 to 7
	local node = minetest.get_node(pos)
	return math.floor(node.param2 / 32)
end