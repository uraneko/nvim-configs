-- TODO: PaintStack loaded schemes window + live_preview of color schemes in this window 
local T = {}

-- loads external colorschemes in nvim/pack/plugins/themes
T.Load = function() 
	local i = 0
	local dir = vim.fn.stdpath "config" .. "/pack/plugins/themes/"
	local themes = io.popen("ls -a \"" .. dir .. "\"")
	if themes == nil then
		return
	end

	local paints = {}
	for theme in themes:lines() do
		i = i + 1
		if i > 2 then
			-- load theme plugin in neovim; TODO: iff not already loaded
			vim.opt.rtp:append(dir .. "/" .. theme)

			-- get cleaned up theme name
			theme = theme:gsub(".nvim", "")
			theme = theme:gsub("neovim", "")
			theme = theme:gsub("-", "")

			-- append schemes with theme name
			paints[i - 2] = theme
		end
	end

	return paints
end

-- takes one exisiting colorscheme name as argument
T.Paint = function(paint)
	local cmd = 'colorscheme ' .. paint
	vim.cmd(cmd)
end

-- prints the Stack array(table)
T.Print = function(paints)
	local msg = ""
	for _, paint in ipairs(paints) do
		msg = msg .. "  " .. paint .. "\n"
	end
	vim.notify(msg, "warn", { title = "Turaco Paint Stack" })
end

-- takes Turaco.Stack, paints random colorscheme from .Stack
T.Shuffle = function(paints) 
	local shuffle = paints[math.random(#paints)]
--	vim.notify("Loading new Paint '" .. shuffle .. "'", "info", { title = "Turaco Paint Shuffle" })
	T.Paint(shuffle)
end

T.Default = function()
	T.Paint("default")
end

-- T.Window = {}
-- 
-- T.Window.id
-- 
-- T.Window.meta = {
-- 	title = "Turaco Stack Live Preview",
-- 	width = 40
-- 	height = 60
-- 	corners = MyrmeciaW.Corners2
-- }
-- 
-- T.Window.Build = MyrmeciaW.Build(T.Stack, T.Window.Launch, T.Window.meta) 
-- 
-- T.window.Close = MyrmeciaW.Close(T.Window.id)
-- 
-- T.Window.Launch = MyrmeciaW

-- takes Turaco.Stack global variable, returns stack as a string
-- T.Str = function(paints) 
-- 	local str_stack = ""
-- 	for _, p in ipairs(paints) do	
-- 		str_stack = str_stack .. p .. "\n"
-- 	end
-- 
-- 	return str_stack
-- end

return T

-- :lua print(vim.inspect(vim.api.nvim_list_runtime_paths()))
