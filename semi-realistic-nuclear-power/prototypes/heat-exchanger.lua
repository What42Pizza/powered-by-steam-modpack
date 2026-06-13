local pressurized_heat_exchanger = table.deepcopy(data.raw["assembling-machine"]["chemical-plant"])
pressurized_heat_exchanger.name = "pressurized-heat-exchanger"
pressurized_heat_exchanger.minable.result = "pressurized-heat-exchanger"
pressurized_heat_exchanger.crafting_categories = { "pressurized-heat-exchanger" }
for _,direction in pairs(pressurized_heat_exchanger.graphics_set.animation) do
	direction.layers[1].filename = "__semi-realistic-nuclear-power__/graphics/entity/pressurized-heat-exchanger.png"
end

local pressurized_heat_exchanger_category = {
	name = "pressurized-heat-exchanger",
	type = "recipe-category",
}



local pressurized_heat_exchanger_item = table.deepcopy(data.raw["item"]["chemical-plant"])
pressurized_heat_exchanger_item.name = "pressurized-heat-exchanger"
pressurized_heat_exchanger_item.place_result = "pressurized-heat-exchanger"
pressurized_heat_exchanger_item.icon = "__semi-realistic-nuclear-power__/graphics/icons/pressurized-heat-exchanger.png"



local pressurized_heat_exchanger_recipe = {
	name = "pressurized-heat-exchanger",
	type = "recipe",
	ingredients = {
		{ amount = 1 , name = "chemical-plant", type = "item" },
		{ amount = 20, name = "steel-plate"   , type = "item" },
		{ amount = 40, name = "copper-plate"  , type = "item" },
		{ amount = 2 , name = "pump"          , type = "item" },
	},
	results = {
		{ amount = 1, name = "pressurized-heat-exchanger", type = "item" },
	},
	energy_required = 3,
	enabled = false,
}



data:extend{pressurized_heat_exchanger, pressurized_heat_exchanger_category, pressurized_heat_exchanger_item, pressurized_heat_exchanger_recipe}
