require("constants")

local fuel_consumption_per_update = prototypes.entity["nuclear-reactor-segment"].get_max_energy_usage() * 30



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

function clamp(v, min, max)
	return (v < min and min) or (v > max and max) or v
end



require("commands.reset-reactors")



script.on_init(function()
	storage.reactors = {}
	storage.reactors_by_unit_number = {}
end)



script.on_event({ defines.events.on_built_entity, defines.events.on_robot_built_entity, defines.events.on_space_platform_built_entity, defines.events.script_raised_built, defines.events.script_raised_revive }, function(event)
	local entity = event.entity
	
	if entity.name == "nuclear-reactor-segment" then
		register_reactor(entity)
	end
	
end)



script.on_event({ defines.events.on_pre_player_mined_item, defines.events.on_robot_pre_mined, defines.events.on_entity_died, defines.events.script_raised_destroy, defines.events.on_space_platform_mined_entity }, function(event)
	local entity = event.entity
	
	if
		entity.name == "nuclear-reactor-segment-fluid-input" or
		entity.name == "nuclear-reactor-segment-fluid-output" or
		entity.name == "nuclear-reactor-segment-pumping-sounds" or
		entity.name == "nuclear-reactor-segment-creaking-sounds"
	then
		game.print("WARNING: HELPER ENTITY DESTROYED, THIS WILL LIKELY CAUSE A CRASH")
	end
	
	local found_reactor = storage.reactors_by_unit_number[entity.unit_number]
	if found_reactor then
		unregister_reactor(found_reactor)
		return
	end
	
end)



function register_reactor(reactor_ent)
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
	local creaking_sound_ent = reactor_ent.surface.create_entity{
		name = "nuclear-reactor-segment-creaking-sounds",
		position = pos,
		force = reactor_ent.force,
	}
	
	fluid_input_ent.destructible = false
	fluid_output_ent.destructible = false
	pumping_sound_ent.destructible = false
	creaking_sound_ent.destructible = false
	fluid_input_ent.minable = false
	fluid_output_ent.minable = false
	pumping_sound_ent.minable = false
	creaking_sound_ent.minable = false
	
	pumping_sound_ent.get_module_inventory().insert({ name = "speed-module", count = 1 })
	pumping_sound_ent.active = false
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



function unregister_reactor(reactor)
	
	local recount_surface = reactor.reactor_ent.surface
	local recount_pos = reactor.reactor_ent.position
	
	table.remove(storage.reactors_by_unit_number, reactor.reactor_ent.unit_number)
	
	--reactor.reactor_ent.destroy() -- this 'custom functionality' system probably shouldn't handle creating/destroying the reactor segment entities
	reactor.fluid_input_ent.destroy()
	reactor.fluid_output_ent.destroy()
	reactor.pumping_sound_ent.destroy()
	reactor.creaking_sound_ent.destroy()
	
	for i = #storage.reactors, 1, -1 do
		if storage.reactors[i] == reactor then
			table.remove(storage.reactors, i)
		end
	end
	
	trigger_neighbors_recount(recount_surface, recount_pos)
	
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
	reactor.neighbors = math.min(reactor.neighbors, MAX_NEIGHBORS) -- max neighbors is 6
	reactor.efficiency = STARTING_EFFICIENCY + reactor.neighbors * NEIGHBOR_EFFICIENCY_BONUS
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
	
	if reactor.temp >= MAX_REACTOR_TEMP then
		reactor_ent.surface.create_entity{
			name = "atomic-rocket",
			position = reactor_ent.position,
			force = reactor_ent.force,
			target = reactor_ent.position,
			speed = 1.0
		}
	end
	
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
		local control_rod_signal = reactor_ent.get_signal({ name = "iron-stick", type = "item" }, defines.wire_connector_id.circuit_red, defines.wire_connector_id.circuit_green)
		local consume_amount = 1.0 - clamp(control_rod_signal, 0, 100) / 100.0
		local heating_amount = (reactor.efficiency + EFFICIENCY_BOOST_PER_HUNDRED_TEMP * reactor.temp / 100) * consume_amount
		reactor.decay_heat = reactor.decay_heat + 0.01 * heating_amount
		reactor.direct_heat = reactor.direct_heat + 0.5 * heating_amount
		reactor.fuel = reactor.fuel - fuel_consumption_per_update * consume_amount
		if reactor.fuel <= 0 then
			local burnt_result = prototypes.item[reactor_ent.burner.currently_burning.name.name].burnt_result
			reactor_ent.burner.burnt_result_inventory.insert({ name = burnt_result.name, count = 1 })
			reactor_ent.burner.currently_burning = nil
		end
	end
	
	reactor.temp = reactor.temp + reactor.decay_heat + reactor.direct_heat
	
	local max_water_available = reactor.fluid_input_ent.get_fluid_count()
	local max_water_heatable = round(math.max(reactor.temp - SUPERHEATED_TEMP, 0) / TEMP_PER_SUPERHEATED_WATER)
	local max_water_output_available = REACTOR_OUT_FLOW_SIZE - reactor.fluid_output_ent.get_fluid_count()
	local water_to_heat = math.min(max_water_available, max_water_heatable, max_water_output_available, MAX_FLOW_PER_TICK)
	reactor.temp = reactor.temp - water_to_heat * TEMP_PER_SUPERHEATED_WATER
	if water_to_heat > 0 then
		reactor.fluid_input_ent.remove_fluid({ name = "high-pressure-water", amount = water_to_heat })
		reactor.fluid_output_ent.insert_fluid({ name = "superheated-water", amount = water_to_heat })
	end
	reactor.pumping_sound_ent.active = water_to_heat > 0
	reactor.creaking_sound_ent.active = reactor.temp > 100
	
	reactor.decay_heat = reactor.decay_heat * 0.99
	reactor.direct_heat = reactor.direct_heat * 0.5
	reactor.temp = lerp(reactor.temp, 15, 0.00005)
	
	reactor_ent.burner.remaining_burning_fuel = reactor.fuel
	reactor_ent.temperature = reactor.temp
	
end
