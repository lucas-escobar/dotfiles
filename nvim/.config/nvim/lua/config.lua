local vim = vim

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.textwidth = 80
vim.opt.swapfile = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
-- yy and pp will use the system clipboard (+)
vim.opt.clipboard = "unnamedplus"

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = false,
	float = { source = "if_many" },
})

vim.g.markdown_fenced_languages = {
	"ts=typescript",
	"js=javascript",
	"sh=bash",
	"rust=rust",
	"py=python",
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "single"
	opts.max_width = opts.max_width or 80
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.g.rustfmt_autosave = 1

--vim.opt.list = true
--vim.opt.listchars:append("trail:·")

-- to debug lsp issues
--vim.lsp.set_log_level("info")

--if vim.fn.has('nvim-0.5') == 1 then
--    local socket_dir = '/tmp/nvim'
--    local socket_path = string.format('%s/nvim-%d.sock', socket_dir, vim.fn.getpid())
--
--    -- Ensure the directory exists
--    if vim.fn.isdirectory(socket_dir) == 0 then
--        vim.fn.mkdir(socket_dir, 'p') -- 'p' creates parent directories if necessary
--        print("Created directory: " .. socket_dir)
--    end
--
--    -- Only start the server if the socket does not already exist
--    if vim.fn.filereadable(socket_path) == 0 then
--        vim.fn.serverstart(socket_path)
--        print("Server started on " .. socket_path)
--    else
--        print("Socket already in use: " .. socket_path)
--    end
--end
vim.api.nvim_create_augroup("UserColors", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
	group = "UserColors",
	pattern = "*",
	callback = function()
		vim.cmd("highlight Normal ctermbg=NONE guibg=NONE")
	end,
})
