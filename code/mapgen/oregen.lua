local default = ...

local veins_by_breakpoints, vein_breakpoints_s, vein_breakpoint_w
local vein_breakpoints, registered_veins = {}, {}

function trinium.register_vein(name, params)
	assert(not registered_veins[name], "Vein "..name.." already exists!")
	assert(trinium.validate(params, {min_height = "number", max_height = "number", ore_chances = "table", ore_list = "table", density = "number"}))
	assert(params.min_height < params.max_height, "Min Height must be less than Max Height for "..name)
	assert(params.density <= 1000 and params.density > 0, "Failed density check for "..name)
	assert(#params.ore_chances == #params.ore_list, "Failed ores number check for "..name)
	assert(params.min_height >= -31000 and params.min_height <= 31000, "Failed minheight check for "..name)
	assert(params.max_height >= -31000 and params.max_height <= 31000, "Failed maxheight check for "..name)
	local sum = 0
	for i = 1, #params.ore_chances do
		sum = sum + params.ore_chances[i]
	end
	local ocm = params.ore_chances_multiplier or 10
	assert(sum == ocm, "Failed ore chances check for "..name)

	for i = 1, #params.ore_list do
		params.ore_list[i] = minetest.get_content_id(params.ore_list[i])
		assert(params.ore_list[i] ~= 127, "No such block exists!")
		trinium.dump(params.ore_list[i])
	end

	vein_breakpoints[params.min_height] = vein_breakpoints[params.min_height] or 1
	vein_breakpoints[params.max_height] = vein_breakpoints[params.max_height] or 1
	registered_veins[name] = params
	registered_veins[name].name = name
	registered_veins[name].ore_chances_multiplier = ocm
end

local stone_cid = default and minetest.get_content_id("default:stone") or minetest.get_content_id("trinium:block_stone")
minetest.register_on_generated(function(minp, maxp, seed)
	local vb, vbs, wb = veins_by_breakpoints, vein_breakpoints_s, vein_breakpoint_w
	if not vb or not vbs or not wb then
		local n
		vb, wb, n = {}, {}, {}
		for i in pairs(vein_breakpoints) do
			n[#n + 1] = i
		end
		table.sort(n)
		for i = 2, #n do
			vb[n[i].."_"..n[i - 1]] = {}
			wb[n[i].."_"..n[i - 1]] = 0
		end
		for k,v in pairs(registered_veins) do
			for i = 2, #n do
				if v.max_height >= n[i] and v.min_height <= n[i - 1] then
					vb[n[i].."_"..n[i - 1]][k] = v.weight
					wb[n[i].."_"..n[i - 1]] = wb[n[i].."_"..n[i - 1]] + v.weight
				end
			end
		end

		vbs = n
	end

	if math.random() > trinium.config.vein_probability then return end

	local xs, ys, zs = math.random(trinium.config.min_vein_size, trinium.config.max_vein_size), 9, math.random(trinium.config.min_vein_size, trinium.config.max_vein_size)
	local xc, yc, zc = minp.x + math.random(0, 80 - xs), minp.y + math.random(0, 80 - ys), minp.z + math.random(0, 80 - zs)
	local j, veinname, weight, vein

	for i = 2, #vbs do
		j = 0
		if yc >= vbs[i - 1] and yc <= vbs[i] then
			weight = math.random(1, wb[vbs[i].."_"..vbs[i - 1]])
			for y,w in pairs(vb[vbs[i].."_"..vbs[i - 1]]) do
				j = j + w
				if j >= weight then
					vein = y
					break
				end
			end

			break
		end
	end

	if not vein then return end -- something went wrong
	local v = registered_veins[vein]

	local vm, emin, emax = minetest.get_mapgen_object"voxelmanip"
	local data, area, choice, x, y, w = vm:get_data(), VoxelArea:new{MinEdge=emin, MaxEdge=emax}

	for i in area:iter(xc, yc, zc, xc + xs, yc + ys, zc + zs) do
		if math.random(1, 50) <= v.density then
			x, y, w = 0, 0, v.ore_chances_multiplier
			choice = math.random(1, w)
			while x < choice and y < #v.ore_chances do
				y = y + 1
				x = x + v.ore_chances[y]
			end

			if data[i] == stone_cid then
				data[i] = v.ore_list[y]
			end
		end
	end

	vm:set_data(data)
	vm:set_lighting{day=0, night=0}
	vm:calc_lighting()
	vm:write_to_map()
end)