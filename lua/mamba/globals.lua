-- async
-- async = require "plenary.async"

-- set leaders
vim.g.leader = "`"
vim.g.localleader = "<"

-- set modifiers
modifiers = {
	mamba_mod = "<c-",   -- local custom bindings modifier
	tls_mod = "<cr>", -- telescope
	fennel_mod = "<c-s-", -- harpoon
	ts_mod = "<tab>", -- treesitter not many custom bindings here
	turaco_mod = "<tab>",
	lsp_mod = "<a-",      -- not used often
	dap_mod = "",        -- not many custom bindings here -> use leaders
	-- git_mod = "", -- no bindings
}

-- useful vim variable bindings
map = vim.keymap.set
arg = { noremap = true, silent = true }

inspect = vim.inspect

return {
	--	async = async,
	--	leaders = Leaders,
	modifiers = modifiers,
	map = map,
	arg = arg,
	inspect = inspect,
}
