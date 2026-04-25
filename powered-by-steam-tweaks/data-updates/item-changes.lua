for _,module in pairs(data.raw["module"]) do
	if module.effect.consumption then
		module.effect.pollution = -module.effect.consumption
	end
end

data.raw["utility-constants"]["default"].default_pipeline_extent = 640
