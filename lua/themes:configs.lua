-- loads external colorschemes in nvim/pack/plugins/themes
function unpack_themes()
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

-- :lua print(vim.inspect(vim.api.nvim_list_runtime_paths()))

unpack_themes()
vim.cmd("colorscheme everblush")
