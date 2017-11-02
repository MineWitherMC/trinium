-- MN Controller
minetest.register_node("trinium:mn_controller", {
	tiles = {"mn_controller.png"},
	description = S("Material Network Controller"),
	groups = {harvested_by_pickaxe = 1, mn_part = 1},
	paramtype2 = "facedir",
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_int("can_work", 1) -- placeholder b4 energy system

		for i = 1, #trinium.vectors do
			if minetest.get_meta(vector.add(pos, trinium.vectors[i])):get_int("connected") == 1 or minetest.get_node(vector.add(pos, trinium.vectors[i])).name == "trinium:mn_controller" then
				minetest.set_node(pos, {name = "air"})
			end
		end
	end,
	on_destruct = function(pos)
		local arr = minetest.deserialize(minetest.get_meta(pos):get_string("connected_machines"))
		if not arr then return end
		for k in pairs(arr) do
			minetest.get_meta(vector.destringify(k)):set_int("connected", 0)
		end
	end
})

function trinium.mn_active(ctrlpos)
	return minetest.get_node(ctrlpos).name == "trinium:mn_controller" and minetest.get_meta(ctrlpos):get_int("can_work") == 1
end

function trinium.get_mn_storage(ctrlpos, item)
	return false -- Placeholder
end

function trinium.get_mn_items(ctrlpos)
	return {} -- Placeholder
end