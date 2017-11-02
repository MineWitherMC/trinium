local insecure, path, has_default = ...

assert(loadfile(path.."/api/init.lua"))(insecure, path.."/api", has_default)
S = minetest.get_translator("trinium")
trinium.S = S

trinium.config = {}
trinium.config.vein_probability = tonumber(trinium.setting_get("trinium_vein_probability", 0.9))
trinium.config.vein_height = tonumber(trinium.setting_get("trinium_vein_height", 8))
trinium.config.min_vein_size = tonumber(trinium.setting_get("trinium_vein_min_size", 24))
trinium.config.max_vein_size = tonumber(trinium.setting_get("trinium_vein_max_size", 56))
trinium.config.disable_oregen = tonumber(trinium.setting_get("trinium_disable_oregen", 0)) == 0 and false or true

assert(loadfile(path.."/player/init.lua"))(path.."/player", has_default)
assert(loadfile(path.."/recipe/init.lua"))(path.."/recipe", has_default)
assert(loadfile(path.."/material/init.lua"))(path.."/material", has_default)
assert(loadfile(path.."/mapgen/init.lua"))(path.."/mapgen", has_default)
assert(loadfile(path.."/random/init.lua"))(path.."/random", has_default)
assert(loadfile(path.."/research/init.lua"))(path.."/research", has_default)
assert(loadfile(path.."/mn/init.lua"))(path.."/mn")
S = nil