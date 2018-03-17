trinium.materials.m = {}
trinium.materials.material_types = {}
trinium.materials.material_interactions = {}
local mat = trinium.materials

function mat.register_material(name, def)
	local def1 = assert(trinium.validate(def, {name = "string", color = "table", types = "table"}))
	local color = ("%xC0"):format(def1.color[1] * 256 * 256 + def1.color[2] * 256 + def1.color[3])
	while #color < 8 do
		color = "0"..color
	end
	local def = def1.types
	local def2 = {
		id = name,
		name = def1.name,
		color = color,
		formula = def1.formula and "\n"..def1.formula or "",
		data = def1.data or {},
		types = def,
	}
	mat.m[def2.id] = def2
	assert(#def >= 1)
	for i = 1, #def do
		assert(mat.material_types[def[i]], "No such material type: "..def[i])
		mat.material_types[def[i]](def2)
	end
	for k,v in pairs(mat.material_interactions) do
		if table.every(v.requirements, function(x) return table.exists(def, function(a) return a == x end) end) then
			v.apply(name, def2.data)
		end
	end
end

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