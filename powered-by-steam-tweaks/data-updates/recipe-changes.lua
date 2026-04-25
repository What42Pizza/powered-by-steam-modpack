data.raw["recipe"]["stone-furnace"].ingredients = {
	{ amount = 8, name = "stone", type = "item" },
}
data.raw["recipe"]["burner-mining-drill"].ingredients = {
	{ amount = 5, name = "copper-plate"   , type = "item" },
	{ amount = 4, name = "iron-gear-wheel", type = "item" },
	{ amount = 1, name = "stone-furnace"  , type = "item" },
}
data.raw["recipe"]["lab"].ingredients = {
	{ amount = 10, name = "iron-gear-wheel"   , type = "item" },
	{ amount = 8 , name = "electronic-circuit", type = "item" },
	{ amount = 4 , name = "pipe"              , type = "item" },
}

data.raw["recipe"]["iron-chest"].ingredients = {
	{ amount = 4, name = "iron-plate", type = "item" },
}
data.raw["recipe"]["pipe-to-ground"].ingredients = {
	{ amount = 2, name = "iron-plate", type = "item" },
	{ amount = 8, name = "pipe"      , type = "item" },
}
data.raw["recipe"]["electric-mining-drill"].ingredients = {
	{ amount = 8, name = "iron-plate"        , type = "item" },
	{ amount = 5, name = "iron-gear-wheel"   , type = "item" },
	{ amount = 3, name = "electronic-circuit", type = "item" },
}
data.raw["recipe"]["transport-belt"].ingredients = {
	{ amount = 1, name = "copper-plate"   , type = "item" },
	{ amount = 1, name = "iron-gear-wheel", type = "item" },
}
data.raw["recipe"]["underground-belt"].ingredients = {
	{ amount = 4, name = "copper-plate"      , type = "item" },
	{ amount = 4, name = "transport-belt"    , type = "item" },
}
data.raw["recipe"]["splitter"].ingredients = {
	{ amount = 4, name = "copper-plate"      , type = "item" },
	{ amount = 3, name = "electronic-circuit", type = "item" },
	{ amount = 2, name = "transport-belt"    , type = "item" },
}



data.raw["recipe"]["pipe"].enabled = true
data.raw["recipe"]["pipe-to-ground"].enabled = true

data.raw["recipe"]["iron-plate"].energy_required = 2.4
data.raw["recipe"]["copper-plate"].energy_required = 2.4
data.raw["recipe"]["stone-brick"].energy_required = 4.8



local electronic_circuit = data.raw["recipe"]["electronic-circuit"]
electronic_circuit.energy_required = 2.0
electronic_circuit.ingredients = {
	{ amount = 1, name = "iron-cylinder"     , type = "item"  },
	{ amount = 5, name = "graphite-lubricant", type = "fluid" },
}

local advanced_circuit = data.raw["recipe"]["advanced-circuit"]
advanced_circuit.ingredients = {
	{ amount = 3 , name = "electronic-circuit", type = "item"  },
	{ amount = 2 , name = "iron-gear-wheel"   , type = "item"  },
	{ amount = 10, name = "lubricant"         , type = "fluid" },
	{ amount = 1 , name = "soft-plastic-bar"  , type = "item"  },
}
advanced_circuit.results = {
	{ amount = 2, name = "advanced-circuit", type = "item" }
}

local agricultural_tower = data.raw["recipe"]["agricultural-tower"]
agricultural_tower.ingredients = {
	{ amount = 8, name = "copper-plate"      , type = "item" },
	{ amount = 2, name = "pipe"              , type = "item" },
	{ amount = 3, name = "electronic-circuit", type = "item" },
	{ amount = 1, name = "landfill"          , type = "item" },
}

data.raw["recipe"]["wood-processing"].ingredients = {
	{ amount = 1, name = "wood", type = "item" },
}

