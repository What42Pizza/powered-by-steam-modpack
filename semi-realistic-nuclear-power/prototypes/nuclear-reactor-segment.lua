local nuclear_reactor = data.raw["reactor"]["nuclear-reactor"]

local nuclear_reactor_segment = {
	name = "nuclear-reactor-segment",
	type = "reactor",
	icon = "__semi-realistic-nuclear-power__/graphics/entity/nuclear-reactor-segment.png",
	consumption = "40MW",
	energy_source = {
		type = "burner",
		fuel_inventory_size = 1,
		burnt_inventory_size = 1,
		fuel_categories = { "nuclear" },
		effectivity = FUEL_CONSUME_EFFICIENCY,
		light_flicker = {
			color = { 0, 0, 0 },
			maximum_intensity = 0.95,
			minimum_intensity = 0.7,
		},
	},
	heat_buffer = {
		max_temperature = MAX_REACTOR_TEMP,
		specific_heat = "10MJ",
		max_transfer = "10GW",
	},
	flags = { "placeable-neutral", "player-creation" },
	collision_box = {
		{ -0.9, -0.9 },
		{  0.9,  0.9 },
	},
	selection_box = {
		{ -1.1, -1.1 },
		{  1.1,  1.1 },
	},
	minable = { mining_time = 2.0, result = "nuclear-reactor-segment" },
	impact_category = "metal-large",
	max_health = 500,
	neighbour_bonus = 0,
	meltdown_action = table.deepcopy(nuclear_reactor.meltdown_action),
	open_sound = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"].open_sound),
	close_sound = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"].close_sound),
	circuit_connector = table.deepcopy(nuclear_reactor.circuit_connector),
	circuit_wire_max_distance = 9,
	default_temperature_signal = table.deepcopy(nuclear_reactor.default_temperature_signal),
	dying_explosion = "nuclear-reactor-explosion",
	picture = {
		layers = {
			{
				filename = "__semi-realistic-nuclear-power__/graphics/entity/nuclear-reactor-segment.png",
				width = 138,
				height = 138,
				scale = 0.5,
				shift = { 0.0, 0.0 },
			},
			{
				draw_as_shadow = true,
				filename = "__semi-realistic-nuclear-power__/graphics/entity/nuclear-reactor-segment-shadow.png",
				width = 173,
				height = 147,
				scale = 0.5,
				shift = { 0.22, 0.077 },
			}
		}
	},
}



local nuclear_reactor_segment_item = table.deepcopy(data.raw["item"]["nuclear-reactor"])
nuclear_reactor_segment_item.name = "nuclear-reactor-segment"
nuclear_reactor_segment_item.place_result = "nuclear-reactor-segment"



local nuclear_reactor_segment_recipe = {
	name = "nuclear-reactor-segment",
	type = "recipe",
	ingredients = {
		{ amount = 1000, name = "concrete"      , type = "item" },
		{ amount = 250 , name = "steel-plate"   , type = "item" },
		{ amount = 500 , name = "copper-plate"  , type = "item" },
		{ amount = 4   , name = "pipe-to-ground", type = "item" },
	},
	results = {
		{ amount = 1, name = "nuclear-reactor-segment", type = "item" },
	},
	energy_required = 5,
	enabled = false,
}



local nuclear_reactor_segment_pumping_sounds = {
	name = "nuclear-reactor-segment-pumping-sounds",
	type = "beacon",
	working_sound = {
		max_sounds_per_prototype = 5,
		sound = {
			filename = "__base__/sound/boiler.ogg",
			volume = 1.5,
			audible_distance_modifier = 0.9,
		}
	},
	flags = { "placeable-off-grid", "not-deconstructable", "not-blueprintable", "not-on-map" },
	collision_mask = {
		layers = {},
	},
	module_slots = 1,
	allowed_effects = { "speed" },
	energy_usage = "1W",
	energy_source = {
		type = "void",
	},
	supply_area_distance = 0,
	distribution_effectivity = 1,
}

