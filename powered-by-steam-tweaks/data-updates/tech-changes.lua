-- I've tried to lay this out as 'these tech are researched, then a new science pack is unlocked and these are researched, etc', but I decided kinda late so it might not fully be in order

-- first techs

local steam_power = data.raw["technology"]["steam-power"]
steam_power.research_trigger.item = "copper-plate"
steam_power.research_trigger.count = 10
remove_effect_recipe(steam_power, "pipe")
remove_effect_recipe(steam_power, "pipe-to-ground")
remove_effect_recipe(steam_power, "steam-engine")

local electronics = data.raw["technology"]["electronics"]
electronics.research_trigger.item = "iron-plate"
remove_effect_recipe(electronics, "inserter")
remove_effect_recipe(electronics, "copper-cable")
remove_effect_recipe(electronics, "small-electric-pole")
remove_effect_recipe(electronics, "electronic-circuit")
table.insert(electronics.effects, { recipe = "crude-camshaft-production", type = "unlock-recipe" })

local automation = data.raw["technology"]["automation"]
remove_effect_recipe(automation, "long-handed-inserter")
table.insert(automation.effects, { recipe = "electronic-circuit", type = "unlock-recipe" })
table.insert(automation.effects, { recipe = "graphite-lubricant", type = "unlock-recipe" })



-- material science start

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
	count = 20,
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

data.raw["technology"]["logistics"].unit.count = 25

data.raw["technology"]["military"].unit.count = 50

local fluid_handling = data.raw["technology"]["fluid-handling"]
fluid_handling.prerequisites = { "material-science-pack" }
table.insert(fluid_handling.effects, 3, { recipe = "electric-pump", type = "unlock-recipe"})
fluid_handling.unit.ingredients = {
	{ "material-science-pack", 1 }
}



-- logistic science start

local oil_gathering = data.raw["technology"]["oil-gathering"]
oil_gathering.prerequisites = { "logistic-science-pack", "fluid-handling" }
oil_gathering.unit.count = 50

local logistics_2 = data.raw["technology"]["logistics-2"]
table.insert(logistics_2.prerequisites, "resin")

data.raw["technology"]["tree-seeding"].hidden = true
data.raw["technology"]["fish-breeding"].prerequisites = { "agricultural-science-pack" }

data.raw["technology"]["jellynut"].prerequisites = { "planet-discovery-gleba" }
data.raw["technology"]["yumako"].prerequisites = { "planet-discovery-gleba" }

local railway = data.raw["technology"]["railway"]
railway.prerequisites = { "engine", "logistic-science-pack" }
table.insert(railway.effects, { recipe = "fluid-wagon", type = "unlock-recipe" })
data.raw["technology"]["fluid-wagon"].hidden = true

if mods["Mini_Trains"] then
	
	remove_effect_recipe(railway, "locomotive")
	remove_effect_recipe(railway, "cargo-wagon")
	remove_effect_recipe(railway, "fluid-wagon")
	table.insert(railway.effects, { recipe = "mini-locomotive", type = "unlock-recipe" })
	table.insert(railway.effects, { recipe = "mini-cargo-wagon", type = "unlock-recipe" })
	table.insert(railway.effects, { recipe = "mini-fluid-wagon", type = "unlock-recipe" })
	
end

data.raw["technology"]["sulfur-processing"].unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
}

data.raw["technology"]["plastics"].unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
}

local fast_inserter = data.raw["technology"]["fast-inserter"]
fast_inserter.prerequisites = { "long-handed-inserter", "logistic-science-pack" }
fast_inserter.unit.count = 75
fast_inserter.unit.ingredients = {
	{ "material-science-pack", 1 },
	{ "logistic-science-pack", 1 },
}



-- automation science start

data.raw["technology"]["automobilism"].prerequisites = { "engine" }

local chemical_science_pack = data.raw["technology"]["chemical-science-pack"]
chemical_science_pack.prerequisites = { "plastics", "sulfur-processing", "advanced-oil-processing" }
chemical_science_pack.unit.count = 100
chemical_science_pack.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
}

