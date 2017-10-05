local materials = trinium.materials
materials.register_mattype("plate", function(def)
	minetest.register_craftitem(("trinium:plate_%s"):format(def.id), {
		description = S("@1 Plate", def.name)..def.formula,
		inventory_image = "(materials_plate.png^[colorize:#"..def.color..")^materials_plate_overlay.png"
	})
end)


materials.register_mattype("sheet", function(def)
	minetest.register_craftitem(("trinium:sheet_%s"):format(def.id), {
		description = S("@1 Sheet", def.name)..def.formula,
		inventory_image = "(materials_plate.png^[colorize:#"..def.color..")^materials_plate_overlay.png"
	})
end)


materials.register_mattype("cell", function(def)
	minetest.register_craftitem(("trinium:cell_%s"):format(def.id), {
		description = S("@1 Cell", def.name)..def.formula,
		inventory_image = "(materials_cell.png^[colorize:#"..def.color..")^materials_cell_overlay.png"
	})
end)


materials.register_mattype("ingot", function(def)
	minetest.register_craftitem(("trinium:ingot_%s"):format(def.id), {
		description = S("@1 Ingot", def.name)..def.formula,
		inventory_image = "(materials_ingot.png^[colorize:#"..def.color..")^materials_ingot_overlay.png"
	})
end)
materials.register_interaction("ingot_bending", {
	requirements = {"plate", "ingot"},
	apply = function(name, data)
		trinium.register_recipe("metal_former", {"trinium:ingot_"..name}, {"trinium:plate_"..name}, {["type"] = "bending"})
	end,
})


materials.register_mattype("gem", function(def)
	minetest.register_craftitem(("trinium:gem_%s"):format(def.id), {
		description = def.name..def.formula,
		inventory_image = "materials_gem.png^[colorize:#"..def.color
	})
end)
materials.register_interaction("gem_ingot_transform", {
	requirements = {"gem", "ingot"},
	apply = function(name, data)
		trinium.register_recipe("trinium:molecular_reconstructor", {"trinium:ingot_"..name.." 4"}, {"trinium:gem_"..name.." 3"}, {["type"] = "compressing", tier = 7, base_sg_per_tick = 12})
		trinium.register_recipe("trinium:molecular_reconstructor", {"trinium:gem_"..name.." 4"}, {"trinium:ingot_"..name.." 3"}, {["type"] = "melting", tier = 7, base_sg_per_tick = 12})
	end,
})


materials.register_mattype("dust", function(def)
	minetest.register_craftitem(("trinium:dust_%s"):format(def.id), {
		description = S("@1 Dust", def.name)..def.formula,
		inventory_image = "(materials_dust.png^[colorize:#"..def.color..")^materials_dust_overlay.png"
	})
end)
materials.register_interaction("dust_smelting", {
	requirements = {"dust", "ingot"},
	apply = function(name, data)
		trinium.register_recipe("trinium:grinder", {"trinium:ingot_"..name}, {"trinium:dust_"..name}, {})
		trinium.register_recipe("trinium:blast_furnace", {"trinium:dust_"..name}, {"trinium:ingot_"..name}, {melting_point = data.melting_point})
	end,
})
materials.register_interaction("dust_implosion", {
	requirements = {"dust", "gem"},
	apply = function(name, data)
		trinium.register_recipe("trinium:grinder", {"trinium:gem_"..name}, {"trinium:dust_"..name}, {})
		trinium.register_recipe("trinium:implosion", {"trinium:dust_"..name.." 4"}, {"trinium:gem_"..name.." 3"}, {})
	end,
})


materials.register_mattype("water_cell", function(def)
	minetest.register_craftitem(("trinium:cell_%s"):format(def.id), {
		description = S("@1 Cell", def.name)..def.formula,
		inventory_image = "(materials_cell.png^[colorize:#"..def.color..")^materials_cell_overlay.png"
	})
end)
materials.register_interaction("water_mixing", {
	requirements = {"dust", "water_cell"},
	apply = function(name, data)
		trinium.register_recipe("trinium:mixer", {"trinium:dust_"..name, "trinium:cell_empty", [7] = "trinium:water_source 1000"}, {"trinium:cell_"..name}, {velocity = data.water_mix_velocity})
	end,
})


materials.register_mattype("rod", function(def)
	minetest.register_craftitem(("trinium:rod_%s"):format(def.id), {
		description = S("@1 Rod", def.name)..def.formula,
		inventory_image = "(materials_rod.png^[colorize:#"..def.color..")^materials_rod_overlay.png"
	})
end)
materials.register_interaction("gem_lathing", {
	requirements = {"rod", "gem"},
	apply = function(name, data)
		trinium.register_recipe("trinium:metal_former", {"trinium:gem_"..name}, {"trinium:rod_"..name.." 2"}, {["type"] = "lathing"})
	end,
})
materials.register_interaction("ingot_lathing", {
	requirements = {"rod", "ingot"},
	apply = function(name, data)
		trinium.register_recipe("trinium:metal_former", {"trinium:ingot_"..name}, {"trinium:rod_"..name.." 2"}, {["type"] = "lathing"})
	end,
})


materials.register_mattype("ring", function(def)
	minetest.register_craftitem(("trinium:ring_%s"):format(def.id), {
		description = S("@1 Ring", def.name)..def.formula,
		inventory_image = "(materials_ring.png^[colorize:#"..def.color..")^materials_ring_overlay.png"
	})
end)
materials.register_interaction("rod_hammering", {
	requirements = {"rod", "ring"},
	apply = function(name, data)
		trinium.register_recipe("trinium:metal_former", {"trinium:rod_"..name}, {"trinium:ring_"..name.." 2"}, {["type"] = "hammering"})
	end,
})


materials.register_mattype("brick", function(def)
	minetest.register_craftitem(("trinium:brick_%s"):format(def.id), {
		description = S("@1 Brick", def.name)..def.formula,
		inventory_image = "materials_ingot.png^[colorize:#"..def.color..""
	})
end)
materials.register_interaction("brick_compression", {
	requirements = {"dust", "brick"},
	apply = function(name, data)
		trinium.register_recipe("trinium:metal_former", {"trinium:dust_"..name}, {"trinium:brick_"..name}, {["type"] = "compressing"})
	end,
})