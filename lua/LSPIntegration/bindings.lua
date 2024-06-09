local lsp_mod = modifiers.lsp_mod

-- diag maneuvers
map('n', lsp_mod .. '[>', ':lua vim.diagnostic.goto_prev()<cr>', arg)
map('n', lsp_mod .. ']>', ':lua vim.diagnostic.goto_next()<cr>', arg)

-- map("n", lsp_mod .. "d", function() require("trouble").toggle("document_diagnostics") end, arg)
-- map("TROUBLE", lsp_mod .. "d", function() require("trouble").toggle("document_diagnostics") end, arg)
map('n', lsp_mod .. 'cr>', ':Telescope diagnostics<cr>', arg)
map('n', lsp_mod .. 'e>', ':lua vim.diagnostic.enable(0)<cr>', arg)

-- Switch LSP On Off
local function lsp_controller()
	local with_lsp = query_buffer_lsp()
	if with_lsp == nil then
		vim.cmd(":LspStart<cr>")
		vim.notify("Buffer Attach: LSP Client", "info", { title = "LSP Controller" })
	else
		vim.cmd(":LspStop<cr>")
		vim.notify("Buffer Detach: LSP Client " .. with_lsp['name'], "info", { title = "LSP Controller" })
	end
end

function query_buffer_lsp()
	local idx = next(vim.lsp.buf_get_clients())
	if idx == nil then
		print("query_buffer_lsp(): No LSP client detected on buffer")
		return nil
	end
	local data = vim.lsp.buf_get_clients()[idx]

	return data
end

map('n', lsp_mod .. 'bs>', lsp_controller, arg)
