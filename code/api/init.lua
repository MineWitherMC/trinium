local insecure, path = ...

dofile(path.."/compat.lua")
S = minetest.get_translator(minetest.get_current_modname())
trinium.S = S
assert(loadfile(path.."/framework.lua"))(insecure)
dofile(path.."/sfinv_api.lua")

if not minetest.get_modpath("cmsg") then
	dofile(path.."/cmsg_api.lua")
end