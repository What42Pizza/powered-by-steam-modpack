local utils = require("utils")



-- oil refinery tweaks
local oil_refinery = data.raw["assembling-machine"]["oil-refinery"]
oil_refinery.crafting_speed = 1.75
local fluid_boxes = oil_refinery.fluid_boxes
fluid_boxes[1].pipe_connections[1].position = { -2, 2 }
fluid_boxes[2].pipe_connections[1].position = {  0, 2 }
data.raw["assembling-machine"]["oil-refinery"] = oil_refinery
local new_fluid_box = table.deepcopy(fluid_boxes[5])
new_fluid_box.pipe_connections[1].position = { 2, 2 }
new_fluid_box.pipe_connections[1].direction = defines.direction.south
table.insert(fluid_boxes, new_fluid_box)

-- chemical plant tweaks
local chemical_plant = data.raw["assembling-machine"]["chemical-plant"]
chemical_plant.crafting_speed = 1.5
local fluid_boxes = chemical_plant.fluid_boxes
local new_fluid_box = table.deepcopy(fluid_boxes[3])
new_fluid_box.pipe_connections[1].position = { 0, 1 }
table.insert(fluid_boxes, new_fluid_box)

-- heating tower tweaks
if mods["space-age"] then
	local heating_tower = data.raw["reactor"]["heating-tower"]
	heating_tower.energy_source.effectivity = 2.0
end



-- basic oil processing tweaks
local basic_oil_processing_recipe = data.raw["recipe"]["basic-oil-processing"]
basic_oil_processing_recipe.ingredients = {
	{
		amount = 25,
		name = "steam",
		type = "fluid"
	},
	{
		amount = 100,
		name = "crude-oil",
		type = "fluid"
	}
}
basic_oil_processing_recipe.results = {
	{
		amount = 45,
		name = "petroleum-gas",
		fluidbox_index = 3,
		type = "fluid"
	},
	{
		amount = 20,
		name = "volatile-gas",
		fluidbox_index = 4,
		type = "fluid"
	}
}
basic_oil_processing_recipe.icon = "__better-oil-processing__/graphics/icons/fluid/basic-oil-processing.png"

-- advanced oil processing tweaks
local advanced_oil_processing_recipe = data.raw["recipe"]["advanced-oil-processing"]
advanced_oil_processing_recipe.ingredients = {
	{
		amount = 25,
		name = "steam",
		type = "fluid"
	},
	{
		amount = 100,
		name = "crude-oil",
		type = "fluid"
	}
}
advanced_oil_processing_recipe.results = {
	{
		amount = 30,
		name = "hot-tar",
		type = "fluid"
	},
	{
		amount = 45,
		name = "kerosene",
		type = "fluid"
	},
	{
		amount = 55,
		name = "petroleum-gas",
		type = "fluid"
	},
	{
		amount = 30,
		name = "volatile-gas",
		type = "fluid"
	}
}
advanced_oil_processing_recipe.icon = "__better-oil-processing__/graphics/icons/fluid/advanced-oil-processing.png"

-- coal liquefaction recipe tweaks
local coal_liquefaction_recipe = data.raw["recipe"]["coal-liquefaction"]
coal_liquefaction_recipe.ingredients = {
	{
		amount = 8,
		name = "coal",
		type = "item"
	},
	{
		amount = 50,
		name = "steam",
		type = "fluid"
	},
	{
		amount = 100,
		name = "sulfuric-acid",
		type = "fluid"
	}
}
coal_liquefaction_recipe.results = {
	{
		amount = 40,
		name = "hot-tar",
		type = "fluid"
	},
	{
		amount = 50,
		name = "petroleum-gas",
		type = "fluid"
	},
	{
		amount = 75,
		name = "sulfuric-acid",
		type = "fluid"
	}
}
coal_liquefaction_recipe.icon = "__better-oil-processing__/graphics/icons/fluid/coal-liquefaction.png"

-- oil processing tech tweaks
local oil_processing_tech = data.raw["technology"]["oil-processing"]
table.insert(oil_processing_tech.effects, {
	recipe = "coal-coking",
	type = "unlock-recipe"
})
table.insert(oil_processing_tech.effects, {
	recipe = "volatile-gas-solidification",
	type = "unlock-recipe"
})

