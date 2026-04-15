require("utils")
require("from-krastorio-2")

require("data-updates.recipe-changes")
require("data-updates.tech-changes")
require("data-updates.add-steam-power")



data.raw["mining-drill"]["burner-mining-drill"].mining_speed = 1.0 / 2.4

data.raw["construction-robot"]["construction-robot"].speed = 0.08

data.raw["inserter"]["inserter"].rotation_speed = 0.018

furnace_to_assembler("stone-furnace")
furnace_to_assembler("steel-furnace")
data.raw["furnace"]["electric-furnace"].enabled = false

local assembling_machine_1 = data.raw["assembling-machine"]["assembling-machine-1"]
table.insert(assembling_machine_1.crafting_categories, "crafting-with-fluid")
assembling_machine_1.fluid_boxes = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-2"].fluid_boxes)
assembling_machine_1.fluid_boxes_off_when_no_fluid_recipe = true

data.raw["cargo-wagon"]["cargo-wagon"].inventory_size = 60

local one_second = 60
local one_minute = one_second * 60
local one_hour = one_minute * 60
data.raw["capsule"]["raw-fish"].spoil_ticks = one_hour



for _,tech in pairs(data.raw.technology) do
	local unit = tech.unit
	if unit and unit.count then
		unit.count = unit.count * 2
	end
end
