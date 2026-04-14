local electric_pump_entity = table.deepcopy(data.raw["pump"]["pump"])
electric_pump_entity.name = "electric-pump"
electric_pump_entity.minable.result = "electric-pump"
data:extend{electric_pump_entity}

local electric_pump_item = table.deepcopy(data.raw["item"]["pump"])
electric_pump_item.name = "electric-pump"
data.raw["item"]["pump"].order = "b[pipe]-c[pump1]"
electric_pump_item.order = "b[pipe]-c[pump2]"
electric_pump_item.place_result = "electric-pump"
data:extend{electric_pump_item}

local electric_pump_recipe = table.deepcopy(data.raw["recipe"]["pump"])
electric_pump_recipe.name = "electric-pump"
electric_pump_recipe.results = {
	{
		amount = 1,
		name = "electric-pump",
		type = "item"
	}
}
data:extend{electric_pump_recipe}
