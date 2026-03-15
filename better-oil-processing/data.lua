local resource_autoplace = require('resource-autoplace')
local utils = require("utils")



-- coke
local coke = table.deepcopy(data.raw["item"]["solid-fuel"])
coke.name = "coke"
coke.order = "b[chemistry]-ba[coke]"
coke.icon = "__better-oil-processing__/graphics/icons/coke.png"
coke.fuel_value = "8MJ"
coke.fuel_acceleration_multiplier = 1.0
data:extend{coke}

-- asphalt (item)
local asphalt = table.deepcopy(data.raw["item"]["concrete"])
asphalt.name = "asphalt"
asphalt.order = "b[asphalt]-a[plain]"
asphalt.icon = "__better-oil-processing__/graphics/icons/asphalt.png"
asphalt.place_as_tile.result = "asphalt"
data:extend{asphalt}

-- asphalt (recipe)
local asphalt_recipe = table.deepcopy(data.raw["recipe"]["concrete"])
asphalt_recipe.name = "asphalt"
asphalt_recipe.energy_required = 8.0
asphalt_recipe.ingredients = {
	{
		amount = 25,
		name = "stone",
		type = "item"
	},
	{
		amount = 200,
		name = "hot-tar",
		type = "fluid"
	}
}
asphalt_recipe.results = {
	{
		amount = 10,
		name = "asphalt",
		type = "item"
	}
}
data:extend{asphalt_recipe}

-- asphalt (technology)
local asphalt_tech = table.deepcopy(data.raw["technology"]["concrete"])
asphalt_tech.name = "asphalt"
asphalt_tech.icon = "__better-oil-processing__/graphics/technology/asphalt.png"
asphalt_tech.effects = {
	{
		recipe = "asphalt",
		type = "unlock-recipe"
	}
}
asphalt_tech.prerequisites = {
	"advanced-oil-processing",
}
asphalt_tech.unit = {
	count = 500,
	ingredients = {
		{ "automation-science-pack", 1 },
		{ "logistic-science-pack", 1 },
		{ "chemical-science-pack", 1 }
	},
	time = 30
}
data:extend{asphalt_tech}

-- asphalt (tile)
local asphalt_tile = table.deepcopy(data.raw["tile"]["concrete"])
asphalt_tile.name = "asphalt"
if mods["space-age"] then
	asphalt_tile.frozen_variant = "frozen-asphalt"
end
asphalt_tile.minable.result = "asphalt"
asphalt_tile.order = "a[artificial]-b[tier-2]-a[asphalt]"
asphalt_tile.decorative_removal_probability = 0.7
asphalt_tile.walking_speed_modifier = 1.5
asphalt_tile.vehicle_friction_modifier = 0.7
asphalt_tile.variants.material_background.picture = "__better-oil-processing__/graphics/terrain/asphalt/asphalt.png"
data:extend{asphalt_tile}

-- asphalt (tile, frozen)
if mods["space-age"] then
	local frozen_asphalt_tile = table.deepcopy(data.raw["tile"]["frozen-concrete"])
	frozen_asphalt_tile.name = "frozen-asphalt"
	frozen_asphalt_tile.thawed_variant = "asphalt"
	frozen_asphalt_tile.minable.result = "asphalt"
	frozen_asphalt_tile.order = "a[artificial]-b[tier-2]-a[frozen-asphalt]"
	data:extend{frozen_asphalt_tile}
end



-- sulfur (autoplace-control)
local sulfur_autoplace_control = table.deepcopy(data.raw["autoplace-control"]["coal"])
sulfur_autoplace_control.name = "sulfur"
sulfur_autoplace_control.order = "a-e"
sulfur_autoplace_control.localised_name = {
	"",
	"[entity=sulfur] ",
	{
		"entity-name.sulfur"
	}
}
data:extend{sulfur_autoplace_control}

-- vulcanus sulfur (autoplace-control)
if mods["space-age"] then
	local vulcanus_sulfur_autoplace_control = table.deepcopy(data.raw["autoplace-control"]["vulcanus_coal"])
	vulcanus_sulfur_autoplace_control.name = "vulcanus_sulfur"
	vulcanus_sulfur_autoplace_control.order = "b-b"
	vulcanus_sulfur_autoplace_control.localised_name = {
		"",
		"[entity=sulfur] ",
		{
			"entity-name.sulfur"
		}
	}
	data:extend{vulcanus_sulfur_autoplace_control}
end

-- sulfur (resource)
local sulfur_resource = table.deepcopy(data.raw["resource"]["coal"])
sulfur_resource.name = "sulfur"
sulfur_resource.autoplace = resource_autoplace.resource_autoplace_settings{
	name = "sulfur",
	order = "b-z",
	base_density = 2.5,
	base_spots_per_km2 = 2.0,
	has_starting_area_placement = false,
	regular_rq_factor_multiplier = 1.2,
	starting_rq_factor_multiplier = 1.7,
	additional_richness = 500
}
sulfur_resource.factoriopedia_simulation.init = string.gsub(sulfur_resource.factoriopedia_simulation.init, "coal", "sulfur")
sulfur_resource.icon = "__base__/graphics/icons/sulfur.png"
sulfur_resource.map_color = { 0.8, 0.8, 0.0 }
sulfur_resource.minable = {
	mining_particle = "sulfur-particle",
	mining_time = 1,
	result = "sulfur"
}
sulfur_resource.stages.sheet.filename = "__better-oil-processing__/graphics/entity/sulfur/sulfur.png"
data:extend{sulfur_resource}