data.raw["technology"]["advanced-material-processing-2"].hidden = true
find_remove(data.raw["technology"]["production-science-pack"].prerequisites, "advanced-material-processing-2")
find_remove(data.raw["technology"]["rocket-silo"].prerequisites, "advanced-material-processing-2")

local automation_2 = data.raw["technology"]["automation-2"]
automation_2.prerequisites = { "automation", "steel-processing", "automation-science-pack" }
automation_2.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
}

local military_2 = data.raw["technology"]["military-2"]
military_2.prerequisites = { "military", "steel-processing", "automation-science-pack" }
remove_effect_recipe(military_2, "piercing-rounds-magazine")
military_2.unit.count = 150
military_2.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
}
table.insert(military_2.effects, { recipe = "poison-capsule"  , type = "unlock-recipe" })
table.insert(military_2.effects, { recipe = "slowdown-capsule", type = "unlock-recipe" })
table.insert(military_2.effects, { recipe = "combat-shotgun"  , type = "unlock-recipe" })

local gate = data.raw["technology"]["gate"]
gate.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
}

local inserter_capacity_bonus_1 = data.raw["technology"]["inserter-capacity-bonus-1"]
inserter_capacity_bonus_1.prerequisites = { "electricity", "automation-science-pack" }
inserter_capacity_bonus_1.effects = {
	{ modifier = 1, type = "inserter-stack-size-bonus"    },
	{ modifier = 1, type = "bulk-inserter-capacity-bonus" },
}
inserter_capacity_bonus_1.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
}

local advanced_oil_processing = data.raw["technology"]["advanced-oil-processing"]
advanced_oil_processing.prerequisites = { "automation-science-pack", "sulfur-processing" }
advanced_oil_processing.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
}

local lubricant = data.raw["technology"]["lubricant"]
lubricant.prerequisites = { "advanced-oil-processing" }
lubricant.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
}

local asphalt = data.raw["technology"]["asphalt"]
asphalt.prerequisites = { "advanced-oil-processing" }
asphalt.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
}

local advanced_circuit = data.raw["technology"]["advanced-circuit"]
advanced_circuit.prerequisites = { "electronics", "lubricant", "plastics" }
advanced_circuit.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
}

local modules = data.raw["technology"]["modules"]
modules.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
}
local efficiency_module = data.raw["technology"]["efficiency-module"]
efficiency_module.unit.count = 150
efficiency_module.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
}
local productivity_module = data.raw["technology"]["productivity-module"]
productivity_module.unit.count = 150
productivity_module.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
}
local quality_module = data.raw["technology"]["quality-module"]
quality_module.unit.count = 150
quality_module.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
}
local speed_module = data.raw["technology"]["speed-module"]
speed_module.unit.count = 150
speed_module.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
}

local bulk_inserter = data.raw["technology"]["bulk-inserter"]
bulk_inserter.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
}

local solar_panel_equipment = data.raw["technology"]["solar-panel-equipment"]
solar_panel_equipment.unit.count = 125
solar_panel_equipment.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
}

local night_vision_equipment = data.raw["technology"]["night-vision-equipment"]
night_vision_equipment.prerequisites = { "modular-armor" }
night_vision_equipment.unit.count = 125
night_vision_equipment.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
}

local belt_immunity_equipment = data.raw["technology"]["belt-immunity-equipment"]
belt_immunity_equipment.unit.count = 200
belt_immunity_equipment.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
}

local personal_roboport_equipment = data.raw["technology"]["personal-roboport-equipment"]
personal_roboport_equipment.unit.count = 200

local exoskeleton_equipment = data.raw["technology"]["exoskeleton-equipment"]
exoskeleton_equipment.unit.count = 200



-- military science start

local military_science_pack = data.raw["technology"]["military-science-pack"]
table.insert(military_science_pack.unit.ingredients, { "automation-science-pack", 1 })

local modular_armor = data.raw["technology"]["modular-armor"]
modular_armor.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "military-science-pack"  , 1 },
}



-- chemical science start

