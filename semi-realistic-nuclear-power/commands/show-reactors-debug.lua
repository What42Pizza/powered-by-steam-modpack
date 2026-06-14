commands.add_command(
	"show-reactors-debug",
	"Shows debug info about reactor internals",
	function(command)
	
		for _,reactor in ipairs(storage.reactors) do
			local pos = reactor.reactor_ent.position
			local text_id_1 = rendering.draw_text{
				text = "",
				surface = reactor.reactor_ent.surface,
				target = { pos.x + 0.5, pos.y - 0.5 },
				color = { 1, 1, 1 },
				scale = 0.7,
			}
			local text_id_2 = rendering.draw_text{
				text = "",
				surface = reactor.reactor_ent.surface,
				target = { pos.x + 0.5, pos.y - 0.25 },
				color = { 1, 1, 1 },
				scale = 0.7,
			}
			local text_id_3 = rendering.draw_text{
				text = "",
				surface = reactor.reactor_ent.surface,
				target = { pos.x + 0.5, pos.y + 0.0 },
				color = { 1, 1, 1 },
				scale = 0.7,
			}
			local text_id_4 = rendering.draw_text{
				text = "",
				surface = reactor.reactor_ent.surface,
				target = { pos.x + 0.5, pos.y + 0.25 },
				color = { 1, 1, 1 },
				scale = 0.7,
			}
			local text_id_5 = rendering.draw_text{
				text = "",
				surface = reactor.reactor_ent.surface,
				target = { pos.x + 0.5, pos.y + 0.5 },
				color = { 1, 1, 1 },
				scale = 0.7,
			}
			reactor.debug_text_1 = text_id_1
			reactor.debug_text_2 = text_id_2
			reactor.debug_text_3 = text_id_3
			reactor.debug_text_4 = text_id_4
			reactor.debug_text_5 = text_id_5
		end
		
	end
)
