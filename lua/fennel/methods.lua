FennelMetaState = {} -- all buffer groups 
FennelState = {} -- current group and buffer 
FennelBuffer = function()end -- returns buffer struct type 

function FetchBuffers() 
	local buffers = vim.cmd("buffers")
	print("these are your buffers" .. buffers)
	return buffers
end

local Group = {
	name = "", -- nogroup
	buffers = {} -- 3, 4, 56... 
	is_active_group = false -- the buffer group currently navigatable 
	is_special_group = false, -- the special buffer group 
}

return {
	MetaState = {
		Groups = {},
		new = function() end, -- initialize a new meta state that contains buffer groups and and their buffers
		push = function() end, -- make a new group and push it to the end of Groups field
		remove  = function() end, -- remove group from Groups by its index
		ignored = {} -- buffer types and names that are ignored by fennel, 
		-- i.e., not added/handled n any way when they are opened, 
		-- e.g., the :Explore buffer, telescope windows and pane splits
		overwrite_special = function() end, -- change the special buffer group 
		overwrite_active = function() end, -- change the active buffer group 
		active = {}, -- the active group 
		special = {}, -- the special group
		groups = function() end, -- opens floating window of all groups 
	},
	State = {
		Buffers = {}, -- table of buffers of the active group
		buffers_special = {}, -- table of buffers of the special group
		new = function() end, -- initialize a new State that contains the current buffer group
		-- default is the nogroup always there group
		buffer = function() end, -- behavior of when a  new buffer is opened,
		push = function() end, -- push buffer to active group
		-- default behavior is to add an entry to nogroups or currently active  buffer group
		remove = function() end, -- remove buffer from active group by index
		next = function() end, -- go to the next buffer in the active group
		prev = function() end, -- go to the prev buffer in the active group
		-- prev and next use ':b(uf(fer))' # command under the hood
		buffers = function() end, -- opens floating window of all the buffers in the current group
	},

}

-- Behavior: when a new buffer is opened fennel adds it to the active buffer group 
-- buffer next/prev can only navigate to/from buffers inside the current buffer group 
-- 1 special buffer group
-- by default special is set to nogroup
