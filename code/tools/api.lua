trinium.tool_system = {}
local ts = trinium.tool_system

ts.materials = {}
function ts.register_tool_material(name, def)
	local ri = assert(minetest.registered_items[name], "Not registered material: "..name)
	ts.materials[name] = def
	local cg = table.copy(ri.groups)
	cg._tool_mat = 1
	cg.usable_in_station = 1
	minetest.override_item(name, {groups = cg})
end

ts.rods = {}
function ts.register_tool_rod(name, def)
	local ri = assert(minetest.registered_items[name], "Not registered material: "..name)
	ts.rods[name] = def
	local cg = table.copy(ri.groups)
	cg._tool_rod = 1
	cg.usable_in_station = 1
	minetest.override_item(name, {groups = cg})
end

ts.templates = {}
function ts.register_template(id, def)
	ts.templates[id] = def
	
	minetest.register_tool("trinium:dynamic_"..id, {
		description = "Fallback Tool",
		inventory_image = "tool_"..id..".png",
		groups = {hidden_from_irp = 1},
		max_stack = 1,
	})
end