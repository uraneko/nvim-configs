-- TODO: terminal convenience
-- TODO: file navigation utilities conveniece
-- INFO: flatten nvim and oil nvim
-- TODO: order of require can be more effecient
-- NOTE: operators can take the normal search as movement
-- NOTE: i in V Mode acts the same as f in N Mode
require "plenary.async"

-- mamba
globals = require "mamba.globals"

modifiers = globals.modifiers
map = globals.map
arg = globals.arg
i = globals.inspect

require "mamba.options"
require "mamba.bindings"
require "mamba.setup"

-- treesitter
require "TSIntegration.setup"
require "TSIntegration.bindings"

-- telescope
require "TLSIntegration.setup"
require "TLSIntegration.bindings"

-- fennel
-- require "fennel.setup"
-- require "fennel.bindings"

-- LSP
require "LSPIntegration.setup"
require "LSPIntegration.bindings"

-- capybara
require "capybara.setup"

-- myrmecia
-- alpaca
-- quetzal
-- gibbon

-- turaco
require "turaco.setup"
require "turaco.bindings"
-- myrmecia
-- alpaca
-- quetzal
-- gibbon

-- turaco
require "turaco.setup"
require "turaco.bindings"

-- temporary plugins

vim.cmd("colorscheme everblush")
