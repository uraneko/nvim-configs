-- HACK: string.format is faster than ..

local bg0 = "#b1ceb1"
local fg0 = "#2c5a75"
local bg1 = "#202120"
local fg1 = "#c8d6d1"

local orange0 = "#dd6b00"
local red0 = "#da2112"
local green0 = "#40b800"
local yellow0 = "#f6e375"
local blue0 = "#3647df"
local green1 = "#5bc83a"
local purple0 = "#7f45d5"
local brown0 = "#522222"

vim.cmd("hi statusline guifg=" .. bg0)
vim.cmd("hi statusline guibg=" .. bg1)
vim.cmd("hi statusline gui=bold")

vim.cmd("hi yesmod guifg=" .. orange0 .. " guibg=" .. bg1)
vim.cmd("hi nomod guifg=" .. green0 .. " guibg=" .. bg1)

vim.cmd("hi red gui=bold guifg=" .. red0 .. " guibg=" .. bg1)
vim.cmd("hi orange gui=bold guifg=" .. orange0 .. " guibg=" .. bg1)
vim.cmd("hi green gui=bold guifg=" .. green0 .. " guibg=" .. bg1)
vim.cmd("hi blue gui=bold guifg=" .. blue0 .. " guibg=" .. bg1)
vim.cmd("hi yellow gui=bold guifg=" .. yellow0 .. " guibg=" .. bg1)
vim.cmd("hi purple gui=bold guifg=" .. purple0 .. " guibg=" .. bg1)

local fetch_mode = {}

fetch_mode.modes = {
	["n"] = "NORMAL",
	["no"] = "NORMAL",
	["v"] = "VISUAL",
	["V"] = "VISUAL LINE",
	[""] = "VISUAL BLOCK",
	["s"] = "SELECT",
	["S"] = "SELECT LINE",
	[""] = "SELECT BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["R"] = "REPLACE",
	["Rv"] = "VISUAL REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM EX",
	["ce"] = "EX",
	["r"] = "PROMPT",
	["rm"] = "MOAR",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}

fetch_mode.current = function()
	local mode = vim.api.nvim_get_mode().mode
	return string.format(" %s ", fetch_mode.modes[mode]):upper()
end

fetch_mode.update_color = function()
	local current = fetch_mode:current()
	local mode_color = "%#StatusLineAccent#"
	if current_mode == "n" then
		mode_color = "%#StatuslineAccent#"
	elseif current_mode == "i" or current_mode == "ic" then
		mode_color = "%#StatuslineInsertAccent#"
	elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
		mode_color = "%#StatuslineVisualAccent#"
	elseif current_mode == "R" then
		mode_color = "%#StatuslineReplaceAccent#"
	elseif current_mode == "c" then
		mode_color = "%#StatuslineCmdLineAccent#"
	elseif current_mode == "t" then
		mode_color = "%#StatuslineTerminalAccent#"
	end
	return mode_color
end

local file = {}
file.path = function()
	local path = vim.fn.expand "%:."
	if path == "" then
		return "...!! A Wild Buffer Appears 🦬 "
	end
	return string.format(" %s ", path)
end


file.type = function()
	local type = vim.bo.filetype
	if type == "" then
		return " 虚" -- utsuro/void
	end
	return string.format(" %s ", type)
end


file.modified = function()
	if vim.bo.readonly then
		return ""
	end
	local modif = vim.bo.modified
	if modif then
		return "%#yesmod#⬤  "
	else
		return "%#nomod#⬤  "
	end
	--	return "⬤"
end

file.readonly = function()
	local fro = vim.bo.readonly
	if fro then
		return " " --"You don't have the right, O you don't have the right"
	end
	return ""
end

--⏺
--⬤
--⚫
-- vim.api.nvim_buf_set_name(0, "... A Wild Buffer Appears 🦬")

local lsp = {}

lsp.error = function()
	local count_me = #vim.diagnostic.get(0, { severity = { vim.diagnostic.severity.ERROR } })
	if count_me ~= 0 then
		return table.concat { " %#red# ", count_me }
	end
	return ""
end

lsp.warn = function()
	local count_me = #vim.diagnostic.get(0, { severity = { vim.diagnostic.severity.WARN } })
	if count_me ~= 0 then
		return table.concat { "%#orange# ", count_me }
	end
	return ""
end
lsp.info = function()
	local count_me = #vim.diagnostic.get(0, { severity = { vim.diagnostic.severity.INFO } })
	if count_me ~= 0 then
		return table.concat { " %#green# ", count_me }
	end
	return ""
end
lsp.hint = function()
	local count_me = #vim.diagnostic.get(0, { severity = { vim.diagnostic.severity.HINT } })
	if count_me ~= 0 then
		return table.concat { " %#blue# ", count_me }
	end
	return ""
end

lsp.diag = function()
	return table.concat {
		lsp.error(),
		lsp.warn(),
		lsp.info(),
		lsp.hint(),
		" "
	}
end

local git = {}

git.branch = function()
	local branch = vim.fn.system([[
	if test $(fd -H ".git" --maxdepth 1 -t dir | wc -l) != 0
		echo $(git branch --show-current)
    end
	]])
	branch = branch:gsub("%s+", "")
	return "%#purple#" .. string.format("  %s", branch)
end

-- git.diff = vim.api.nvim_exec("git diff  --stat  lua/turaco/setup.lua")
--
-- git.fadd = function()
-- end
--
-- git.fmod = function()
-- end
--
-- git.fdel = function()
-- end

local function lineinfo()
	if vim.bo.filetype == "alpha" then
		return ""
	end
	return " %c:%l/%L "
end

local filepath = file.path()
local filereadonly = file.readonly()
local git_branch = git.branch()

Statusline = {}

Statusline.active = function()
	return table.concat {
		"%#Statusline#",
		fetch_mode.update_color(),
		fetch_mode.current(),
		file.path(),
		file.modified(),
		file.readonly(),
		lsp.diag(),
		git_branch,
		"%=%#StatusLineExtra#",
		file.type(),
		" b'%n ",
		lineinfo(),
	}
end

function Statusline.inactive()
	return " %F"
end

function Statusline.short()
	return "%#StatusLineNC#   NvimTree"
end

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)
