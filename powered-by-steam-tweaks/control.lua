script.on_init(function()
	if remote.interfaces["freeplay"] then
		remote.call("freeplay", "set_created_items", {
			["modular-armor"] = 1,
			["personal-roboport-equipment"] = 1,
			["battery-mk2-equipment"] = 1,
			["solar-panel-equipment"] = 19,
			["construction-robot"] = 20,
			["pistol"] = 1,
			["firearm-magazine"] = 10,
		})
	end
end)
