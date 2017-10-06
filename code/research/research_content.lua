local research = trinium.res

--[[ Aspects ]]--
-- Tier 0
research.register_aspect("IGNIS", {
	texture = "aspect_ignis.png",
	name = "Ignis\n"..S("Fire")
})
research.register_aspect("AQUA", {
	texture = "aspect_aqua.png",
	name = "Aqua\n"..S("Water")
})
research.register_aspect("TERRA", {
	texture = "aspect_terra.png",
	name = "Terra\n"..S("Earth")
})
research.register_aspect("AER", {
	texture = "aspect_aer.png",
	name = "Aer\n"..S("Air")
})

-- Tier 1
research.register_aspect("INTERITUM", {
	texture = "aspect_interitum.png",
	name = "Interitum\n"..S("Destruction, Entropy"),
	req1 = "IGNIS",
	req2 = "TERRA"
})
research.register_aspect("ORDINATIO", {
	texture = "aspect_ordinatio.png",
	name = "Ordinatio\n"..S("Order"),
	req1 = "IGNIS",
	req2 = "AQUA"
})
research.register_aspect("LUX", {
	texture = "aspect_lux.png",
	name = "Lux\n"..S("Light"),
	req1 = "IGNIS",
	req2 = "AER"
})
research.register_aspect("VITA", {
	texture = "aspect_vita.png",
	name = "Vita\n"..S("Life"),
	req1 = "AQUA",
	req2 = "TERRA"
})
research.register_aspect("TEMPESTAS", {
	texture = "aspect_tempestas.png",
	name = "Tempestas\n"..S("Weather"),
	req1 = "AER",
	req2 = "AQUA"
})
research.register_aspect("MOTUS", {
	texture = "aspect_motus.png",
	name = "Motus\n"..S("Motion"),
	req1 = "TERRA",
	req2 = "AER"
})

-- Tier 2
research.register_aspect("INSTRUMENTUM", {
	texture = "aspect_instrumentum.png",
	name = "Instrumentum\n"..S("Tool"),
	req1 = "ORDINATIO",
	req2 = "MOTUS"
})
research.register_aspect("CELERITAS", {
	texture = "aspect_celeritas.png",
	name = "Celeritas\n"..S("Speed, Haste, Flight"),
	req1 = "MOTUS",
	req2 = "TEMPESTAS"
})
research.register_aspect("ALIENIS", {
	texture = "aspect_alienis.png",
	name = "Alienis\n"..S("Strangeness, Alien"),
	req1 = "INTERITUM",
	req2 = "ORDINATIO"
})
research.register_aspect("POTENTIA", {
	texture = "aspect_potentia.png",
	name = "Potentia\n"..S("Power, Energy, Potential"),
	req1 = "MOTUS",
	req2 = "LUX"
})
research.register_aspect("SPECULUM", {
	texture = "aspect_speculum.png",
	name = "Speculum\n"..S("Glass, Crystal"),
	req1 = "TERRA",
	req2 = "ORDINATIO"
})

-- Tier 3
research.register_aspect("PERMUTATIO", {
	texture = "aspect_permutatio.png",
	name = "Permutatio\n"..S("Exchange"),
	req1 = "ALIENIS",
	req2 = "POTENTIA"
})
research.register_aspect("METALLICUM", {
	texture = "aspect_metallicum.png",
	name = "Metallicum\n"..S("Metal"),
	req1 = "SPECULUM",
	req2 = "POTENTIA"
})
research.register_aspect("ITER", {
	texture = "aspect_iter.png",
	name = "Iter\n"..S("Journey"),
	req1 = "CELERITAS",
	req2 = "ORDINATIO"
})
research.register_aspect("MERIDIEM", {
	texture = "aspect_meridiem.png",
	name = "Meridiem\n"..S("Radiance, Radioactivity"),
	req1 = "ALIENIS",
	req2 = "LUX"
})
research.register_aspect("VINCULUM", {
	texture = "aspect_vinculum.png",
	name = "Vinculum\n"..S("Trap, Imprison, Slowness"),
	req1 = "CELERITAS",
	req2 = "INTERITUM"
})
research.register_aspect("POPULUS", {
	texture = "aspect_populus.png",
	name = "Populus\n"..S("Human"),
	req1 = "INSTRUMENTUM",
	req2 = "VITA"
})

