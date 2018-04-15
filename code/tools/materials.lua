local ts = trinium.tool_system
local S = trinium.S
local M = trinium.materials.materials

ts.register_tool_material("trinium:rock", {
	name = S"tool.material.rock",
	durability = 40,
	level = 0,
	time_mult = 10,
})

ts.register_tool_material(M.bronze:get("ingot"), {
	name = S"tool.material.bronze",
	durability = 50,
	level = 1,
	time_mult = 24,
})

ts.register_tool_material(M.bronze:get("ingot"), {
	name = S"tool.material.iron",
	durability = 70,
	level = 1,
	time_mult = 22,
})

ts.register_tool_rod("trinium:stick", {
	name = S"tool.rod.stick",
	durability = 1,
	level = 1,
	time_mult = 1,
})

ts.register_tool_rod(M.copper:get("rod"), {
	name = S"tool.rod.copper",
	durability = 1.1,
	level = 1,
	time_mult = 1.25,
})