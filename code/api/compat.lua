-- 0.4.16 compatibility
if not minetest.get_translator then
	minetest.get_translator = function(str, ...)
		local arr = {...}
		return str:gsub("@(.)", function(matched)
			return arr[string.byte(matched) - string.byte(0)]
		end)
	end
end