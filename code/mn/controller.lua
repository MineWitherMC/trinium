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

function trinium.add_mn_storage(ctrlpos, priority, machinepos, registry, type_ammount, items)
	local M = minetest.get_meta(ctrlpos)
	local arr = minetest.deserialize(M:get_string("storage_cells")) or {}
	arr[priority] = arr[priority] or {}
	table.insert(arr[priority], {registry_name = vector.stringify(machinepos).."~"..registry, types = type_ammount, available_types = type_ammount - #items, items = items})
	M:set_string("storage", minetest.serialize(arr))
end

function trinium.update_priority(ctrlpos, machinepos, registry, oldpriority, priority)
	local M = minetest.get_meta(ctrlpos)
	local regname = vector.stringify(machinepos).."~"..registry
	local k = table.exists(arr[oldpriority], function(v) return v.registry_name == regname)
	local v = arr[oldpriority][k]
	table.remove(arr[oldpriority], k)
	arr[priority] = arr[priority] or {}
	table.insert(arr[priority], v)
	M:set_string("storage", minetest.serialize(arr))
end

function trinium.remove_mn_storage(ctrlpos, priority, machinepos, registry)
	local M = minetest.get_meta(ctrlpos)
	local regname = vector.stringify(machinepos).."~"..registry
	arr[priority] = table.remap(table.filter(arr[priority], function(v) return v.registry_name == regname end))
	M:set_string("storage", minetest.serialize(arr))
end

function trinium.get_mn_items(ctrlpos)
	return {} -- Placeholder
end