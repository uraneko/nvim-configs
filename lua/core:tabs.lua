-- TODO: refactor this and statusline to import the same deps
-- so as to not waste resources
-- broken

tab = vim.api.nvim_get_current_tabpage()

tabs = {}

vim.api.nvim_create_augroup("logistics", { clear = true })

-- update tab value when tab changes
vim.api.nvim_create_autocmd({ "TabEnter", "TabLeave", "TabClosed", "TabNewEntered" }, {
	desc = "tab change",
	group = "logistics",
	callback = function()
		tab = vim.api.nvim_get_current_tabpage()
	end
})

-- save current buffer to curret tab
vim.api.nvim_create_autocmd({ "WinEnter" }, {
	desc = "buf classification by tab",
	group = "logistics",
	callback = function()
		-- print(vim.api.nvim_get_current_buf())
		-- print(inspect(tabs))

		if tabs[tab] == nil then
			tabs[tab] = {}
		end
		local val = vim.api.nvim_get_current_buf()
		for _, v in ipairs(tabs[tab]) do
			if v == val then
				return
			end
		end
		table.insert(tabs[tab], vim.api.nvim_get_current_buf())
	end
})


return {
	Bufnext = function()
		local buf = vim.api.nvim_get_current_buf()
		local prev

		local first
		for k, v in ipairs(tabs[tab]) do
			if k == 1 then
				first = v
			elseif k == #tabs[tab] and v == buf then
				return first
			end

			if prev == buf then
				return v
			else
				prev = v
			end
		end

		return nil
	end,

	Bufprev = function()
		local buf = vim.api.nvim_get_current_buf()
		local prev

		local last = false
		for _, v in ipairs(tabs[tab]) do
			if k == 1 and v == buf then
				last = true
			elseif k == #tabs[tab] and last then
				return v
			end

			if v == buf then
				return prev
			else
				prev = v
			end
		end

		return nil
	end,

	Bufdel = function()
		if #tabs[tab] == 1 then
			return nil
		else
			for k, v in ipairs(tabs[tab]) do
				if v == vim.api.nvim_get_current_buf() then
					table.remove(tabs[tab], k)
					return v
				end
			end
		end
	end
}
