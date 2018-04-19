minetest.register_craftitem("trinium:item_bonemeal_wand", {
	inventory_image = "bonemeal_wand.png",
	description = S"item.bonemeal_wand",
	stack_max = 1,
	on_place = function(item, player, pointed_thing)
		local crd = pointed_thing.under
		local node = minetest.get_node(crd)
        if minetest.get_node_group(node.name, "herb") == 2 then
            minetest.set_node(crd, {name = "trinium:herb_flower_"..((minetest.get_node(crd).name):split"_"[3]), param2 = node.param2})
        end
        if minetest.get_node_group(node.name, "herb") == 3 then
            minetest.set_node(crd, {name = "trinium:herb_shoot_"..((minetest.get_node(crd).name):split"_"[3]), param2 = node.param2})
        end
	end,
})