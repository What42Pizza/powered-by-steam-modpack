local fuel_consumption_per_update = prototypes.entity["nuclear-reactor-segment"].get_max_energy_usage() * 30
local temp_per_superheated_water = 0.15



function world_text(pos, text)
	game.players[1].create_local_flying_text{
		position = pos,
		text = text,
		color = {r = 1, g = 1, b = 1}
	}
end

function lerp(a, b, c)
	return a + (b - a) * c
end

function round(v)
	return math.floor(v + 0.5)
end



require("commands.reset-reactors")



script.on_init(function()
	storage.reactors = {}
	storage.reactors_by_unit_number = {}
end)



script.on_event({ defines.events.on_built_entity, defines.events.on_robot_built_entity, defines.events.on_space_platform_built_entity, defines.events.script_raised_built, defines.events.script_raised_revive }, function(event)
	local entity = event.entity
	
	if entity.name == "nuclear-reactor-segment" then
		add_reactor(entity)
	end
	
end)



script.on_event({ defines.events.on_pre_player_mined_item, defines.events.on_robot_pre_mined, defines.events.on_entity_died, defines.events.script_raised_destroy, defines.events.on_space_platform_mined_entity }, function(event)
	local entity = event.entity
	
	if entity.name == "nuclear-reactor-segment" then
		for i,v in ipairs(storage.reactors) do
			if v.reactor_ent == entity then
				remove_reactor(i)
				return
			end
		end
	end
	
end)



