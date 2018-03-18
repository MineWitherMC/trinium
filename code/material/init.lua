local path, default = ...

dofile(path.."/api.lua")
dofile(path.."/material_types.lua")
assert(loadfile(path.."/materials/init.lua"))(path.."/materials", default)