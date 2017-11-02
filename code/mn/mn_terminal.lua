local terminal_formspec_base = ([=[
	size[8,10]
	bgcolor[#080808BB;true]
	background[5,5;1,1;gui_formbg.png;true]
	label[0,0;%s]
	list[current_player;main;0,6;8,4;]
	list[context;return;0,4.5;6,1;]
	button[6,4.5;2,1;mnterm~deposit_all;%s]
	button[7,0.5;1,1;mnterm~scrolltop;↑]
	button[7,3.5;1,1;mnterm~scrollbottom;↓]
]=]):format(S"MN Terminal", S"Deposit all")

minetest.register_node("trinium:mn_terminal", {
	tiles = {"research_table_wall.png", "research_table_wall.png", "research_chassis.png", "research_chassis.png", "research_chassis.png", "mn_terminal.png"},
	description = S"MN Terminal",
	groups = {harvested_by_pickaxe = 2, mn_part = 1},
	paramtype2 = "facedir",
	on_construct = trinium.update_cable,
	on_destruct = trinium.downgrade_network,
	after_place_node = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		trinium.initialize_inventory(inv, {["return"] = 6})
		meta:set_string("formspec", terminal_formspec_base)
		meta:set_string("storage", minetest.serialize(trinium.get_mn_items(minetest.deserialize(meta:get_string("ctrlpos")))))
	end,
})