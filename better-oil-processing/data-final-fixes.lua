local utils = require("utils")



-- replace light and heavy oils in recipes with kerosene and hot tar
local recipes = data.raw["recipe"]
for _,recipe in pairs(recipes) do
	if recipe.ingredients then
		for _,ingredient in pairs(recipe.ingredients) do
			if ingredient.name == "light-oil" then
				ingredient.name = "kerosene"
			end
			if ingredient.name == "heavy-oil" then
				ingredient.name = "hot-tar"
			end
		end
	end
	if recipe.results then
		for _,result in pairs(recipe.results) do
			if result.name == "light-oil" then
				result.name = "kerosene"
			end
			if result.name == "heavy-oil" then
				result.name = "hot-tar"
			end
		end
	end
end
