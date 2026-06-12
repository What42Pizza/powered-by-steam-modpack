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
		fuel_categories = {
			"nuclear"
		},
		effectivity = 1,
		light_flicker = {
			color = {
			0,
			0,
			0
			},
			maximum_intensity = 0.95,
			minimum_intensity = 0.7
		},
	},
	heat_buffer = {
		max_temperature = 1000,
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
	open_sound = table.deepcopy(nuclear_reactor.open_sound),
	close_sound = table.deepcopy(nuclear_reactor.close_sound),
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
				shift = { 0.2, 0.077 },
			}
		}
	},
}



local nuclear_reactor_segment_fluid_input = {
	name = "nuclear-reactor-segment-fluid-input",
	type = "pipe",
	collision_box = {
		{ -0.5, -1.0 },
		{  0.5,  1.0 },
	},
	selection_box = {
		{ -0.5, -1.0 },
		{  0.5,  1.0 },
	},
	fluid_box = {
		volume = 100,
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
	horizontal_window_bounding_box = {
		left_top = { 0, 0 },
		right_bottom = { 0, 0 },
	},
	vertical_window_bounding_box = {
		left_top = { 0, 0 },
		right_bottom = { 0, 0 },
	},
}

local nuclear_reactor_segment_fluid_output = {
	name = "nuclear-reactor-segment-fluid-output",
	type = "pipe",
	collision_box = {
		{ -0.5, -1.0 },
		{  0.5,  1.0 },
	},
	selection_box = {
		{ -0.5, -1.0 },
		{  0.5,  1.0 },
	},
	fluid_box = {
		volume = 100,
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
	horizontal_window_bounding_box = {
		left_top = { 0, 0 },
		right_bottom = { 0, 0 },
	},
	vertical_window_bounding_box = {
		left_top = { 0, 0 },
		right_bottom = { 0, 0 },
	},
}



local nuclear_reactor_segment_item = table.deepcopy(data.raw["item"]["nuclear-reactor"])
nuclear_reactor_segment_item.name = "nuclear-reactor-segment"
nuclear_reactor_segment_item.place_result = "nuclear-reactor-segment"



data:extend{nuclear_reactor_segment, nuclear_reactor_segment_item, nuclear_reactor_segment_fluid_input, nuclear_reactor_segment_fluid_output}
