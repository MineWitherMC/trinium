local S = trinium.S

-- Research Casing
minetest.register_node("trinium:research_casing", {
	tiles = {"research_casing.png"},
	description = S("Research Casing"),
	groups = {harvested_by_pickaxe = 1},
})

-- Research Chassis
minetest.register_node("trinium:research_chassis", {
	tiles = {"research_chassis.png"},
	description = S("Research Chassis"),
	groups = {harvested_by_pickaxe = 2},
})

-- Knowledge Charms
minetest.register_craftitem("trinium:research_knowledge_charm", {
	inventory_image = "knowledge_charm.png",
	description = S("Knowledge Charm"),
	groups = {kcharm = 1},
	stack_max = 16,
})
minetest.register_craftitem("trinium:research_aspected_charm", {
	inventory_image = "aspected_charm.png",
	description = S("Aspected Charm"),
	groups = {kcharm = 2},
	stack_max = 16,
})
minetest.register_craftitem("trinium:research_focused_charm", {
	inventory_image = "focused_charm.png",
	description = S("Focused Charm"),
	groups = {kcharm = 3, hidden_from_irp = 1},
	stack_max = 16,
})

-- Abacus
minetest.register_craftitem("trinium:research_abacus", {
	stack_max = 1,
	inventory_image = "abacus.png",
	description = S("Abacus"),
})

-- Lens and Upgrades
minetest.register_craftitem("trinium:research_lens", {
	inventory_image = "research_lens.png",
	description = S("Research Lens"),
	stack_max = 1,
	groups = {hidden_from_irp = 1},
})
minetest.register_craftitem("trinium:research_lensupgrade_1", {
	inventory_image = "lens_upgrade_1.png",
	description = S("Lens Upgrade"),
	groups = {lens_upgrade = 1},
	stack_max = 1,
})
minetest.register_craftitem("trinium:research_lensupgrade_2", {
	inventory_image = "lens_upgrade_2.png",
	description = S("Improved Lens Upgrade"),
	groups = {lens_upgrade = 2},
	stack_max = 1,
})
minetest.register_craftitem("trinium:research_lens_band_press", {
	inventory_image = "lens_band_press.png",
	description = S("Band Press"),
	stack_max = 1,
	groups = {hidden_from_irp = 1},
})

-- Knowledge Crystal
minetest.register_craftitem("trinium:knowledge_crystal", {
	inventory_image = "knowledge_crystal.png",
	description = S("Knowledge Crystal"),
	stack_max = 16,
	on_place = function(item, player, pointed_thing)
		local item = ItemStack(item)
		local meta = item:get_meta()
		local pn = player:get_player_name()
		meta:set_string("player", pn)
		meta:set_string("description", S("Knowledge Crystal").."\n"..S("Bound to @1", pn))
		cmsg.push_message_player(player, "Successfully bound to "..pn)
		return item
	end,
})