-- sulfur particle
local sulfur_particle = table.deepcopy(data.raw["optimized-particle"]["coal-particle"])
sulfur_particle.name = "sulfur-particle"
for i = 1,4 do
	sulfur_particle.pictures[i].filename = "__better-oil-processing__/graphics/particle/sulfur-particle/sulfur-particle-" .. i .. ".png"
	sulfur_particle.shadows[i].filename = "__better-oil-processing__/graphics/particle/sulfur-particle/sulfur-particle-shadow-" .. i .. ".png"
end
data:extend{sulfur_particle}



-- hot tar
local hot_tar = table.deepcopy(data.raw["fluid"]["heavy-oil"])
hot_tar.name = "hot-tar"
hot_tar.order = "a[fluid]-b[oil]-d[hot-tar]"
hot_tar.icon = "__better-oil-processing__/graphics/icons/fluid/hot-tar.png"
hot_tar.base_color = { 0.173, 0.106, 0.090 } -- stat bars & pipe windows
hot_tar.flow_color = { 0.173, 0.106, 0.090 } -- slightly in pipe windows
hot_tar.visualization_color = { 0.173, 0.106, 0.090 } -- pipe visualizations
data:extend{hot_tar}

-- kerosene
local kerosene = table.deepcopy(data.raw["fluid"]["light-oil"])
kerosene.name = "kerosene"
kerosene.order = "a[fluid]-b[oil]-d[kerosene]"
kerosene.icon = "__better-oil-processing__/graphics/icons/fluid/kerosene.png"
kerosene.base_color = { 0.598, 0.175, 0.051 }
kerosene.flow_color = { 0.865, 0.632, 0.313 }
data:extend{kerosene}

-- volatile gas
local volatile_gas = table.deepcopy(data.raw["fluid"]["petroleum-gas"])
volatile_gas.name = "volatile-gas"
volatile_gas.order = "a[fluid]-b[oil]-d[volatile-gas]"
volatile_gas.icon = "__better-oil-processing__/graphics/icons/fluid/volatile_gas.png"
volatile_gas.base_color = { 0.906, 0.878, 0.592 }
volatile_gas.flow_color = { 0.906, 0.878, 0.592 }
data:extend{volatile_gas}



-- hot tar refining
local hot_tar_refining = table.deepcopy(data.raw["recipe"]["heavy-oil-cracking"])
hot_tar_refining.name = "hot-tar-refining"
hot_tar_refining.order = "b[fluid-chemistry]-a[hot-tar-refining]"
hot_tar_refining.energy_required = 1.25
hot_tar_refining.ingredients = {
	{
		amount = 100,
		name = "sulfuric-acid",
		type = "fluid"
	},
	{
		amount = 40,
		name = "hot-tar",
		type = "fluid"
	}
}
hot_tar_refining.results = {
	{
		amount = 35,
		name = "lubricant",
		type = "fluid"
	},
	{
		amount = 75,
		name = "sulfuric-acid",
		type = "fluid"
	},
	{
		amount = 10,
		name = "volatile-gas",
		type = "fluid"
	},
	{
		amount = 1,
		name = "coke",
		type = "item"
	}
}
hot_tar_refining.icon = "__better-oil-processing__/graphics/icons/fluid/hot-tar-refining.png"
data:extend{hot_tar_refining}

-- lubricant from kerosene
local lubricant_from_kerosene = table.deepcopy(data.raw["recipe"]["lubricant"])
lubricant_from_kerosene.name = "lubricant-from-kerosene"
replace_ingredient(lubricant_from_kerosene, "heavy-oil", {
	amount = 30,
	name = "kerosene",
	type = "fluid"
})
lubricant_from_kerosene.icon = "__better-oil-processing__/graphics/icons/fluid/lubricant-from-kerosene.png"
data:extend{lubricant_from_kerosene}

-- hot tar cracking
local hot_tar_cracking = table.deepcopy(data.raw["recipe"]["heavy-oil-cracking"])
hot_tar_cracking.name = "hot-tar-cracking"
hot_tar_cracking.order = "b[fluid-chemistry]-ba[hot-tar-cracking]"
hot_tar_cracking.energy_required = 0.75
hot_tar_cracking.ingredients = {
	{
		amount = 100,
		name = "sulfuric-acid",
		type = "fluid"
	},
	{
		amount = 40,
		name = "hot-tar",
		type = "fluid"
	}
}
hot_tar_cracking.results = {
	{
		amount = 30,
		name = "kerosene",
		type = "fluid"
	},
	{
		amount = 75,
		name = "sulfuric-acid",
		type = "fluid"
	},
	{
		amount = 10,
		name = "volatile-gas",
		type = "fluid"
	},
	{
		amount = 1,
		name = "coke",
		type = "item"
	}
}
hot_tar_cracking.icon = "__better-oil-processing__/graphics/icons/fluid/hot-tar-cracking.png"
data:extend{hot_tar_cracking}