-- advanced oil processing tech tweaks
local advanced_oil_processing_tech = data.raw["technology"]["advanced-oil-processing"]
advanced_oil_processing_tech.effects = {
	{
		recipe = "advanced-oil-processing",
		type = "unlock-recipe"
	},
	{
		recipe = "hot-tar-cracking",
		type = "unlock-recipe"
	},
	{
		recipe = "kerosene-cracking",
		type = "unlock-recipe"
	},
	{
		recipe = "petroleum-gas-cracking",
		type = "unlock-recipe"
	},
	{
		recipe = "solid-fuel-from-kerosene",
		type = "unlock-recipe"
	}
}



-- lubricant tech tweaks
local lubricant_tech = data.raw["technology"]["lubricant"]
lubricant_tech.effects = {
	{
		recipe = "hot-tar-refining",
		type = "unlock-recipe"
	},
	{
		recipe = "lubricant-from-kerosene",
		type = "unlock-recipe"
	}
}

-- rocket fuel recipe tweaks
local rocket_fuel_recipe = data.raw["recipe"]["rocket-fuel"]
replace_ingredient(rocket_fuel_recipe, "light-oil", {
	amount = 10,
	name = "kerosene",
	type = "fluid"
})

-- acid neutralisation recipe tweaks
if mods["space-age"] then
	local acid_neutralisation_recipe = data.raw["recipe"]["acid-neutralisation"]
	replace_result(acid_neutralisation_recipe, "steam", {
		amount = 3000,
		name = "steam",
		temperature = 500,
		type = "fluid"
	})
end



-- sulfur recipe removal
local sulfur_recipe = data.raw["recipe"]["sulfur"]
sulfur_recipe.enabled = false
sulfur_recipe.hidden = true

-- sulfuric acid tweaks
local sulfuric_acid_recipe = data.raw["recipe"]["sulfuric-acid"]
sulfuric_acid_recipe.ingredients = {
	{
		amount = 4,
		name = "sulfur",
		type = "item"
	},
	{
		amount = 20,
		name = "steam",
		type = "fluid"
	}
}
sulfuric_acid_recipe.results = {
	{
		amount = 75,
		name = "sulfuric-acid",
		type = "fluid"
	},
	{
		amount = 2,
		name = "stone",
		type = "item"
	}
}
sulfuric_acid_recipe.icon = "__base__/graphics/icons/fluid/sulfuric-acid.png" -- this is needed because there's no longer a single result

-- sulfur tech tweaks
local sulfur_tech = data.raw["technology"]["sulfur-processing"]
sulfur_tech.effects = {
	{
		recipe = "sulfuric-acid",
		type = "unlock-recipe"
	}
}
sulfur_tech.icon = "__base__/graphics/icons/fluid/sulfuric-acid.png"
sulfur_tech.icon_size = 64



-- add sulfur resources wherever needed

local planet = data.raw["planet"]

planet.nauvis.map_gen_settings.autoplace_controls["sulfur"] = {}
planet.nauvis.map_gen_settings.autoplace_settings.entity.settings["sulfur"] = {}
if mods["space-age"] then
	planet.vulcanus.map_gen_settings.autoplace_controls["vulcanus_sulfur"] = {}
	planet.vulcanus.map_gen_settings.autoplace_settings.entity.settings["sulfur"] = {}
end



-- chemical science recipe tweaks
local chemical_science_pack_recipe = data.raw["recipe"]["chemical-science-pack"]
chemical_science_pack_recipe.category = "crafting-with-fluid"
replace_ingredient(chemical_science_pack_recipe, "sulfur", {
	amount = 300,
	name = "sulfuric-acid",
	type = "fluid"
})

-- tungsten plate recipe tweaks
if mods["space-age"] then
	local tungsten_plate_recipe = data.raw["recipe"]["tungsten-plate"]
	table.insert(tungsten_plate_recipe.ingredients, {
		amount = 1,
		name = "coke",
		type = "item"
	})
end

-- explosives tech tweaks
local explosives_tech = data.raw["technology"]["explosives"]
explosives_tech.prerequisites = { "military-2" }



-- flamethrower tweaks
local flamethrower = data.raw["fluid-turret"]["flamethrower-turret"]
flamethrower.attack_parameters.fluids = {
	{
		type = "crude-oil",
		damage_modifier = 0.75
	},
	{
		type = "kerosene",
		damage_modifier = 1.0
	}
}



-- disable old fluids
data.raw["fluid"]["heavy-oil"].hidden = true
data.raw["fluid"]["light-oil"].hidden = true
