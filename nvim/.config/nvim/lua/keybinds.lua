local vim = vim

vim.g.mapleader = ' '

vim.keymap.set('n', ';', '.', { noremap = true })
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- Close HTML and XML tags
vim.keymap.set('i', '<C-c>', '</<C-X><C-O><Esc>F<i', { noremap = false })

-- Jump up and down half pages while keeping cursor position in center
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Copy/paste to primary (*) and clipboard (+) in normal mode
vim.keymap.set('n', '<leader>y', '"*y')
vim.keymap.set('n', '<leader>p', '"*p')
vim.keymap.set('n', '<leader>Y', '"+y')
vim.keymap.set('n', '<leader>P', '"+p')

-- Copy/paste to primary (*) and clipboard (+) in visual mode
vim.keymap.set('v', '<leader>y', '"*y')
vim.keymap.set('v', '<leader>p', '"*p')
vim.keymap.set('v', '<leader>Y', '"+y')
vim.keymap.set('v', '<leader>P', '"+p')

-- Allow oil to navigate above the original nvim call
--vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

-- Create new journal entry with current date as title. Open if file exists.
vim.keymap.set('n', '<leader>jo', function()
	local filename = os.date('%Y-%m-%d', os.time()) .. '.md'
	vim.cmd.edit('$HOME/docs/journal/' .. filename)
end)

-- Recommended for nvim-lspconfig global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<space>f', function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})
