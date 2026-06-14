commands.add_command(
	"hide-reactors-debug",
	"Hides debug info about reactor internals",
	function(command)
	
		for _,reactor in ipairs(storage.reactors) do
			reactor.debug_text_1 = nil
			reactor.debug_text_2 = nil
			reactor.debug_text_3 = nil
			reactor.debug_text_4 = nil
		end
		
		rendering.clear()
		
	end
)
