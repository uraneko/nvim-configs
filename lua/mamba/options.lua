local g = vim.g
local opt = vim.opt

opt.shell = 'fish'
-- opt.shellcmdflag = '-nologo -noprofile -ExecutionPolicy RemoteSigned -command'
-- opt.shellxquote = ''

opt.swapfile = false

opt.termguicolors = true

opt.encoding = "utf-8"
opt.arabicshape = true
-- opt.guifont = ""

opt.cmdheight = 0
opt.laststatus = 3

-- merges vim yanking with clipbaord copy
-- opt.clipboard = "unnamedplus"

opt.number = true
opt.relativenumber = true

opt.mouse = ''
opt.guicursor = "n-v-i-c-r:block-Cursor"

opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.autoindent = true

opt.ignorecase = false
opt.smartcase = true
