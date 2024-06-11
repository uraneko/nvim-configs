vim.cmd('hi StatusLine guibg="#123141"')
local colors = require "sttusline.utils.color"
require("sttusline").setup {
	on_attach = function(create_update_group)
	end,

	-- the colors of statusline will be set follow the colors of the active buffer
	statusline_color = "#123141",
	disabled = {
		filetypes = {
			-- "NvimTree",
			-- "lazy",
		},
		buftypes = {
			-- "terminal",
		},
	},
	components = {
		"mode",
		"filename",
		"modified",
		"git-branch",
		"git-diff",
		"lsps-formatters",
		"diagnostics",
		"%=",
		"navic",
		"%=",
		"indent",
		"pos-cursor",
	},
}

-- 	return string.format(" %s ", fetch_mode.modes[mode]):upper()
--
--
-- 	local path = vim.fn.expand "%:."
-- 		return "...!! A Wild Buffer Appears 🦬 "
--
-- 	local type = vim.bo.filetype
-- 		return " 虚" -- utsuro/void
-- 	if vim.bo.readonly then
-- 	local modif = vim.bo.modified
-- 	--	return "⬤"
-- 	local fro = vim.bo.readonly
-- 		return " " --"You don't have the right, O you don't have the right"
-- 		return table.concat { " %#red# ", count_me }
-- 		return table.concat { "%#orange# ", count_me }
-- 		return table.concat { " %#green# ", count_me }
-- 		return table.concat { " %#blue# ", count_me }
-- 	return "%#purple#" .. string.format("  %s", branch)
-- 	if vim.bo.filetype == "alpha" then
-- 	return " %c:%l/%L "
