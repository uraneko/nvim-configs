-- TODO: file navigation utilities conveniece
-- INFO: flatten nvim and oil nvim
-- TODO: order of require can be more effecient
-- NOTE: operators can take the normal search as movement
-- NOTE: i in V Mode acts the same as f in N Mode

-- backstage plugins: nui, nio, web-dev-icons, plenary, codeicons,
-- workspace plugins: notify, fidget, gitsigns, tls, fine-cmd, tls-cmd,
-- in-buffer plugins: ufo, bqf, comment, surround, aerial,
-- on-buffer plugins: lsp-config, lsp-format, lsp-lint, navic, ts, ts-ts, ts-to, dap, dap-ui, sttusline

-- set leaders
vim.g.leader = "`"
vim.g.localleader = "<"

-- convenient variable
keymap_arg = { noremap = true, silent = false }
map = vim.keymap.set
inspect = vim.inspect

-- allegedly enhances plugins load times
vim.loader.enable()

require "core:options"
require "core:bindings"

-- backstage plugins
require "plenary.async"
require "themes:configs"
-- require "wd-icons:configs"
-- require "codicons:configs"
-- TODO: get rid of fine-cmdline nui dependency in favor of nio, ultimately removing both and using native ui capabilities
-- no explicit import needed for nui, should be imported on use by fine-cmdline
-- require "nui" -- dep for fine-cmdline
-- require "nio" -- dep for dap-ui

-- workspace plugins
require "tls:configs"
require "gitsigns:configs"
require "fidget:configs"
require "notify:configs"
-- require "fine-cmdline:configs"
-- NOTE: tls-cmdline plugin does not need to be imported, just import the tls extension and map it ':'

-- on-buffer plugins
require "ts:configs"
require "sttusline:configs"
require "lsp:configs"
-- require "dap:configs" -- should be loaded only when needed

-- in-buffer plugins
-- require "ufo:configs"
-- require "bqf:configs"
require "comment:configs"
require "autoclose:configs"
require "aerial:configs"
