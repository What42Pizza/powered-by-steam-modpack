local material_science_pack_tool = table.deepcopy(data.raw["tool"]["automation-science-pack"])
material_science_pack_tool.name = "material-science-pack"
data:extend{material_science_pack_tool}

local material_science_pack_recipe = table.deepcopy(data.raw["recipe"]["automation-science-pack"])
material_science_pack_recipe.name = "material-science-pack"
material_science_pack_recipe.ingredients = {
	{ amount = 1, name = "copper-plate", type = "item" },
	{ amount = 1, name = "stone"       , type = "item" },
	{ amount = 1, name = "wood"        , type = "item" }
}
material_science_pack_recipe.results = {
	{ amount = 1, name = "material-science-pack", type = "item" }
}
data:extend{material_science_pack_recipe}

local material_science_pack_tech = table.deepcopy(data.raw["technology"]["automation-science-pack"])
material_science_pack_tech.name = "material-science-pack"
material_science_pack_tech.icon = "__powered-by-steam-tweaks__/graphics/technology/material-science-pack.png"
material_science_pack_tech.effects = {
	{ recipe = "material-science-pack", type = "unlock-recipe" }
}
data:extend{material_science_pack_tech}
