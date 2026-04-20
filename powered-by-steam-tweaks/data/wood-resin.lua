local one_second = 60
local one_minute = one_second * 50

local wood_resin_item = {
	name = "wood-resin",
	icon = "__powered-by-steam-tweaks__/graphics/icons/wood-resin.png",
	order = "a[smelting]-d[wood-resin]",
	stack_size = 100,
	spoil_ticks = 5 * one_minute,
	spoil_result = "dried-wood-resin",
	subgroup = "raw-material",
	drop_sound = table.deepcopy(data.raw["item"]["wood"].drop_sound),
	inventory_move_sound = table.deepcopy(data.raw["item"]["wood"].inventory_move_sound),
	pick_sound = table.deepcopy(data.raw["item"]["wood"].pick_sound),
	type = "item"
}
data:extend{wood_resin_item}

local wood_resin_recipe = {
	name = "wood-resin",
	order = "b[smelting]-a[wood-resin]",
	crafting_machine_tint = {
		primary = { a = 1, b = 0.09, g = 0.205, r = 0.442 },
		secondary = { a = 1, b = 0, g = 0.5, r = 1 }
	},
	enabled = false,
	ingredients = {
		{ amount = 1, name = "wood", type = "item" },
	},
	results = {
		{ amount = 1, name = "wood-resin", type = "item" },
	},
	energy_required = 5,
	allow_productivity = true,
	auto_recycle = false,
	category = "advanced-crafting",
	subgroup = "nauvis-agriculture",
	type = "recipe"
}
data:extend{wood_resin_recipe}

local wood_resin_tech = {
	name = "wood-resin",
	icon = "__powered-by-steam-tweaks__/graphics/icons/wood-resin.png",
	icon_size = 64,
	prerequisites = { "agriculture", },
	effects = {
		{ recipe = "wood-resin", type = "unlock-recipe" },
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
data:extend{wood_resin_tech}
