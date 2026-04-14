local electricity_tech = table.deepcopy(data.raw["technology"]["steam-power"])
electricity_tech.name = "electricity"
electricity_tech.icon = "__base__/graphics/icons/steam-engine.png"
electricity_tech.icon_size = 64
electricity_tech.research_trigger = nil
electricity_tech.effects = {
	{
		recipe = "steam-engine",
		type = "unlock-recipe"
	},
	{
		recipe = "copper-cable",
		type = "unlock-recipe"
	},
	{
		recipe = "small-electric-pole",
		type = "unlock-recipe"
	}
}
electricity_tech.unit = {
	count = 25,
	ingredients = {
		{ "automation-science-pack", 1 }
	},
	time = 10
}
electricity_tech.prerequisites = {
	"steam-power",
	"automation-science-pack"
}
data:extend{electricity_tech}
