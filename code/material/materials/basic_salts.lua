materials.new_material("iron_trioxide", {
	formula = {{"iron", 2}, {"oxygen", 3}},
	color = {100, 100, 155},
	types = {"dust", "brick"},
	description = S"material.fe2o3",
	data = {melting_point = 1839},
}):generate_interactions()

materials.new_material("chromium_trioxide", {
	formula = {{"chromium", 2}, {"oxygen", 3}},
	color = {100, 160, 100},
	types = {"dust", "brick"},
	description = S"material.cr2o3",
	data = {melting_point = 2708},
}):generate_interactions()

materials.new_material("aluminium_trioxide", {
	formula = {{"aluminium", 2}, {"oxygen", 3}},
	color = {160, 160, 100},
	types = {"dust", "brick", "catalyst"},
	description = S"material.al2o3",
	data = {melting_point = 2417},
}):generate_interactions()

materials.new_material("potassium_oxide", {
	formula = {{"potassium", 2}, {"oxygen", 1}},
	color = {250, 250, 235},
	types = {"dust", "brick"},
	description = S"material.k2o",
	data = {melting_point = 973},
}):generate_interactions()

materials.new_material("aluminium_chloride", {
	formula = {{"aluminium", 1}, {"chlorine", 3}},
	color = {100, 160, 160},
	types = {"dust", "brick", "catalyst"},
	description = S"material.alcl3",
}):generate_interactions()

materials.new_material("chromium_aluminium_oxide", {
	formula = {{"chromium_trioxide", 1}, {"aluminium_trioxide", 1}},
	types = {"ingot", "catalyst"},
	description = S"material.cr2o3al2o3",
}):generate_data("melting_point"):generate_interactions():generate_recipe("trinium:alloysmelting_tower")

materials.new_material("chromium_iron_oxide", {
	formula = {{"chromium_trioxide", 1}, {"iron_trioxide", 1}},
	types = {"ingot", "catalyst"},
	description = S"material.cr2o3fe2o3",
}):generate_data("melting_point"):generate_interactions():generate_recipe("trinium:alloysmelting_tower")

materials.new_material("ipa_compound", {
	formula = {{"iron", 7}, {"potassium_oxide", 1}, {"aluminium_trioxide", 1}},
	types = {"ingot", "catalyst"},
	description = S"material.fe7k2oal2o3",
}):generate_data("melting_point"):generate_interactions():generate_recipe("trinium:alloysmelting_tower")