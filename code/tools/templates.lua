local ts = trinium.tool_system
local S = trinium.S

ts.register_template("axe", {
	name = function(inputs)
		return S("tool.type.axe @1", inputs)
	end,
	
	schematic = "MMM__ MMMM_ MMR__ __R__ __R__",
	
	apply = function(stack, capabilities)
		local meta = stack:get_meta()
		meta:set_string("description", meta:get_string"description"..
				"\n"..S("tool.capability.speed @1", capabilities.time_mult / 10)..
				"\n"..S("tool.capability.durability @1", capabilities.durability)..
				"\n"..S("tool.capability.level @1", capabilities.level))
		meta:set_tool_capabilities({
			full_punch_interval = 1.0,
			max_drop_level = capabilities.level,
			groupcaps = {
				harvested_by_axe = {
					times = {30 / capabilities.time_mult, 22 / capabilities.time_mult, 15 / capabilities.time_mult}, 
					uses = capabilities.durability,
					maxlevel = capabilities.level,
				},
			},
		})
		return stack
	end,
})

ts.register_template("shovel", {
	name = function(inputs)
		return S("tool.type.shovel @1", inputs)
	end,
	
	schematic = "_MM__ _MMM_ _MRM_ __R__ __R__",
	
	apply = function(stack, capabilities)
		local meta = stack:get_meta()
		meta:set_string("description", meta:get_string"description"..
				"\n"..S("tool.capability.speed @1", capabilities.time_mult / 10)..
				"\n"..S("tool.capability.durability @1", capabilities.durability)..
				"\n"..S("tool.capability.level @1", capabilities.level))
		meta:set_tool_capabilities({
			full_punch_interval = 1.0,
			max_drop_level = capabilities.level,
			groupcaps = {
				harvested_by_shovel = {
					times = {30 / capabilities.time_mult, 22 / capabilities.time_mult, 15 / capabilities.time_mult}, 
					uses = capabilities.durability,
					maxlevel = capabilities.level,
				},
			},
		})
		return stack
	end,
})

ts.register_template("pickaxe", {
	name = function(inputs)
		return S("tool.type.pickaxe @1", inputs)
	end,
	
	schematic = "_MMM_ M_R_M __R__ __R__ __R__",
	
	apply = function(stack, capabilities)
		local meta = stack:get_meta()
		meta:set_string("description", meta:get_string"description"..
				"\n"..S("tool.capability.speed @1", capabilities.time_mult / 10)..
				"\n"..S("tool.capability.durability @1", capabilities.durability)..
				"\n"..S("tool.capability.level @1", capabilities.level))
		meta:set_tool_capabilities({
			full_punch_interval = 1.0,
			max_drop_level = capabilities.level,
			groupcaps = {
				harvested_by_pickaxe = {
					times = {30 / capabilities.time_mult, 22 / capabilities.time_mult, 15 / capabilities.time_mult}, 
					uses = capabilities.durability,
					maxlevel = capabilities.level,
				},
			},
		})
		return stack
	end,
})