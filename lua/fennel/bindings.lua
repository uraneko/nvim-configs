local fennel_mod = globals.modifiers.fennel_mod

-- local fennel = require "fennel.setup"

map('n', '<F12>c', function() 
	local region = vim.fn.input("region name: ")
	fennel.create_region(region)
end)

map('n', '<F12>l',  
	fennel.list_regions)

map('n', '<F12>m', function() 
	local buf = vim.fn.input("buffer number: ")
	local regi = vim.fn.input("region name: ")
	fennel.move_buffer(buf, regi)
end)

map('n', '<F12>s', function() 
	local regi = vim.fn.input("region name: ")
	fennel.switch_region(regi)
end)

map('n', "<F12><Right>", fennel.buf_next)

map('n', "<F12><Left>", fennel.buf_prev)

