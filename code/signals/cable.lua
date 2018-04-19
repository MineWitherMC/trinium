local neighbours = {
    {x = 1, y = 0, z = 0},
    {x = -1, y = 0, z = 0},
    {y = 1, x = 0, z = 0},
    {y = -1, x = 0, z = 0},
    {z = 1, x = 0, y = 0},
    {z = -1, x = 0, y = 0},
}

function trinium.get_connections(pos)
    local k = {}
    for i = 1, #neighbours do
        local v1 = vector.add(pos, neighbours[i])
        if minetest.get_item_group(minetest.get_node(v1).name, "signals_use_key") > 0 then
            k[v1] = 1
        end
    end
    return k
end

function trinium.rebuild_signals(pos)
    local search = trinium.search(pos, vector.stringify, trinium.get_connections)
    search:forEach(function(v)
        local node = minetest.get_node(v)
        local group = minetest.get_item_group(node.name, "signals_use_key")
        if group ~= 3 and node["param"..group] ~= 255 then node["param"..group] = 0 end
        minetest.set_node(v, node)
    end):push(pos):filter(function(v)
        local node = minetest.get_node(v)
        local group = minetest.get_item_group(node.name, "signals_use_key")
        if group == 3 then
            return minetest.get_meta(v):get_int("is_running") == 1
        else
            return minetest.get_item_group(node.name, "signals_emitter") > 0 or node["param"..group] == 255
        end
    end):forEach(function(v)
        local s1 = trinium.advanced_search(v, vector.stringify, trinium.get_connections)
        s1:forEach(function(v1)
            local pos1, steps = v1[1], v1[2]
            local node = minetest.get_node(pos1)
            local group = minetest.get_item_group(node.name, "signals_use_key")
            local bs = 256
            if group == 3 then bs = node["param"..minetest.get_item_group(node.name, "signals_use_key2")] end
            if node["param"..group] < 256 - steps then
                node["param"..group] = 256 - steps
                minetest.set_node(pos1, node)
            end
        end)
    end)
end

minetest.register_node("trinium:block_cable", {
    paramtype = "light",
    description = S"node.cable",
    drawtype = "nodebox",
    node_box = {
        ["type"] = "connected",
        fixed = {-3/16, -3/16, -3/16, 3/16, 3/16, 3/16},
        connect_left = {-0.5, -3/16, -3/16, -3/16, 3/16, 3/16},
        connect_right = {0.5, -3/16, -3/16, 3/16, 3/16, 3/16},
        connect_top = {-3/16, 3/16, -3/16, 3/16, 0.5, 3/16},
        connect_bottom = {-3/16, -3/16, -3/16, 3/16, -0.5, 3/16},
        connect_front = {-3/16, -3/16, -3/16, 3/16, 3/16, -0.5},
        connect_back = {-3/16, -3/16, 3/16, 3/16, 3/16, 0.5},
    },
    tiles = {"cable.png"},
    connects_to = {"group:signals_use_key"},
    groups = {harvested_by_pickaxe = 2, signals_use_key = 2},
    after_place_node = trinium.rebuild_signals,
    after_dig_node = trinium.rebuild_signals,
})

minetest.register_node("trinium:block_cable_emitter", {
    description = S"node.cable_emitter",
    tiles = {"cable_emitter.png"},
    groups = {harvested_by_pickaxe = 2, signals_emitter = 1, signals_use_key = 2},
    after_place_node = trinium.rebuild_signals,
    after_dig_node = trinium.rebuild_signals,
})