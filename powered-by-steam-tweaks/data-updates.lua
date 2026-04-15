require("utils")
require("from-krastorio-2")



for _,tech in pairs(data.raw.technology) do
	local unit = tech.unit
	if unit and unit.ingredients and #unit.ingredients > 0 then
		if unit.ingredients[1][1] == "automation-science-pack" then unit.ingredients[1][1] = "material-science-pack" end
		if #unit.ingredients > 2 then table.insert(unit.ingredients, 3, { "automation-science-pack", 1 }) end
	end
end



require("data-updates.recipe-changes")
require("data-updates.tech-changes")
require("data-updates.add-steam-power")



for _,tree in pairs(data.raw["tree"]) do
	if tree.emissions_per_second and tree.emissions_per_second.pollution then
		tree.emissions_per_second.pollution = tree.emissions_per_second.pollution * 0.5
	end
end

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



for _,tech in pairs(data.raw.technology) do
	local unit = tech.unit
	if unit and unit.count then
		unit.count = unit.count * 2
	end
end
