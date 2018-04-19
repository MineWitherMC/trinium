local M = materials.materials

M.pyrocatalyst = materials.new_material("pyrocatalyst", {
	formula = {{"carbon", 2}, {"naquadah", 1}, {"extrium", 1}},
	types = {"dust"},
	color = {255, 134, 0},
	description = S"material.catalyst.pyrolysis",
})

M.bifrost = materials.new_material("bifrost", {
	formula = {{"extrium", 5}, {"iodine_acid_ion", 6}},
	types = {"dust"},
	color = {50, 0, 95},
	description = S"material.bifrost",
})

M.xpcatalyst = materials.new_material("experience_catalyst", {
	formula = {{"extrium", 1}, {"phosphoric_acid_ion", 2}},
	types = {"dust"},
	color = {70, 250, 85},
	description = S"material.catalyst.xp",
})

M.forcirium = materials.new_material("forcirium", {
	formula = {{"iron", 1}, {"extrium", 1}, {"caesium", 2}, {"fluorine", 1}},
	types = {"ingot", "gem", "dust", "water_cell"},
	color = {220, 239, 4},
	description = S"material.forcirium",
	data = {melting_point = 2963, water_mix_velocity = 750},
}):generate_interactions()

M.forcirium2 = materials.new_material("imbued_forcirium", {
	formula = {{"forcirium_induced_ion", 4}, {"naquadah", 1}},
	types = {"ingot", "gem", "dust"},
	color = {220, 155, 0},
	description = S"material.forcirium.imbued",
	data = {melting_point = 4107},
}):generate_interactions()

M.endium = materials.new_material("endium", {
	formula = {{"extrium", 4}, {"naquadah", 3}},
	types = {"ingot", "dust", "plate", "foil"},
	color = {0, 155, 220},
	description = S"material.endium",
	data = {melting_point = 2884},
}):generate_interactions()

M.pulsating_alloy = materials.new_material("pulsating_alloy", {
	formula = {{"silver_alloy", 5}, {"forcirium", 6}, {"platinum", 3}, {"iron", 2}},
	types = {"ingot", "dust", "plate", "rod"},
	description = S"material.alloy.pulsating",
}):generate_data("melting_point"):generate_interactions():generate_recipe("trinium:alloysmelting_tower")