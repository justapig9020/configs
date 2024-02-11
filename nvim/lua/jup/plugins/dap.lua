local dap, dapui = require("dap"), require("dapui")

local keymap = vim.keymap

local enter = function()
	dapui.open()
	keymap.set("n", "<leader>ni", "<cmd> DapStepOver <cr>")
	keymap.set("n", "<leader>si", "<cmd> DapStepInto <cr>")
	keymap.set("n", "<leader>q", "<cmd> DapTerminate <cr>")
	keymap.set("n", "<leader>fini", "<cmd> DapStepOut <cr>")
end

local exit = function()
	dapui.close()
	-- TODO: Remove keymaps
end

dap.listeners.before.attach.dapui_config = enter
dap.listeners.before.launch.dapui_config = enter
dap.listeners.before.event_terminated.dapui_config = exit
dap.listeners.before.event_exited.dapui_config = exit
