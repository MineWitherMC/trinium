local insecure, path = ...

assert(loadfile(path.."/api/init.lua"))(insecure, path.."/api")
-- trinium.localizer = trinium.register_localization()
S = minetest.get_translator("trinium")
trinium.S = S
assert(loadfile(path.."/player/init.lua"))(path.."/player")
assert(loadfile(path.."/recipe/init.lua"))(path.."/recipe")
assert(loadfile(path.."/mapgen/init.lua"))(path.."/mapgen")
assert(loadfile(path.."/material/init.lua"))(path.."/material")
assert(loadfile(path.."/random/init.lua"))(path.."/random")
assert(loadfile(path.."/research/init.lua"))(path.."/research")
S = nil