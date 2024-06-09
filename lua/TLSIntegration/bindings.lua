local tls_mod = globals.modifiers.tls_mod

-- notify
-- map('n', tls_mod .. '<bs>', ":Telescope notify<cr>", arg)

-- telescope
map('n', tls_mod .. '.', ':Telescope live_grep <CR>', arg)
map('n', tls_mod .. '/', ':Telescope current_buffer_fuzzy_find<cr>', arg)

-- map('n', tls_mod .. 'f', ':Telescope find_files <CR>', arg)
-- map('n', tls_mod .. 'b', ':Telescope buffers <CR>', arg)
-- map('n', tls_mod .. 'o', ':Telescope live_grep grep_open_files=true <CR>', arg)

map('n', tls_mod .. "'", ':Telescope git_commits<CR>', arg)
map('n', tls_mod .. ';', ':Telescope git_stash<CR>', arg)
-- map('n', tls_mod .. 'B', ':Telescope git_branches<CR>', arg)
-- map('n', tls_mod .. '?', ':Telescope git_status<CR>', arg)

-- map('n', tls_mod .. '\\', ':Telescope treesitter<cr>', arg)
map('n', tls_mod .. '\\', ':Telescope lsp_document_symbols<cr>', arg)
-- map('n', tls_mod .. '<bs>', ':Telescope diagnostics<cr>', arg)
-- map('n', tls_mod .. 'o', ':Telescope oldfiles', arg)
-- map('n', tls_mod .. 'c', ':Telescope colorscheme', arg)
