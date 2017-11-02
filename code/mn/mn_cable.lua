trinium.vectors = {
	{x = 1, y = 0, z = 0},
	{x = -1, y = 0, z = 0},
	{x = 0, y = 1, z = 0},
	{x = 0, y = -1, z = 0},
	{x = 0, y = 0, z = 1},
	{x = 0, y = 0, z = -1},
}
local vectors = trinium.vectors

function trinium.update_cable(pos)
	local M = minetest.get_meta(pos)
	if M:get_int("connected") == 1 then return end

	local C = nil

	for i = 1, #vectors do
		local v1 = vector.add(pos, vectors[i])
		if minetest.get_item_group(minetest.get_node(v1).name, "mn_part") > 0 then
			if minetest.get_meta(v1):get_int("connected") == 1 or minetest.get_node(v1).name == "trinium:mn_controller" then
				M:set_int("connected", 1)
				M:set_string("ctrlpos", (minetest.get_node(v1).name == "trinium:mn_controller") and minetest.serialize(v1) or minetest.get_meta(v1):get_string("ctrlpos"))
				if C and C ~= M:get_string("ctrlpos") then
					C = M:get_string("ctrlpos")
					minetest.set_node(minetest.deserialize(C), {name = "air"})
				else
					C = M:get_string("ctrlpos")
				end
				local cp = minetest.deserialize(M:get_string("ctrlpos"))
				local cm = minetest.get_meta(cp)
				local cs = minetest.deserialize(cm:get_string("connected_machines")) or {}
				cs[vector.stringify(pos)] = 1
				cm:set_string("connected_machines", minetest.serialize(cs))
			end
		end
	end

	if M:get_int("connected") == 0 then return end
	for i = 1, #vectors do
		local v1 = vector.add(pos, vectors[i])
		if minetest.get_item_group(minetest.get_node(v1).name, "mn_part") > 0 then
			trinium.update_cable(v1)
		end
	end
end

local function generate_map(beginpos, pos, map)
	for i = 1, #vectors do
		local v1 = vector.add(pos, vectors[i])
		if minetest.get_item_group(minetest.get_node(v1).name, "mn_part") > 0 and not map[vector.stringify(v1)] and minetest.get_node(v1).name ~= "trinium:mn_controller" and vector.stringify(v1) ~= beginpos then
			map[vector.stringify(v1)] = 1
			generate_map(beginpos, v1, map)
		end
	end
end

function trinium.downgrade_network(pos)
	local M = minetest.get_meta(pos)
	if M:get_int("connected") == 0 then return end
	local P = minetest.deserialize(M:get_string("ctrlpos"))
	local CM = minetest.get_meta(P)
	local CMF = minetest.deserialize(CM:get_string("connected_machines"))

	local map = {}
	generate_map(vector.stringify(pos), P, map)

	CM:set_string("connected_machines", minetest.serialize(map))
	local delmap = table.intersect_key_rev(CMF, map)
	for k in pairs(delmap) do
		local M1 = minetest.get_meta(vector.destringify(k))
		M1:set_int("connected", 0)
		M1:set_string("ctrlpos", "")
	end
end

minetest.register_node("trinium:mn_cable", {
	tiles = {"mn_cable.png"},
	description = S("Material Network Cable"),
	groups = {harvested_by_pickaxe = 3, mn_part = 1},
	paramtype = "light",
	drawtype = "nodebox",
	connects_to = {"group:mn_part"},
	node_box = {
		["type"] = "connected",
		fixed = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
		connect_top = {-0.1, 0.1, -0.1, 0.1, 0.5, 0.1},
		connect_bottom = {-0.1, -0.5, -0.1, 0.1, -0.1, 0.1},
		connect_front = {-0.1, -0.1, -0.5, 0.1, 0.1, -0.1},
		connect_back = {-0.1, -0.1, 0.1, 0.1, 0.1, 0.5},
		connect_left = {-0.5, -0.1, -0.1, -0.1, 0.1, 0.1},
		connect_right = {0.1, -0.1, -0.1, 0.5, 0.1, 0.1},
	},

	on_construct = trinium.update_cable,
	on_destruct = trinium.downgrade_network,
})