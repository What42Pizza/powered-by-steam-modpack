local long_handed_inserter_tech = table.deepcopy(data.raw["technology"]["automation"])
long_handed_inserter_tech.name = "long-handed-inserter"
long_handed_inserter_tech.icon = "__base__/graphics/icons/long-handed-inserter.png"
long_handed_inserter_tech.icon_size = 64
long_handed_inserter_tech.effects = {
	{
		recipe = "long-handed-inserter",
		type = "unlock-recipe"
	}
}
long_handed_inserter_tech.unit = {
	count = 50,
	ingredients = {
		{ "automation-science-pack", 1 }
	},
	time = 15
}
long_handed_inserter_tech.prerequisites = {
	"electricity"
}
data:extend{long_handed_inserter_tech}
