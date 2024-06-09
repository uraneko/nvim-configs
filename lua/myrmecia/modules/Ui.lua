-- ui popup
local popup = require "plenary.popup"

-- implementation detail, should not reside here 
local win_id

local Ui  = {}

Ui.Window = {}

Ui.Window.Corners1 = { "_", "|", "_", "|", "⌜", "⌝", "⌟", "⌞" }
Ui.Window.Corners2 = { "_", "|", "_", "|", "⟔", "⌝", "⟓", "⌞" }
Ui.Window.Corners3 = { "_", "|", "_", "|", "⎡", "⎤", "⎦", "⎣" }

Ui.Window.Build = function(opts, cb, meta, wid)
	local height = h
	local width = w
	local borderchars = borders

	WinId = popup.create(opts, {
		title = meta.title,
		highlight = meta.title,
		line = math.floor(((vim.o.lines - meta.height) / 2) - 1),
		col = math.floor((vim.o.columns - meta.width) /2),
		minwidth = meta.width,
		minheight = meta.height,
		borderchars= meta.corners,
		callback = cb,
	})
	local bufnr = vim.api.nvim_win_get_buf(wid)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '=', '<cmd>lua Ui.Window.Close(' .. tostring(wid) .. '<cr>', { silent = false })
end

Ui.Window.Close = function(wid) 
	vim.api.nvim_win_close(wid, true)
end

-- implementation method, i.e., should reside in the pseudo-plugin that requires it, not myrmecia
-- NOTE: myrmecia only provides the additional feature
function Launch(opts, cb)
	local opts = opts
	
	local cb = function(_, sel)
		Turaco.Paint(sel)
	end
	Ui.Window.Build(opts, cb, meta, wid)
end

return Ui
