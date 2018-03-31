materials.new_material("antracite", {
	formula = {{"carbon", 4}},
	types = {"dust", "gem", "ore", "brick"},
	color = {9, 9, 9},
	description = S"material.antracite",
}):generate_interactions()

materials.new_material("graphite", {
	formula = {{"carbon", 6}},
	types = {"dust", "ore"},
	color = {50, 50, 50},
	description = S"material.graphite",
}):generate_interactions()

materials.new_material("tennantite", {
	formula = {{"copper", 12}, {"arsenic", 4}, {"sulfur", 13}},
	types = {"dust", "gem", "ore"},
	color = {55, 55, 94},
	description = S"material.tennantite",
}):generate_interactions()

materials.new_material("diamond", {
	formula = {{"graphite", 8}},
	types = {"dust", "gem", "ore"},
	color = {200, 255, 255},
	description = S"material.diamond",
}):generate_interactions()

materials.new_material("coal", {
	formula = {{"carbon", 2}},
	types = {"dust", "gem", "ore"},
	color = {21, 21, 21},
	description = S"material.coal",
}):generate_interactions()