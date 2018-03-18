-- Diamonds
materials.register_material("diamond", {
	name = S"Diamond",
	color = {200, 255, 255},
	types = {"gem", "dust", "ore"},
	formula = "C60",
})
minetest.register_alias("trinium:gem_diamond", "default:diamond")
minetest.register_alias("trinium:ore_diamond", "default:stone_with_diamond")

-- Coal
materials.register_material("coal", {
	name = S"Coal",
	color = {34, 34, 34},
	types = {"gem", "dust", "ore"},
	formula = "C2",
})
minetest.register_alias("trinium:gem_coal", "default:coal_lump")
minetest.register_alias("trinium:ore_coal", "default:stone_with_coal")