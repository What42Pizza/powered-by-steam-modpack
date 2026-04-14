function addSteamPower(prototype, pipe_connections)
	prototype.energy_source = {
		type = "fluid",
		scale_fluid_usage = true,
		fluid_box = {
			pipe_connections = pipe_connections,
			volume = 100
		},
		emissions_per_minute = prototype.energy_source.emissionsPerMinute
	}
end

local pipeConnections_LR = { -- left, right
	{
		position = {1, 0},
		direction = 4,
		flow_direction = "input-output"
	},
	{
		position = {-1, 0},
		direction = 12,
		flow_direction = "input-output"
	}
}
local pipeConnections_LR_3 = { -- left, right
	{
		position = {2, 0},
		direction = 4,
		flow_direction = "input-output"
	},
	{
		position = {-2, 0},
		direction = 12,
		flow_direction = "input-output"
	}
}
local pipeConnections_LRTB = { -- left, right, top, bottom
	{
		position = {1, 0},
		direction = 4,
		flow_direction = "input-output"
	},
	{
		position = {-1, 0},
		direction = 12,
		flow_direction = "input-output"
	},
	{
		position = {0, 1},
		direction = 8,
		flow_direction = "input-output"
	},
	{
		position = {0, -1},
		direction = 0,
		flow_direction = "input-output"
	}
}
local pipeConnections_LRTB_5 = { -- left, right, top, bottom
	{
		position = {2.5, 0},
		direction = 4,
		flow_direction = "input-output"
	},
	{
		position = {-2.5, 0},
		direction = 12,
		flow_direction = "input-output"
	},
	{
		position = {0, 2.5},
		direction = 8,
		flow_direction = "input-output"
	},
	{
		position = {0, -2.5},
		direction = 0,
		flow_direction = "input-output"
	}
}



addSteamPower(data.raw.lab.lab, pipeConnections_LRTB)
addSteamPower(data.raw["assembling-machine"]["assembling-machine-1"], pipeConnections_LR)
addSteamPower(data.raw["assembling-machine"]["assembling-machine-2"], pipeConnections_LR)
addSteamPower(data.raw["assembling-machine"]["assembling-machine-3"], pipeConnections_LR)
addSteamPower(data.raw["mining-drill"]["electric-mining-drill"], {
	{
		position = {1, 1},
		direction = 4,
		flow_direction = "input-output"
	},
	{
		position = {-1, 1},
		direction = 12,
		flow_direction = "input-output"
	}
})
addSteamPower(data.raw["mining-drill"]["pumpjack"], pipeConnections_LR)
addSteamPower(data.raw["pump"]["pump"], {
	{
		position = {0.0, 0.5},
		direction = 4,
		flow_direction = "input-output"
	},
	{
		position = {0.0, 0.5},
		direction = 12,
		flow_direction = "input-output"
	}
})
addSteamPower(data.raw["assembling-machine"]["oil-refinery"], pipeConnections_LR_3)
