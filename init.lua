cmd = vim.cmd
exec = vim.api.nvim_exec
fn = vim.fn
map = vim.api.nvim_set_keymap

-- leader
g = vim.g
g.mapleader = "\\"

-- basic options
opt = vim.opt
opt.mouse = "a" -- enable mouse support
opt.clipboard = "unnamedplus" -- copy/paste to system clipboard
opt.swapfile = false -- don't use swapfile
opt.number = true -- show line number
opt.showmatch = true -- highlight matching parenthesis
opt.foldmethod = "marker" -- enable folding (default 'foldmarker')
opt.colorcolumn = "80" -- line lenght marker at 80 columns
opt.splitright = true -- vertical split to the right
opt.splitbelow = true -- orizontal split to the bottom
opt.ignorecase = true -- ignore case letters when search
opt.smartcase = true -- ignore lowercase for the whole pattern
opt.linebreak = true -- wrap on word boundary
opt.hidden = true -- enable background buffers
opt.history = 100 -- remember n lines in history
opt.lazyredraw = true -- faster scrolling
opt.synmaxcol = 240 -- max column for syntax highlight
opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 4 -- shift 4 spaces when tab
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.smartindent = true -- autoindent new lines

-- colors
opt.termguicolors = true -- enable 24-bit RGB colors
cmd([[colorscheme kanagawa]])

-- whitespace and tabs
cmd([[au BufWritePre * :%s/\s\+$//e]])
cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])
cmd([[autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0]])
cmd([[
  autocmd FileType xml,html,xhtml,css,scss,javascript,yaml setlocal shiftwidth=2 tabstop=2
]])

-- bootstrap Packer plugin manager
ensure_packer = function()
	install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			"https://github.com/wbthomason/packer.nvim",
			install_path,
		})
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

packer_bootstrap = ensure_packer()

require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-treesitter/nvim-treesitter")
	use("neovim/nvim-lspconfig")
	use("nvim-tree/nvim-tree.lua")
	use("lewis6991/gitsigns.nvim")
	use("nvim-lua/plenary.nvim")
	use("rebelot/kanagawa.nvim")
	use("lukas-reineke/lsp-format.nvim")
	use("nvim-tree/nvim-web-devicons")

	-- install without yarn or npm
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
		},
	})
	use("terrortylor/nvim-comment")
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup()
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
end

-- lsp config
capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = {
	"markdown",
	"plaintext",
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = { "documentation", "detail", "additionalTextEdits" },
}

-- tree-sitter settings
nvim_lsp = require("lspconfig")
servers = { "gopls", "clangd" }
ts_settings = function(client)
	client.resolved_capabilities.document_formatting = true
	ts_settings(client)
end
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		ts_settings = ts_settings,
		flags = { debounce_text_changes = 500 },
	})
end

-- telescope settings
actions = require("telescope.actions")
require("telescope").setup({ pickers = { buffers = { sort_lastused = true } } })

-- completion settings
local cmp = require("cmp")
cmp.setup({
	completion = { keyword_length = 2 },
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	},
	sources = { { name = "nvim_lsp" }, { name = "path" }, { name = "buffer" } },
})

-- conform formatting settings
require("conform").setup({
	formatters_by_ft = {
		go = { "goimports", "gofmt" },
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		rust = { "rustfmt", lsp_format = "fallback" },
		-- Conform will run the first available formatter
		javascript = { "prettierd", "prettier", stop_after_first = true },
	},
})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- keymaps
default_opts = { noremap = true, silent = true }
map("n", "<C-n>", ":NvimTreeToggle<CR>", default_opts) -- open/close
map("n", "<leader>r", ":NvimTreeRefresh<CR>", default_opts) -- refresh
map("n", "<leader>n", ":NvimTreeFindFile<CR>", default_opts) -- search file

map("n", "<leader>w", ":w<CR>", default_opts) -- refresh
map("n", "<leader>f", ":Telescope find_files<CR>", default_opts) -- refresh
map("n", "<leader>s", ":Telescope live_grep<CR>", default_opts) -- refresh
map("n", ";", ":Telescope buffers<CR>", default_opts) -- refresh
map("n", "g?", "<cmd>lua vim.diagnostic.open_float()<CR>", default_opts)
map("n", "<leader>p", ":MarkdownPreview<CR>", default_opts) -- refresh
map("n", "<leader>ps", ":MarkdownPreviewStop<CR>", default_opts) -- refresh

require("nvim-tree").setup()
require("nvim_comment").setup()
require("gitsigns").setup()

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"lua",
		"rust",
		"go",
		"python",
		"json",
		"javascript",
	},
	sync_install = false,
	auto_install = false,
	highlight = {
		enable = true,
		-- disable slow treesitter highlight for large files
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		additional_vim_regex_highlighting = false,
	},
})
