data.raw["recipe"]["pipe"].enabled = true
data.raw["recipe"]["pipe-to-ground"].enabled = true

data.raw["recipe"]["iron-plate"].energy_required = 2.4
data.raw["recipe"]["copper-plate"].energy_required = 2.4
data.raw["recipe"]["stone-brick"].energy_required = 4.8



local electronic_circuit = data.raw["recipe"]["electronic-circuit"]
electronic_circuit.ingredients = {
	{ amount = 1, name = "iron-cylinder"     , type = "item"  },
	{ amount = 5, name = "graphite-lubricant", type = "fluid" }
}

local advanced_circuit = data.raw["recipe"]["advanced-circuit"]
advanced_circuit.ingredients = {
	{ amount = 3 , name = "electronic-circuit", type = "item"  },
	{ amount = 10, name = "lubricant"         , type = "fluid" },
	{ amount = 1 , name = "soft-plastic-bar"  , type = "item"  }
}



replace_ingredient_name(data.raw["recipe"]["lab"], "transport-belt", "pipe")
replace_ingredient_name(data.raw["recipe"]["assembling-machine-1"], "iron-plate", "copper-plate")
replace_ingredient_name(data.raw["recipe"]["burner-mining-drill"], "iron-plate", "copper-plate")
replace_ingredient_name(data.raw["recipe"]["inserter"], "iron-plate", "copper-plate")
replace_ingredient_name(data.raw["recipe"]["steam-engine"], "iron-plate", "copper-plate")
replace_ingredient_name(data.raw["recipe"]["transport-belt"], "iron-plate", "copper-plate")



table.insert(data.raw["recipe"]["steel-plate"].ingredients, {
	amount = 1,
	name = "coal",
	type = "item"
})

local engine = data.raw["recipe"]["engine-unit"]
engine.ingredients = {
	{ amount = 3 , name = "iron-cylinder"     , type = "item"  },
	{ amount = 10, name = "graphite-lubricant", type = "fluid" },
	{ amount = 3 , name = "steel-plate"       , type = "item"  }
}



local automation_science_pack = data.raw["recipe"]["automation-science-pack"]
automation_science_pack.ingredients = {
	{ amount = 1, name = "assembling-machine-1", type = "item" },
	{ amount = 1, name = "burner-mining-drill" , type = "item" }
}



local chemical_science_pack = data.raw["recipe"]["chemical-science-pack"]
chemical_science_pack.category = "chemistry"
chemical_science_pack.ingredients = {
	{ amount = 30 , name = "graphite-lubricant", type = "fluid" },
	{ amount = 5  , name = "plastic-bar"       , type = "item"  },
	{ amount = 150, name = "sulfuric-acid"     , type = "fluid" }
}
