trinium.potions = {}
local pot = trinium.potions


function pot.new_ingridient (name, def)
	local effects2 = def.effects
	local sum = 0
	local i = 1
	while def.effects[i] do
		sum = sum + def.effects[i][4] 
		i = i + 1
	end
	while def.effects[i] do
		effects2[i][4] = effects2[i][4] / sum * 100
		i = i + 1
	end
	minetest.register_craftitem("trinium:ingridient_"..name, {
	inventory_image = "ingridient_"..name..".png",
	types = {gives_effect = 1, usable_in_cauldron = 1},
	description = def.description,
	effects = effects2,
	on_place = function(item, player, pointed_thing)
		local i = 1
		local mas = {}
		local k
		while def.effects[i] do
			mas[i] = def.effects[i][4]
			i = i + 1
		end
		k = trinium.weighted_random(mas)
        cmsg.push_message_player(player, "Applied effect "..def.effects[k][1].." "..trinium.roman_number(def.effects[k][2]).." for "..def.effects[k][3].." seconds")
    end,
	on_secondary_use = function(item, player, pointed_thing)
		local i = 1
		local mas = {}
		local k
		while def.effects[i] do
			mas[i] = def.effects[i][4]
			i = i + 1
		end
		k = trinium.weighted_random(mas)
        cmsg.push_message_player(player, "Applied effect "..def.effects[k][1].." "..trinium.roman_number(def.effects[k][2]).." for "..def.effects[k][3].." seconds")
    end,
	})
end


function pot.new_herb (name, def)
		minetest.register_node("trinium:herb_sprout_"..name, {
		drawtype = "plantlike",
		paramtype2 = "meshoptions",
		place_param2 = 8 + def.structure,
		param2 = 8 + def.structure,
		tiles = {"herb_sprout_"..name..".png"},
		groups = {harvested_by_hand = 3, non_silkable = 1, herb = 3},
		description = S("node.herb.sprout @1", S("node.herb."..name)),
		drop = "",
		walkable = false,
		paramtype = "light",
	})
	minetest.register_node("trinium:herb_shoot_"..name, {
		drawtype = "plantlike",
		paramtype2 = "meshoptions",
		place_param2 = 8 + def.structure,
		param2 = 8 + def.structure,
		tiles = {"herb_shoot_"..name..".png"},
		groups = {harvested_by_hand = 3, non_silkable = 1, herb = 2},
		description = S("node.herb.shoot @1", S("node.herb."..name)),
		drop = def[item],
		walkable = false,
		paramtype = "light",
	})
	minetest.register_node("trinium:herb_flower_"..name, {
		drawtype = "plantlike",
		paramtype2 = "meshoptions",
		place_param2 = 8 + def.structure,
		param2 = 8 + def.structure,
		tiles = {"herb_flower_"..name..".png"},
		groups = {harvested_by_hand = 3, non_silkable = 1, herb = 1},
		description = S("node.herb.flower @1", S("node.herb."..name)),
		drop = def[item],
		walkable = false,
		paramtype = "light",
	})
	minetest.register_craftitem("trinium:item_seed_"..name, {
		inventory_image = "herb_seeds_"..name..".png",
		description = S("item.seeds @1", S("node.herb."..name)),
		on_place = function(item, player, pointed_thing)
			local crd = pointed_thing.under
			local node = minetest.get_node(crd)
			local nodeabove = pointed_thing.above
			if table.exists(def.grows_on, function(v) return v == node.name end) and minetest.get_node(nodeabove).name == "air" then
				minetest.set_node(nodeabove, {name = "trinium:herb_sprout_"..name, param2 = 8 + def.structure})
				if not trinium.creative_mode then
				item:take_item()
				end
			end
			return item
		end
	})
	minetest.register_decoration({
		deco_type = "simple",
		place_on = def.grows_on,
		sidelen = 8,
		fill_ratio = 0.001,
		biomes = def.grows_in,
		decoration = {"trinium:herb_sprout_"..name,"trinium:herb_shoot_"..name,"trinium:herb_flower_"..name},
		height = 1,
		param2 = 8 + def.structure,
	})
end







