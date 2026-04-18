function re_init()
	
	
	
	if remote.interfaces["freeplay"] then
		remote.call("freeplay", "set_created_items", {
			["modular-armor"] = 1,
			["personal-roboport-equipment"] = 1,
			["battery-mk2-equipment"] = 1,
			["solar-panel-equipment"] = 19,
			["construction-robot"] = 20,
		})
		remote.call("freeplay", "set_respawn_items", {})
		remote.call("freeplay", "set_ship_items", {
			["pistol"] = 1,
			["firearm-magazine"] = 100,
		})
		remote.call("freeplay", "set_debris_items", {})
	end
	
	
	
	-- set color for disco science
	if remote.interfaces["DiscoScience"] then
		remote.call("DiscoScience", "setIngredientColor", "material-science-pack", { r = 0.55, g = 0.3, b = 0.0 })
	end
	
	
	
	-- retroactively apply new game settings:
	
	local map_settings = game.map_settings
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
	
	game.print("applied changes")
	
	
	
end



script.on_init(re_init)
script.on_configuration_changed(re_init)
