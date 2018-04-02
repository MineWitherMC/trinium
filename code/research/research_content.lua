local research = trinium.res

--[[ Aspects ]]--
-- Tier 0
research.register_aspect("AER", {
	texture = "aspect_aer.png",
	name = "Aer\n"..S"aspect.aer"
})
research.register_aspect("AQUA", {
	texture = "aspect_aqua.png",
	name = "Aqua\n"..S"aspect.aqua"
})
research.register_aspect("IGNIS", {
	texture = "aspect_ignis.png",
	name = "Ignis\n"..S"aspect.ignis"
})
research.register_aspect("TERRA", {
	texture = "aspect_terra.png",
	name = "Terra\n"..S"aspect.terra"
})

-- Tier 1
research.register_aspect("INTERITUM", {
	texture = "aspect_interitum.png",
	name = "Interitum\n"..S"aspect.interitum",
	req1 = "IGNIS",
	req2 = "TERRA"
})
research.register_aspect("LUX", {
	texture = "aspect_lux.png",
	name = "Lux\n"..S"aspect.lux",
	req1 = "IGNIS",
	req2 = "AER"
})
research.register_aspect("MOTUS", {
	texture = "aspect_motus.png",
	name = "Motus\n"..S"aspect.motus",
	req1 = "TERRA",
	req2 = "AER"
})
research.register_aspect("ORDINATIO", {
	texture = "aspect_ordinatio.png",
	name = "Ordinatio\n"..S"aspect.ordinatio",
	req1 = "IGNIS",
	req2 = "AQUA"
})
research.register_aspect("TEMPESTAS", {
	texture = "aspect_tempestas.png",
	name = "Tempestas\n"..S"aspect.tempestas",
	req1 = "AER",
	req2 = "AQUA"
})
research.register_aspect("VITA", {
	texture = "aspect_vita.png",
	name = "Vita\n"..S"aspect.vita",
	req1 = "AQUA",
	req2 = "TERRA"
})

-- Tier 2
research.register_aspect("ALIENIS", {
	texture = "aspect_alienis.png",
	name = "Alienis\n"..S"aspect.alienis",
	req1 = "INTERITUM",
	req2 = "ORDINATIO"
})
research.register_aspect("CELERITAS", {
	texture = "aspect_celeritas.png",
	name = "Celeritas\n"..S"aspect.celeritas",
	req1 = "MOTUS",
	req2 = "TEMPESTAS"
})
research.register_aspect("INSTRUMENTUM", {
	texture = "aspect_instrumentum.png",
	name = "Instrumentum\n"..S"aspect.instrumentum",
	req1 = "ORDINATIO",
	req2 = "MOTUS"
})
research.register_aspect("POTENTIA", {
	texture = "aspect_potentia.png",
	name = "Potentia\n"..S"aspect.potentia",
	req1 = "MOTUS",
	req2 = "LUX"
})
research.register_aspect("SPECULUM", {
	texture = "aspect_speculum.png",
	name = "Speculum\n"..S"aspect.speculum",
	req1 = "TERRA",
	req2 = "ORDINATIO"
})
research.register_aspect("VENENUM", {
	texture = "aspect_venenum.png",
	name = "Venenum\n"..S"aspect.venenum",
	req1 = "AQUA",
	req2 = "INTERITUM"
})

-- Tier 3
research.register_aspect("FIRMITATEM", {
	texture = "aspect_firmitatem.png",
	name = "Firmitatem\n"..S"aspect.firmitatem",
	req1 = "TERRA",
	req2 = "ALIENIS"
})
research.register_aspect("ITER", {
	texture = "aspect_iter.png",
	name = "Iter\n"..S"aspect.iter",
	req1 = "CELERITAS",
	req2 = "ORDINATIO"
})
research.register_aspect("MERIDIEM", {
	texture = "aspect_meridiem.png",
	name = "Meridiem\n"..S"aspect.meridiem",
	req1 = "ALIENIS",
	req2 = "LUX"
})
research.register_aspect("PERMUTATIO", {
	texture = "aspect_permutatio.png",
	name = "Permutatio\n"..S"aspect.permutatio",
	req1 = "ALIENIS",
	req2 = "POTENTIA"
})
research.register_aspect("POPULUS", {
	texture = "aspect_populus.png",
	name = "Populus\n"..S"aspect.populus",
	req1 = "INSTRUMENTUM",
	req2 = "VITA"
})
research.register_aspect("VINCULUM", {
	texture = "aspect_vinculum.png",
	name = "Vinculum\n"..S"aspect.vinculum",
	req1 = "CELERITAS",
	req2 = "INTERITUM"
})

-- Tier 4
research.register_aspect("CAELESTA", {
	texture = "aspect_caelesta.png",
	name = "Caelesta\n"..S"aspect.caelesta",
	req1 = "AER",
	req2 = "FIRMITATEM"
})
research.register_aspect("CANALICULUS", {
	texture = "aspect_canaliculus.png",
	name = "Canaliculus\n"..S"aspect.canaliculus",
	req1 = "PERMUTATIO",
	req2 = "INSTRUMENTUM"
})
research.register_aspect("CONSEQUAT", {
	texture = "aspect_consequat.png",
	name = "Consequat\n"..S"aspect.consequat",
	req1 = "POPULUS",
	req2 = "INSTRUMENTUM"
})
research.register_aspect("DAMNUM", {
	texture = "aspect_damnum.png",
	name = "Damnum\n"..S"aspect.damnum",
	req1 = "FIRMITATEM",
	req2 = "INTERITUM"
})
research.register_aspect("HERBA", {
	texture = "aspect_herba.png",
	name = "Herba\n"..S"aspect.herba",
	req1 = "VINCULUM",
	req2 = "VITA"
})
research.register_aspect("METALLICUM", {
	texture = "aspect_metallicum.png",
	name = "Metallicum\n"..S"aspect.metallicum",
	req1 = "SPECULUM",
	req2 = "FIRMITATEM"
})
research.register_aspect("SENTENTIA", {
	texture = "aspect_sententia.png",
	name = "Sententia\n"..S"aspect.sententia",
	req1 = "POPULUS",
	req2 = "TEMPESTAS"
})
research.register_aspect("TEMPUS", {
	texture = "aspect_tempus.png",
	name = "Tempus\n"..S"aspect.tempus",
	req1 = "VINCULUM",
	req2 = "CELERITAS"
})

