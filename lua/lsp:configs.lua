local lsp_config = require "lspconfig"
local lsp_format = require "lsp-format"
local navic = require "nvim-navic"
-- 🖌
navic.setup {
  icons = {
    File = ' ',
    Module = ' ',
    Namespace = ' ',
    Package = ' ',
    Class = ' ',
    Method = ' ',
    Property = ' ',
    Field = ' ',
    Constructor = ' ',
    Enum = ' ',
    Interface = ' ',
    Function = ' ',
    Variable = ' ',
    Constant = ' ',
    String = ' ',
    Number = ' ',
    Boolean = ' ',
    Array = ' ',
    Object = ' ',
    Key = ' ',
    Null = ' ',
    EnumMember = ' ',
    Struct = ' ',
    Event = ' ',
    Operator = ' ',
    TypeParameter = ' '
  }
}

local on_attach = function(client, bufnr)
	lsp_format.on_attach(client, bufnr)
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
end

-- rust
lsp_config.rust_analyzer.setup {
	-- autostart = false,
	on_attach = on_attach,
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
	on_attach = on_attach,
}

-- go
lsp_config.gopls.setup {
	-- autostart = false,
	on_attach = on_attach,
}

-- zig
lsp_config.zls.setup {
	-- autostart = false,
	cmd = { "/home/brownbread/.zig/lsp/zls/zig-out/bin/zls" },
	on_attach = on_attach,
}

-- haskell
lsp_config.hls.setup {
	-- autostart = false,
	on_attach = on_attach,
}

-- ocaml
lsp_config.ocamllsp.setup {
	-- autostart = false,
	on_attach = on_attach,
}

lsp_config.clangd.setup {
	-- autostart = false,
	-- filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	on_attach = on_attach,
}

lsp_config.elixirls.setup {
	cmd = { "/home/brownbread/.elixir/lsp/elixir-ls/bin/language_server.sh" },
	on_attach = on_attach
}

lsp_config.tsserver.setup {
	-- autostart = false,
	on_attach = on_attach,
	-- cmd = { "bunx", "tsserver", "--stdio" },
	-- init_options = { hostInfo = "neovim" }
}

lsp_config.pyright.setup {
	-- autostart = false,
	-- cmd = { "pyright" },
	on_attach = on_attach,
}

lsp_config.cssls.setup {
	on_attach = on_attach,
	filetypes = { "css" },
}

lsp_config.html.setup {
	on_attach = on_attach,
}

-- lsp_config.jsonls.setup {
-- 	on_attach = on_attach,
-- }
--
-- lsp_config.dockerls.setup {
-- 	on_attach = on_attach,
-- }
--
-- lsp_config.docker_compose_language_service.setup {
-- 	on_attach = on_attach,
-- }
--
-- lsp_config.yamlls.setup {
-- 	on_attach = on_attach,
-- }
--
-- lsp_config.bufls.setup {
-- 	on_attach = on_attach,
-- }

local mod = "<c-"

-- diag maneuvers
map('n', mod .. 'Right>', ':lua vim.diagnostic.goto_prev()<cr>', keymap_arg)
map('n', mod .. 'Left>', ':lua vim.diagnostic.goto_next()<cr>', keymap_arg)

-- map("n", lsp_mod .. "d", function() require("trouble").toggle("document_diagnostics") end, keymap_arg)
-- map("TROUBLE", lsp_mod .. "d", function() require("trouble").toggle("document_diagnostics") end, keymap_arg)
-- map('n', lsp_mod .. 'e>', ':lua vim.diagnostic.enable(0)<cr>', keymap_arg)
-- vim.diagnostic.get(0, {severity = { vim.diagnostic.severity.WARN,}})

