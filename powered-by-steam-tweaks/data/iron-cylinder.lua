local iron_cylinder_item = table.deepcopy(data.raw["item"]["iron-plate"])
iron_cylinder_item.name = "iron-cylinder"
iron_cylinder_item.icon = "__powered-by-steam-tweaks__/graphics/icons/iron-cylinder.png"
data:extend{iron_cylinder_item}

local iron_cylinder_recipe = table.deepcopy(data.raw["recipe"]["iron-plate"])
iron_cylinder_recipe.name = "iron-cylinder"
iron_cylinder_recipe.results = {
	{
		amount = 1,
		name = "iron-cylinder",
		type = "item"
	}
}
data:extend{iron_cylinder_recipe}
