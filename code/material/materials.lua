local materials = trinium.materials
local default = ...

materials.register_material("carton", {
	name = S"Carton",
	color = {160, 112, 64},
	types = {"sheet"},
})
materials.register_material("ink", {
	name = S"Ink", 
	color = {0, 0, 0},
	types = {"cell"},
})
materials.register_material("empty", {
	name = S"Empty", 
	color = {64, 64, 64},
	types = {"cell"},
})
materials.register_material("paper", {
	name = S"Paper",
	color = {224, 224, 224},
	types = {"sheet"},
})
materials.register_material("parchment", {
	name = S"Parchment",
	color = {226, 190, 190},
	types = {"sheet"},
})
materials.register_material("water", {
	name = S"Water",
	color = {0, 0, 220},
	types = {"cell"},
	formula = "H2O",
})
materials.register_material("forcirium", {
	name = S"Forcirium",
	color = {220, 239, 4},
	types = {"ingot", "gem", "dust", "water_cell"},
	data = {melting_point = 2963, water_mix_velocity = 750},
	formula = "FeXCs2F",
})
materials.register_material("imbued_forcirium", {
	name = S"Imbued Forcirium",
	color = {220, 155, 0},
	types = {"ingot", "gem", "dust"},
	data = {melting_point = 4107},
	formula = "(FeXCs2Rb)4Nq",
})
materials.register_material("titanium_rhenium", {
	name = S"Titanium-Rhenium",
	color = {190, 180, 200},
	types = {"ingot", "dust"},
	data = {melting_point = 2093},
	formula = "ReTi9",
})
materials.register_material("stardust", {
	name = S"Star",
	color = {170, 210, 0},
	types = {"dust"},
	formula = "He2X",
})
materials.register_material("pyrocatalyst", {
	name = S"Pyrolysis Catalyst",
	color = {255, 134, 0},
	types = {"dust"},
	formula = "(C2Nq)X",
})
materials.register_material("bifrost", {
	name = S"Bifrost",
	color = {50, 0, 95},
	types = {"dust"},
	formula = "X5(IO6)8",
})
materials.register_material("experience", {
	name = S"Experience Catalyst",
	color = {70, 250, 85},
	types = {"dust"},
	formula = "X(PO4)2",
})
materials.register_material("antracite", {
	name = S"Antracite",
	color = {9, 9, 9},
	types = {"gem", "dust", "ore"},
	formula = "C4",
})
materials.register_material("graphite", {
	name = S"Graphite",
	color = {50, 50, 50},
	types = {"dust", "ore"},
	formula = "C6",
})

if not default then
	materials.register_material("diamond", {
		name = S"Diamond",
		color = {200, 255, 255},
		types = {"gem", "dust", "ore"},
		formula = "C60",
	})

	materials.register_material("coal", {
		name = S"Coal",
		color = {34, 34, 34},
		types = {"gem", "dust", "ore"},
		formula = "C2",
	})
else
	materials.register_material("diamond", {
		name = S"Diamond",
		color = {200, 255, 255},
		types = {"dust"},
		formula = "C60",
	})
	minetest.register_alias("trinium:gem_diamond", "default:diamond")
	minetest.register_alias("trinium:ore_diamond", "default:stone_with_diamond")

	materials.register_material("coal", {
		name = S"Coal",
		color = {21, 21, 21},
		types = {"dust"},
		formula = "C2",
	})
	minetest.register_alias("trinium:gem_coal", "default:coal_lump")
	minetest.register_alias("trinium:ore_coal", "default:stone_with_coal")
end


materials.register_material("abs_plastic", {
	name = S"ABS Plastic",
	color = {100, 100, 100},
	types = {"ingot", "pulp", "cell"},
	data = {},
	formula = "((C8H8)8(C4H6)3(C3H3N)5)n",
})

materials.register_material("abs_plastic_compound", {
	name = S"ABS Plastic Compound",
	color = {250, 230, 210},
	types = {"cell"},
	data = {},
	formula = "(C8H8)8(C4H6)3(C3H3N)5",
})

materials.register_material("styrene", {
	name = S"Styrene",
	color = {250, 230, 210},
	types = {"cell"},
	data = {},
	formula = "C8H8",
})

materials.register_material("butadiene", {
	name = S"Butadiene",
	color = {50, 40, 40},
	types = {"cell"},
	data = {},
	formula = "C4H6",
})

materials.register_material("acrylonitrile", {
	name = S"Acrylonitrile",
	color = {240, 240, 225},
	types = {"cell"},
	data = {},
	formula = "C3H3N",
})

