local S = trinium.S
-- Day
minetest.register_craftitem("trinium:item_timesetter_day", {
	inventory_image = "timesetter_day.png",
	description = S("item.timesetter.day"),
	stack_max = 1,
	on_place = function(item, player, pointed_thing)
		minetest.set_timeofday(0.5)
		cmsg.push_message_player(player, S"gui.info.time_set")
	end,
	on_secondary_use = function(item, player, pointed_thing)
		minetest.set_timeofday(0.5)
		cmsg.push_message_player(player, S"gui.info.time_set")
	end,
})

-- Night
minetest.register_craftitem("trinium:item_timesetter_night", {
	inventory_image = "timesetter_night.png",
	description = S("item.timesetter.night"),
	stack_max = 1,
	on_place = function(item, player, pointed_thing)
		minetest.set_timeofday(0)
		cmsg.push_message_player(player, S"gui.info.time_set")
	end,
	on_secondary_use = function(item, player, pointed_thing)
		minetest.set_timeofday(0)
		cmsg.push_message_player(player, S"gui.info.time_set")
	end,
})

-- Dawn
minetest.register_craftitem("trinium:item_timesetter_dawn", {
	inventory_image = "timesetter_dawn.png",
	description = S("item.timesetter.dawn"),
	stack_max = 1,
	on_place = function(item, player, pointed_thing)
		minetest.set_timeofday(0.27)
		cmsg.push_message_player(player, S"gui.info.time_set")
	end,
	on_secondary_use = function(item, player, pointed_thing)
		minetest.set_timeofday(0.27)
		cmsg.push_message_player(player, S"gui.info.time_set")
	end,
})