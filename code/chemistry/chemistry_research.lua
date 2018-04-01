local research = trinium.res

--[[ Chapters ]]--
research.register_chapter("Chemistry1", {
	texture = "trinium:machine_chemical_reactor",
	x = 0,
	y = 1,
	name = S("research.chapter.chemistry.basic"),
	tier = 1
})

research.register_chapter("Chemistry2", {
	texture = "trinium:material_ingot_abs_plastic",
	x = 1,
	y = 1,
	name = S("research.chapter.chemistry.advanced"),
	tier = 2
})

--[[ Researches ]]--
research.register_research("OilDesulf", {
	texture = "trinium:material_cell_oil_raw",
	x = 3.5,
	y = 3.5,
	name = S("research.oil_desulf"),
	chapter = "Chemistry2",
	text = {
		S("research.text.oildesulf.1"),
		{trinium.draw_research_recipe("trinium:material_cell_oil_desulfurized")},
		research.label_escape(S("research.text.oildesulf.2"), S("research.text.oildesulf.3"), {RATUS = 8, MANIFESTATIO = 11, CONSEQUAT = 5})
	},
	requires_lens = {},
	color = "101010",
	map = {
		{x = 2, y = 1, aspect = "INSTRUMENTUM"},
		{x = 1, y = 7, aspect = "RATUS"},
		{x = 7, y = 2, aspect = "POTENTIA"},
		{x = 5, y = 6, aspect = "TERRA"},
	},
})

research.register_research("OilDistillation", {
	texture = "trinium:material_cell_fraction_diesel",
	x = 3.5,
	y = 2.5,
	name = S("research.oil_distillation"),
	chapter = "Chemistry2",
	text = {
		S("research.text.oildistillation"),
		{trinium.draw_research_recipe("trinium:material_cell_fraction_naphtha")}
	},
	requires_lens = {
		requirement = true,
		band_material = "Platinum",
		core = "Diamond",
	},
	color = "808040",
	map = {
		{x = 2, y = 1, aspect = "CANALICULUS"},
		{x = 1, y = 7, aspect = "PERMUTATIO"},
		{x = 7, y = 2, aspect = "MERIDIEM"},
		{x = 5, y = 6, aspect = "POTENTIA"},
		{x = 3, y = 4, aspect = "AQUA"},
	},
})
research.set_research_requirements("OilDistillation", {"OilDesulf"})

research.register_research("OilCrack", {
	texture = "trinium:machine_chemical_cracker",
	x = 4.5,
	y = 3,
	name = S("research.oil_cracking"),
	chapter = "Chemistry2",
	text = {
		S("research.text.oilcrack.1"),
		S("research.text.oilcrack.2"),
		{trinium.draw_research_recipe("trinium:material_cell_propene")},
		{trinium.draw_research_recipe("trinium:material_cell_isooctane")}
	},
	requires_lens = {
		requirement = true,
		band_material = "Platinum",
		core = "Diamond",
	},
	color = {115, 85, 135},
	map = {
		{x = 2, y = 1, aspect = "INTERITUM"},
		{x = 1, y = 7, aspect = "POTENTIA"},
		{x = 7, y = 2, aspect = "FIRMITATEM"},
		{x = 5, y = 6, aspect = "RATUS"},
		{x = 3, y = 4, aspect = "AQUA"},
	},
})
research.set_research_requirements("OilCrack", {"OilDistillation"})

research.register_research("HydrocarbonsCrack", {
	texture = "trinium:material_cell_butadiene",
	x = 5.5,
	y = 2.5,
	name = S("research.hydrocarbon_cracking"),
	chapter = "Chemistry2",
	text = {
		S("research.text.hydrocarbonscrack.1"),
		{trinium.draw_research_recipe("trinium:material_cell_butadiene")},
		{trinium.draw_research_recipe("trinium:material_cell_acetylene")},
		research.label_escape(S("research.text.hydrocarbonscrack.2"), S("research.text.hydrocarbonscrack.3"), {POTENTIA = 12, INTERITUM = 15, AQUA = 18, SENTENTIA = 24, RATUS = 21})
	},
	requires_lens = {
		requirement = true,
		band_material = "Platinum",
		core = "Diamond",
	},
	color = {50, 40, 40},
	map = {
		{x = 2, y = 1, aspect = "INTERITUM"},
		{x = 1, y = 7, aspect = "MOTUS"},
		{x = 7, y = 2, aspect = "IGNIS"},
		{x = 5, y = 6, aspect = "INSTRUMENTUM"},
		{x = 3, y = 4, aspect = "POTENTIA"},
	},
})
research.set_research_requirements("HydrocarbonsCrack", {"OilCrack"})

