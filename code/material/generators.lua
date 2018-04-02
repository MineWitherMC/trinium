local mat = trinium.materials
mat.add_recipe_generator("trinium:alloysmelting_tower", function(name)
	local formula = mat.materials[name].formula
	local inputs = {}
	local count = 0
	local melting = -1
	for i = 1, #formula do
		local x
		if table.exists(mat.materials[formula[i][1]].types, function(v) return v == "ingot" end) then
			x = "trinium:material_ingot_"..mat.materials[formula[i][1]].id
			count = count + formula[i][2]
		elseif table.exists(mat.materials[formula[i][1]].types, function(v) return v == "brick" end) then
			x = "trinium:material_brick_"..mat.materials[formula[i][1]].id
			count = count + formula[i][2]
		else
			x = "trinium:material_dust_"..mat.materials[formula[i][1]].id
		end
		if formula[i][2] > 1 then
			x = x.." "..formula[i][2]
		end
		inputs[#inputs + 1] = x
		
		if mat.materials[formula[i][1]].data.melting_point and 
				mat.materials[formula[i][1]].data.melting_point > melting then
			melting = mat.materials[formula[i][1]].data.melting_point
		end
	end
	melting = math.ceil(melting / 50) * 50
	
	trinium.register_recipe("trinium:alloysmelting_tower", 
		inputs, 
		{"trinium:material_ingot_"..name.." "..count}, 
		{temperature = melting})
end)

mat.add_data_generator("melting_point", function(name)
	local formula = mat.materials[name].formula
	formula = table.map(formula, function(v)
		return {mat.materials[v[1]].data.melting_point, v[2]}
	end)
	return math.floor(0.5 + trinium.weighted_avg(formula))
end)