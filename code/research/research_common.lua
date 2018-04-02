local S = trinium.S

-- Research Chassis
minetest.register_node("trinium:research_chassis", {
	tiles = {"research_chassis.png"},
	description = S"node.casing.research1",
	groups = {harvested_by_pickaxe = 2},
})
trinium.register_recipe("trinium:crafting", {
		[2] = "trinium:block_stone", 
		[4] = "trinium:block_stone", [5] = "trinium:material_brick_antracite", [6] = "trinium:block_stone",
		[8] = "trinium:block_stone"
}, {"trinium:research_chassis 4"}, {})

-- Research Casing
minetest.register_node("trinium:research_casing", {
	tiles = {"research_casing.png"},
	description = S"node.casing.research2",
	groups = {harvested_by_pickaxe = 1},
})
trinium.register_recipe("trinium:crafting", {
		"trinium:material_ingot_iron", "trinium:material_brick_antracite", "trinium:material_ingot_iron", 
		"trinium:material_brick_antracite", "trinium:research_chassis", "trinium:material_brick_antracite", 
		"trinium:material_ingot_iron", "trinium:material_brick_antracite", "trinium:material_ingot_iron"
}, {"trinium:research_casing"}, {})

-- Knowledge Charms
minetest.register_craftitem("trinium:research_knowledge_charm", {
	inventory_image = "charm_knowledge.png",
	description = S"item.research_charm1",
	groups = {kcharm = 1},
	stack_max = 16,
})
minetest.register_craftitem("trinium:research_aspected_charm", {
	inventory_image = "charm_aspected.png",
	description = S"item.research_charm2",
	groups = {kcharm = 2},
	stack_max = 16,
})
minetest.register_craftitem("trinium:research_focused_charm", {
	inventory_image = "charm_focused.png",
	description = S"item.research_charm3",
	groups = {kcharm = 3, hidden_from_irp = 1},
	stack_max = 16,
})

-- Abacus
minetest.register_craftitem("trinium:research_abacus", {
	stack_max = 1,
	inventory_image = "research_abacus.png",
	description = S"item.research_abacus",
})

-- Lens and Upgrades
minetest.register_craftitem("trinium:research_lens", {
	inventory_image = "research_lens.png",
	description = S"item.research_lens",
	stack_max = 1,
	groups = {hidden_from_irp = 1},
})
minetest.register_craftitem("trinium:research_lensupgrade_1", {
	inventory_image = "research_lens_upgrade_1.png",
	description = S"item.lens_upgrade.1",
	groups = {lens_upgrade = 1},
	stack_max = 1,
})
minetest.register_craftitem("trinium:research_lensupgrade_2", {
	inventory_image = "research_lens_upgrade_2.png",
	description = S"item.lens_upgrade.2",
	groups = {lens_upgrade = 2},
	stack_max = 1,
})
minetest.register_craftitem("trinium:research_lens_band_press", {
	inventory_image = "research_lens_press.png",
	description = S"item.band_press",
	stack_max = 1,
	groups = {hidden_from_irp = 1},
})

-- Knowledge Crystal
minetest.register_craftitem("trinium:knowledge_crystal", {
	inventory_image = "knowledge_crystal.png",
	description = S("item.knowledge_crystal"),
	stack_max = 16,
	on_place = function(item, player, pointed_thing)
		item = ItemStack(item)
		local meta = item:get_meta()
		local pn = player:get_player_name()
		meta:set_string("player", pn)
		meta:set_string("description", S("item.knowledge_crystal").."\n"..S("gui.knowledge_crystal_binding @1", pn))
		cmsg.push_message_player(player, S("gui.info.knowledge_crystal_bound @1", pn))
		return item
	end,
})