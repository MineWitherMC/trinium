trinium.materials = {}
trinium.materials.m = {}
trinium.materials.material_types = {}
trinium.materials.material_interactions = {}
local mat = trinium.materials

function mat.register_mattype(name, callable)
	assert(not mat.material_types[name], "Material type "..name.." already registered!")
	mat.material_types[name] = callable
end

function mat.register_interaction(name, def)
	assert(not mat.material_interactions[name], "Material interaction "..name.." already registered!")
	assert(trinium.validate(def, {requirements = "table", apply = "function"}))
	mat.material_interactions[name] = def
end

function mat.get_material(name)
	local a = select(3, unpack(name:split("_")))
	return table.concat({a}, "_")
end

mat.elements = {}
mat.materials = {}

local function is_complex(formula)
	return type(formula) == "table" and #formula > 0 and (formula[1][2] > 1 or #formula > 1)
end

mat.data_generators = {}
mat.recipe_generators = {}
function mat.add_data_generator(name, callback) mat.data_generators[name] = callback end
function mat.add_recipe_generator(name, callback) mat.recipe_generators[name] = callback end

function mat.new_material(name, def)
	local name = def.name or name
	if not def.formula_string and def.formula then
		local fs = ""
		for i = 1, #def.formula do
			local n = mat.materials[def.formula[i][1]]
			if not n then n = mat.elements[def.formula[i][1]] end
			assert(n, "Could not find part of "..name)
			local add = n.formula_string or n.formula or ""
			if def.formula[i][2] > 1 and is_complex(n.formula) then
				add = "("..add..")"
			end
			fs = fs..add..(def.formula[i][2] == 1 and "" or def.formula[i][2])
		end
		def.formula_string = fs
	end
	
	if not def.color_string and def.color then
		def.color_string = ("%xC0"):format(def.color[1] * 256 * 256 + def.color[2] * 256 + def.color[3])
		while #def.color_string < 8 do def.color_string = "0"..def.color_string end
	elseif not def.color_string and def.formula then
		local formula1 = table.map(def.formula, function(x) 
				return {(mat.materials[x[1]] or mat.elements[x[1]]).color or {0, 0, 0}, x[2]} 
			end)
		local r, g, b
		r = trinium.weighted_avg(table.map(formula1, function(x) return {x[1][1], x[2]} end))
		g = trinium.weighted_avg(table.map(formula1, function(x) return {x[1][2], x[2]} end))
		b = trinium.weighted_avg(table.map(formula1, function(x) return {x[1][3], x[2]} end))
		
		def.color_string = ("%xC0"):format(math.floor(r + 0.5) * 256 * 256 + math.floor(g + 0.5) * 256 + math.floor(b + 0.5))
		while #def.color_string < 8 do def.color_string = "0"..def.color_string end
	end
	
	local def2 = {
		id = name,
		name = def.description,
		color_string = def.color_string,
		color = def.color,
		formula_string = def.formula_string,
		formula = def.formula,
		data = def.data or {},
		types = def.types,
	}
	mat.materials[name] = def2
	
	local def3 = {
		id = name,
		name = def.description,
		color = def.color_string,
		color_tbl = def.color,
		formula = def.formula_string and "\n"..minetest.colorize("#CCC", def.formula_string) or "",
		formula_tbl = def.formula,
		data = def.data or {},
		types = def.types,
	}
	
	if #def.types > 0 then
		for i = 1, #def.types do
			mat.material_types[def.types[i]](def3)
		end
	end
	
	local object = {}
	function object:generate_recipe(id)
		local reg = assert(mat.recipe_generators[id], "Cannot generate recipe "..id.." for "..name)
		reg(name)
		return self
	end
	
	function object:generate_data(id)
		local reg = assert(mat.data_generators[id], "Cannot generate data "..id.." for "..name)
		def2.data[id] = reg(name)
		return self
	end
	
	function object:generate_interactions()
		for k,v in pairs(mat.material_interactions) do
			if table.every(v.requirements, function(x) return table.exists(def.types, function(a) return a == x end) end) then
				v.apply(name, def2.data or {})
			end
		end
		return self
	end
	
	return object
end

function mat.register_element(name, def) 
	mat.elements[name] = def
	local object = {}
	function object:register_material(def1)
		def1.formula_string = def.formula
		def1.formula = {}
		def1.color = def.color
		def1.data = def
		local m1 = mat.new_material(name, def1)
		m1:generate_interactions()
		return self
	end
	return object
end