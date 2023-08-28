-- Source vimrc
vim.cmd("source ~/.vimrc")

-- Personal Reference
-- Get server startup messages
-- lua =vim.lsp.util.get_progress_messages()[1]

-- Setup plugins
require("neoscroll").setup({
	easing_function = "quadratic",
	mappings = { "<C-u>", "<C-d>" },
})
vim.lsp.set_log_level("DEBUG")

require("fidget").setup({
	-- options
})

-- Attach LSP
-- Setup LSP servers. Likely farm this to plugin after dev work on Kotlin server is done.
vim.api.nvim_create_autocmd("FileType", {
	desc = "Setup typescript LSP on typescript filetype",

	pattern = "typescript",
	group = vim.api.nvim_create_augroup("typescript_lsp", { clear = true }),
	callback = function(opts)
		local id = vim.lsp.start({
			name = "typescript-language-server",
			cmd = { "typescript-language-server", "--stdio" },
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
			},
			root_dir = vim.fs.dirname(
				vim.fs.find({ "package.json", "tsconfig.json", "jsconfig.json", ".git" }, { upward = true })[1]
			),
		})
		-- Required to actual attach the server to the buffer that triggered the FileType event.
		vim.lsp.buf_attach_client(opts.buf, id)
	end,
})

-- This works! Try =vim.lsp.buf.definition()
vim.api.nvim_create_autocmd("FileType", {
	desc = "Setup local kotlin LSP on kotlin filetype",
	pattern = "kotlin",
	group = vim.api.nvim_create_augroup("kotlin_lsp_local", { clear = true }),
	callback = function(opts)
		local id = vim.lsp.start({
			name = "kotlin-language-server",
			-- .bash_profile adds the locally built kotlin-language-server to path
			cmd = { "kotlin-language-server" },
			filetypes = {
				"kotlin", -- filetype generated by kotlin-vim
			},
			root_dir = vim.fs.dirname(
				vim.fs.find({ "WORKSPACE.bazel", "WORKSPACE", "settings.gradle", ".gitignore" }, { upward = true })[1]
			),
		})
		-- Required to actual attach the server to the buffer that triggered the FileType event.
		vim.lsp.buf_attach_client(opts.buf, id)
	end,
})

-- Keymaps
vim.keymap.set("n", "gi", vim.lsp.buf.definition)
vim.keymap.set("n", "gh", vim.lsp.buf.hover)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "rr", vim.lsp.buf.rename)
