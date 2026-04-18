local crude_camshaft_production = table.deepcopy(data.raw["recipe"]["electronic-circuit"])
crude_camshaft_production.name = "crude-camshaft-production"
crude_camshaft_production.icon = "__powered-by-steam-tweaks__/graphics/icons/crude-camshaft-production.png"
crude_camshaft_production.ingredients = {
	{ amount = 2, name = "iron-plate", type = "item" },
	{ amount = 1, name = "stone"     , type = "item" },
}
crude_camshaft_production.results = {
	{ amount = 1, name = "electronic-circuit", probability = 0.15, type = "item" },
}
data:extend{crude_camshaft_production}