data.raw["recipe"]["fast-transport-belt"].ingredients = {
	{ amount = 5, name = "iron-gear-wheel", type = "item" },
	{ amount = 1, name = "transport-belt" , type = "item" },
	{ amount = 1, name = "resin"     , type = "item" },
}
table.insert(data.raw["recipe"]["fast-underground-belt"].ingredients, { amount = 1, name = "resin", type = "item" })
table.insert(data.raw["recipe"]["fast-splitter"].ingredients        , { amount = 1, name = "resin", type = "item" })

table.insert(data.raw["recipe"]["fast-inserter"].ingredients, { amount = 1, name = "resin", type = "item" })



replace_ingredient_name(data.raw["recipe"]["lab"], "transport-belt", "pipe")
replace_ingredient_name(data.raw["recipe"]["burner-inserter"], "iron-plate", "copper-plate")
replace_ingredient_name(data.raw["recipe"]["inserter"], "iron-plate", "copper-plate")
replace_ingredient_name(data.raw["recipe"]["steam-engine"], "iron-plate", "copper-plate")

--replace_ingredient_name(data.raw["recipe"]["logistic-science-pack"], "inserter", "burner-inserter")



data.raw["recipe"]["assembling-machine-1"].ingredients = {
	{ amount = 5, name = "iron-plate"        , type = "item" },
	{ amount = 2, name = "transport-belt"    , type = "item" },
	{ amount = 3, name = "electronic-circuit", type = "item" },
}

table.insert(data.raw["recipe"]["steel-plate"].ingredients, {
	amount = 1,
	name = "coal",
	type = "item"
})

local engine = data.raw["recipe"]["engine-unit"]
engine.ingredients = {
	{ amount = 3 , name = "iron-cylinder"     , type = "item"  },
	{ amount = 10, name = "graphite-lubricant", type = "fluid" },
	{ amount = 3 , name = "steel-plate"       , type = "item"  },
}

local rail = data.raw["recipe"]["rail"]
replace_ingredient_name(rail, "iron-stick", "wood")
rail.results[1].amount = 3



local hard_plastic_bar = data.raw["recipe"]["plastic-bar"]
hard_plastic_bar.ingredients = {
	{ amount = 30, name = "petroleum-gas", type = "fluid" },
	{ amount = 5 , name = "volatile-gas" , type = "fluid" },
	{ amount = 1 , name = "resin"        , type = "item"  },
}
local soft_plastic_bar = data.raw["recipe"]["soft-plastic-bar"]
soft_plastic_bar.ingredients = {
	{ amount = 15, name = "kerosene"    , type = "fluid" },
	{ amount = 5 , name = "volatile-gas", type = "fluid" },
	{ amount = 1 , name = "resin"       , type = "item"  },
}

local automation_science_pack = data.raw["recipe"]["automation-science-pack"]
automation_science_pack.ingredients = {
	{ amount = 1, name = "assembling-machine-1", type = "item" },
	{ amount = 1, name = "burner-mining-drill" , type = "item" },
	{ amount = 1, name = "plastic-bar"         , type = "item" },
}

local chemical_science_pack = data.raw["recipe"]["chemical-science-pack"]
chemical_science_pack.category = "chemistry"
chemical_science_pack.ingredients = {
	{ amount = 30 , name = "graphite-lubricant", type = "fluid" },
	{ amount = 5  , name = "soft-plastic-bar"  , type = "item"  },
	{ amount = 150, name = "sulfuric-acid"     , type = "fluid" },
}

local military_science_pack = data.raw["recipe"]["military-science-pack"]
replace_ingredient(military_science_pack, "piercing-rounds-magazine", { amount = 5, name = "firearm-magazine", type = "item" })
table.insert(military_science_pack.ingredients, 2, { amount = 1, name = "steel-plate", type = "item" })

local defender_capsule = data.raw["recipe"]["defender-capsule"]
replace_ingredient_name(defender_capsule, "piercing-rounds-magazine", "firearm-magazine")

local discharge_defense = data.raw["recipe"]["discharge-defense-equipment"]
replace_ingredient(discharge_defense, "laser-turret", { amount = 100, name = "battery", type = "item" })
