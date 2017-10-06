local res = trinium.res
res.chapters = {}
res.researches = {}
res.researches_by_chapter = {}
res.known_aspects = {}
res.aspect_ids = {}
res.sorted_aspect_ids = {}
res.bound_to_maps = {}
res.lens_forms = {
	shapes = {},
	shapes_by_mintier = {},
	band_material = {},
	core = {},
}
local S = trinium.S

function res.register_chapter(name, def)
	assert(trinium.validate(def, {texture = "string", x = "number", y = "number", name = "string", tier = "number"}))
	assert(minetest.registered_items[def.texture], "Texture-item doesn't exist!")
	assert(not res.chapters[name], "Chapter already registered!")
	res.chapters[name] = def
	res.chapters[name].requirements = {}
	res.researches_by_chapter[name] = {}

	local texture = def.texture:gsub(":", "__")
	local i = 0
	while minetest.registered_items[("trinium:researchicon___%s___%s"):format(texture, i)] do i = i + 1 end
	local tbl = {
		description = def.name,
		groups = {hidden_from_irp = 1, number = i}
	}
	if minetest.registered_items[def.texture].inventory_image and minetest.registered_items[def.texture].inventory_image ~= "" then
		tbl.inventory_image = minetest.registered_items[def.texture].inventory_image
	end
	if minetest.registered_items[def.texture].tiles and minetest.registered_items[def.texture].tiles ~= "" then
		tbl.tiles = minetest.registered_items[def.texture].tiles
	end
	local function1 = tbl.tiles and minetest.register_node or minetest.register_craftitem
	function1(("trinium:researchicon___%s___%s"):format(texture, i), tbl)
	res.chapters[name].number = i

	if def.create_map then
		minetest.register_craftitem("trinium:chapter_map___"..name:gsub("%.", "__"), {
			description = S("Chapter Map - @1", def.name),
			groups = {chapter_map = 1, hidden_from_irp = 1},
			stack_max = 1,
			inventory_image = "research_chapter_map.png",
		})
	end
end

function res.register_research(name, def)
	if def.pre_unlock then
		assert(trinium.validate(def, {texture = "string", x = "number", y = "number", name = "string", chapter = "string", text = "table", pre_unlock = "boolean"}))
	else
		assert(trinium.validate(def, {texture = "string", x = "number", y = "number", name = "string", chapter = "string", text = "table", requires_lens = "table", color = "string", map = "table"}))
		for i = 1, #def.map do
			assert(trinium.validate(def.map[i], {x = "number", y = "number", aspect = "string"}))
			assert(res.known_aspects[def.map[i].aspect], "Unknown aspect: "..def.map[i].aspect)
		end
	end
	if def.requires_lens then
		if def.requires_lens.core then
			assert(res.lens_forms.core[def.requires_lens.core] or def.requires_lens.core == "NULL", "No such core: "..def.requires_lens.core)
		end; if def.requires_lens.band_material then
			assert(res.lens_forms.band_material[def.requires_lens.band_material] or def.requires_lens.band_material == "NULL", "No such band material: "..def.requires_lens.band_material)
		end
	end
	assert(minetest.registered_items[def.texture], "Texture-item doesn't exist!")
	res.researches[name] = def
	res.researches[name].requirements = {}
	res.researches_by_chapter[def.chapter][name] = def

	local texture = def.texture:gsub(":", "__")
	local i = 0
	while minetest.registered_items[("trinium:researchicon___%s___%s"):format(texture, i)] do i = i + 1 end
	local tbl = {
		description = def.name,
		groups = {hidden_from_irp = 1, number = i}
	}
	if minetest.registered_items[def.texture].inventory_image and minetest.registered_items[def.texture].inventory_image ~= "" then
		tbl.inventory_image = minetest.registered_items[def.texture].inventory_image
	end
	if minetest.registered_items[def.texture].tiles and minetest.registered_items[def.texture].tiles ~= "" then
		tbl.tiles = minetest.registered_items[def.texture].tiles
	end
	local function1 = tbl.tiles and minetest.register_node or minetest.register_craftitem
	function1(("trinium:researchicon___%s___%s"):format(texture, i), tbl)

	if not def.pre_unlock then
		minetest.register_craftitem("trinium:research_notes___"..name:gsub("%.", "__"), {
			description = S("Research Notes - @1", def.name),
			inventory_image = "research_notes_overlay.png^(research_notes_colorer.png^[colorize:#"..def.color.."C0)",
			groups = {hidden_from_irp = 1},
			stack_max = 1
		})
		minetest.register_craftitem("trinium:discovery___"..name:gsub("%.", "__"), {
			description = S("Discovery - @1", def.name),
			inventory_image = "discovery_overlay.png^(discovery_colorer.png^[colorize:#"..def.color.."C0)",
			stack_max = 1,
			groups = {hidden_from_irp = 1},
			on_place = function(rnotes, player, pointed_thing)
				res.grant(player:get_player_name(), name)
				return ""
			end
		})
	end

	res.researches[name].number = i
	res.researches_by_chapter[def.chapter][name].number = i
