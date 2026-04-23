function addSteamPower(prototype, pipe_connections)
	local emissions = table.deepcopy(prototype.energy_source.emissions_per_minute)
	if emissions and emissions.pollution then emissions.pollution = emissions.pollution * 1.5 end
	prototype.energy_source = {
		type = "fluid",
		scale_fluid_usage = true,
		fluid_box = {
			filter = "steam",
			pipe_connections = pipe_connections,
			volume = 100
		},
		emissions_per_minute = emissions
	}
end

local pipeConnections_LR_3 = { -- left, right, 3x3
	{ position = {1 , 0}, direction = 4 , flow_direction = "input-output" },
	{ position = {-1, 0}, direction = 12, flow_direction = "input-output" }
}
local pipeConnections_LR_5 = { -- left, right, 5x5
	{ position = {2 , 0}, direction = 4 , flow_direction = "input-output" },
	{ position = {-2, 0}, direction = 12, flow_direction = "input-output" }
}
local pipeConnections_LRTB_3 = { -- left, right, top, bottom, 3x3
	{ position = {1 , 0}, direction = 4 , flow_direction = "input-output" },
	{ position = {-1, 0}, direction = 12, flow_direction = "input-output" },
	{ position = {0 , 1}, direction = 8 , flow_direction = "input-output" },
	{ position = {0 , -1}, direction = 0, flow_direction = "input-output" }
}
local pipeConnections_LRTB_5 = { -- left, right, top, bottom, 5x5
	{ position = {2 , 0}, direction = 4 , flow_direction = "input-output" },
	{ position = {-2, 0}, direction = 12, flow_direction = "input-output" },
	{ position = {0 , 2}, direction = 8 , flow_direction = "input-output" },
	{ position = {0, -2}, direction = 0 , flow_direction = "input-output" }
}



addSteamPower(data.raw["mining-drill"]["electric-mining-drill"], {
	{ position = {1 , 1}, direction = 4 , flow_direction = "input-output" },
	{ position = {-1, 1}, direction = 12, flow_direction = "input-output" }
})
addSteamPower(data.raw["pump"]["pump"], {
	{ position = {0.0, 0.5}, direction = 4 , flow_direction = "input-output" },
	{ position = {0.0, 0.5}, direction = 12, flow_direction = "input-output" }
})

addSteamPower(data.raw["mining-drill"]["pumpjack"], pipeConnections_LR_3)

addSteamPower(data.raw["assembling-machine"]["assembling-machine-1"], pipeConnections_LR_3)
addSteamPower(data.raw["assembling-machine"]["assembling-machine-2"], pipeConnections_LR_3)
addSteamPower(data.raw["assembling-machine"]["assembling-machine-3"], pipeConnections_LR_3)
addSteamPower(data.raw["agricultural-tower"]["agricultural-tower"]  , pipeConnections_LRTB_3)
addSteamPower(data.raw["assembling-machine"]["chemical-plant"]      , pipeConnections_LR_3)
addSteamPower(data.raw["assembling-machine"]["oil-refinery"]        , pipeConnections_LR_5)

addSteamPower(data.raw["lab"]["lab"], pipeConnections_LRTB_3)
