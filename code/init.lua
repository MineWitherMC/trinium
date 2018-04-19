local insecure, path = ...

assert(loadfile(path.."/api/init.lua"))(insecure, path.."/api")

trinium.config = {}
trinium.config.vein_probability = tonumber(trinium.setting_get("trinium_vein_probability", 0.92))
trinium.config.vein_height = tonumber(trinium.setting_get("trinium_vein_height", 9))
trinium.config.min_vein_size = tonumber(trinium.setting_get("trinium_vein_min_size", 34))
trinium.config.max_vein_size = tonumber(trinium.setting_get("trinium_vein_max_size", 66))

assert(loadfile(path.."/player/init.lua"))(path.."/player")
assert(loadfile(path.."/recipe/init.lua"))(path.."/recipe")
assert(loadfile(path.."/material/init.lua"))(path.."/material")
assert(loadfile(path.."/mapgen/init.lua"))(path.."/mapgen")
assert(loadfile(path.."/random/init.lua"))(path.."/random")
assert(loadfile(path.."/research/init.lua"))(path.."/research")
assert(loadfile(path.."/machines/init.lua"))(path.."/machines")
assert(loadfile(path.."/chemistry/init.lua"))(path.."/chemistry")
assert(loadfile(path.."/pulsenet/init.lua"))(path.."/pulsenet")
assert(loadfile(path.."/tools/init.lua"))(path.."/tools")
assert(loadfile(path.."/signals/init.lua"))(path.."/signals")
assert(loadfile(path.."/potions/init.lua"))(path.."/potions")
S = nil