function add_reactor(reactor_ent)
	local pos = reactor_ent.position
	
	reactor_ent.active = false
	
	local fluid_input_ent = reactor_ent.surface.create_entity{
		name = "nuclear-reactor-segment-fluid-input",
		position = { x = pos.x - 0.5, y = pos.y },
		force = reactor_ent.force,
	}
	local fluid_output_ent = reactor_ent.surface.create_entity{
		name = "nuclear-reactor-segment-fluid-output",
		position = { x = pos.x + 0.5, y = pos.y },
		force = reactor_ent.force,
	}
	local pumping_sound_ent = reactor_ent.surface.create_entity{
		name = "nuclear-reactor-segment-pumping-sounds",
		position = pos,
		force = reactor_ent.force,
	}
	pumping_sound_ent.get_module_inventory().insert({ name = "speed-module", count = 1 })
	pumping_sound_ent.active = false
	local creaking_sound_ent = reactor_ent.surface.create_entity{
		name = "nuclear-reactor-segment-creaking-sounds",
		position = pos,
		force = reactor_ent.force,
	}
	creaking_sound_ent.get_module_inventory().insert({ name = "speed-module", count = 1 })
	creaking_sound_ent.active = false
	
	table.insert(storage.reactors, {
		
		reactor_ent = reactor_ent,
		fluid_input_ent = fluid_input_ent,
		fluid_output_ent = fluid_output_ent,
		pumping_sound_ent = pumping_sound_ent,
		creaking_sound_ent = creaking_sound_ent,
		
		neighbors = neighbors,
		efficiency = 1,
		
		temp = 15,
		fuel = 0, -- in joules
		direct_heat = 0,
		decay_heat = 0,
		
	})
	storage.reactors_by_unit_number[reactor_ent.unit_number] = storage.reactors[#storage.reactors]
	
	trigger_neighbors_recount(reactor_ent.surface, reactor_ent.position)
	
end



function remove_reactor(reactor_i)
	local reactor = storage.reactors[reactor_i]
	
	table.remove(storage.reactors_by_unit_number, reactor.reactor_ent.unit_number)
	
	if reactor.fluid_input_ent then reactor.fluid_input_ent.destroy() end
	if reactor.fluid_output_ent then reactor.fluid_output_ent.destroy() end
	if reactor.pumping_sound_ent then reactor.pumping_sound_ent.destroy() end
	
	table.remove(storage.reactors, reactor_i)
	
	trigger_neighbors_recount(reactor.reactor_ent.surface, reactor.reactor_ent.position)
	
end



function trigger_neighbors_recount(surface, pos)
	for _,reactor_ent in ipairs(surface.find_entities_filtered({
		area = {
			{pos.x - 3, pos.y - 3},
			{pos.x + 3, pos.y + 3},
		},
		name = "nuclear-reactor-segment"
	})) do
		recount_reactor_neighbors(reactor_ent)
	end
end

function recount_reactor_neighbors(reactor_ent)
	local pos = reactor_ent.position
	local nearby_reactors = reactor_ent.surface.find_entities_filtered({
		area = {
			{pos.x - 3, pos.y - 3},
			{pos.x + 3, pos.y + 3},
		},
		name = "nuclear-reactor-segment"
	})
	local reactor = storage.reactors_by_unit_number[reactor_ent.unit_number]
	reactor.neighbors = #nearby_reactors - 1 -- because it will also count itself
	reactor.neighbors = math.min(reactor.neighbors, 6) -- max neighbors is 6
	reactor.efficiency = 1.0 + 0.25 * reactor.neighbors
	--world_text(reactor.reactor_ent.position, "neighbors: " .. reactor.neighbors)
end



script.on_event(defines.events.on_tick, function(event)
	
	for _,reactor in ipairs(storage.reactors) do
		if (reactor.reactor_ent.unit_number + event.tick) % 30 == 0 then
			update_reactor(reactor)
		end
	end
	
end)



function update_reactor(reactor)
	
	local reactor_ent = reactor.reactor_ent
	
	if reactor.fuel <= 0 then
		local inventory = reactor_ent.burner.inventory.get_contents()
		if #inventory >= 1 then
			local removed_fuel = reactor_ent.burner.inventory.remove({ name = inventory[1].name, count = 1 })
			if removed_fuel == 1 then
				reactor.fuel = prototypes.item[inventory[1].name].fuel_value
				reactor_ent.burner.currently_burning = { name = inventory[1].name }
				--world_text(reactor.reactor_ent.position, "fueled reactor")
			end
		end
	end
	
	if reactor.fuel > 0 then
		reactor.decay_heat = reactor.decay_heat + 0.01 * reactor.efficiency
		reactor.direct_heat = reactor.direct_heat + 0.5 * reactor.efficiency
		reactor.fuel = reactor.fuel - fuel_consumption_per_update
		if reactor.fuel <= 0 then
			local burnt_result = prototypes.item[reactor_ent.burner.currently_burning.name.name].burnt_result
			reactor_ent.burner.burnt_result_inventory.insert({ name = burnt_result.name, count = 1 })
			reactor_ent.burner.currently_burning = nil
		end
	end
	
	reactor.temp = reactor.temp + reactor.decay_heat + reactor.direct_heat
	
	local available_water = reactor.fluid_input_ent.get_fluid_count()
	local max_water_to_heat = round(math.max(reactor.temp - 700, 0) / temp_per_superheated_water)
	local available_output_space = 100 - reactor.fluid_output_ent.get_fluid_count()
	local water_to_heat = math.min(available_water, max_water_to_heat, available_output_space)
	reactor.temp = reactor.temp - water_to_heat * temp_per_superheated_water
	if water_to_heat > 0 then
		reactor.fluid_input_ent.remove_fluid({ name = "high-pressure-water", amount = water_to_heat })
		reactor.fluid_output_ent.insert_fluid({ name = "superheated-water", amount = water_to_heat })
	end
	reactor.pumping_sound_ent.active = water_to_heat > 0
	reactor.creaking_sound_ent.active = reactor.temp > 100
	
	reactor.decay_heat = reactor.decay_heat * 0.99
	reactor.direct_heat = reactor.direct_heat * 0.5
	reactor.temp = lerp(reactor.temp, 15, 0.0001)
	
	reactor_ent.burner.remaining_burning_fuel = reactor.fuel
	reactor_ent.temperature = reactor.temp
	
end
