data.raw["character"]["character"].inventory_size = 40 -- originally 80

for _,armor in pairs(data.raw["armor"]) do
	armor.inventory_size_bonus = nil
end

local toolbelt_tech = data.raw["technology"]["toolbelt"]
toolbelt_tech.prerequisites = { "material-science-pack" }
toolbelt_tech.unit.count = 10
toolbelt_tech.unit.ingredients = {
	{ "material-science-pack", 1 }
}

local toolbelt_equipment_tech = data.raw["technology"]["toolbelt-equipment"]
toolbelt_equipment_tech.prerequisites = { "toolbelt-6" }
