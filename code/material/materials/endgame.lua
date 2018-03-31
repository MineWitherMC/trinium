materials.new_material("pyrocatalyst", {
	formula = {{"carbon", 2}, {"naquadah", 1}, {"extrium", 1}},
	types = {"dust"},
	color = {255, 134, 0},
	description = S"material.catalyst.pyrolysis",
})

materials.new_material("bifrost", {
	formula = {{"extrium", 5}, {"iodine_acid_ion", 6}},
	types = {"dust"},
	color = {50, 0, 95},
	description = S"material.bifrost",
})

materials.new_material("experience_catalyst", {
	formula = {{"extrium", 1}, {"phosphoric_acid_ion", 2}},
	types = {"dust"},
	color = {70, 250, 85},
	description = S"material.catalyst.xp",
})

materials.new_material("forcirium", {
	formula = {{"iron", 1}, {"extrium", 1}, {"caesium", 2}, {"fluorine", 1}},
	types = {"ingot", "gem", "dust", "water_cell"},
	color = {220, 239, 4},
	description = S"material.forcirium",
	data = {melting_point = 2963, water_mix_velocity = 750},
}):generate_interactions()

materials.new_material("imbued_forcirium", {
	formula = {{"forcirium_induced_ion", 4}, {"naquadah", 1}},
	types = {"ingot", "gem", "dust"},
	color = {220, 155, 0},
	description = S"material.forcirium.imbued",
	data = {melting_point = 4107},
}):generate_interactions()

materials.new_material("endium", {
	formula = {{"extrium", 4}, {"naquadah", 3}},
	types = {"ingot", "dust"},
	color = {0, 155, 220},
	description = S"material.endium",
	data = {melting_point = 2884},
}):generate_interactions()