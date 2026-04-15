local steam_power = data.raw["technology"]["steam-power"]
steam_power.research_trigger.item = "copper-plate"
steam_power.research_trigger.count = 10
remove_effect(steam_power, function(effect) return effect.recipe == "pipe" end, "recipe \"pipe\"")
remove_effect(steam_power, function(effect) return effect.recipe == "pipe-to-ground" end, "recipe \"pipe-to-ground\"")
remove_effect(steam_power, function(effect) return effect.recipe == "steam-engine" end, "recipe \"steam-engine\"")
table.insert(steam_power.effects, {
	recipe = "iron-stick",
	type = "unlock-recipe"
})

local electronics = data.raw["technology"]["electronics"]
electronics.research_trigger.item = "iron-plate"
remove_effect(electronics, function(effect) return effect.recipe == "inserter" end, "recipe \"inserter\"")
remove_effect(electronics, function(effect) return effect.recipe == "copper-cable" end, "recipe \"copper-cable\"")
remove_effect(electronics, function(effect) return effect.recipe == "small-electric-pole" end, "recipe \"small-electric-pole\"")
table.insert(electronics.effects, {
	recipe = "graphite-lubricant",
	type = "unlock-recipe"
})



local automation = data.raw["technology"]["automation"]
remove_effect(automation, function(effect) return effect.recipe == "long-handed-inserter" end, "recipe \"long-handed-inserter\"")

local fluid_handling = data.raw["technology"]["fluid-handling"]
fluid_handling.prerequisites = {
	"automation"
}
table.insert(fluid_handling.effects, 3, {
	recipe = "electric-pump",
	type = "unlock-recipe"
})

data.raw["technology"]["toolbelt"].unit.count = 100

local agriculture = data.raw["technology"]["agriculture"]
agriculture.prerequisites = {
	"logistic-science-pack",
	"landfill"
}
agriculture.research_trigger = nil
agriculture.unit = {
	count = 50,
	ingredients = {
		{ "automation-science-pack", 1 },
		{ "logistic-science-pack", 1 },
	},
	time = 30
}

local logistics_2 = data.raw["technology"]["logistics-2"]
table.insert(logistics_2.prerequisites, "agriculture")

data.raw["technology"]["jellynut"].prerequisites = { "planet-discovery-gleba" }
data.raw["technology"]["yumako"].prerequisites = { "planet-discovery-gleba" }



local chemical_science_pack = data.raw["technology"]["chemical-science-pack"]
chemical_science_pack.unit.count = 100
chemical_science_pack.prerequisites = {
	"plastics",
	"sulfur-processing"
}



data.raw["technology"]["advanced-material-processing-2"].hidden = true
find_remove(data.raw["technology"]["production-science-pack"].prerequisites, "advanced-material-processing-2")
find_remove(data.raw["technology"]["rocket-silo"].prerequisites, "advanced-material-processing-2")

local fast_inserter = data.raw["technology"]["fast-inserter"]
fast_inserter.unit.count = 75
fast_inserter.unit.ingredients = {
	{ "automation-science-pack", 1 },
	{ "logistic-science-pack", 1 },
	{ "chemical-science-pack", 1 }
}
fast_inserter.prerequisites = {
	"inserter",
	"chemical-science-pack"
}

local advanced_circuit = data.raw["technology"]["advanced-circuit"]
advanced_circuit.prerequisites = {
	"chemical-science-pack",
	"lubricant"
}
advanced_circuit.unit.ingredients = {
	{ "automation-science-pack", 1 },
	{ "logistic-science-pack", 1 },
	{ "chemical-science-pack", 1 }
}

local automation_2 = data.raw["technology"]["automation-2"]
automation_2.prerequisites = {
	"automation",
	"steel-processing",
	"advanced-circuit"
}
automation_2.unit.ingredients = {
	{ "automation-science-pack", 1 },
	{ "logistic-science-pack", 1 },
	{ "chemical-science-pack", 1 }
}

data.raw["technology"]["battery"].unit.ingredients = {
	{ "automation-science-pack", 1 },
	{ "logistic-science-pack", 1 },
	{ "chemical-science-pack", 1 }
}

local military_2 = data.raw["technology"]["military-2"]
military_2.prerequisites = {
	"military",
	"steel-processing",
	"chemical-science-pack"
}
military_2.unit.count = 150
military_2.unit.ingredients = {
	{ "automation-science-pack", 1 },
	{ "logistic-science-pack", 1 },
	{ "chemical-science-pack", 1 }
}