-- Tier 5
research.register_aspect("ARBOR", {
	texture = "aspect_arbor.png",
	name = "Arbor\n"..S"aspect.arbor",
	req1 = "HERBA",
	req2 = "FIRMITATEM"
})
research.register_aspect("RATUS", {
	texture = "aspect_ratus.png",
	name = "Ratus\n"..S"aspect.ratus",
	req1 = "SENTENTIA",
	req2 = "PERMUTATIO"
})
research.register_aspect("SPIRITUS", {
	texture = "aspect_spiritus.png",
	name = "Spiritus\n"..S"aspect.spiritus",
	req1 = "VITA",
	req2 = "RATUS"
})
research.register_aspect("STELLA", {
	texture = "aspect_stella.png",
	name = "Stella\n"..S"aspect.stella",
	req1 = "MERIDIEM",
	req2 = "CAELESTA"
})

-- Tier 6
research.register_aspect("MANIFESTATIO", {
	texture = "aspect_manifestatio.png",
	name = "Manifestatio\n"..S"aspect.manifestatio",
	req1 = "SPECULUM",
	req2 = "RATUS"
})
research.register_aspect("ORIGO", {
	texture = "aspect_origo.png",
	name = "Origo\n"..S"aspect.origo",
	req1 = "SPIRITUS",
	req2 = "CANALICULUS"
})

--[[ Lens ]]--
research.register_lens_shape("hexagon", 1)
research.register_lens_shape("square", 1)
research.register_lens_shape("diamond", 1)
research.register_lens_shape("triangle", 1)
research.register_lens_shape("circle", 2)
research.register_lens_shape("pentagon", 2)
research.register_lens_shape("starhexagon", 2)
research.register_lens_shape("octagon", 2)
research.register_lens_shape("heptagon", 3)
research.register_lens_shape("reuleauxtriangle", 3)

research.register_lens_material("core", "Forcirium", "trinium:material_gem_forcirium")
research.register_lens_material("core", "Forcirium2", "trinium:material_gem_imbued_forcirium")
research.register_lens_material("core", "Diamond", "trinium:material_gem_diamond")

research.register_lens_material("band_material", "Forcirium", "trinium:material_ingot_forcirium")
research.register_lens_material("band_material", "TiRe", "trinium:material_ingot_rhenium_alloy")
research.register_lens_material("band_material", "Platinum", "trinium:material_ingot_platinum")

research.lens_forms.min_gem = 4
research.lens_forms.max_gem = 32
research.lens_forms.min_metal = 0
research.lens_forms.max_metal = 36
research.lens_forms.max_tier = 5

--[[ Chapters ]]--
research.register_chapter("SystemInfo", {
	texture = "trinium:machine_research_table",
	x = 0,
	y = 0,
	name = S"research.chapter.systeminfo",
	tier = 1
})

--[[ Researches ]]--
research.register_research("Aspect", {
	texture = "trinium:aspect___IGNIS",
	x = 0,
	y = 0,
	name = S"research.aspects",
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
		research.researches["Aspect"].text[p][1] = research.researches["Aspect"].text[p][1]..([=[
			item_image_button[0,%s;1,1;trinium:aspect___%s;;]
			textarea[1.2,%s;6,1;;;%s = %s + %s\n%s]
			item_image_button[6,%s;1,1;trinium:aspect___%s;;]
			item_image_button[7,%s;1,1;trinium:aspect___%s;;]
		]=]):format(h, as, h + 0.2, trinium.adequate_text(as_n), 
			trinium.adequate_text(as_r1), trinium.adequate_text(as_r2), as_t.name:split"\n"[2], h, as_r1, h, as_r2)
	else
		research.researches["Aspect"].text[p][1] = research.researches["Aspect"].text[p][1]..([=[
			item_image_button[0,%s;1,1;trinium:aspect___%s;;]
			textarea[1.2,%s;6,1;;;%s\n%s]
		]=]):format(h, as, h, S("gui.basic_aspect @1", trinium.adequate_text(as_n)), as_t.name:split"\n"[2])
	end
end

research.researches["Aspect"].text[1] = S("About Aspects - here are @1 pages", #research.researches["Aspect"].text - 1)

research.register_research("ResearchRevealing", {
	texture = "trinium:aspect___POTENTIA",
	x = 7,
	y = 0,
	name = S"research.research_revealing",
	chapter = "SystemInfo",
	text = {
		S"research.text.revealing.1",
	},
	requires_lens = {},
	color = "A1004A",
	map = {
		{x = 1, y = 1, aspect = "POTENTIA"},
		{x = 7, y = 3, aspect = "MANIFESTATIO"},
		{x = 3, y = 7, aspect = "RATUS"},
	},
})