local m1 = materials
materials = trinium.materials
local path, default = ...

dofile(path.."/random.lua")
dofile(path.."/gems.lua")
dofile(path.."/endgame.lua")
dofile(path.."/non_org_chemistry.lua")
dofile(path.."/org_chemistry.lua")
dofile(path.."/metals.lua")
dofile(path.."/catalysts.lua")
dofile(path.."/placeholders.lua")

if default then
	dofile(path.."/vanilla.lua")
else
	dofile(path.."/notvanilla.lua")
end

materials = m1