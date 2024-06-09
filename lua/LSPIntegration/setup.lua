local lsp_config = require "lspconfig"

local formatter = function(client, _)
	-- vim.api.nvim_api_create_augroup("Foramt", { clear = true, })
	client.server_capabilities.semanticTokensProvider = nil
	vim.api.nvim_create_autocmd("BufWritePre", {
		buffer = 0, -- vim.api.nvim_get_current_buf(),
		callback = function()
			vim.lsp.buf.format({ async = false })
			vim.diagnostic.enable(0)
		end,
	})
end

-- local on_attach = function(client, bufnr)
-- 	lsp_format.on_attach(client, bufnr)
-- 	if client.server_capabilities.documentSymbolProvider then
-- 		navic.attach(client, bufnr)
-- 	end
-- end

-- rust
lsp_config.rust_analyzer.setup {
	-- autostart = false,
	on_attach = formatter,
	settings = {
		['rust-analyzer'] = {
			diagnostics = {
				enable = true,
			},
		},
		-- ["rustfmt"] = {
		-- 	use_small_heuristics = "Max",
		-- 	struct_fields_align_threshold = 20,
		-- }
	}
}

-- lua
lsp_config.lua_ls.setup {
	-- autostart = false,
	on_attach = formatter,
}

-- go
lsp_config.gopls.setup {
	-- autostart = false,
	on_attach = formatter,
}

-- zig
lsp_config.zls.setup {
	-- autostart = false,
	cmd = { "/home/brownbread/.zig/lsp/zls/zig-out/bin/zls" },
	on_attach = formatter,
}

-- haskell
lsp_config.hls.setup {
	-- autostart = false,
	on_attach = formatter,
}

-- ocaml
lsp_config.ocamllsp.setup {
	-- autostart = false,
	on_attach = formatter,
}

lsp_config.clangd.setup {
	-- autostart = false,
	-- filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	on_attach = formatter,
}

lsp_config.elixirls.setup {
	cmd = { "/home/brownbread/.elixir/lsp/elixir-ls/bin/language_server.sh" },
	on_attach = formatter
}

lsp_config.tsserver.setup {
	-- autostart = false,
	on_attach = formatter,
	-- cmd = { "bunx", "tsserver", "--stdio" },
	-- init_options = { hostInfo = "neovim" }
}

lsp_config.pyright.setup {
	-- autostart = false,
	-- cmd = { "pyright" },
	on_attach = formatter,
}

lsp_config.cssls.setup {
	on_attach = formatter,
	filetypes = { "css" },
}

lsp_config.html.setup {
	on_attach = formatter,
}

-- lsp_config.jsonls.setup {
-- 	on_attach = formatter,
-- }
--
-- lsp_config.dockerls.setup {
-- 	on_attach = formatter,
-- }
--
-- lsp_config.docker_compose_language_service.setup {
-- 	on_attach = formatter,
-- }
--
-- lsp_config.yamlls.setup {
-- 	on_attach = formatter,
-- }
--
-- lsp_config.bufls.setup {
-- 	on_attach = formatter,
-- }