end

function res.grant(pn, research)
	for _,k in pairs(res.researches[research].requirements) do
		if not res.player_stuff[pn].research[k] then
			minetest.chat_send_player(pn, S("research.unknown"))
			return
		end
	end
	for k in pairs(res.chapters[res.researches[research].chapter].requirements) do
		if not res.player_stuff[pn].research[k] then
			minetest.chat_send_player(pn, S("Unknown research requirement!"))
			return
		end
	end
	res.player_stuff[pn].researches[research] = 1
	minetest.chat_send_player(pn, S("Granted @1 research to @2", res.researches[research].name, pn))
end

function res.grant_force(pn, research, rn)
	for _,k in pairs(res.researches[research].requirements) do
		if not res.player_stuff[pn].research[k] then
			res.grant_force(pn, k)
		end
	end
	for k in pairs(res.chapters[res.researches[research].chapter].requirements) do
		if not res.player_stuff[pn].research[k] then
			res.grant_force(pn, k)
		end
	end
	res.player_stuff[pn].researches[research] = 1
	minetest.chat_send_player(pn, S("Force-Granted @1 research to @2", res.researches[research].name, pn))
end

function res.register_aspect(name, def)
	def.req1 = def.req1 or "NULL"
	def.req2 = def.req2 or "NULL"
	assert(trinium.validate(def, {req1 = "string", req2 = "string", texture = "string", name = "string"}))
	assert(not res.known_aspects[name] and name ~= "NULL", "Aspect already registered!")
	assert(res.known_aspects[def.req1] or def.req1 == "NULL", def.req1.." not registered!")
	assert(res.known_aspects[def.req2] or def.req2 == "NULL", def.req1.." not registered!")
	res.known_aspects[name] = def
	res.known_aspects[name].id = name
	res.aspect_ids[#res.aspect_ids + 1] = name
	res.sorted_aspect_ids[#res.sorted_aspect_ids + 1] = name
	table.sort(res.sorted_aspect_ids)

	minetest.register_craftitem("trinium:aspect___"..name, {
		description = def.name,
		inventory_image = def.texture,
		groups = {hidden_from_irp = 1},
		stack_max = 1
	})
end

function res.set_research_requirements(name, table)
	res.researches[name].requirements = table
end

function res.add_chapter_requirement(c, r)
	res.chapters[c].requirements[r] = 1
end

function res.register_lens_material(target, id, material)
	assert(target == "core" or target == "band_material", ("No such target: %s (only band_material and core are applicable)"):format(target))
	assert(not res.lens_forms[target][id], "Material already registered!")
	assert(minetest.registered_items[material], "Material base not registered!")
	res.lens_forms[target][id] = material
end

function res.register_lens_shape(id, tier)
	assert(not res.lens_forms.shapes_by_mintier[id], "Shape already registered!")
	table.insert(res.lens_forms.shapes, id)
	res.lens_forms.shapes_by_mintier[id] = tier
end

function res.label_escape(text, x, y)
	return {"label[0,1;"..minetest.formspec_escape(text).."]", 8, 8, x, y}
end

function res.random_aspects(pn, amount, possible_aspects)
	local tbl = possible_aspects or res.aspect_ids
	for i = 1, amount do
		aspect = tbl[math.random(1, #tbl)]
		res.player_stuff[pn].data.aspects[aspect] = (res.player_stuff[pn].data.aspects[aspect] or 0) + 1
	end
	minetest.sound_play("experience", {
		to_player = pn,
		gain = 4.0
	})
end

function res.bind_to_map(mapname, def)
	if not res.bound_to_maps[mapname] then
		res.bound_to_maps[mapname] = {}
	end
	table.insert(res.bound_to_maps[mapname], def)
end