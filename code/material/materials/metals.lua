local V = materials.vanilla_elements

--[[ Elements ]]--
V.titanium:register_material({
	description = S"material.element.ti",
	types = {"ingot", "dust"},
})

V.iron:register_material({
	description = S"material.element.fe",
	types = {"ingot", "dust"},
})

V.nickel:register_material({
	description = S"material.element.ni",
	types = {"ingot", "dust"},
})

V.copper:register_material({
	description = S"material.element.cu",
	types = {"ingot", "dust"},
})

V.silver:register_material({
	description = S"material.element.ag",
	types = {"ingot", "dust"},
})

V.rhenium:register_material({
	description = S"material.element.re",
	types = {"ingot", "dust"},
})

V.platinum:register_material({
	description = S"material.element.pt",
	types = {"ingot", "dust", "catalyst"},
})

--[[ Compounds ]]--
-- Rhenium Alloy
materials.new_material("rhenium_alloy", {
	formula = {{"titanium", 11}, {"rhenium", 2}, {"platinum", 5}},
	types = {"ingot", "dust"},
	description = S"material.alloy.rhenium"
}):generate_data("melting_point"):generate_interactions():generate_recipe("trinium:alloysmelting_tower")

-- Cupronickel
materials.new_material("cupronickel", {
	formula = {{"copper", 3}, {"nickel", 2}},
	types = {"ingot", "dust"},
	description = S"material.alloy.cupronickel"
}):generate_data("melting_point"):generate_interactions():generate_recipe("trinium:alloysmelting_tower")

-- Silver Alloy
materials.new_material("silver_alloy", {
	formula = {{"silver", 2}, {"tennantite", 5}},
	types = {"ingot", "dust"},
	description = S"material.alloy.silver",
	data = {melting_point = 1563},
}):generate_interactions():generate_recipe("trinium:alloysmelting_tower")