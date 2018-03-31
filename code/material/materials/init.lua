materials = trinium.materials
local path = ...

dofile(path.."/elements.lua")

dofile(path.."/ores.lua")
dofile(path.."/metals.lua")
dofile(path.."/chemicals.lua")

dofile(path.."/endgame.lua")
dofile(path.."/basic_salts.lua")

materials = nil