research.register_research("HydrogenCyanide", {
	texture = "trinium:material_cell_hydrogen_cyanide",
	x = 4.5,
	y = 4,
	name = S("research.hcn"),
	chapter = "Chemistry2",
	text = {
		S("research.text.hydrogencyanide"),
		{trinium.draw_research_recipe("trinium:material_cell_hydrogen_cyanide")},
	},
	requires_lens = {
		requirement = true,
		band_material = "Platinum",
		core = "Diamond",
	},
	color = {180, 100, 215},
	map = {
		{x = 2, y = 1, aspect = "INTERITUM"},
		{x = 1, y = 7, aspect = "VENENUM"},
		{x = 7, y = 2, aspect = "VITA"},
		{x = 5, y = 6, aspect = "AQUA"},
		{x = 3, y = 4, aspect = "CONSEQUAT"},
	},
})
research.set_research_requirements("HydrogenCyanide", {"OilCrack"})

research.register_research("Acrylonitrile", {
	texture = "trinium:material_cell_acrylonitrile",
	x = 4.5,
	y = 5,
	name = S("research.acrylonitrile"),
	chapter = "Chemistry2",
	text = {
		S("research.text.acrylonitrile"),
		{trinium.draw_research_recipe("trinium:material_cell_acrylonitrile")},
	},
	requires_lens = {
		requirement = true,
		band_material = "Platinum",
		core = "Diamond",
	},
	color = {240, 240, 225},
	map = {
		{x = 2, y = 1, aspect = "PERMUTATIO"},
		{x = 1, y = 7, aspect = "VENENUM"},
		{x = 7, y = 2, aspect = "FIRMITATEM"},
		{x = 5, y = 6, aspect = "VITA"},
		{x = 3, y = 4, aspect = "VINCULUM"},
	},
})
research.set_research_requirements("Acrylonitrile", {"HydrogenCyanide", "HydrocarbonsCrack"})

research.register_research("HydrocarbonsChlorination", {
	texture = "trinium:material_cell_chloroethane",
	x = 5.5,
	y = 3.5,
	name = S("research.chlorination.advanced"),
	chapter = "Chemistry2",
	text = {
		S("research.text.hydrocarbonschlorination"),
		{trinium.draw_research_recipe("trinium:material_cell_chloroethane")},
	},
	requires_lens = {
		requirement = true,
		band_material = "Platinum",
		core = "Diamond",
	},
	color = {190, 235, 230},
	map = {
		{x = 2, y = 1, aspect = "PERMUTATIO"},
		{x = 1, y = 7, aspect = "VINCULUM"},
		{x = 7, y = 2, aspect = "VENENUM"},
		{x = 5, y = 6, aspect = "DAMNUM"},
		{x = 3, y = 4, aspect = "LUX"},
	},
})
research.set_research_requirements("HydrocarbonsChlorination", {"HydrocarbonsCrack"})

research.register_research("Ethylbenzene", {
	texture = "trinium:material_cell_ethylbenzene",
	x = 5.5,
	y = 4.5,
	name = S("research.ethylbenzene"),
	chapter = "Chemistry2",
	text = {
		S("research.text.ethylbenzene"),
		{trinium.draw_research_recipe("trinium:material_cell_ethylbenzene")},
	},
	requires_lens = {
		requirement = true,
		band_material = "Platinum",
		core = "Diamond",
	},
	color = {240, 240, 240},
	map = {
		{x = 2, y = 1, aspect = "PERMUTATIO"},
		{x = 1, y = 7, aspect = "ORDINATIO"},
		{x = 7, y = 2, aspect = "POTENTIA"},
		{x = 5, y = 6, aspect = "VENENUM"},
		{x = 3, y = 4, aspect = "SENTENTIA"},
	},
})
research.set_research_requirements("Ethylbenzene", {"HydrocarbonsChlorination"})

research.register_research("ABSPC", {
	texture = "trinium:material_cell_abs_plastic_compound",
	x = 5.5,
	y = 5.5,
	name = S("research.abs_plastic"),
	chapter = "Chemistry2",
	text = {
		S("research.text.abspc"),
		{trinium.draw_research_recipe("trinium:material_cell_abs_plastic_compound")},
	},
	requires_lens = {
		requirement = true,
		band_material = "Platinum",
		core = "Diamond",
	},
	color = {250, 230, 210},
	map = {
		{x = 2, y = 1, aspect = "METALLICUM"},
		{x = 7, y = 2, aspect = "SPECULUM"},
		{x = 6, y = 7, aspect = "SENTENTIA"},
		{x = 1, y = 6, aspect = "RATUS"},
		{x = 4, y = 4, aspect = "FIRMITATEM"},
	},
})
research.set_research_requirements("ABSPC", {"Ethylbenzene", "Acrylonitrile", "HydrocarbonsCrack__4"})
