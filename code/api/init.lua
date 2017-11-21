local insecure, path = ...

assert(loadfile(path.."/framework.lua"))(insecure)
dofile(path.."/sfinv_api.lua")
dofile(path.."/compat.lua")

if not minetest.get_modpath("cmsg") then
	dofile(path.."/cmsg_api.lua")
end