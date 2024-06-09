local mamba_mod = globals.modifiers.mamba_mod
local M = require "mamba.methods"

-- search & replace
map('n', mamba_mod .. 's>', ':%s/', arg)
map('v', mamba_mod .. 's>', ':s/', arg)

-- esc
-- vim.cmd("nnoremap <c-z> <esc>")
-- vim.cmd("inoremap <c-z> <esc>")
-- vim.cmd("vnoremap <c-z> <esc>")
-- vim.cmd("cnoremap <c-z> <esc>")
-- vim.cmd("tnoremap <c-z> <esc>")
-- vim.cmd("onoremap <c-z> <esc>")
map('i', mamba_mod .. 'z>', '<ESC>', arg)
map('v', mamba_mod .. 'z>', '<ESC>', arg)
map('c', mamba_mod .. 'z>', '<c-c>', arg)
map('t', mamba_mod .. 'z>', '<c-Bslash><c-n>', arg)
map('o', mamba_mod .. 'z>', '<esc>', arg)

-- new terminal
map('n', mamba_mod .. 't>', ':terminal<cr>', arg)

-- netrw
map('n', mamba_mod .. 'e>', ':Explore <CR><cr>', arg)

map('n', mamba_mod .. 'z>', M.Bufmod, arg)
map('n', mamba_mod .. '[>', ':bp<cr>', arg)
map('n', mamba_mod .. ']>', ':bn<cr>', arg)

-- command
map("n", "<space>", ":")
map("v", "<space>", ":")

--map({'n', 'v'}, mamba_mod .. 'n>', M.StepUp, arg)
--map({'n', 'v'}, mamba_mod .. 'm>', M.StepDown, arg)

-- view mode move count from the first line in selection


-- insert new line from normal mode
map('n', 'j', 'o<esc>', arg)
map('n', 'J', 'O<esc>', arg)

-- pane control
-- map('n', 'z', '<c-w>', arg)
map('n', 'zv', '<c-w>v', arg)
map('n', 'zs', '<c-w>s', arg)
map('n', 'zx', '<c-w>q', arg)
map('n', '<s-z>', '<c-w>w', arg)
map('n', 'z]', '<c-w>l', arg)
map('n', 'z[', '<c-w>h', arg)
map('n', 'z}', '<c-w>k', arg)
map('n', 'z{', '<c-w>j', arg)
