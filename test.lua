trinium.res.register_research("ForciriumProc", {
	texture = "trinium:gem_forcirium",
	x = 6,
	y = 0,
	name = "Forcirium Processing",
	chapter = "SystemInfo",
	text = {
		trinium.res.label_escape("You've found some interesting gems in the world, called Almandines. Seems that they're able\nto accumulate tiny bit of Magical Energy that you've called Mana.\n\nBut, of course, they must be charged in order to do that."),
		trinium.res.label_escape("Basically, this seems to not be their only purpose, they can also be assembled into lens with\npossibility to read some interesting things on usual items.", "Almandine Lens", 
			{SPECULUM = 10, MERIDIEM = 12, LUX = 6})
	},
	requires_lens = {},
	color = "64265A",
	map = {
		{x = 4, y = 1, aspect = "TEMPESTAS"},
		{x = 4, y = 7, aspect = "METALLICUM"},
	}
})

trinium.res.register_research("ForciriumProc2", {
	texture = "trinium:gem_forcirium",
	x = 7,
	y = 0,
	name = "Forcirium Processing 2",
	chapter = "SystemInfo",
	text = {
		trinium.res.label_escape("You've found some interesting gems in the world, called Almandines. Seems that they're able\nto accumulate tiny bit of Magical Energy that you've called Mana.\n\nBut, of course, they must be charged in order to do that."),
		trinium.res.label_escape("Basically, this seems to not be their only purpose, they can also be assembled into lens with\npossibility to read some interesting things on usual items.", "Almandine Lens", 
			{SPECULUM = 10, MERIDIEM = 12, LUX = 6})
	},
	requires_lens = {
		requirement = true,
		band_material = "TITANIUM-RHENIUM",
		band_tier = 4,
		band_shape = "reuleaux-triangle"
	},
	color = "64263A",
	map = {
		{x = 4, y = 1, aspect = "TEMPESTAS"},
		{x = 4, y = 7, aspect = "METALLICUM"},
	}
})