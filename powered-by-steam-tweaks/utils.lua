function remove_ingredient(input, ingredient_name)
	for k,v in pairs(input.ingredients) do
		if v.name == ingredient_name then
			table.remove(input.ingredients, k)
		end
	end
end

function replace_ingredient(input, ingredient_name, new_ingredient)
	for k,v in pairs(input.ingredients) do
		if v.name == ingredient_name then
			input.ingredients[k] = new_ingredient
		end
	end
end

function replace_result(input, result_name, new_result)
	for k,v in pairs(input.results) do
		if v.name == result_name then
			input.results[k] = new_result
		end
	end
end

function remove_effect(input, check_fn, checking_for)
	local to_remove = {}
	for k,v in pairs(input.effects) do
		if check_fn(v) then
			table.insert(to_remove, k)
		end
	end
	if #to_remove == 0 then log("Warning: tried to remove " .. checking_for .. " but it was not found") end
	for _,v in ipairs(to_remove) do
		table.remove(input.effects, v)
	end
end

function round(v, nearest)
	if not nearest then nearest = 1.0 end
	return math.floor(v / nearest + 0.5) * nearest
end
