leavepre = function()
	package.loaded.lspconfig = nil
end

local fbuftype = vim.bo.buftype -- this nullifies my c-z binding

vim.cmd("autocmd VimLeavePre * call leavepre()")

-- NOTE: :int(roduction) command
