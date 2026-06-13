local high_pressure_water = table.deepcopy(data.raw["fluid"]["water"])
high_pressure_water.name = "high-pressure-water"
high_pressure_water.auto_barrel = false
high_pressure_water.default_temperature = 200
high_pressure_water.max_temperature = 200

local superheated_water = table.deepcopy(data.raw["fluid"]["water"])
superheated_water.name = "superheated-water"
superheated_water.auto_barrel = false
superheated_water.default_temperature = SUPERHEATED_TEMP
superheated_water.max_temperature = SUPERHEATED_TEMP

local high_pressure_steam = table.deepcopy(data.raw["fluid"]["steam"])
high_pressure_steam.name = "high-pressure-steam"
high_pressure_steam.auto_barrel = false
high_pressure_steam.default_temperature = SUPERHEATED_TEMP
high_pressure_steam.max_temperature = SUPERHEATED_TEMP

local medium_pressure_steam = table.deepcopy(data.raw["fluid"]["steam"])
medium_pressure_steam.name = "medium-pressure-steam"
medium_pressure_steam.auto_barrel = false
medium_pressure_steam.default_temperature = 400
medium_pressure_steam.max_temperature = 400

local dry_high_pressure_steam = table.deepcopy(data.raw["fluid"]["steam"])
dry_high_pressure_steam.name = "dry-high-pressure-steam"
dry_high_pressure_steam.auto_barrel = false
dry_high_pressure_steam.default_temperature = SUPERHEATED_TEMP
dry_high_pressure_steam.max_temperature = SUPERHEATED_TEMP

local dry_medium_pressure_steam = table.deepcopy(data.raw["fluid"]["steam"])
dry_medium_pressure_steam.name = "dry-medium-pressure-steam"
dry_medium_pressure_steam.auto_barrel = false
dry_medium_pressure_steam.default_temperature = 400
dry_medium_pressure_steam.max_temperature = 400



data:extend{high_pressure_water, superheated_water, high_pressure_steam, medium_pressure_steam, dry_high_pressure_steam, dry_medium_pressure_steam}
