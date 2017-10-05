local insecure, path = ...

assert(loadfile(path.."/framework.lua"))(insecure)
dofile(path.."/sfinv_api.lua")
dofile(path.."/cmsg_api.lua")