materials.register_material("ethylbenzene", {
	name = S"Ethylbenzene",
	color = {240, 240, 240},
	types = {"cell"},
	data = {},
	formula = "C8H10",
})

materials.register_material("chloroethane", {
	name = S"Chloroethane",
	color = {190, 235, 230},
	types = {"cell"},
	data = {},
	formula = "C2H5Cl",
})

materials.register_material("ethylene", {
	name = S"Ethylene",
	color = {190, 175, 235},
	types = {"cell"},
	data = {},
	formula = "C2H4",
})

materials.register_material("hydrochloride", {
	name = S"Hydrogen Chloride",
	color = {190, 190, 190},
	types = {"cell"},
	data = {},
	formula = "HCl",
})

materials.register_material("benzene", {
	name = S"Benzene",
	color = {40, 40, 50},
	types = {"cell"},
	data = {},
	formula = "C6H6",
})

materials.register_material("aluminiumchloride", {
	name = S"Aluminium Chloride",
	color = {245, 245, 245},
	types = {"dust", "catalyst", "brick"},
	data = {},
	formula = "AlCl3",
})

materials.register_material("aluminiumoxide", {
	name = S"Aluminium Trioxide",
	color = {160, 160, 100},
	types = {"dust", "catalyst", "brick"},
	data = {},
	formula = "Al2O3",
})

materials.register_material("aluminiumchloride", {
	name = S"Aluminium Trichloride",
	color = {100, 160, 160},
	types = {"dust", "catalyst", "brick"},
	data = {},
	formula = "AlCl3",
})

materials.register_material("irontrioxide", {
	name = S"Iron Trioxide",
	color = {100, 100, 155},
	types = {"dust", "catalyst", "brick"},
	data = {},
	formula = "Fe2O3",
})

materials.register_material("chromiumoxide", {
	name = S"Chromium Trioxide",
	color = {160, 100, 100},
	types = {"dust", "catalyst", "brick"},
	data = {},
	formula = "Cr2O3",
})

materials.register_material("potassiumoxide", {
	name = S"Potassium Oxide",
	color = {250, 250, 235},
	types = {"dust", "catalyst", "brick"},
	data = {},
	formula = "K2O",
})

materials.register_material("iron", {
	name = S"Iron",
	color = {200, 200, 200},
	types = {"dust", "catalyst", "ingot"},
	data = {melting_point = 1811},
	formula = "Fe",
})

materials.register_material("butane", {
	name = S"Butane",
	color = {160, 90, 0},
	types = {"cell"},
	data = {},
	formula = "C4H10",
})

materials.register_material("acetylene", {
	name = S"Acetylene",
	color = {240, 240, 240},
	types = {"cell"},
	data = {},
	formula = "C2H2",
})

materials.register_material("methane", {
	name = S"Methane",
	color = {240, 90, 240},
	types = {"cell"},
	data = {},
	formula = "CH4",
})

materials.register_material("oxygen", {
	name = S"Oxygen",
	color = {185, 185, 240},
	types = {"cell"},
	data = {},
	formula = "O2",
})

materials.register_material("ammonia", {
	name = S"Ammonia",
	color = {200, 145, 200},
	types = {"cell"},
	data = {},
	formula = "NH3",
})

materials.register_material("nitrogen", {
	name = S"Nitrogen",
	color = {185, 240, 240},
	types = {"cell"},
	data = {},
	formula = "N2",
})

materials.register_material("hydrogen", {
	name = S"Hydrogen",
	color = {0, 0, 150},
	types = {"cell"},
	data = {},
	formula = "H2",
})

materials.register_material("ammoniacatalyst", {
	name = S"Ammonia Catalyst",
	color = {205, 210, 180},
	types = {"ingot", "catalyst"},
	data = {},
	formula = "Fe7(K2O)(Al2O3)",
})

materials.register_material("platinum", {
	name = S"Platinum",
	color = {255, 255, 200},
	types = {"ingot", "catalyst", "dust"},
	data = {melting_point = 2041},
	formula = "Pt",
})

materials.register_material("hydrogencyanide", {
	name = S"Hydrogen Cyanide",
	color = {255, 100, 255},
	types = {"cell"},
	data = {},
	formula = "HCN",
})

materials.register_material("chromiumaluminiumoxide", {
	name = S"Chromium-Aluminium Oxide",
	color = {230, 225, 195},
	types = {"catalyst", "ingot"},
	data = {},
	formula = "CrAlO3",
})

materials.register_material("chromiumironoxide", {
	name = S"Chromium-Iron Oxide",
	color = {230, 205, 195},
	types = {"catalyst", "ingot"},
	data = {},
	formula = "CrFeO3",
})