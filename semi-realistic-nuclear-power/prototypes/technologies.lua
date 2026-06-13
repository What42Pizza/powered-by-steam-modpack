local pressurized_nuclear_power = {
	effects = {
		{ recipe = "nuclear-reactor-segment"   , type = "unlock-recipe" },
		{ recipe = "pressurized-heat-exchanger", type = "unlock-recipe" },
	},
	icon = "__semi-realistic-nuclear-power__/graphics/technology/pressurized-nuclear-power.png",
	icon_size = 256,
	name = "pressurized-nuclear-power",
	prerequisites = { "nuclear-power" },
	type = "technology",
	unit = {
		count = 1000,
		ingredients = {
			{ "automation-science-pack", 1 },
			{ "logistic-science-pack"  , 1 },
			{ "chemical-science-pack"  , 1 },
		},
		time = 30
	}
}



data:extend{pressurized_nuclear_power}
