-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
	-- setup formatters & linters
	sources = {
		--  to disable file types use
		--  "formatting.prettier.with({disabled_filetypes = {}})" (see null-ls docs)
		formatting.prettier, -- js/ts formatter
		formatting.stylua, -- lua formatter
		diagnostics.eslint_d.with({ -- js/ts linter
			-- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
			condition = function(utils)
				return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
			end,
		}),
		diagnostics.shellcheck.with({ filetypes = { "sh", "zsh" } }), -- shell script
		formatting.clang_format, -- c/c++ formatter
		formatting.rustfmt, -- rust formatter
		formatting.shfmt.with({ filetypes = { "sh", "zsh" } }), -- shell script
	},
	-- configure format on save
	on_attach = function(current_client, bufnr)
		local project_root = vim.fn.getcwd()
		local disable_file_path = project_root .. "/.clang-format-disable"
		local enable_auto_format = not (vim.fn.filereadable(disable_file_path) ~= 0)
		if not enable_auto_format then
			print("File '" .. disable_file_path .. "' exists. Auto formatting disabled")
		end
		if current_client.supports_method("textDocument/formatting") and enable_auto_format then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							--  only use null-ls for formatting instead of lsp server
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})