local flammables = data.raw["technology"]["flammables"]
flammables.prerequisites = { "military-2", "military-science-pack" }
flammables.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "military-science-pack"  , 1 },
	{ "chemical-science-pack"  , 1 },
}

local battery = data.raw["technology"]["battery"]
battery.prerequisites = { "sulfur-processing", "chemical-science-pack" }
battery.unit.count = 100
battery.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "chemical-science-pack"  , 1 },
}

local electric_energy_distribution_1 = data.raw["technology"]["electric-energy-distribution-1"]
electric_energy_distribution_1.prerequisites = { "chemical-science-pack", "steel-processing" }
electric_energy_distribution_1.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "chemical-science-pack"  , 1 },
}
remove_effect_recipe(electric_energy_distribution_1, "big-electric-pole")

local bulk_inserter = data.raw["technology"]["bulk-inserter"]
table.insert(bulk_inserter.prerequisites, "chemical-science-pack")
bulk_inserter.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "chemical-science-pack"  , 1 },
}

local inserter_capacity_bonus_2 = data.raw["technology"]["inserter-capacity-bonus-2"]
inserter_capacity_bonus_2.prerequisites = { "inserter-capacity-bonus-1", "bulk-inserter" }
inserter_capacity_bonus_2.effects = {
	{ modifier = 1, type = "bulk-inserter-capacity-bonus" },
}
inserter_capacity_bonus_2.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "chemical-science-pack"  , 1 },
}

local explosives = data.raw["technology"]["explosives"]
explosives.prerequisites = { "military-3" }
explosives.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "military-science-pack"  , 1 },
	{ "chemical-science-pack"  , 1 },
}

data.raw["technology"]["flamethrower"].unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "military-science-pack"  , 1 },
	{ "chemical-science-pack"  , 1 },
}

data.raw["technology"]["electric-energy-accumulators"].unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "chemical-science-pack"  , 1 },
}

data.raw["technology"]["mining-productivity-1"].unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "chemical-science-pack"  , 1 },
}

local military_3 = data.raw["technology"]["military-3"]
military_3.unit.count = 175
table.insert(military_3.effects, 1, { recipe = "piercing-rounds-magazine", type = "unlock-recipe" })
remove_effect_recipe(military_3, "poison-capsule")
remove_effect_recipe(military_3, "slowdown-capsule")
remove_effect_recipe(military_3, "combat-shotgun")

local rocketry = data.raw["technology"]["rocketry"]
rocketry.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "military-science-pack"  , 1 },
	{ "chemical-science-pack"  , 1 },
}

local rocket_silo = data.raw["technology"]["rocket-silo"]
table.insert(rocket_silo.effects, {
	hidden = true,
	modifier = 999,
	type = "cargo-landing-pad-count"
})

local electric_engine = data.raw["technology"]["electric-engine"]
electric_engine.prerequisites = { "engine", "lubricant" }
electric_engine.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "chemical-science-pack"  , 1 },
}

local battery_equipment = data.raw["technology"]["battery-equipment"]
battery_equipment.unit.count = 100
battery_equipment.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "chemical-science-pack"  , 1 },
}

local energy_shield_equipment = data.raw["technology"]["energy-shield-equipment"]
energy_shield_equipment.unit.count = 250
energy_shield_equipment.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "military-science-pack"  , 1 },
	{ "chemical-science-pack"  , 1 },
}

local discharge_defense_equipment = data.raw["technology"]["discharge-defense-equipment"]
discharge_defense_equipment.unit.count = 250
discharge_defense_equipment.unit.ingredients = {
	{ "material-science-pack"  , 1 },
	{ "logistic-science-pack"  , 1 },
	{ "automation-science-pack", 1 },
	{ "military-science-pack"  , 1 },
	{ "chemical-science-pack"  , 1 },
}

