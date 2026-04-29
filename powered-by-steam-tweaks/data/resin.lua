local one_second = 60
local one_minute = one_second * 50

local resin_item = {
	name = "resin",
	icon = "__powered-by-steam-tweaks__/graphics/icons/resin.png",
	order = "a[smelting]-d[resin]",
	stack_size = 100,
	subgroup = "raw-material",
	drop_sound = table.deepcopy(data.raw["item"]["wood"].drop_sound),
	inventory_move_sound = table.deepcopy(data.raw["item"]["wood"].inventory_move_sound),
	pick_sound = table.deepcopy(data.raw["item"]["wood"].pick_sound),
	type = "item"
}
data:extend{resin_item}

local resin_recipe = {
	name = "resin",
	order = "b[smelting]-a[resin]",
	crafting_machine_tint = {
		primary = { a = 1, b = 0.09, g = 0.205, r = 0.442 },
		secondary = { a = 1, b = 0, g = 0.5, r = 1 }
	},
	enabled = false,
	ingredients = {
		{ amount = 1, name = "wood", type = "item" },
	},
	results = {
		{ amount = 3, name = "resin", type = "item" },
	},
	energy_required = 5,
	allow_productivity = true,
	auto_recycle = false,
	category = "advanced-crafting",
	subgroup = "nauvis-agriculture",
	type = "recipe"
}
data:extend{resin_recipe}

local resin_tech = {
	name = "resin",
	icon = "__powered-by-steam-tweaks__/graphics/icons/resin.png",
	icon_size = 64,
	prerequisites = { "agriculture", },
	effects = {
		{ recipe = "resin", type = "unlock-recipe" },
	},
	unit = {
		count = 50,
		ingredients = {
			{ "automation-science-pack", 1 },
		},
		time = 15
	},
	type = "technology",
}
data:extend{resin_tech}
