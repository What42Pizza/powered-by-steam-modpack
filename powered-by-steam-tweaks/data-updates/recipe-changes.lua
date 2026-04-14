data.raw["recipe"]["pipe"].enabled = true
data.raw["recipe"]["pipe-to-ground"].enabled = true

data.raw["recipe"]["iron-plate"].energy_required = 2.4
data.raw["recipe"]["copper-plate"].energy_required = 2.4

local electronic_circuit = data.raw["recipe"]["electronic-circuit"]
electronic_circuit.ingredients = {
	{
		amount = 1,
		name = "iron-stick",
		type = "item"
	},
	{
		amount = 1,
		name = "iron-gear-wheel",
		type = "item"
	},
}

replace_ingredient(data.raw["recipe"]["lab"], "transport-belt", {
	amount = 5,
	name = "pipe",
	type = "item"
})

replace_ingredient(data.raw["recipe"]["assembling-machine-1"], "iron-plate", {
	amount = 9,
	name = "copper-plate",
	type = "item"
})

replace_ingredient(data.raw["recipe"]["burner-mining-drill"], "iron-plate", {
	amount = 3,
	name = "copper-plate",
	type = "item"
})

replace_ingredient(data.raw["recipe"]["inserter"], "iron-plate", {
	amount = 1,
	name = "copper-plate",
	type = "item"
})

replace_ingredient(data.raw["recipe"]["steam-engine"], "iron-plate", {
	amount = 10,
	name = "copper-plate",
	type = "item"
})

replace_ingredient(data.raw["recipe"]["transport-belt"], "iron-plate", {
	amount = 1,
	name = "copper-plate",
	type = "item"
})
