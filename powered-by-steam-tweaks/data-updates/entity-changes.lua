data.raw["character"]["character"].running_speed = 0.17

data.raw["mining-drill"]["burner-mining-drill"].mining_speed = 1.0 / 2.4 * 1.25

data.raw["construction-robot"]["construction-robot"].speed = 0.08

data.raw["inserter"]["inserter"].rotation_speed = 0.018

furnace_to_assembler("stone-furnace")
furnace_to_assembler("steel-furnace")
data.raw["furnace"]["electric-furnace"].enabled = false

local assembling_machine_1 = data.raw["assembling-machine"]["assembling-machine-1"]
table.insert(assembling_machine_1.crafting_categories, "crafting-with-fluid")
table.insert(assembling_machine_1.crafting_categories, "organic-or-assembling")
assembling_machine_1.fluid_boxes = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-2"].fluid_boxes)
assembling_machine_1.fluid_boxes_off_when_no_fluid_recipe = true

data.raw["cargo-wagon"]["cargo-wagon"].inventory_size = 60

local agricultural_tower = data.raw["agricultural-tower"]["agricultural-tower"]
local agricultural_tower_speed = agricultural_tower.crane.speed
agricultural_tower_speed.arm.turn_rate = agricultural_tower_speed.arm.turn_rate * 0.6
agricultural_tower_speed.arm.extension_speed = agricultural_tower_speed.arm.extension_speed * 0.75
agricultural_tower_speed.grappler.vertical_turn_rate = agricultural_tower_speed.grappler.vertical_turn_rate * 0.8
agricultural_tower_speed.grappler.horizontal_turn_rate = agricultural_tower_speed.grappler.horizontal_turn_rate * 0.8
agricultural_tower_speed.grappler.extension_speed = agricultural_tower_speed.grappler.extension_speed * 0.8

local one_second = 60
local one_minute = one_second * 60
local one_hour = one_minute * 60
data.raw["capsule"]["raw-fish"].spoil_ticks = 30 * one_minute

data.raw["lab"]["lab"].inputs = {
	"material-science-pack",
	"logistic-science-pack",
	"automation-science-pack",
	"military-science-pack",
	"chemical-science-pack",
	"production-science-pack",
	"utility-science-pack",
	"space-science-pack",
	"metallurgic-science-pack",
	"agricultural-science-pack",
	"electromagnetic-science-pack",
	"cryogenic-science-pack",
	"promethium-science-pack"
}
data.raw["lab"]["biolab"].inputs = {
	"material-science-pack",
	"logistic-science-pack",
	"automation-science-pack",
	"military-science-pack",
	"chemical-science-pack",
	"production-science-pack",
	"utility-science-pack",
	"space-science-pack",
	"metallurgic-science-pack",
	"agricultural-science-pack",
	"electromagnetic-science-pack",
	"cryogenic-science-pack",
	"promethium-science-pack"
}

for _,resource in pairs(data.raw["resource"]) do
	if resource.minable and resource.minable.mining_time then
		resource.minable.mining_time = resource.minable.mining_time * 1.25
	end
end
