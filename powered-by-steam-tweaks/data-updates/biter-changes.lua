-- biters (and more)
for _,unit in pairs(data.raw["unit"]) do
	
	-- increase biter (and more) health by 50%
	if unit.max_health then unit.max_health = unit.max_health * 1.5 end
	
	-- decrease all resistance decreases by 50%
	if unit.resistances then
		for _,resistance in ipairs(unit.resistances) do
			if resistance.decrease then resistance.decrease = resistance.decrease * 0.5 end
		end
	end
	
end



-- worms
for _,worm in pairs(data.raw["turret"]) do
	-- decrease all resistance decreases by 50%
	if worm.resistances then
		for _,resistance in ipairs(worm.resistances) do
			if resistance.decrease then resistance.decrease = resistance.decrease * 0.5 end
		end
	end
end



-- increase all spawner healths by 25%
for _,unit_spawner in pairs(data.raw["unit-spawner"]) do
	if unit_spawner.max_health then unit_spawner.max_health = unit_spawner.max_health * 1.25 end
end



-- decrease tree pollution absorption by 50%
for _,tree in pairs(data.raw["tree"]) do
	if tree.emissions_per_second and tree.emissions_per_second.pollution then
		tree.emissions_per_second.pollution = tree.emissions_per_second.pollution * 0.5
	end
end



-- increase magazine size
data.raw["ammo"]["firearm-magazine"].magazine_size = 12
data.raw["ammo"]["piercing-rounds-magazine"].magazine_size = 12



local map_settings = data.raw["map-settings"]["map-settings"]
local enemy_evolution = map_settings.enemy_evolution
local enemy_expansion = map_settings.enemy_expansion
local pollution       = map_settings.pollution
local one_second = 60
local one_minute = one_second * 60
local one_hour   = one_minute * 60

-- increase time-based evolution factor by 2x
enemy_evolution.time_factor = 8e-06

-- increase expansion rate ~2x
enemy_expansion.min_expansion_cooldown = 3 * one_minute
enemy_expansion.max_expansion_cooldown = 25 * one_minute

-- increase min expansion party size 2x
enemy_expansion.settler_group_min_size = 10

-- increase max threshold for pollution 'redness' on map view by 33%
pollution.expected_max_per_chunk = 200
