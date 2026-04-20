local utils = require("utils")



-- foundry tech
local foundry_tech = data.raw["technology"]["foundry"]
remove_effect(foundry_tech, function(effect) return effect.recipe == "molten-iron-from-lava" end, "recipe \"molten-iron-from-lava\"")
remove_effect(foundry_tech, function(effect) return effect.recipe == "molten-copper-from-lava" end, "recipe \"molten-copper-from-lava\"")
remove_effect(foundry_tech, function(effect) return effect.recipe == "molten-iron" end, "recipe \"molten-iron\"")
remove_effect(foundry_tech, function(effect) return effect.recipe == "molten-copper" end, "recipe \"molten-copper\"")



-- replace all molten metal in recipes with 0.1x plate

for _,recipe in pairs(data.raw["recipe"]) do
	if recipe.ingredients then
		for _,ingredient in ipairs(recipe.ingredients) do
			if ingredient.name then
				if ingredient.name == "molten-iron" then
					ingredient.name = "iron-plate"
					ingredient.amount = math.ceil(ingredient.amount / 10.0)
					ingredient.type = "item"
				end
				if ingredient.name == "molten-copper" then
					ingredient.name = "copper-plate"
					ingredient.amount = math.ceil(ingredient.amount / 10.0)
					ingredient.type = "item"
				end
			else
				if ingredient[1] == "molten-iron" then
					ingredient[1] = "iron-plate"
					ingredient[2] = math.ceil(ingredient[2] / 10.0)
				end
				if ingredient[1] == "molten-copper" then
					ingredient[1] = "copper-plate"
					ingredient[2] = math.ceil(ingredient[2] / 10.0)
				end
			end
		end
	end
end

-- remove all molten metals
data.raw["fluid"]["molten-iron"].hidden = true
data.raw["fluid"]["molten-copper"].hidden = true



-- casting iron recipe
local casting_iron_recipe = data.raw["recipe"]["casting-iron"]
casting_iron_recipe.ingredients = {
	{ amount = 10, name = "iron-ore", type = "item" },
	{ amount = 1 , name = "calcite" , type = "item" },
}
casting_iron_recipe.results = {
	{ amount = 10, name = "iron-plate", type = "item" },
}
casting_iron_recipe.energy_required = 32.0

-- casting copper recipe
local casting_copper_recipe = data.raw["recipe"]["casting-copper"]
casting_copper_recipe.ingredients = {
	{ amount = 10, name = "copper-ore", type = "item" },
	{ amount = 1 , name = "calcite"   , type = "item" },
}
casting_copper_recipe.results = {
	{ amount = 10, name = "copper-plate", type = "item" },
}
casting_copper_recipe.energy_required = 32.0





-- foundries
local foundry = data.raw["assembling-machine"]["foundry"]
foundry.crafting_speed = 2
foundry.effect_receiver.base_effect.productivity = 0.25
foundry.energy_usage = "750kW"

-- biochamber
local biochamber = data.raw["assembling-machine"]["biochamber"]
biochamber.effect_receiver.base_effect.productivity = 0.25

-- electromagnetic plant
local electromagnetic_plant = data.raw["assembling-machine"]["electromagnetic-plant"]
electromagnetic_plant.crafting_speed = 1.5
electromagnetic_plant.effect_receiver.base_effect.productivity = 0.25
electromagnetic_plant.energy_usage = "750kW"

-- biolab
local biolab = data.raw["lab"]["biolab"]
biolab.researching_speed = 1.5
biolab.science_pack_drain_rate_percent = 75





-- inserters
--remove_effect(data.raw["technology"]["inserter-capacity-bonus-7"], function(effect) return effect.type == "inserter-stack-size-bonus" end)
local stack_inserter = data.raw["inserter"]["stack-inserter"]
stack_inserter.stack_size_bonus = 3
stack_inserter.max_belt_stack_size = 3
for _,effect in ipairs(data.raw["technology"]["stack-inserter"].effects) do
	if effect.type == "belt-stack-size-bonus" then
		effect.modifier = 2
	end
end
data.raw["technology"]["transport-belt-capacity-1"].hidden = true
data.raw["technology"]["transport-belt-capacity-2"].hidden = true





-- asteroid reprocessing
local carbonic_asteroid_reprocessing = data.raw["recipe"]["carbonic-asteroid-reprocessing"]
local metallic_asteroid_reprocessing = data.raw["recipe"]["metallic-asteroid-reprocessing"]
local oxide_asteroid_reprocessing    = data.raw["recipe"]["oxide-asteroid-reprocessing"]
for _,recipe in ipairs({carbonic_asteroid_reprocessing, metallic_asteroid_reprocessing, oxide_asteroid_reprocessing}) do
	for _,result in ipairs(recipe.results) do
		result.probability = result.probability * 0.625
	end
end





-- quality technology tweaks

local quality_module_2_tech = data.raw["technology"]["quality-module-2"]
table.insert(quality_module_2_tech.effects, {
	quality = "epic",
	type = "unlock-quality"
})
data.raw["technology"]["epic-quality"].hidden = true

local quality_module_3_tech = data.raw["technology"]["quality-module-3"]
table.insert(quality_module_3_tech.effects, {
	quality = "legendary",
	type = "unlock-quality"
})
data.raw["technology"]["legendary-quality"].hidden = true

-- quality module tweaks

local quality_module_1 = data.raw["module"]["quality-module"]
local quality_module_2 = data.raw["module"]["quality-module-2"]
local quality_module_3 = data.raw["module"]["quality-module-3"]
quality_module_1.effect.quality = 0.125
quality_module_2.effect.quality = 0.25
quality_module_3.effect.quality = 0.325

-- quality buff tweaks

data.raw["quality"]["uncommon"] .default_multiplier = 1.2
data.raw["quality"]["rare"]     .default_multiplier = 1.4
data.raw["quality"]["epic"]     .default_multiplier = 1.6
data.raw["quality"]["legendary"].default_multiplier = 2.0

data.raw["quality"]["uncommon"] .beacon_power_usage_multiplier = 0.9
data.raw["quality"]["rare"]     .beacon_power_usage_multiplier = 0.8
data.raw["quality"]["epic"]     .beacon_power_usage_multiplier = 0.7
data.raw["quality"]["legendary"].beacon_power_usage_multiplier = 0.6

data.raw["quality"]["uncommon"] .mining_drill_resource_drain_multiplier = 0.85
data.raw["quality"]["rare"]     .mining_drill_resource_drain_multiplier = 0.7
data.raw["quality"]["epic"]     .mining_drill_resource_drain_multiplier = 0.55
data.raw["quality"]["legendary"].mining_drill_resource_drain_multiplier = 0.4

local speed_module_3 = data.raw["module"]["speed-module-3"]
speed_module_3.effect.quality = -0.2

local beacon = data.raw["beacon"]["beacon"]
beacon.distribution_effectivity_bonus_per_quality_level = 0.1

local chain_tesla_gun_chain = data.raw["chain-active-trigger"]["chain-tesla-gun-chain"]
chain_tesla_gun_chain.fork_chance_increase_per_quality_level = 0.025

local chain_tesla_turret_chain = data.raw["chain-active-trigger"]["chain-tesla-turret-chain"]
chain_tesla_turret_chain.fork_chance_increase_per_quality_level = 0.025