-- kerosene cracking
local kerosene_cracking = table.deepcopy(data.raw["recipe"]["heavy-oil-cracking"])
kerosene_cracking.name = "kerosene-cracking"
kerosene_cracking.order = "b[fluid-chemistry]-bb[kerosene-cracking]"
kerosene_cracking.energy_required = 0.75
kerosene_cracking.ingredients = {
	{
		amount = 100,
		name = "sulfuric-acid",
		type = "fluid"
	},
	{
		amount = 50,
		name = "kerosene",
		type = "fluid"
	}
}
kerosene_cracking.results = {
	{
		amount = 40,
		name = "petroleum-gas",
		type = "fluid"
	},
	{
		amount = 75,
		name = "sulfuric-acid",
		type = "fluid"
	},
	{
		amount = 10,
		name = "volatile-gas",
		type = "fluid"
	}
}
kerosene_cracking.icon = "__better-oil-processing__/graphics/icons/fluid/kerosene-cracking.png"
data:extend{kerosene_cracking}

-- petroleum gas cracking
local petroleum_gas_cracking = table.deepcopy(data.raw["recipe"]["heavy-oil-cracking"])
petroleum_gas_cracking.name = "petroleum-gas-cracking"
petroleum_gas_cracking.order = "b[fluid-chemistry]-bc[petroleum-gas-cracking]"
petroleum_gas_cracking.energy_required = 0.75
petroleum_gas_cracking.ingredients = {
	{
		amount = 100,
		name = "sulfuric-acid",
		type = "fluid"
	},
	{
		amount = 60,
		name = "petroleum-gas",
		type = "fluid"
	}
}
petroleum_gas_cracking.results = {
	{
		amount = 30,
		name = "volatile-gas",
		type = "fluid"
	},
	{
		amount = 75,
		name = "sulfuric-acid",
		type = "fluid"
	}
}
petroleum_gas_cracking.icon = "__better-oil-processing__/graphics/icons/fluid/petroleum-gas-cracking.png"
data:extend{petroleum_gas_cracking}



-- kerosene to solid fuel
local solid_fuel_from_kerosene = table.deepcopy(data.raw["recipe"]["solid-fuel-from-heavy-oil"])
solid_fuel_from_kerosene.name = "solid-fuel-from-kerosene"
solid_fuel_from_kerosene.ingredients = {
	{
		amount = 30,
		name = "kerosene",
		type = "fluid"
	}
}
solid_fuel_from_kerosene.order = "b[fluid-chemistry]-e[solid-fuel-from-kerosene]"
data:extend{solid_fuel_from_kerosene}

-- volatile gas solidification
local volatile_gas_solidification = table.deepcopy(data.raw["recipe"]["solid-fuel-from-petroleum-gas"])
volatile_gas_solidification.name = "volatile-gas-solidification"
volatile_gas_solidification.ingredients = {
	{
		amount = 50,
		name = "volatile-gas",
		type = "fluid"
	}
}
volatile_gas_solidification.results = {
	{
		amount = 1,
		name = "coke",
		type = "item"
	}
}
volatile_gas_solidification.crafting_machine_tint = {
	primary    = { r = 1.000, g = 0.908, b = 0.400, a = 1 },
	quaternary = { r = 0.969, g = 0.950, b = 0.419, a = 1 },
	secondary  = { r = 1.000, g = 0.802, b = 0.572, a = 1 },
	tertiary   = { r = 0.876, g = 0.819, b = 0.797, a = 1 }
}
volatile_gas_solidification.order = "b[fluid-chemistry]-e[volatile-gas-solidification]"
volatile_gas_solidification.icon = "__better-oil-processing__/graphics/icons/fluid/volatile-gas-solidification.png"
data:extend{volatile_gas_solidification}



-- coal coking
local coal_coking = table.deepcopy(data.raw["recipe"]["solid-fuel-from-petroleum-gas"])
coal_coking.name = "coal-coking"
coal_coking.icon = "__better-oil-processing__/graphics/icons/coke.png"
coal_coking.order = "c[oil-products]-b[coal-coking]"
coal_coking.energy_required = 4.0
coal_coking.ingredients = {
	{
		amount = 3,
		name = "coal",
		type = "item"
	}
}
coal_coking.results = {
	{
		amount = 1,
		name = "coke",
		type = "item"
	},
	{
		amount = 5,
		name = "volatile-gas",
		type = "fluid"
	}
}
coal_coking.crafting_machine_tint = {
	primary    = { r = 1.000, g = 0.908, b = 0.400, a = 1 },
	quaternary = { r = 0.969, g = 0.950, b = 0.419, a = 1 },
	secondary  = { r = 1.000, g = 0.802, b = 0.572, a = 1 },
	tertiary   = { r = 0.876, g = 0.819, b = 0.797, a = 1 }
}
coal_coking.icon = "__better-oil-processing__/graphics/icons/fluid/coal-coking.png"
data:extend{coal_coking}
