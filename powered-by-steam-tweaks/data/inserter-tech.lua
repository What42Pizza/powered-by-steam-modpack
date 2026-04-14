local inserter_tech = table.deepcopy(data.raw["technology"]["automation"])
inserter_tech.name = "inserter"
inserter_tech.icon = "__base__/graphics/icons/inserter.png"
inserter_tech.icon_size = 64
inserter_tech.effects = {
	{
		recipe = "inserter",
		type = "unlock-recipe"
	}
}
inserter_tech.unit = {
	count = 20,
	ingredients = {
		{ "automation-science-pack", 1 }
	},
	time = 15
}
inserter_tech.prerequisites = {
	"automation",
	"electricity"
}
data:extend{inserter_tech}
