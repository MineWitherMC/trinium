local research = trinium.res

--[[ Chapters ]]--
research.register_chapter("Chemistry1", {
	texture = "trinium:machine_chemical_reactor",
	x = 0,
	y = 1,
	name = S("Basic Chemistry"),
	tier = 1
})

research.register_chapter("Chemistry2", {
	texture = "trinium:material_ingot_abs_plastic",
	x = 1,
	y = 1,
	name = S("Advanced Chemistry"),
	tier = 2
})

--[[ Researches ]]--
research.register_research("OilDesulf", {
	texture = "trinium:material_cell_raw_oil",
	x = 3.5,
	y = 3.5,
	name = S("Oil Desulfurization"),
	chapter = "Chemistry2",
	text = {
		[[You've discovered a way to purify fluid you found a while ago.
That oil had way too much sulfur in it... But you think it is possible to capture it using
hydrogen. Such an active gas should bind Sulfur into Hydrogen Sulfide, shouldn't it?..]],
		{trinium.draw_research_recipe("trinium:material_cell_desulfurized_oil")}
	},
	requires_lens = {
		requirement = true,
		band_material = "Platinum",
		core = "Diamond",
	},
	color = "101010",
	map = {
		{x = 2, y = 1, aspect = "INSTRUMENTUM"},
		{x = 1, y = 7, aspect = "RATUS"},
		{x = 7, y = 2, aspect = "POTENTIA"},
		{x = 5, y = 6, aspect = "TERRA"},
	},
})

research.register_research("OilDistillation", {
	texture = "trinium:material_cell_diesel",
	x = 3.5,
	y = 2.5,
	name = S("Distillation"),
	chapter = "Chemistry2",
	text = {
		[[The hydrogen you added to Raw Oil worked perfectly. But what next?
You think that oil is not strong until it is separated into components, which is what Distillation Tower used for. It should give a lot of light fractions and some kerosene and diesel, which are heavier and thus rarer.]],
		{trinium.draw_research_recipe("trinium:material_cell_naphtha")}
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