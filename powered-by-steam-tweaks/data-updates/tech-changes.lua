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



local automation = data.raw["technology"]["automation"]
remove_effect(automation, function(effect) return effect.recipe == "long-handed-inserter" end, "recipe \"long-handed-inserter\"")

local fast_inserter = data.raw["technology"]["fast-inserter"]
fast_inserter.unit.ingredients = {
	{ "automation-science-pack", 1 },
	{ "logistic-science-pack", 1 },
	{ "chemical-science-pack", 1 }
}
fast_inserter.prerequisites = {
	"inserter"
}



data.raw["technology"]["physical-projectile-damage-1"].enabled = false
data.raw["technology"]["physical-projectile-damage-1"].hidden = true
data.raw["technology"]["physical-projectile-damage-2"].enabled = false
data.raw["technology"]["physical-projectile-damage-2"].hidden = true
data.raw["technology"]["physical-projectile-damage-3"].enabled = false
data.raw["technology"]["physical-projectile-damage-3"].hidden = true
data.raw["technology"]["physical-projectile-damage-4"].enabled = false
data.raw["technology"]["physical-projectile-damage-4"].hidden = true
data.raw["technology"]["physical-projectile-damage-5"].enabled = false
data.raw["technology"]["physical-projectile-damage-5"].hidden = true
data.raw["technology"]["physical-projectile-damage-6"].enabled = false
data.raw["technology"]["physical-projectile-damage-6"].hidden = true
data.raw["technology"]["physical-projectile-damage-7"].enabled = false
data.raw["technology"]["physical-projectile-damage-7"].hidden = true

data.raw["technology"]["weapon-shooting-speed-1"].enabled = false
data.raw["technology"]["weapon-shooting-speed-1"].hidden = true
data.raw["technology"]["weapon-shooting-speed-2"].enabled = false
data.raw["technology"]["weapon-shooting-speed-2"].hidden = true
data.raw["technology"]["weapon-shooting-speed-3"].enabled = false
data.raw["technology"]["weapon-shooting-speed-3"].hidden = true
data.raw["technology"]["weapon-shooting-speed-4"].enabled = false
data.raw["technology"]["weapon-shooting-speed-4"].hidden = true
data.raw["technology"]["weapon-shooting-speed-5"].enabled = false
data.raw["technology"]["weapon-shooting-speed-5"].hidden = true
data.raw["technology"]["weapon-shooting-speed-6"].enabled = false
data.raw["technology"]["weapon-shooting-speed-6"].hidden = true
