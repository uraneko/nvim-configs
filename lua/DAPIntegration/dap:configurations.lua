-- -- -- -- -- -- -- -
-- nvim-dap - start --
-- -- -- -- -- -- -- -
local dap = require "dap"

--rust / c
dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "-i", "dap" }
}

dap.configurations.c = {
	{
		name = "Launch",
		type = "gdb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
	},
}

dap.configurations.rust = {
	{
		name = "Launch",
		type = "gdb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
	},
}

--golang
dap.adapters.delve = {
	type = "server",
	port = "38697",
	executable = {
		command = "dlv",
		args = { "dap", "-l", "127.0.0.1:38697" },
	}
}

dap.configurations.go = {
	{
		type = "delve",
		name = "Debug",
		request = "launch",
		showLog = false,
		program = "${file}",
	},
	{
		type = "delve",
		name = "Debug test",
		request = "launch",
		mode = "test",
		program = "${file}"
	},
	{
		type = "delve",
		name = "Debug test (go.mod)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirName}"
	}
}

-- haskell
dap.adapters.haskell = {
	type = 'executable',
	command = 'haskell-debug-adapter',
	args = { '--hackage-version=0.0.33.0' },
}

dap.configurations.haskell = {
	{
		type = 'haskell',
		request = 'launch',
		name = 'Debug',
		workspace = '${workspaceFolder}',
		startup = "${file}",
		stopOnEntry = true,
		logFile = vim.fn.stdpath('data') .. '/haskell-dap.log',
		logLevel = 'WARNING',
		ghciEnv = vim.empty_dict(),
		ghciPrompt = "λ: ",
		-- Adjust the prompt to the prompt you see when you invoke the stack ghci command below
		ghciInitialPrompt = "λ: ",
		ghciCmd = "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
	},
}
-- -- -- -- -- -- --
-- nvim-dap - end --
-- -- -- -- -- -- --
-- -- -- -- -- -- -- -- -
-- nvim-dap-ui - start --
-- -- -- -- -- -- -- -- -
local dap_ui = require "dapui"
return function()
	require('dapui').setup()

	local dap, dapui = require("dap"), require("dapui")
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open({})
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close({})
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close({})
	end
end
-- -- -- -- -- -- -- --
-- nvim-dap-ui - end --
-- -- -- -- -- -- -- --
