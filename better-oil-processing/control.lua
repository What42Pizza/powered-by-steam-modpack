script.on_init(function()
	
	-- fix map gen settings for existing saves
	local nauvis_map_gen_settings = game.surfaces.nauvis.map_gen_settings
	nauvis_map_gen_settings.autoplace_controls["sulfur"] = {}
	nauvis_map_gen_settings.autoplace_settings.entity.settings["sulfur"] = {}
	game.surfaces.nauvis.map_gen_settings = nauvis_map_gen_settings
	if script.active_mods["space-age"] and game.surfaces.vulcanus then
		local vulcanus_map_gen_settings = game.surfaces.vulcanus.map_gen_settings
		vulcanus_map_gen_settings.autoplace_controls["vulcanus_sulfur"] = {}
		vulcanus_map_gen_settings.autoplace_settings.entity.settings["sulfur"] = {}
		game.surfaces.vulcanus.map_gen_settings = vulcanus_map_gen_settings
	end
	
end)
