local graphite_lubricant_liquid = table.deepcopy(data.raw["fluid"]["water"])
graphite_lubricant_liquid.name = "graphite-lubricant"
graphite_lubricant_liquid.icon = "__powered-by-steam-tweaks__/graphics/icons/graphite-lubricant.png"
graphite_lubricant_liquid.base_color = { 0.47, 0.55, 0.6 }
data:extend{graphite_lubricant_liquid}

local graphite_lubricant_recipe = table.deepcopy(data.raw["recipe"]["lubricant"])
graphite_lubricant_recipe.name = "graphite-lubricant"
graphite_lubricant_recipe.category = "crafting-with-fluid"
graphite_lubricant_recipe.ingredients = {
	{ amount = 100, name = "water", type = "fluid" },
	{ amount = 3, name = "coal", type = "item" }
}
graphite_lubricant_recipe.results = {
	{ amount = 100, name = "graphite-lubricant", type = "fluid" }
}
data:extend{graphite_lubricant_recipe}
