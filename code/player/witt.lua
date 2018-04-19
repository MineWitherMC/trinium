local player_to_id_text = {} -- Storage of players so the mod knows what huds to update
local player_to_id_mtext = {}
local player_to_id_image = {}
local player_to_id_current_item = {}
local player_to_cnode = {} -- Get the current looked at node
local player_to_cwield = {} -- Get the current looked at node
local player_to_animtime = {} -- For animation
local player_to_animon = {} -- For disabling animation
local player_to_enabled = {} -- For disabling WiTT
local player_to_fluid_enabled = {}

local S = trinium.S

local ypos = 0.1

local function get_looking_node(player)
    local lookat
    for i = 0, 50 do
        local lookvector = -- This variable will store what node we might be looking at
            vector.add( -- This add function corrects for the players approximate height
                vector.add( -- This add function applies the camera's position to the look vector
                    vector.multiply( -- This multiply function adjusts the distance from the camera by the iteration of the loop we're in
                        player:get_look_dir(), 
                        i/10 -- Goes from 0 to 5 with step of 1/10
                    ), 
                    player:get_pos()
                ),
                vector.new(0, 1.5, 0)
            )
        lookat = minetest.get_node_or_nil( -- This actually gets the node we might be looking at
            lookvector
        ) or lookat
        if lookat ~= nil and -- node is loaded,
			lookat.name ~= "air" and -- not air
			minetest.registered_nodes[lookat.name] and -- and known
			(player_to_fluid_enabled[player] or minetest.registered_nodes[lookat.name].liquidtype == "none")
				-- either player has fluids enabled or it is not fluid
		then break else
			lookat = nil
		end
    end
    return lookat
end

local function describe_node(node)
    local mod, nodename = minetest.registered_nodes[node.name].mod_origin, minetest.registered_nodes[node.name].description
    if nodename == "" then
        nodename = node.name
    end
	mod = trinium.adequate_text2(mod)
	nodename = nodename:split("\n")[1]
    return nodename, mod
end

