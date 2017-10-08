local path, default = ...

if not default then
	dofile(path.."/basic_mapgen.lua")
	dofile(path.."/biomes.lua")
end

assert(loadfile(path.."/oregen.lua"))(default)
assert(loadfile(path.."/ores.lua"))(default)