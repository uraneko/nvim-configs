-- FIXME: line move doesnt work at all, although StepDown executes
-- TODO: VimLeavePre shutdown all lsp clients and servers before leaving
return {
	Bufmod = function()
		local mod = vim.bo.modified
		local btype = vim.bo.buftype
		if mod then
			vim.cmd("w")
		else
			vim.cmd("bd")
		end
	end,

	StepUp = function()
		local mode = vim.api.nvim_get_mode()["mode"]

		local count = vim.v.count + 1
		if count == 0 then count = count + 1 end

		local cmd = "m-" .. tostring(count)
		if mode == "v" then cmd = "'<,'>" .. cmd end

		vim.cmd(cmd)
	end,

	StepDown = function()
		local mode = vim.api.nvim_get_mode()["mode"]

		local count = vim.v.count
		if count == 0 then count = count + 1 end

		local cmd = "m+" .. tostring(count)
		if mode == "v" then cmd = "'<,'>" .. cmd end
		print("cmd: " .. cmd)

		vim.cmd(cmd)
	end,
}
