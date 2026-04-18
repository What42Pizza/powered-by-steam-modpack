-- first techs

local steam_power = data.raw["technology"]["steam-power"]
steam_power.research_trigger.item = "copper-plate"
steam_power.research_trigger.count = 10
remove_effect(steam_power, function(effect) return effect.recipe == "pipe" end, "recipe \"pipe\"")
remove_effect(steam_power, function(effect) return effect.recipe == "pipe-to-ground" end, "recipe \"pipe-to-ground\"")
remove_effect(steam_power, function(effect) return effect.recipe == "steam-engine" end, "recipe \"steam-engine\"")

local electronics = data.raw["technology"]["electronics"]
electronics.research_trigger.item = "iron-plate"
remove_effect(electronics, function(effect) return effect.recipe == "inserter" end, "recipe \"inserter\"")
remove_effect(electronics, function(effect) return effect.recipe == "copper-cable" end, "recipe \"copper-cable\"")
remove_effect(electronics, function(effect) return effect.recipe == "small-electric-pole" end, "recipe \"small-electric-pole\"")
remove_effect(electronics, function(effect) return effect.recipe == "electronic-circuit" end, "recipe \"electronic-circuit\"")
table.insert(electronics.effects, {
	recipe = "crude-camshaft-production",
	type = "unlock-recipe"
})

local automation = data.raw["technology"]["automation"]
automation.unit.count = 15
remove_effect(automation, function(effect) return effect.recipe == "long-handed-inserter" end, "recipe \"long-handed-inserter\"")
table.insert(automation.effects, {
	recipe = "electronic-circuit",
	type = "unlock-recipe"
})
table.insert(automation.effects, {
	recipe = "graphite-lubricant",
	type = "unlock-recipe"
})

local electric_mining_drill = data.raw["technology"]["electric-mining-drill"]
electric_mining_drill.prerequisites = { "material-science-pack", "steam-power" }
electric_mining_drill.unit.count = 15
electric_mining_drill.unit.ingredients = {
	{ "material-science-pack", 1 },
}

local agriculture = data.raw["technology"]["agriculture"]
agriculture.prerequisites = { "material-science-pack" }
agriculture.research_trigger = nil
agriculture.unit = {
	count = 25,
	ingredients = {
		{ "material-science-pack", 1 }
	},
	time = 30
}
agriculture.effects = {
	{ recipe = "agricultural-tower", type = "unlock-recipe" },
	{ recipe = "landfill"          , type = "unlock-recipe" },
	{ recipe = "wood-processing"   , type = "unlock-recipe" },
}

data.raw["technology"]["planet-discovery-gleba"].prerequisites = { "space-platform-thruster", "agriculture" }
data.raw["technology"]["landfill"].hidden = true

data.raw["technology"]["gun-turret"].unit.count = 25
data.raw["technology"]["stone-wall"].unit.count = 15
data.raw["technology"]["radar"].unit.count = 25
data.raw["technology"]["radar"].prerequisites = { "material-science-pack", "electricity" }
data.raw["technology"]["lamp"].unit.count = 25



-- early tech

local fluid_handling = data.raw["technology"]["fluid-handling"]
fluid_handling.prerequisites = { "automation" }
table.insert(fluid_handling.effects, 3, {
	recipe = "electric-pump",
	type = "unlock-recipe"
})

data.raw["technology"]["toolbelt"].unit.count = 100

local logistics_2 = data.raw["technology"]["logistics-2"]
table.insert(logistics_2.prerequisites, "agriculture")

data.raw["technology"]["tree-seeding"].hidden = true
data.raw["technology"]["fish-breeding"].prerequisites = { "agricultural-science-pack" }

data.raw["technology"]["jellynut"].prerequisites = { "planet-discovery-gleba" }
data.raw["technology"]["yumako"].prerequisites = { "planet-discovery-gleba" }

data.raw["technology"]["military"].unit.count = 50

data.raw["technology"]["logistics"].unit.count = 25



-- early-mid techs

data.raw["technology"]["automobilism"].prerequisites = { "engine" }

local chemical_science_pack = data.raw["technology"]["chemical-science-pack"]
chemical_science_pack.unit.count = 100
chemical_science_pack.prerequisites = { "plastics", "sulfur-processing" }

data.raw["technology"]["advanced-material-processing-2"].hidden = true
find_remove(data.raw["technology"]["production-science-pack"].prerequisites, "advanced-material-processing-2")
find_remove(data.raw["technology"]["rocket-silo"].prerequisites, "advanced-material-processing-2")

local fast_inserter = data.raw["technology"]["fast-inserter"]
fast_inserter.unit.count = 75
fast_inserter.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 }
}
fast_inserter.prerequisites = { "long-handed-inserter", "chemical-science-pack" }

local advanced_circuit = data.raw["technology"]["advanced-circuit"]
advanced_circuit.prerequisites = { "chemical-science-pack", "lubricant", "electronics" }
advanced_circuit.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "chemical-science-pack"  , 1 }
}

--local automation_2 = data.raw["technology"]["automation-2"]
--automation_2.prerequisites = {
--	"automation",
--	"steel-processing",
--	"advanced-circuit"
--}
--automation_2.unit.ingredients = {
--	{ "material-science-pack"  , 1 },
--	{ "logistic-science-pack"  , 1 },
--	{ "automation-science-pack", 1 },
--	{ "chemical-science-pack"  , 1 }
--}

data.raw["technology"]["battery"].unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "chemical-science-pack"  , 1 }
}

local military_2 = data.raw["technology"]["military-2"]
military_2.prerequisites = { "military", "steel-processing", "chemical-science-pack" }
remove_effect(military_2, function(effect) return effect.recipe == "piercing-rounds-magazine" end, "recipe \"piercing-rounds-magazine\"")
military_2.unit.count = 150
military_2.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 }
}

local flammables = data.raw["technology"]["flammables"]
flammables.prerequisites = { "military-2", "chemical-science-pack" }
flammables.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "chemical-science-pack"  , 1 }
}

local electric_energy_distribution_1 = data.raw["technology"]["electric-energy-distribution-1"]
electric_energy_distribution_1.prerequisites = { "chemical-science-pack", "steel-processing" }
electric_energy_distribution_1.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "chemical-science-pack"  , 1 }
}
remove_effect(electric_energy_distribution_1, function(effect) return effect.recipe == "big-electric-pole" end, "recipe \"big-electric-pole\"")

local electric_energy_distribution_2 = data.raw["technology"]["electric-energy-distribution-2"]
electric_energy_distribution_2.prerequisites = { "electric-energy-distribution-1", "utility-science-pack" }
electric_energy_distribution_2.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "chemical-science-pack"  , 1 },
	{ "utility-science-pack"   , 1 }
}

data.raw["technology"]["explosives"].unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "chemical-science-pack"  , 1 }
}

data.raw["technology"]["electric-energy-accumulators"].unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "chemical-science-pack"  , 1 }
}

data.raw["technology"]["mining-productivity-1"].unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "chemical-science-pack"  , 1 }
}

local military_3 = data.raw["technology"]["military-3"]
table.insert(military_3.effects, 1, { recipe = "piercing-rounds-magazine", type = "unlock-recipe" })

local rocketry = data.raw["technology"]["rocketry"]
rocketry.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "military-science-pack"  , 1 },
	{ "chemical-science-pack"  , 1 }
}



-- make all technologies twice as expensive

for _,tech in pairs(data.raw.technology) do
	local unit = tech.unit
	if unit and unit.count then
		unit.count = unit.count * 2
	end
end



-- remove some techs

data.raw["technology"]["electric-energy-distribution-2"].hidden = true

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
