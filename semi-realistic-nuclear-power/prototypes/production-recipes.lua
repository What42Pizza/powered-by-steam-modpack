local high_pressure_water_recipe = {
	name = "high-pressure-water",
	type = "recipe",
	ingredients = {
		{ amount = 50, name = "water", type = "fluid" },
	},
	results = {
		{ amount = 45, name = "high-pressure-water", type = "fluid" },
	},
	energy_required = 2,
	category = "chemistry",
	enabled = false,
}



local superheated_water_exchange_recipe = {
	name = "superheated-water-exchange",
	type = "recipe",
	ingredients = {
		{ amount = 50, name = "superheated-water", type = "fluid" },
		{ amount = 50, name = "water"            , type = "fluid" },
	},
	results = {
		{ amount = 50 , name = "high-pressure-water", type = "fluid" },
		{ amount = 500, name = "high-pressure-steam", type = "fluid" },
	},
	energy_required = 1,
	category = "pressurized-heat-exchanger",
	enabled = false,
}

local high_pressure_steam_exchange_recipe = {
	name = "high-pressure-steam-exchange",
	type = "recipe",
	ingredients = {
		{ amount = 500, name = "high-pressure-steam", type = "fluid" },
		{ amount = 50 , name = "water"              , type = "fluid" },
	},
	results = {
		{ amount = 500, name = "medium-pressure-steam", type = "fluid" },
		{ amount = 500, name = "steam"                , type = "fluid" },
	},
	energy_required = 1,
	category = "pressurized-heat-exchanger",
	enabled = false,
}

local medium_pressure_steam_exchange_recipe = {
	name = "medium-pressure-steam-exchange",
	type = "recipe",
	ingredients = {
		{ amount = 500, name = "medium-pressure-steam", type = "fluid" },
		{ amount = 50 , name = "water"                , type = "fluid" },
	},
	results = {
		{ amount = 1000, name = "steam", type = "fluid" },
	},
	energy_required = 1,
	category = "pressurized-heat-exchanger",
	enabled = false,
}



local high_pressure_steam_drying = {
	name = "high-pressure-steam-drying",
	type = "recipe",
	ingredients = {
		{ amount = 500, name = "high-pressure-steam-drying", type = "fluid" },
	},
	results = {
		{ amount = 490, name = "dry-high-pressure-steam", type = "fluid" },
		{ amount =   1, name = "water"                  , type = "fluid" },
	},
	energy_required = 1,
	icon = "__semi-realistic-nuclear-power__/graphics/icons/fluid/dry-high-pressure-steam.png",
	category = "chemistry",
	enabled = false,
}

local medium_pressure_steam_drying = {
	name = "medium-pressure-steam-drying",
	type = "recipe",
	ingredients = {
		{ amount = 500, name = "medium-pressure-steam-drying", type = "fluid" },
	},
	results = {
		{ amount = 490, name = "dry-medium-pressure-steam", type = "fluid" },
		{ amount =   1, name = "water"                    , type = "fluid" },
	},
	energy_required = 1,
	icon = "__semi-realistic-nuclear-power__/graphics/icons/fluid/dry-medium-pressure-steam.png",
	category = "chemistry",
	enabled = false,
}



--data:extend{high_pressure_water_recipe, superheated_water_exchange_recipe, high_pressure_steam_exchange_recipe, medium_pressure_steam_exchange_recipe, high_pressure_steam_drying, medium_pressure_steam_drying}
