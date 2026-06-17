require("constants")



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

function contains(t, f)
	for _,v in pairs(t) do
		if v == f then
			return true
		end
	end
	return false
end

function find_index(t, f)
	for k,v in pairs(t) do
		if v == f then
			return k
		end
	end
	return nil
end



local fuel_consumption_per_update = prototypes.entity["nuclear-reactor-segment"].get_max_energy_usage() * 30 / FUEL_CONSUME_EFFICIENCY

local qualities = {}
function detect_qualities()
	local curr_quality = prototypes.quality["normal"]
	while true do
		log("detected quality '" .. curr_quality.name .. "'")
		table.insert(qualities, curr_quality.name)
		if not curr_quality.next or contains(qualities, curr_quality.next) then
			return
		end
		curr_quality = curr_quality.next
	end
end
detect_qualities()



require("commands.reset-reactors")
require("commands.show-reactors-debug")
require("commands.hide-reactors-debug")



script.on_init(function()
	storage.reactors = {}
	storage.reactors_by_unit_number = {}
	storage.format = 1
	storage.gui_format = CURRENT_GUI_STORAGE_FORMAT
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
		
		is_active = true, -- this is false if the reactor is being unregistered
		reactor_ent = reactor_ent,
		fluid_input_ent = fluid_input_ent,
		fluid_output_ent = fluid_output_ent,
		pumping_sound_ent = pumping_sound_ent,
		creaking_sound_ent = creaking_sound_ent,
		prev_burner_fuel = 0,
		
		neighbors = neighbors,
		starting_neighbor_transfer = 0,
		efficiency = 1,
		
		temp = 15,
		fuel = 0, -- in joules
		direct_heat = 0,
		decay_heat = 0,
		
		last_control_rod_strength = 0,
		last_coolant_flow = 0,
		
	})
	
	storage.reactors_by_unit_number[reactor_ent.unit_number] = storage.reactors[#storage.reactors]
	
	trigger_neighbors_recount(reactor_ent.surface, reactor_ent.position)
	
end



function unregister_reactor(reactor)
	
	reactor.is_active = false
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
	
	local nearby_reactor_entities = reactor_ent.surface.find_entities_filtered({
		area = {
			{pos.x - 3, pos.y - 3},
			{pos.x + 3, pos.y + 3},
		},
		name = "nuclear-reactor-segment"
	})
	
	local reactor = storage.reactors_by_unit_number[reactor_ent.unit_number]
	reactor.neighbors = {}
	for _,nearby_reactor_entity in ipairs(nearby_reactor_entities) do
		local neighbor = storage.reactors_by_unit_number[nearby_reactor_entity.unit_number]
		if neighbor ~= reactor and neighbor.is_active then
			table.insert(reactor.neighbors, neighbor)
		end
	end
	
	local neighbor_count = math.min(#reactor.neighbors, MAX_NEIGHBORS)
	reactor.efficiency = STARTING_EFFICIENCY + neighbor_count * NEIGHBOR_EFFICIENCY_BONUS
	local quality_num = find_index(qualities, reactor_ent.quality.name)
	quality_bonus = 1.0 + (quality_num - 1) * QUALITY_LEVEL_EFFICIENCY_BONUS
	reactor.efficiency = reactor.efficiency * quality_bonus
	--world_text(reactor.reactor_ent.position, "neighbors: " .. reactor.neighbors)
	
end



script.on_event(defines.events.on_tick, function(event)
	
	for _,reactor in ipairs(storage.reactors) do
		if (reactor.reactor_ent.unit_number + event.tick) % 30 == 0 then
			update_reactor_data(reactor)
		end
	end
	
	for _,player in pairs(game.players) do
		update_player_ui(player)
	end
	
end)



function update_reactor_data(reactor)
	
	local reactor_ent = reactor.reactor_ent
	
	-- 'meltdown'
	if reactor.temp >= MAX_REACTOR_TEMP then
		local pos = reactor_ent.position
		game.print("The reactor at [gps=" .. pos.x .. "," .. pos.y .. "] has overheated:")
		game.print("    Reactor's temperature: " .. reactor.temp)
		game.print("    Reactor's direct heat: +" .. round(reactor.direct_heat * 2 * 1000) / 1000 .. "/s")
		game.print("    Reactor's decay heat: +" .. round(reactor.decay_heat * 2 * 1000) / 1000 .. "/s")
		game.print("    Reactor's Control rods: " .. round(reactor.last_control_rod_strength * 100) .. "% inserted (automatically inserted)")
		game.print("    Reactor's coolant flow: " .. round(reactor.last_coolant_flow) * 2 .. "/s")
		game.print("    Reactor's available coolant: " .. round(math.max(math.floor(reactor.fluid_input_ent.get_fluid_count()) - 15, 0) * 2) .. "/s")
		game.print("    Reactor's available output space: " .. round((REACTOR_OUT_FLOW_SIZE - reactor.fluid_output_ent.get_fluid_count()) * 2) .. "/s")
		reactor_ent.surface.create_entity{
			name = "atomic-rocket",
			position = reactor_ent.position,
			force = reactor_ent.force,
			target = reactor_ent.position,
			speed = 1.0
		}
	end
	
	-- detect refuels
	local burner_fuel_value = reactor_ent.burner.remaining_burning_fuel
	if burner_fuel_value - reactor.prev_burner_fuel > 100 then
		reactor.fuel = burner_fuel_value
		--world_text(reactor.reactor_ent.position, "fueled reactor")
	end
	reactor.prev_burner_fuel = burner_fuel_value
	
	-- transfer heat between neighbors
	for i = 0,#reactor.neighbors - 1 do
		local neighbor_i = ((i + reactor.starting_neighbor_transfer) % #reactor.neighbors)
		local neighbor = reactor.neighbors[neighbor_i + 1] -- the math before here says indexing starts at 0
		local transfer_amount = (reactor.temp - neighbor.temp) * NEIGHBOR_TRANSFER_AMOUNT
		reactor.temp = reactor.temp - transfer_amount
		neighbor.temp = neighbor.temp + transfer_amount
	end
	reactor.starting_neighbor_transfer = (reactor.starting_neighbor_transfer + 1) % math.max(#reactor.neighbors, 1)
	
	-- increase direct and decay heat
	if reactor.fuel > 0 then
		local control_rod_signal = reactor_ent.get_signal({ name = "iron-stick", type = "item" }, defines.wire_connector_id.circuit_red, defines.wire_connector_id.circuit_green)
		control_rod_signal = clamp(control_rod_signal / 100.0, 0, 1)
		local auto_control_rod = clamp((reactor.temp - 1000) / 100.0, 0, 1)
		reactor.last_control_rod_strength = math.max(control_rod_signal, auto_control_rod)
		local consume_amount = 1.0 - reactor.last_control_rod_strength
		local heating_amount = consume_amount * reactor.efficiency
		reactor.decay_heat = reactor.decay_heat + DECAY_HEAT_INCREASE * heating_amount
		reactor.direct_heat = reactor.direct_heat + DIRECT_HEAT_INCREASE * heating_amount
		reactor.fuel = reactor.fuel - fuel_consumption_per_update * consume_amount
	end
	
	-- apply heat
	reactor.temp = reactor.temp + (reactor.decay_heat + reactor.direct_heat) * (1.0 + EFFICIENCY_BOOST_PER_HUNDRED_TEMP * (reactor.temp - 15) / 100)
	
	-- transfer heat to water
	local max_water_available = math.max(math.floor(reactor.fluid_input_ent.get_fluid_count()) - 15, 0)
	local max_water_heat_available = round(math.max(reactor.temp - SUPERHEATED_TEMP, 0) / TEMP_PER_SUPERHEATED_WATER)
	local max_water_output_available = math.floor(REACTOR_OUT_FLOW_SIZE - reactor.fluid_output_ent.get_fluid_count())
	local water_to_heat = math.min(max_water_available, max_water_heat_available, max_water_output_available, MAX_FLOW_PER_TICK)
	reactor.last_coolant_flow = water_to_heat
	reactor.temp = reactor.temp - water_to_heat * TEMP_PER_SUPERHEATED_WATER
	if water_to_heat > 0 then
		reactor.fluid_input_ent.remove_fluid({ name = "high-pressure-water", amount = water_to_heat })
		reactor.fluid_output_ent.insert_fluid({ name = "superheated-water", amount = water_to_heat })
	end
	reactor.pumping_sound_ent.active = water_to_heat > 0
	reactor.creaking_sound_ent.active = reactor.temp > 100
	
	-- normalize values
	reactor.decay_heat = reactor.decay_heat * DECAY_HEAT_DECAY
	reactor.direct_heat = reactor.direct_heat * DIRECT_HEAT_DECAY
	reactor.temp = lerp(reactor.temp, 15, 0.00005)
	
	-- update reactor entity
	reactor_ent.burner.remaining_burning_fuel = reactor.fuel
	reactor_ent.temperature = reactor.temp
	
	if reactor.debug_text_1 then
		reactor.debug_text_1.text = "Temp: " .. round(reactor.temp)
		reactor.debug_text_2.text = "Direct heat: " .. round(reactor.direct_heat * 100) / 100
		reactor.debug_text_3.text = "Decay heat: " .. round(reactor.decay_heat * 100) / 100
		reactor.debug_text_4.text = "Control rod percent: " .. round(reactor.last_control_rod_strength * 100)
		reactor.debug_text_5.text = "Coolant flow: " .. round(water_to_heat)
	end
	
end



local CURRENT_GUI_STORAGE_FORMAT = 1

function update_player_ui(player)
	
	local selected_ent = player.selected
	if selected_ent and selected_ent.name == "nuclear-reactor-segment" then
		local reactor = storage.reactors_by_unit_number[selected_ent.unit_number]
		local left_ui = player.gui.left
		
		if (storage.gui_format or 0) < CURRENT_GUI_STORAGE_FORMAT and left_ui.reactor_ui then
			left_ui.reactor_ui.destroy()
		end
		
		if not left_ui.reactor_ui then
			add_player_left_gui(left_ui)
			storage.gui_format = CURRENT_GUI_STORAGE_FORMAT
		end
		
		left_ui.visible = true
		
		local reactor_ui = left_ui.reactor_ui
		reactor_ui.temp.caption = "Temperature: " .. round(reactor.temp * 10) / 10 .. "°"
		reactor_ui.direct_heat.caption = "Direct heat: +" .. round(reactor.direct_heat * 2 * 100) / 100 .. "/s"
		reactor_ui.decay_heat.caption = "Decay heat: +" .. round(reactor.decay_heat * 2 * 100) / 100 .. "/s"
		reactor_ui.control_rods.caption = "Control rods: " .. round(reactor.last_control_rod_strength * 100) .. "% inserted"
		reactor_ui.coolant_flow.caption = "Coolant flow: " .. round(reactor.last_coolant_flow) * 2 .. "/s"
		reactor_ui.available_coolant.caption = "Available coolant: " .. math.max(math.floor(reactor.fluid_input_ent.get_fluid_count()) - 15, 0) * 2 .. "/s"
		reactor_ui.available_output_space.caption = "Available output space: " .. math.floor(REACTOR_OUT_FLOW_SIZE - reactor.fluid_output_ent.get_fluid_count()) * 2 .. "/s"
		reactor_ui.neighbors.caption = "Neighbors: " .. #reactor.neighbors .. (#reactor.neighbors > 6 and " (maxed at 6)" or "")
		reactor_ui.efficiency.caption = "Efficiency: " .. round(reactor.efficiency * (1.0 + EFFICIENCY_BOOST_PER_HUNDRED_TEMP * (reactor.temp - 15) / 100) * 100) .. "%"
		
	else
		
		local left_ui = player.gui.left
		if left_ui.reactor_ui then
			left_ui.visible = false
		end
		
	end
	
end



function add_player_left_gui(left_ui)
	
	left_ui.add{
		type = "frame",
		name = "reactor_ui",
		direction = "vertical",
		caption = "Reactor data:",
	}
	
	
	left_ui.reactor_ui.add{
		type = "label",
		name = "temp",
		caption = "Temperature: _°",
	}
	left_ui.reactor_ui.temp.style.font_color = { r = 1.0, g = 0.95, b = 0.9 }
	left_ui.reactor_ui.add{
		type = "label",
		name = "direct_heat",
		caption = "Direct heat: +_/s",
	}
	left_ui.reactor_ui.direct_heat.style.font_color = { r = 1.0, g = 0.95, b = 0.9 }
	left_ui.reactor_ui.add{
		type = "label",
		name = "decay_heat",
		caption = "Decay heat: +_/s",
	}
	left_ui.reactor_ui.decay_heat.style.font_color = { r = 1.0, g = 0.95, b = 0.9 }
	
	
	left_ui.reactor_ui.add{
		type = "line",
		name = "line_1"
	}
	
	
	left_ui.reactor_ui.add{
		type = "label",
		name = "control_rods",
		caption = "Control rods: _% inserted",
	}
	left_ui.reactor_ui.control_rods.style.font_color = { r = 1.0, g = 0.95, b = 0.9 }
	left_ui.reactor_ui.add{
		type = "label",
		name = "control_rods_note_1",
		caption = "- You can increase the control rods by",
	}
	left_ui.reactor_ui.control_rods_note_1.style.font_color = { r = 0.85, g = 0.85, b = 0.85 }
	left_ui.reactor_ui.add{
		type = "label",
		name = "control_rods_note_2",
		caption = "sending an 'iron-stick' signal",
	}
	left_ui.reactor_ui.control_rods_note_2.style.font_color = { r = 0.85, g = 0.85, b = 0.85 }
	left_ui.reactor_ui.add{
		type = "label",
		name = "control_rods_note_3",
		caption = "- Automatically deploy starting at 1000°",
	}
	left_ui.reactor_ui.control_rods_note_3.style.font_color = { r = 0.85, g = 0.85, b = 0.85 }
	
	
	left_ui.reactor_ui.add{
		type = "line",
		name = "line_2"
	}
	
	
	left_ui.reactor_ui.add{
		type = "label",
		name = "coolant_flow",
		caption = "Coolant flow: _/s",
	}
	left_ui.reactor_ui.coolant_flow.style.font_color = { r = 1.0, g = 0.95, b = 0.9 }
	left_ui.reactor_ui.add{
		type = "label",
		name = "available_coolant",
		caption = "Available coolant: _",
	}
	left_ui.reactor_ui.available_coolant.style.font_color = { r = 1.0, g = 0.95, b = 0.9 }
	left_ui.reactor_ui.add{
		type = "label",
		name = "available_output_space",
		caption = "Available output space: _",
	}
	left_ui.reactor_ui.available_output_space.style.font_color = { r = 1.0, g = 0.95, b = 0.9 }
	
	
	left_ui.reactor_ui.add{
		type = "line",
		name = "line_3"
	}
	
	
	left_ui.reactor_ui.add{
		type = "label",
		name = "neighbors",
		caption = "Neighbors: _",
	}
	left_ui.reactor_ui.neighbors.style.font_color = { r = 1.0, g = 0.95, b = 0.9 }
	left_ui.reactor_ui.add{
		type = "label",
		name = "efficiency",
		caption = "Efficiency: _%",
	}
	left_ui.reactor_ui.efficiency.style.font_color = { r = 1.0, g = 0.95, b = 0.9 }
	
end
