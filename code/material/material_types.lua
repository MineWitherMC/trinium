local materials = trinium.materials
materials.register_mattype("plate", function(def)
	minetest.register_craftitem(("trinium:material_plate_%s"):format(def.id), {
		description = S("@1 Plate", def.name)..def.formula,
		inventory_image = "(materials_plate.png^[colorize:#"..def.color..")^materials_plate_overlay.png",
	})
end)


materials.register_mattype("sheet", function(def)
	minetest.register_craftitem(("trinium:material_sheet_%s"):format(def.id), {
		description = S("@1 Sheet", def.name)..def.formula,
		inventory_image = "(materials_plate.png^[colorize:#"..def.color..")^materials_plate_overlay.png",
	})
end)


materials.register_mattype("cell", function(def)
	minetest.register_craftitem(("trinium:material_cell_%s"):format(def.id), {
		description = S("@1 Cell", def.name)..def.formula,
		inventory_image = "(materials_cell.png^[colorize:#"..def.color..")^materials_cell_overlay.png",
	})
end)


materials.register_mattype("ingot", function(def)
	minetest.register_craftitem(("trinium:material_ingot_%s"):format(def.id), {
		description = S("@1 Ingot", def.name)..def.formula,
		inventory_image = "(materials_ingot.png^[colorize:#"..def.color..")^materials_ingot_overlay.png",
	})
end)
materials.register_interaction("ingot_bending", {
	requirements = {"plate", "ingot"},
	apply = function(name, data)
		trinium.register_recipe("trinium:metal_former", {"trinium:material_ingot_"..name}, {"trinium:material_plate_"..name}, {["type"] = "bending"})
	end,
})


materials.register_mattype("gem", function(def)
	minetest.register_craftitem(("trinium:material_gem_%s"):format(def.id), {
		description = def.name..def.formula,
		inventory_image = "materials_gem.png^[colorize:#"..def.color,
	})
end)
materials.register_interaction("gem_ingot_transform", {
	requirements = {"gem", "ingot"},
	apply = function(name, data)
		trinium.register_recipe("trinium:molecular_reconstructor", {"trinium:material_ingot_"..name.." 4"}, {"trinium:material_gem_"..name.." 3"}, {["type"] = "compressing", tier = 7, base_sg_per_tick = 12})
		trinium.register_recipe("trinium:molecular_reconstructor", {"trinium:material_gem_"..name.." 4"}, {"trinium:material_ingot_"..name.." 3"}, {["type"] = "melting", tier = 7, base_sg_per_tick = 12})
	end,
})


materials.register_mattype("dust", function(def)
	minetest.register_craftitem(("trinium:material_dust_%s"):format(def.id), {
		description = S("@1 Dust", def.name)..def.formula,
		inventory_image = "(materials_dust.png^[colorize:#"..def.color..")^materials_dust_overlay.png",
	})
end)
materials.register_interaction("dust_smelting", {
	requirements = {"dust", "ingot"},
	apply = function(name, data)
		trinium.register_recipe("trinium:grinder", {"trinium:material_ingot_"..name}, {"trinium:material_dust_"..name}, {})
		trinium.register_recipe("trinium:blast_furnace", {"trinium:material_dust_"..name}, {"trinium:material_ingot_"..name}, {melting_point = data.melting_point})
	end,
})
materials.register_interaction("dust_implosion", {
	requirements = {"dust", "gem"},
	apply = function(name, data)
		trinium.register_recipe("trinium:grinder", {"trinium:material_gem_"..name}, {"trinium:material_dust_"..name}, {})
		trinium.register_recipe("trinium:implosion", {"trinium:material_dust_"..name.." 4"}, {"trinium:material_gem_"..name.." 3"}, {})
	end,
})


materials.register_mattype("water_cell", function(def)
	minetest.register_craftitem(("trinium:material_cell_%s"):format(def.id), {
		description = S("@1 Cell", def.name)..def.formula,
		inventory_image = "(materials_cell.png^[colorize:#"..def.color..")^materials_cell_overlay.png",
	})
end)
materials.register_interaction("water_mixing", {
	requirements = {"dust", "water_cell"},
	apply = function(name, data)
		trinium.register_recipe("trinium:mixer", {"trinium:material_dust_"..name, "trinium:material_cell_empty", [7] = "trinium:material_water_source 1000"}, {"trinium:material_cell_"..name}, {velocity = data.water_mix_velocity})
	end,
})


materials.register_mattype("rod", function(def)
	minetest.register_craftitem(("trinium:material_rod_%s"):format(def.id), {
		description = S("@1 Rod", def.name)..def.formula,
		inventory_image = "(materials_rod.png^[colorize:#"..def.color..")^materials_rod_overlay.png",
	})
end)
materials.register_interaction("gem_lathing", {
	requirements = {"rod", "gem"},
	apply = function(name, data)
		trinium.register_recipe("trinium:metal_former", {"trinium:material_gem_"..name}, {"trinium:material_rod_"..name.." 2"}, {["type"] = "lathing"})
	end,
})
materials.register_interaction("ingot_lathing", {
	requirements = {"rod", "ingot"},
	apply = function(name, data)
		trinium.register_recipe("trinium:metal_former", {"trinium:material_ingot_"..name}, {"trinium:material_rod_"..name.." 2"}, {["type"] = "lathing"})
	end,
})


materials.register_mattype("ring", function(def)
	minetest.register_craftitem(("trinium:material_ring_%s"):format(def.id), {
		description = S("@1 Ring", def.name)..def.formula,
		inventory_image = "(materials_ring.png^[colorize:#"..def.color..")^materials_ring_overlay.png",
	})
end)
materials.register_interaction("rod_hammering", {
	requirements = {"rod", "ring"},
	apply = function(name, data)
		trinium.register_recipe("trinium:metal_former", {"trinium:material_rod_"..name}, {"trinium:material_ring_"..name.." 2"}, {["type"] = "hammering"})
	end,
})


materials.register_mattype("brick", function(def)
	minetest.register_craftitem(("trinium:material_brick_%s"):format(def.id), {
		description = S("@1 Brick", def.name)..def.formula,
		inventory_image = "materials_ingot.png^[colorize:#"..def.color,
	})
end)
materials.register_interaction("brick_compression", {
	requirements = {"dust", "brick"},
	apply = function(name, data)
		trinium.register_recipe("trinium:metal_former", {"trinium:material_dust_"..name}, {"trinium:material_brick_"..name}, {["type"] = "compressing"})
	end,
})


materials.register_mattype("ore", function(def)
	local def1 = {
		description = S("@1 Ore", def.name),
		groups = {harvested_by_pickaxe = def.data.hardness or 4},
		tiles = {"stone.png^(oreoverlay.png^[colorize:#"..def.color..")"},
	}
	if table.exists(def.types, function(x) return x == "gem" end) then
		def1.drop = "trinium:material_gem_"..def.id
	end
	minetest.register_node(("trinium:material_ore_%s"):format(def.id), def1)
end)
materials.register_interaction("ore_grinding", {
	requirements = {"ore", "dust"},
	apply = function(name, data)
		if not minetest.registered_items["trinium:material_gem_"..name] then
			trinium.register_recipe("trinium:grinder", {"trinium:material_ore_"..name}, {"trinium:material_dust_"..name.." 3"}, {})
		else
			trinium.register_recipe("trinium:grinder", {"trinium:material_ore_"..name}, {"trinium:material_dust_"..name, "trinium:material_gem_"..name.." 2"}, {})
		end
	end,
})