local nuclear_reactor_segment_creaking_sounds = {
	name = "nuclear-reactor-segment-creaking-sounds",
	type = "beacon",
	working_sound = {
		max_sounds_per_prototype = 1,
		sound = {
			{ filename = "__semi-realistic-nuclear-power__/sound/reactor-segment-creaking-1.ogg", volume = 0.4, audible_distance_modifier = 0.8 },
			{ filename = "__semi-realistic-nuclear-power__/sound/reactor-segment-creaking-2.ogg", volume = 0.4, audible_distance_modifier = 0.8 },
			{ filename = "__semi-realistic-nuclear-power__/sound/reactor-segment-creaking-3.ogg", volume = 0.4, audible_distance_modifier = 0.8 },
			{ filename = "__semi-realistic-nuclear-power__/sound/reactor-segment-creaking-4.ogg", volume = 0.4, audible_distance_modifier = 0.8 },
			{ filename = "__semi-realistic-nuclear-power__/sound/reactor-segment-creaking-5.ogg", volume = 0.4, audible_distance_modifier = 0.8 },
			{ filename = "__semi-realistic-nuclear-power__/sound/reactor-segment-creaking-6.ogg", volume = 0.4, audible_distance_modifier = 0.8 },
			{ filename = "__semi-realistic-nuclear-power__/sound/reactor-segment-creaking-7.ogg", volume = 0.4, audible_distance_modifier = 0.8 },
			{ filename = "__semi-realistic-nuclear-power__/sound/reactor-segment-creaking-8.ogg", volume = 0.4, audible_distance_modifier = 0.8 },
			{ filename = "__semi-realistic-nuclear-power__/sound/reactor-segment-creaking-9.ogg", volume = 0.4, audible_distance_modifier = 0.8 },
			{ filename = "__semi-realistic-nuclear-power__/sound/reactor-segment-creaking-10.ogg", volume = 0.4, audible_distance_modifier = 0.8 },
			{ filename = "__semi-realistic-nuclear-power__/sound/reactor-segment-creaking-11.ogg", volume = 0.4, audible_distance_modifier = 0.8 },
			{ filename = "__semi-realistic-nuclear-power__/sound/reactor-segment-creaking-12.ogg", volume = 0.4, audible_distance_modifier = 0.8 },
			{ filename = "__semi-realistic-nuclear-power__/sound/silence-1.ogg", volume = 1.0, audible_distance_modifier = 0.8 },
			{ filename = "__semi-realistic-nuclear-power__/sound/silence-2.ogg", volume = 1.0, audible_distance_modifier = 0.8 },
			{ filename = "__semi-realistic-nuclear-power__/sound/silence-3.ogg", volume = 1.0, audible_distance_modifier = 0.8 },
		}
	},
	flags = { "placeable-off-grid", "not-deconstructable", "not-blueprintable", "not-on-map" },
	collision_mask = {
		layers = {},
	},
	module_slots = 1,
	allowed_effects = { "speed" },
	energy_usage = "1W",
	energy_source = {
		type = "void",
	},
	supply_area_distance = 0,
	distribution_effectivity = 1,
}



local nuclear_reactor_segment_fluid_input = {
	name = "nuclear-reactor-segment-fluid-input",
	type = "pipe",
	collision_box = {
		{ 0.0, -0.5 },
		{ 0.0,  0.5 },
	},
	selection_box = {
		{ -0.3, -0.8 },
		{  0.3,  0.8 },
	},
	fluid_box = {
		volume = REACTOR_IN_FLOW_SIZE,
		filter = "high-pressure-water",
		pipe_connections = {
			{
				position = { 0.0, -0.5 },
				direction = defines.direction.north,
				connection_type = "underground",
				max_underground_distance = 5,
			},
			{
				position = { 0.0, 0.5 },
				direction = defines.direction.south,
				connection_type = "underground",
				max_underground_distance = 5,
			},
		},
	},
	flags = { "placeable-off-grid", "not-deconstructable", "not-blueprintable", "not-on-map" },
	collision_mask = {
		layers = {},
	},
	horizontal_window_bounding_box = {
		left_top     = { 0, 0 },
		right_bottom = { 0, 0 },
	},
	vertical_window_bounding_box = {
		left_top     = { 0, 0 },
		right_bottom = { 0, 0 },
	},
}

local nuclear_reactor_segment_fluid_output = {
	name = "nuclear-reactor-segment-fluid-output",
	type = "pipe",
	collision_box = {
		{ 0.0, -0.5 },
		{ 0.0,  0.5 },
	},
	selection_box = {
		{ -0.3, -0.8 },
		{  0.3,  0.8 },
	},
	fluid_box = {
		volume = REACTOR_OUT_FLOW_SIZE,
		filter = "superheated-water",
		pipe_connections = {
			{
				position = { 0.0, -0.5 },
				direction = defines.direction.north,
				connection_type = "underground",
				max_underground_distance = 5,
			},
			{
				position = { 0.0, 0.5 },
				direction = defines.direction.south,
				connection_type = "underground",
				max_underground_distance = 5,
			},
		},
	},
	flags = { "placeable-off-grid", "not-deconstructable", "not-blueprintable", "not-on-map" },
	collision_mask = {
		layers = {},
	},
	horizontal_window_bounding_box = {
		left_top     = { 0, 0 },
		right_bottom = { 0, 0 },
	},
	vertical_window_bounding_box = {
		left_top     = { 0, 0 },
		right_bottom = { 0, 0 },
	},
}



data:extend{nuclear_reactor_segment, nuclear_reactor_segment_item, nuclear_reactor_segment_recipe, nuclear_reactor_segment_pumping_sounds, nuclear_reactor_segment_creaking_sounds, nuclear_reactor_segment_fluid_input, nuclear_reactor_segment_fluid_output}
