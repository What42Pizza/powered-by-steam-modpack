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
			if
				entity.name == "nuclear-reactor-segment-fluid-input" or
				entity.name == "nuclear-reactor-segment-fluid-output" or
				entity.name == "nuclear-reactor-segment-pumping-sounds"
			then
				entity.destroy()
				return
			end
		end
		
		for _,surface in pairs(game.surfaces) do
			for _,entity in ipairs(surface.find_entities()) do
				process_entity(entity, surface)
			end
		end
		
		storage.reactors = {}
		storage.reactors_by_unit_number = {}
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
