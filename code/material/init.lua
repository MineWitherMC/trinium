local path = ...

dofile(path.."/api.lua")
dofile(path.."/material_types.lua")
dofile(path.."/generators.lua")
assert(loadfile(path.."/materials/init.lua"))(path.."/materials")