local tabbing = require "core:tabs"
local tdel = tabbing.Bufdel
local tnext = tabbing.Bufnext
local tprev = tabbing.Bufprev

-- modifier key
local mod = '<esc>'

-- substitute
map('n', mod .. 's', ':%s/', keymap_arg)
map('v', mod .. 's', ':s/', keymap_arg)

-- esc
map('t', '<esc>', '<c-Bslash><c-n>', keymap_arg)
-- map('i', mod .. 'z>', '<ESC>', keymap_arg)
-- map('v', mod .. 'z>', '<ESC>', keymap_arg)
-- map('c', mod .. 'z>', '<c-c>', keymap_arg)
-- map('o', mod .. 'z>', '<esc>', keymap_arg)

-- new terminal
map('n', mod .. '<t>', ':terminal<cr>', keymap_arg)

-- netrw
map('n', mod .. 'e', ':Explore <CR><cr>', keymap_arg)

-- save buf
map('n', mod .. 'w', ':up<cr>', keymap_arg)

-- alternate buffer
-- vim.fn.getreg("#")
-- local bc = #vim.api.nvim_tabpage_list_wins(vim.api.nvim_get_current_tabpage())

-- buffer delete / prev when having split windows
-- TODO: if more than one buffer exists then dont close the empty buffer pane but only do a bd
map('n', mod .. 'd',
	function()
		local bufs = vim.fn.tabpagebuflist()
		local hash = {}
		local bc = 0
		-- cant recall what this is
		local multipane = false

		if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
			vim.cmd("bd")
			return
		end

		for _, v in ipairs(bufs) do
			if not hash[v] then
				if vim.api.nvim_buf_get_name(v) ~= "" then
					bc = bc + 1
					hash[v] = true
				end
			else
				multipane = true
			end
		end
		if bc > 1 then
			vim.cmd('bp|bd #')
		elseif bc == 1 and not multipane then
			vim.cmd("bd")
		end
	end, keymap_arg)

-- buffer next
map('n', mod .. '<Right>', function()
	local val = "bn"
	vim.cmd(val)
end, keymap_arg)

-- buffer prev
map('n', mod .. '<Left>', function()
	local val = "bp"
	vim.cmd(val)
end, keymap_arg)

-- command
map("n", "<space>", ":")
map("v", "<space>", ":")

-- insert break
-- map('i', '<End>', '<C-o>', keymap_arg)

--map({'n', 'v'}, mod .. 'n>', M.StepUp, keymap_arg)
--map({'n', 'v'}, mod .. 'm>', M.StepDown, keymap_arg)

-- view mode move count from the first line in selection

-- insert new line from normal mode
-- map('n', 'j', 'o<esc>', keymap_arg)
-- map('n', 'J', 'O<esc>', keymap_arg)

-- copy to clipboard
map('v', mod .. 'y', ":'<,'>:w !bat | wl-copy<cr><cr>", keymap_arg)

-- pane control
-- map('n', 'z', '<c-w>', keymap_arg)
map('n', 'z\'', '<c-w>v', keymap_arg)
map('n', 'z;', '<c-w>s', keymap_arg)
map('n', 'zx', '<c-w>q', keymap_arg)
map('n', '<s-z>', '<c-w>w', keymap_arg)
map('n', 'z<Right>', '<c-w>l', keymap_arg)
map('n', 'z<left>', '<c-w>h', keymap_arg)
map('n', 'z<up>', '<c-w>k', keymap_arg)
map('n', 'z<down>', '<c-w>j', keymap_arg)

-- tabs
map('n', '<c-s-right>', ':tabnext<cr>', keymap_arg)
map('n', '<c-s-left>', ':tabprev<cr>', keymap_arg)
map('n', '🍜', ':tabnew<cr>', keymap_arg)
map('n', '🍔', ':tabclose<cr>', keymap_arg)


-- leavepre = function()
-- 	package.loaded.lspconfig = nil
-- end
--
-- local fbuftype = vim.bo.buftype -- this nullifies my c-z binding
--
-- vim.cmd("autocmd VimLeavePre * call leavepre()")
--
-- -- NOTE: :int(roduction) command
--
-- -- load opt module
-- function opt_loader(name)
--     vim.cmd("packadd " .. name)
--     require name
--     require mod_reflector(name)
-- end
--
-- -- reflector for configs from opt plugin names
-- function mod_reflector(name)
--     if name == "ale" or name == "lsp-config" then
-- 	return "lsp"
--     else if name == "nvim-dap" then
-- 	return "dap"
--     else if name == "pigments" then
-- 	return load_additional_pigments()
--     end
-- end
