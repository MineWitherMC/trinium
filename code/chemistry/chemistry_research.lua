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
		[[Some decent time ago, you found some interesting dark brown liquid. It seemed to contained a lot of power at first, but it was poisonous and power couldn't be used because of this.
But now you've discovered a way to purify it from the useless and dangerous Sulfur. You think it is possible to capture it using hydrogen. Such an active gas should bind Sulfur into Hydrogen Sulfide, shouldn't it?..]],
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

research.register_research("OilCrack", {
	texture = "trinium:machine_chemical_cracker",
	x = 4.5,
	y = 3,
	name = S("Cracking"),
	chapter = "Chemistry2",
	text = {
		[[Heavier fractions of the oil, Kerosene and Diesel, probably are very good fuels that can be used in Multiverse Turbines. But Naphtha and Natural Gas, lighter fractions, are not that useful - Kerosene holds more than double Naphtha power, and Gas is really awful.
You thought that, and started to think outside of the box. And your new idea was a device, that heats Naphtha and Gas and breaks them into the Hydrocarbons, more useful things than the gases themselves. Fuels, plastics, chemistry, and more can be achieved here!..]],
		[[But device is not easy. It uses Cupronickel Coils to heat the Naphtha and Gas, which are contained in some kind of pipe made of Chemical Casings. Also the device's controller is probably very hard to assemble.
But after closer look you finally got that this device not only cracks the oil compounds, but also ALMOST DOUBLES them!]],
		{trinium.draw_research_recipe("trinium:material_cell_propene")},
		{trinium.draw_research_recipe("trinium:material_cell_octane")}
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
		{x = 7, y = 2, aspect = "PRAESIDIO"},
		{x = 5, y = 6, aspect = "RATUS"},
		{x = 3, y = 4, aspect = "AQUA"},
	},
})
research.set_research_requirements("OilCrack", {"OilDistillation"})

research.register_research("HydrocarbonsCrack", {
	texture = "trinium:material_cell_butadiene",
	x = 5.5,
	y = 2.5,
	name = S("Hydrocarbons Dehydration"),
	chapter = "Chemistry2",
	text = {
		[[Some of the hydrocarbons you obtained from cracking are useful. For example, Octane and Toluene. They both can be used in creation of very strong fuel, Premium Gasoline, even stronger than natural Diesel. Furthermore, former probably can be used to create some kind of explosives.
But what can be done with, e.g., Methane, or Butane? Absolutely useless gases, main components of Gas and Naphtha respectively?..
You found an answer. These two can be dehydrated with usage of new catalysts to form Acetylene and Butadiene respectively. Which are definitely useful.]],
		{trinium.draw_research_recipe("trinium:material_cell_butadiene")},
		{trinium.draw_research_recipe("trinium:material_cell_acetylene")},
		research.label_escape([[After some deeper research, you discovered that Styrene can also be obtained with this mechanic by dehydrating Ethylbenzene.]], "Styrene Production", {POTENTIA = 12, INTERITUM = 15, AQUA = 18, SENTENTIA = 24, RATUS = 21})
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
	name = S("Hydrogen Cyanide"),
	chapter = "Chemistry2",
	text = {
		[[Methane is not really useful, you thought. But you needed something dangerous.
You found an interesting thing. When Ammonia, Methane and Oxygen are combined with presence of Platinum and high temperature, they burn, leaving not Carbon Dioxide and Nitrogen Oxides, but a weak acid you called Hydrogen Cyanide. It is probably most poisonous compound you've ever seen, able to kill anyone in several seconds. But you're sure there is another usage for it...]],
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