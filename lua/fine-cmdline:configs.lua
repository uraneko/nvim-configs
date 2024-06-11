-- TODO: change the colors of this ??
require "fine-cmdline".setup {
    cmdline = {
    enable_keymaps = true,
    smart_history = true,
    prompt = ';'
  },
  popup = {
    position = {
      row = '40%',
      col = '50%',
    },
    size = {
      width = '30%',
    },
    border = {
      style = 'rounded',
    },
    win_options = {
      winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
    },
  },
--  hooks = {
--    before_mount = function(input)
--      -- code
--    end,
--    after_mount = function(input)
--      -- code
--    end,
--    set_keymaps = function(imap, feedkeys)
--      -- code
--    end
--  }
}

map('n', '<space>', ':FineCmdline<cr>', keymap_arg)