local flammables = data.raw["technology"]["flammables"]
flammables.prerequisites = {
	"military-2",
	"chemical-science-pack"
}
flammables.unit.ingredients = {
	{ "automation-science-pack", 1 },
	{ "logistic-science-pack", 1 },
	{ "chemical-science-pack", 1 }
}

local electric_energy_distribution_1 = data.raw["technology"]["electric-energy-distribution-1"]
electric_energy_distribution_1.prerequisites = {
	"chemical-science-pack",
	"steel-processing"
}
electric_energy_distribution_1.unit.ingredients = {
	{ "automation-science-pack", 1 },
	{ "logistic-science-pack", 1 },
	{ "chemical-science-pack", 1 }
}
remove_effect(electric_energy_distribution_1, function(effect) return effect.recipe == "big-electric-pole" end, "recipe \"big-electric-pole\"")

local electric_energy_distribution_2 = data.raw["technology"]["electric-energy-distribution-2"]
electric_energy_distribution_2.prerequisites = {
	"electric-energy-distribution-1",
	"utility-science-pack"
}
electric_energy_distribution_2.unit.ingredients = {
	{ "automation-science-pack", 1 },
	{ "logistic-science-pack", 1 },
	{ "chemical-science-pack", 1 },
	{ "utility-science-pack", 1 }
}

data.raw["technology"]["explosives"].unit.ingredients = {
	{ "automation-science-pack", 1 },
	{ "logistic-science-pack", 1 },
	{ "chemical-science-pack", 1 }
}

data.raw["technology"]["electric-energy-accumulators"].unit.ingredients = {
	{ "automation-science-pack", 1 },
	{ "logistic-science-pack", 1 },
	{ "chemical-science-pack", 1 }
}



data.raw["technology"]["physical-projectile-damage-1"].hidden = true
data.raw["technology"]["physical-projectile-damage-2"].hidden = true
data.raw["technology"]["physical-projectile-damage-3"].hidden = true
data.raw["technology"]["physical-projectile-damage-4"].hidden = true
data.raw["technology"]["physical-projectile-damage-5"].hidden = true
data.raw["technology"]["physical-projectile-damage-6"].hidden = true
data.raw["technology"]["physical-projectile-damage-7"].hidden = true

data.raw["technology"]["weapon-shooting-speed-1"].hidden = true
data.raw["technology"]["weapon-shooting-speed-2"].hidden = true
data.raw["technology"]["weapon-shooting-speed-3"].hidden = true
data.raw["technology"]["weapon-shooting-speed-4"].hidden = true
data.raw["technology"]["weapon-shooting-speed-5"].hidden = true
data.raw["technology"]["weapon-shooting-speed-6"].hidden = true

data.raw["technology"]["braking-force-1"].hidden = true
data.raw["technology"]["braking-force-2"].hidden = true
data.raw["technology"]["braking-force-3"].hidden = true
data.raw["technology"]["braking-force-4"].hidden = true
data.raw["technology"]["braking-force-5"].hidden = true
data.raw["technology"]["braking-force-6"].hidden = true
data.raw["technology"]["braking-force-7"].hidden = true

data.raw["technology"]["research-speed-1"].hidden = true
data.raw["technology"]["research-speed-2"].hidden = true
data.raw["technology"]["research-speed-3"].hidden = true
data.raw["technology"]["research-speed-4"].hidden = true
data.raw["technology"]["research-speed-5"].hidden = true
data.raw["technology"]["research-speed-6"].hidden = true

data.raw["technology"]["laser"].hidden = true
data.raw["technology"]["laser-turret"].hidden = true
data.raw["technology"]["personal-laser-defense-equipment"].hidden = true
data.raw["technology"]["laser-shooting-speed-1"].hidden = true
data.raw["technology"]["laser-shooting-speed-2"].hidden = true
data.raw["technology"]["laser-shooting-speed-3"].hidden = true
data.raw["technology"]["laser-shooting-speed-4"].hidden = true
data.raw["technology"]["laser-shooting-speed-5"].hidden = true
data.raw["technology"]["laser-shooting-speed-6"].hidden = true
data.raw["technology"]["laser-shooting-speed-7"].hidden = true
data.raw["technology"]["laser-weapons-damage-1"].hidden = true
data.raw["technology"]["laser-weapons-damage-2"].hidden = true
data.raw["technology"]["laser-weapons-damage-3"].hidden = true
data.raw["technology"]["laser-weapons-damage-4"].hidden = true
data.raw["technology"]["laser-weapons-damage-5"].hidden = true
data.raw["technology"]["laser-weapons-damage-6"].hidden = true
data.raw["technology"]["laser-weapons-damage-7"].hidden = true