local worker_robot_speed_1 = data.raw["technology"]["worker-robots-speed-1"]
worker_robot_speed_1.unit.count = 200
local worker_robot_speed_2 = data.raw["technology"]["worker-robots-speed-2"]
worker_robot_speed_2.unit.count = 300
local worker_robot_speed_3 = data.raw["technology"]["worker-robots-speed-3"]
worker_robot_speed_3.unit.count = 450
local worker_robot_speed_4 = data.raw["technology"]["worker-robots-speed-4"]
worker_robot_speed_4.unit.count = 700
local worker_robot_speed_5 = data.raw["technology"]["worker-robots-speed-5"]
worker_robot_speed_5.unit.count = 1000
local worker_robot_speed_6 = data.raw["technology"]["worker-robots-speed-6"]
worker_robot_speed_6.unit.count = 1500
local worker_robot_speed_7 = data.raw["technology"]["worker-robots-speed-7"]
worker_robot_speed_7.unit.count_formula = "2^(L-6)*1500"



-- metallurgic science start

local artillery = data.raw["technology"]["artillery"]
artillery.prerequisites = { "explosives", "metallurgic-science-pack", "radar" }



-- fix some techs

local discharge_defense = data.raw["technology"]["discharge-defense-equipment"]
replace_prerequisite(discharge_defense, "laser-turret", "battery")

local distractor = data.raw["technology"]["distractor"]
replace_prerequisite(distractor, "laser", "battery")



-- make all technologies twice as expensive

for _,tech in pairs(data.raw.technology) do
	local unit = tech.unit
	if unit and unit.count then
		unit.count = unit.count * 2
	end
end



-- remove some techs

data.raw["technology"]["electric-energy-distribution-2"].hidden = true
data.raw["technology"]["effect-transmission"].hidden = true

data.raw["technology"]["physical-projectile-damage-1"].hidden = true
data.raw["technology"]["physical-projectile-damage-2"].hidden = true
data.raw["technology"]["physical-projectile-damage-3"].hidden = true
data.raw["technology"]["physical-projectile-damage-4"].hidden = true
data.raw["technology"]["physical-projectile-damage-5"].hidden = true
data.raw["technology"]["physical-projectile-damage-6"].hidden = true
data.raw["technology"]["physical-projectile-damage-7"].hidden = true

data.raw["technology"]["refined-flammables-1"].hidden = true
data.raw["technology"]["refined-flammables-2"].hidden = true
data.raw["technology"]["refined-flammables-3"].hidden = true
data.raw["technology"]["refined-flammables-4"].hidden = true
data.raw["technology"]["refined-flammables-5"].hidden = true
data.raw["technology"]["refined-flammables-6"].hidden = true
data.raw["technology"]["refined-flammables-7"].hidden = true

data.raw["technology"]["weapon-shooting-speed-1"].hidden = true
data.raw["technology"]["weapon-shooting-speed-2"].hidden = true
data.raw["technology"]["weapon-shooting-speed-3"].hidden = true
data.raw["technology"]["weapon-shooting-speed-4"].hidden = true
data.raw["technology"]["weapon-shooting-speed-5"].hidden = true
data.raw["technology"]["weapon-shooting-speed-6"].hidden = true

data.raw["technology"]["electric-weapons-damage-1"].hidden = true
data.raw["technology"]["electric-weapons-damage-2"].hidden = true
data.raw["technology"]["electric-weapons-damage-3"].hidden = true
data.raw["technology"]["electric-weapons-damage-4"].hidden = true

data.raw["technology"]["braking-force-1"].hidden = true
data.raw["technology"]["braking-force-2"].hidden = true
data.raw["technology"]["braking-force-3"].hidden = true
data.raw["technology"]["braking-force-4"].hidden = true
data.raw["technology"]["braking-force-5"].hidden = true
data.raw["technology"]["braking-force-6"].hidden = true
data.raw["technology"]["braking-force-7"].hidden = true

--data.raw["technology"]["research-speed-1"].hidden = true
--data.raw["technology"]["research-speed-2"].hidden = true
--data.raw["technology"]["research-speed-3"].hidden = true
--data.raw["technology"]["research-speed-4"].hidden = true
--data.raw["technology"]["research-speed-5"].hidden = true
--data.raw["technology"]["research-speed-6"].hidden = true

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
