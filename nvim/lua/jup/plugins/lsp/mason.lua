-- import mason plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

-- import mason-tool-installer
local mason_tool_installer_status, mason_tool_installer = pcall(require, "mason-tool-installer")
if not mason_tool_installer_status then
	return
end

-- enable mason
mason.setup()

mason_lspconfig.setup({
	-- list of servers for mason to install
	ensure_installed = {
		"tsserver",
		"html",
		"cssls",
		"tailwindcss",
		"lua_ls",
		"emmet_ls",
		"clangd",
		-- "gopls",
		-- "hls",
		"jsonls",
		-- "pylsp",
		"rust_analyzer",
		"pyright",
	},
	-- auto-install configured servers (with lspconfig)
	automatic_installation = true, -- not the same as ensure_installed
})

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"prettier", -- ts/js formatter
		"stylua", -- lua formatter
		"eslint_d", -- ts/js linter
		"clang_format", -- c/c++ formatter
		"rustfmt", -- rust formatte
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})

mason_tool_installer.setup({
	ensure_installed = {
		"black",
		"debugpy",
		"flake8",
		"isort",
		"mypy",
		"pylint",
	},
})
