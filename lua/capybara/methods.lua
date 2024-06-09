local Capy = {}

Capy.file_meta = function()
	return {
		shortname = shortname,
		fullname = fullname,
		type = filetype,
		modifiable = modifiable,

	}
end

Capy.dir_meta = function() end

Capy.mode_meta = function() end

Capy.lsp_meta = function() end

Capy.dap_meta = function() end

Capy.diag_meta = function() end

Capy.buf_meta = function() end

Capy.git_meta = function() end


local statusline = {
	' %t',
	'%r',
	'%m',
	'%=',
	'%{&filetype}',
	' %2p%%',
	' %3l:%-2c '
}

vim.o.statusline = table.concat(statusline, '')
