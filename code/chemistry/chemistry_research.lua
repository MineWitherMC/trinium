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
		[[You found some interesting dark brown liquid a long time ago. It looked like it contained a lot of power at the beginning, but it was poisonous and power couldn't be used due to this.
But you've just discovered the way to purify it from useless and dangerous brimstone. You think it is possible to capture it using hydrogen. Such an active gas should bind sulfur into hydrogen sulfide, shouldn't it?..]],
		{trinium.draw_research_recipe("trinium:material_cell_oil_desulfurized")},
		research.label_escape([[You think that for oil researches a diamond lens will be useful - no material has such complicated carbon structure... Also, platinum will do. A very inert metal, probably a good catalyst, definitely good for holding active materials, You think you'll need it too.]], "Further Oil Researching", {RATUS = 8, MANIFESTATIO = 11, CONSEQUAT = 5})
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
		[[The hydrogen you added to the raw oil worked perfectly. But what is next?
You think that oil is not powerful enough until it is separated into components, which is what the distillation tower is used for. It should give a lot of light fractions and some kerosene and diesel, which are heavier and thus rarer.]],
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
		[[Heavier fractions of the oil, kerosene and diesel, are probably very good fuels that can be used in multiverse turbines. But naphtha and natural gas, lighter fractions, are not that useful - kerosene holds more than twice the power of naphtha, and gas is actually awful.
You realised that and started to think outside of the box. Your new idea was a device that heats naphtha and gas and breaks them into the hydrocarbons, more useful things than the gases themselves. Fuels, plastics, chemistry, and more can be achieved here!..]],
		[[But device is not easy to build. It uses cupronickel coils to heat the naphtha and gas, which are contained in some kind of pipe made of chemical casings. Also the device's controller is probably very hard to assemble.
But after closer look you finally got that this device not only cracks the oil compounds, but also ALMOST DOUBLES them!]],
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
		[[Some of the hydrocarbons you obtained from cracking are useful, for instance, octane and toluene. They both can be used in creation of a very strong fuel, premium gasoline, even stronger than natural diesel. Furthermore, former probably can be used to create some kind of explosives.
But what can be done with, e.g., methane or butane, absolutely useless gases, main components of natural gas and naphtha respectively?..
You found an answer. These two can be dehydrated with usage of the new catalysts to form acetylene and butadiene respectively, which are definitely useful.]],
		{trinium.draw_research_recipe("trinium:material_cell_butadiene")},
		{trinium.draw_research_recipe("trinium:material_cell_acetylene")},
		research.label_escape([[After some deeper research, you discovered that styrene can also be obtained with this mechanic by dehydrating ethylbenzene.]], "Styrene Production", {POTENTIA = 12, INTERITUM = 15, AQUA = 18, SENTENTIA = 24, RATUS = 21})
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
		[[Methane is not really useful, you thought. But you needed something dangerous.
You found an interesting thing. When ammonia, methane and oxygen are combined with presence of platinum and high temperature, they burn, leaving not carbon dioxide and nitrogen oxides, but a weak acid you called hydrogen cyanide. It is probably most poisonous compound you've ever seen, able to kill anyone in several seconds. But you're sure there is another usage for it...]],
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
		[[Hydrogen cyanide you obtained a while ago is useful not only as a poison.
In fact, it has an ability to mix with organic chemicals, which are mostly inert, to create some new materials. You mixed the acid with acetylene and got a whitish compound, which is probably very durable even though it's a fluid.
You called the compound 'acrylonitrile'.]],
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
		[[You were performing some chemical recipes with chlorine on normal compounds. Now you have petrochemicals obtained from crack, and you think if it is possible to perform similar recipes on them.
And after some deep research you were able to say yes! You found a way to chlorinate ethylene with hydrogen chloride to obtain a somewhat poisonous fluid you've named chloroethane. However, you needed a more complicated catalyst than you mostly use, but it did the trick.]],
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
		[[You had found some notes about the chloroethane and you thought they might be useful.
"Yeah, that chloroethane is obviously a very interesting fluid. But it doesn't work.
Really. It is absolutely useless, I didn't find a purpose for it before now. Seems that combining chloroethane with benzene with presence of catalyst - aluminium chloride - yields surprising results. The hydrogen chloride gets returned to me, and also I get a product called ethylbenzene which must lead me to new plastic.
In fact, these two recipes use hydrogen chloride as a catalyst, and isn't it possible to simply combine ethylene and benzene for performing the recipe?.."]],
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
		[["I suddenly found the ideal proportions for this recipe... X of acrylonitrile, Y of butadiene and a lot of styrene..." - it is a page from old diary of chemist. Nothing more was saved from the destructive nature of world. Yeah, X and Y weren't saved, too.
But it was enough for you, and after some trial and error you found these proportions, too.
It is 8 parts of styrene, 4 parts of butadiene and 5 parts of acrylonitrile.
This compound will definitely be very useful in your further progressions.]],
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
