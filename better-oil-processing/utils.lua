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

function replace_ingredient_name(input, ingredient_name, new_ingredient_name)
	for k,v in pairs(input.ingredients) do
		if v.name == ingredient_name then
			input.ingredients[k].name = new_ingredient_name
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