-- Tier 4
research.register_aspect("FIRMITATEM", {
	texture = "aspect_firmitatem.png",
	name = "Firmitatem\n"..S("Fortress, Stability"),
	req1 = "VINCULUM",
	req2 = "ALIENIS"
})
research.register_aspect("SENTENTIA", {
	texture = "aspect_sententia.png",
	name = "Sententia\n"..S("Sense"),
	req1 = "POPULUS",
	req2 = "TEMPESTAS"
})
research.register_aspect("RATUS", {
	texture = "aspect_ratus.png",
	name = "Ratus\n"..S("Cognition"),
	req1 = "POPULUS",
	req2 = "MERIDIEM"
})
research.register_aspect("CONSEQUAT", {
	texture = "aspect_consequat.png",
	name = "Consequat\n"..S("Creation, Assembly"),
	req1 = "POPULUS",
	req2 = "INSTRUMENTUM"
})
research.register_aspect("PRAESIDIO", {
	texture = "aspect_praesidio.png",
	name = "Praesidio\n"..S("Protection, Armor, Defence"),
	req1 = "POPULUS",
	req2 = "METALLICUM"
})
research.register_aspect("CANALICULUS", {
	texture = "aspect_canaliculus.png",
	name = "Canaliculus\n"..S("Machine, Mechanism, Gear"),
	req1 = "PERMUTATIO",
	req2 = "INSTRUMENTUM"
})

-- Tier 5
research.register_aspect("DAMNUM", {
	texture = "aspect_damnum.png",
	name = "Damnum\n"..S("Damage, Weapon, Attack"),
	req1 = "PRAESIDIO",
	req2 = "INTERITUM"
})


--[[ Lens ]]--
research.register_lens_shape("hexagon", 1)
research.register_lens_shape("square", 1)
research.register_lens_shape("diamond", 1)
research.register_lens_shape("triangle", 1)
research.register_lens_shape("circle", 2)
research.register_lens_shape("pentagon", 2)
research.register_lens_shape("star-hexagon", 2)
research.register_lens_shape("octagon", 2)
research.register_lens_shape("cycloid", 3)
research.register_lens_shape("heptagon", 3)
research.register_lens_shape("reuleaux-triangle", 3)

research.register_lens_material("core", "FORCIRIUM", "trinium:gem_forcirium")

research.register_lens_material("band_material", "FORCIRIUM", "trinium:ingot_forcirium")
research.register_lens_material("band_material", "TITANIUM-RHENIUM", "trinium:ingot_titanium_rhenium")

research.lens_forms.min_gem = 4
research.lens_forms.max_gem = 32
research.lens_forms.min_metal = 0
research.lens_forms.max_metal = 36
research.lens_forms.max_tier = 5

--[[ Chapters ]]--
research.register_chapter("SystemInfo", {
	texture = "trinium:block_dirt",
	x = 0,
	y = 0,
	name = S("Research System"),
	tier = 1
})

--[[ Researches ]]--
research.register_research("Aspect", {
	texture = "trinium:aspect___ALIENIS",
	x = 0,
	y = 0,
	name = S("Aspects"),
	chapter = "SystemInfo",
	text = {
		""
	},
	pre_unlock = true,
})

local p, as, as_t, as_n, as_r1, as_r2, h
for i = 1, #research.aspect_ids do
	p, as, h = math.ceil(i / 7) + 1, research.aspect_ids[i], ((i - 1) % 7) + 1
	as_t = research.known_aspects[as]
	as_n, as_r1, as_r2 = as_t.id, as_t.req1, as_t.req2
	if not research.researches["Aspect"].text[p] then
		research.researches["Aspect"].text[p] = {"", 8, 8}
	end
	if as_r1 ~= "NULL" then
		research.researches["Aspect"].text[p][1] = ("%sitem_image_button[0,%s;1,1;trinium:aspect___%s;;]label[1,%s;%s = %s + %s\n%s]item_image_button[6,%s;1,1;trinium:aspect___%s;;]"..
			"item_image_button[7,%s;1,1;trinium:aspect___%s;;]"):format(research.researches["Aspect"].text[p][1], h, as, h, trinium.adequate_text(as_n), trinium.adequate_text(as_r1),
			trinium.adequate_text(as_r2), as_t.name:split("\n")[2], h, as_r1, h, as_r2)
	else
		research.researches["Aspect"].text[p][1] = ("%sitem_image_button[0,%s;1,1;trinium:aspect___%s;;]label[1,%s;%s - Basic Aspect\n%s]")
			:format(research.researches["Aspect"].text[p][1], h, as, h, trinium.adequate_text(as_n), as_t.name:split("\n")[2])
	end
end

research.researches["Aspect"].text[1] = S("About Aspects - here are @1 pages", #research.researches["Aspect"].text - 1)