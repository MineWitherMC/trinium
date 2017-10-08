local path, default = ...

if not default then
	dofile(path.."/player.lua")
	dofile(path.."/inventory.lua")
end

if not minetest.get_modpath("creative") then
	dofile(path.."/creative.lua")
end

dofile(path.."/irp.lua")