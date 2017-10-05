local speed = 50
local caps = {times = {speed, speed, speed, speed}, uses = 0, maxlevel = 456}

trinium.creative_mode = minetest.settings:get_bool("creative_mode")
if trinium.creative_mode then
	minetest.register_item(":", {
		type = "none",
		wield_image = "wieldhand.png",
		wield_scale = {x = 1, y = 1, z = 2.5},
		groups = {hidden_from_nei = 1},
		tool_capabilities = {
			full_punch_interval = 0.5,
			max_drop_level = 3,
			groupcaps = {
				harvested_by_pickaxe = caps,
				harvested_by_axe = caps,
				harvested_by_shears = caps,
				harvested_by_sword = caps,
				harvested_by_shovel = caps,
				harvested_by_hand = caps,
			},
			damage_groups = {fleshy = 10},
		}
	})
else
	minetest.register_item(":", {
		type = "none",
		wield_image = "wieldhand.png",
		wield_scale = {x = 1, y = 1, z = 2.5},
		groups = {hidden_from_nei = 1},
		tool_capabilities = {
			full_punch_interval = 0.9,
			max_drop_level = 0,
			groupcaps = {
				harvested_by_hand = {times = {3.50, 2.00, 0.70}, uses = 0},
			},
			damage_groups = {fleshy=1},
		}
	})
end

local old_handle_node_drops = minetest.handle_node_drops
function minetest.handle_node_drops(pos, drops, digger)
	return digger and digger:is_player() and (trinium.creative_mode or old_handle_node_drops(pos, drops, digger))
end
minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack)
	return trinium.creative_mode
end)