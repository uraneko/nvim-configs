fennel = {}

-- one table: groups = { "A" = { 1, 3, 5 } , B = { 4, 2, 6 }
-- two methods:
-- bind_buffer: binds the current buffer to a group name
-- bind_group: marks the current group as active; the "" group is for all buffers


fennel.regions = { len = 1, ["none"] = 1 } -- all region names
fennel.buffers = { len = 0 }               -- buffer number = buffer's region; all buffers with their regions
fennel.rname = "none"                      -- the current region name
fennel.region = { len = 0 }                -- the current region buffers; index = buffer number in nvim
fennel.buffer = 0                          -- the current file buffer key inside region

fennel.create_region = function(name)      -- creates a new region with name and number
	fennel.regions.len = fennel.regions.len + 1
	fennel.regions[name] = fennel.regions.len
end

fennel.list_regions = function() -- lists all regions names
	local keys = {}
	for k, _ in pairs(fennel.regions) do
		table.insert(keys, string.format(" %s\n", k))
	end
	print(vim.inspect(table.concat(keys)))
end

fennel.move_buffer = function(bufnum, reginame) -- moves buffer from one region to another
	if reginame == fennel.buffers[bufnum] then
		return
	elseif fennel.buffers[bufnum] == fennel.rname then
		for k, v in pairs(fennel.region) do
			if v == bufnum then
				fennel.region[k] = nil
				fennel.region.len = fennel.region.len - 1
				break
			end
		end
	elseif reginame == fennel.rname then
		fennel.region[#fennel.region + 1] = bufnum
		fennel.region.len = fennel.region.len + 1
	end
	fennel.buffers[bufnum] = reginame
end

fennel.region_buffers = function() -- returns all the buffers of current region
	local collect = {}
	local idx = 0
	for buf, regi in pairs(fennel.buffers) do
		if regi == fennel.rname then
			collect[idx] = buf
			idx = idx + 1
		end
	end
	collect.len = idx
	return collect
end

fennel.switch_region = function(region) -- changes the current region
	fennel.rname = region
	fennel.region = fennel.region_buffers()
	if fennel.region.len > 0 then
		vim.cmd(string.format("b%d", fennel.region[1]))
		fennel.buffer = 1
	else
		vim.cmd("enew")
		-- fennel.buffer = 0
	end
end

fennel.buf_next = function() -- go to next buffer in region
	local buf
	if fennel.buffer == fennel.region.len then
		buf = 1
	else
		buf = fennel.region[fennel.buffer + 1]
	end
	fennel.buffer = buf
	vim.cmd(string.format("b%s", buf))
end

fennel.buf_prev = function() -- go to next buffer in region
	local buf
	if fennel.buffer == 1 then
		buf = fennel.region.len
	else
		buf = fennel.region[fennel.buffer - 1]
	end
	fennel.buffer = buf
	vim.cmd(string.format("b%s", buf))
end

fennel.new_buffer = function() -- behavior when entering a new buffer
	local ft = vim.bo.filetype
	local m = vim.api.nvim_get_mode().mode
	print(string.format("this buffer is : %s", vim.fn.expand "%P"))
	if ft == "" and m == "n" then
		print(111)
		fennel.buffer = 0
		return
	else
		print(222)
		local bufn = vim.fn.bufnr()

		fennel.buffers.len = fennel.buffers.len + 1
		fennel.buffers[bufn] = fennel.rname

		fennel.region.len = fennel.region.len + 1
		fennel.region[fennel.region.len] = bufn
		fennel.buffer = fennel.region.len

		vim.notify(string.format("bound buf%d on current region", bufn))
	end
end

-- FIXME: most events work before the new buffer is loaded, which breaks everything
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = "*",
	callback = function()
		fennel.new_buffer()
	end,
})

-- vim.api.nvim_create_user_command("Fennel",
-- vim.api.nvim_create_user_command("Fennel",
