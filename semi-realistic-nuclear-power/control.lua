script.on_init(function()
	storage.reactors = {}
end)



commands.add_command(
	"reset-reactors",
	"Detects all placed reactors, deletes all reactors and reactor entities, resets all stored reactor datas, then re-places all reactor entities.",
	function(command)
		
		local all_reactors = {}
		
		function process_entity(entity, surface)
			if entity.name == "nuclear-reactor-segment" then
				table.insert(all_reactors, {
					position = entity.position,
					surface = surface,
					force = entity.force,
				})
				entity.destroy()
				return
			end
			if entity.name == "nuclear-reactor-segment-fluid-input" or entity.name == "nuclear-reactor-segment-fluid-output" then
				entity.destroy()
				return
			end
		end
		
		for _,surface in pairs(game.surfaces) do
			for _,entity in ipairs(surface.find_entities_filtered({})) do
				process_entity(entity, surface)
			end
		end
		
		storage.reactors = {}
		for _,reactor in ipairs(all_reactors) do
			local reactor_ent = reactor.surface.create_entity{
				name = "nuclear-reactor-segment",
				position = reactor.position,
				force = reactor.force,
			}
			add_reactor(reactor_ent)
		end
		
	end
)



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
	table.insert(storage.reactors, {
		reactor_ent = reactor_ent,
		fluid_input_ent = fluid_input_ent,
		fluid_output_ent = fluid_output_ent,
	})
end



function remove_reactor(reactor_id)
	
	local reactor = storage.reactors[reactor_id]
	if reactor.fluid_input_ent then reactor.fluid_input_ent.destroy() end
	if reactor.fluid_output_ent then reactor.fluid_output_ent.destroy() end
	
end