local function handle_tiles(node)
    local tiles = node.tiles
    local overlay_tiles = node.overlay_tiles

    if tiles then
        for i,v in pairs(tiles) do
            if type(v) == "table" then
                if tiles[i].name then
                    tiles[i] = tiles[i].name
                else
                    return ""
                end
            end
        end

        if overlay_tiles then
            if #tiles < 6 then
                for i = #tiles + 1, 6 do
                    tiles[i] = tiles[#tiles]
                end
            end
            if #overlay_tiles < 6 then
                for i = #overlay_tiles + 1, 6 do
                    overlay_tiles[i] = overlay_tiles[#overlay_tiles]
                end
            end
            for i = 1, #overlay_tiles do
                if type(overlay_tiles[i]) == "table" then
                    if overlay_tiles[i].name then
                        overlay_tiles[i] = overlay_tiles[i].name
                    else
                        return "aspect_tempus.png"
                    end
                end
                tiles[i] = "("..tiles[i]..")^("..overlay_tiles[i]..")"
            end
        end

        if node.drawtype == "normal" or node.drawtype == "allfaces" or node.drawtype == "allfaces_optional" or
				node.drawtype == "glasslike" or node.drawtype == "glasslike_framed" or 
				node.drawtype == "glasslike_framed_optional" then
            if #tiles == 1 then -- Whole block
                return minetest.inventorycube(tiles[1], tiles[1], tiles[1])
			elseif #tiles == 2 then -- Top differs
                return minetest.inventorycube(tiles[1], tiles[2], tiles[2])
            elseif #tiles == 3 then -- Top and Bottom differ
                return minetest.inventorycube(tiles[1], tiles[3], tiles[3])
            elseif #tiles == 6 then -- All sides
                return minetest.inventorycube(tiles[1], tiles[6], tiles[5])
            end
        end
    end

    return ""
end

local function update_player_hud_pos(player, to_x, to_y)
	to_y = to_y or ypos
	player:hud_change(player_to_id_text[player], "position", {x = to_x, y = to_y})
	player:hud_change(player_to_id_image[player], "position", {x = to_x, y = to_y})
	player:hud_change(player_to_id_mtext[player], "position", {x = to_x, y = to_y+0.015})
end

local function blank_player_hud(player) -- Make hud appear blank
	player:hud_change(player_to_id_text[player], "text", "")
	player:hud_change(player_to_id_mtext[player], "text", "")
	player:hud_change(player_to_id_image[player], "text", "")
end

minetest.register_globalstep(function(dtime)
    for _, player in ipairs(minetest:get_connected_players()) do
        if player_to_enabled[player] == nil then player_to_enabled[player] = true end
        if player_to_fluid_enabled[player] == nil then player_to_fluid_enabled[player] = false end
        if not player_to_enabled[player] then return end
        local lookat = get_looking_node(player)

        player_to_animtime[player] = math.min((player_to_animtime[player] or 0.4) + dtime, 0.5)

        if player_to_animon[player] then
            update_player_hud_pos(player, player_to_animtime[player])
        end

        if lookat then 
            if player_to_cnode[player] ~= lookat.name then
                player_to_animtime[player] = nil
                local nodename, mod = describe_node(lookat)
                player:hud_change(player_to_id_text[player], "text", nodename)
                player:hud_change(player_to_id_mtext[player], "text", mod)
                local node_object = minetest.registered_nodes[lookat.name]
                player:hud_change(player_to_id_image[player], "text", handle_tiles(node_object))
            end
            player_to_cnode[player] = lookat.name -- Update the current node
        else
            blank_player_hud(player) -- If they are not looking at anything, do not display the text
            player_to_cnode[player] = nil -- Update the current node
        end
		
		local stack = player:get_wielded_item()
		if stack:to_string() ~= player_to_cwield[player] then
			if stack:is_empty() then
				player:hud_change(player_to_id_current_item[player], "text", "")
			elseif not stack:is_known() then
				player:hud_change(player_to_id_current_item[player], "text", S"info.unknown")
			elseif stack:get_meta():get_string"description" ~= "" then
				player:hud_change(player_to_id_current_item[player], "text", 
						stack:get_meta():get_string"description":split"\n"[1])
			else
				player:hud_change(player_to_id_current_item[player], "text", 
						minetest.registered_items[stack:get_name()].description:split("\n")[1] or "???")
			end
			player_to_cwield[player] = stack:to_string()
		end
    end
end)

minetest.register_on_joinplayer(function(player) -- Add the hud to all players
    player_to_id_text[player] = player:hud_add({ -- Add the block name text
        hud_elem_type = "text",
        text = "test",
        number = 0xffffff,
        alignment = {x = 1, y = 0},
        position = {x = 0.5, y = ypos},
    })
    player_to_id_mtext[player] = player:hud_add({ -- Add the mod name text
        hud_elem_type = "text",
        text = "test",
        number = 0x2d62b7,
        alignment = {x = 1, y = 0},
        position = {x = 0.5, y = ypos+0.015},
    })
    player_to_id_image[player] = player:hud_add({ -- Add the block image
        hud_elem_type = "image",
        text = "",
        scale = {x = 1, y = 1},
        alignment = 0,
        position = {x = 0.5, y = ypos},        
        offset = {x = -40, y = 0}
    })
    player_to_id_current_item[player] = player:hud_add({ -- Add the wielded item
        hud_elem_type = "text",
        text = "",
        number = 0xffffff,
        alignment = {x = 0, y = 0},
        position = {x = 0.5, y = 0.9},
    })
end)

minetest.register_chatcommand("wanim", {
	params = "<on/off>",
	description = "Turn WiTT animations on/off",
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if not player then return false end
        player_to_animon[player] = param == "on"
        return true
	end
})

minetest.register_chatcommand("witt", {
	params = "<on/off>",
	description = "Turn WiTT on/off",
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if not player then return false end
        player_to_enabled[player] = param == "on"
        blank_player_hud(player)
        player_to_cnode[player] = nil
        return true
	end
})

minetest.register_chatcommand("wittfluid", {
	params = "<on/off>",
	description = "Turn WiTT fluids on/off",
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if not player then return false end
        player_to_fluid_enabled[player] = param == "on"
        blank_player_hud(player)
        player_to_cnode[player] = nil
        return true
	end
})