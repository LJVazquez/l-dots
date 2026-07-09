--configs-----------------------------------------------------------------------------
-- 1. CONFIGURACIÓN BASE & GLOBAL (Debe ir al principio)
-------------------------------------------------------------------------------
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Optimización de portapapeles (Carga asíncrona para evitar lag al arrancar)
vim.schedule(function()
	vim.opt.clipboard = 'unnamedplus'
end)

-------------------------------------------------------------------------------
-- 2. OPCIONES DEL EDITOR (Vim Options)
-------------------------------------------------------------------------------
local opt = vim.opt

opt.confirm = true     -- Confirmar antes de salir si hay cambios sin guardar
opt.number = true      -- Mostrar números de línea
opt.signcolumn = 'yes' -- Mantener la columna de signos fija para evitar saltos visuales

-- Búsqueda inteligente
opt.ignorecase = true -- Ignorar mayúsculas/minúsculas al buscar
opt.smartcase = true  -- No ignorarlas si se usa una mayúscula explícita
opt.hlsearch = true   -- Mantener el resaltado de búsqueda

-- Folds basados en Treesitter
opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99

-- Needed for bufferline
vim.opt.termguicolors = true

-------------------------------------------------------------------------------
-- 3. AUTOCOMANDOS NATIVOS
-------------------------------------------------------------------------------
local group_id = vim.api.nvim_create_augroup('CustomAutocommands', { clear = true })

-- Resaltar texto al copiar (Yank)
vim.api.nvim_create_autocmd('TextYankPost', {
	group = group_id,
	callback = function()
		vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 150 })
	end,
})

-------------------------------------------------------------------------------
-- 4. GESTIÓN DE PAQUETES (Native Package Management)
-------------------------------------------------------------------------------
vim.pack.add({
	-- Core / Herramientas de búsqueda y sintaxis
	'https://github.com/ibhagwan/fzf-lua',
	'https://github.com/nvim-treesitter/nvim-treesitter',
	'https://github.com/neovim/nvim-lspconfig',
	{ src = 'https://github.com/saghen/blink.cmp',           version = vim.version.range('1.x') },
	'https://github.com/nvim-mini/mini.pairs',
	'https://github.com/nvim-mini/mini.clue',
	'https://github.com/github/copilot.vim',

	-- UI & Estética
	{ src = 'https://github.com/catppuccin/nvim',            name = 'catppuccin' },
	{ src = 'https://github.com/nvim-tree/nvim-web-devicons' },
	{ src = 'https://github.com/nvim-tree/nvim-tree.lua' },
	'https://github.com/nvimdev/dashboard-nvim',
	{ src = 'https://github.com/akinsho/bufferline.nvim', tag = "1.*", requires = 'nvim-tree/nvim-web-devicons' }


})

-------------------------------------------------------------------------------
-- 5. CONFIGURACIÓN DE PLUGINS (UI & Herramientas)
-------------------------------------------------------------------------------

-- Colorscheme
vim.cmd.colorscheme 'catppuccin'

-- FZF Lua
local fzf = require('fzf-lua')
fzf.setup({ keymap = {} })

vim.keymap.set('n', '<leader>p', fzf.files, { desc = 'FZF: Find files' })
vim.keymap.set('n', '<leader>/', fzf.live_grep, { desc = 'FZF: Live grep' })

-- Treesitter Configuration
require('nvim-treesitter').setup({
	ensure_installed = { 'lua', 'typescript', 'javascript', 'java', 'markdown', 'yaml' },
	highlight = { enable = true },
})

-- NvimTree
local nvim_tree = require('nvim-tree')
vim.keymap.set('n', '<leader>b', '<cmd>NvimTreeToggle<CR>', { desc = 'Tree: Toggle file explorer' })

nvim_tree.setup({
	view = { width = 30, side = 'left' },
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = { enable = true, update_root = true },
	renderer = {
		icons = {
			show = { file = true, folder = true, folder_arrow = true, git = true },
		},
	},
	actions = { open_file = { quit_on_open = false } },
	on_attach = function(bufnr)
		local api = require('nvim-tree.api')
		local function opts(desc)
			return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true }
		end

		api.config.mappings.default_on_attach(bufnr)
		vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open / Toggle folder'))
		vim.keymap.set('n', 'n', api.fs.create, opts('New file'))
		vim.keymap.set('n', '<Del>', api.fs.remove, opts('Delete'))
		vim.keymap.set('n', '<BS>', api.fs.remove, opts('Delete (Mac fallback)'))
		vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
	end,
})

-- Mini utils
require("mini.pairs").setup()
require("mini.clue").setup({
	triggers = {
		{ mode = { 'n', 'x' }, keys = '<Leader>' } },
})

-- Dashboard
require('dashboard').setup({
	theme = 'hyper',
	config = {
		header = {
			[[                                                ]],
			[[            /|_/|                               ]],
			[[           / o o\                               ]],
			[[          (   "   )                             ]],
			[[           \~(*)~/                              ]],
			[[            // \\                               ]],
			[[           ((   ))                              ]],
			[[           GOATVIM 🐐                           ]],
			[[                                                ]],
		},
		footer = { '', '🐐 that\'s why he is the GOAT' },

		project = {
			action = 'FzfLua files cwd='
		},

		shortcut = {
			{ desc = '󰈞 Find File', group = 'DashboardShortCut', action = 'FzfLua files', key = 'f' },
			{ desc = '󰊄 Recent Files', group = 'DashboardShortCut', action = 'FzfLua oldfiles', key = 'r' },
			{ desc = '󰱼 Live Grep', group = 'DashboardShortCut', action = 'FzfLua live_grep', key = 'g' },
		},
	},
})

-------------------------------------------------------------------------------
-- 6. SERVIDOR DE LENGUAJES (LSP) & AUTOCOMPLETADO
-------------------------------------------------------------------------------

-- Mappings globales de LSP y UI
vim.keymap.set('n', '<leader>kl', 'za', { desc = 'LSP: Toggle fold' })
vim.keymap.set('n', '<leader>kf', function() vim.lsp.buf.format({ async = true }) end, { desc = 'LSP: Format file' })

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- Blink.cmp (Autocompletado moderno escrito en Rust)
require('blink.cmp').setup({
	keymap = {
		preset = 'enter',
		['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
		['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
	},
	appearance = { nerd_font_variant = 'mono' },
	completion = {
		ghost_text = { enabled = true },
		documentation = { auto_show = true, auto_show_delay_ms = 200 },
		accept = { auto_brackets = { enabled = true } },
		menu = { draw = { columns = { { 'kind_icon' }, { 'label', 'label_description' } } } },
	},
	signature = { enabled = true },
	fuzzy = { implementation = 'prefer_rust' },
})

-- Configuración declarativa nativa (Neovim 0.11+)
local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config('lua_ls', {
	capabilities = capabilities,
	settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
})

vim.lsp.config('ts_ls', {
	capabilities = capabilities,
	settings = { typescript = { preferences = { importModuleSpecifierPreference = 'relative' } } },
})

vim.lsp.config("jdtls", {
  capabilities = capabilities,
})

-- Activación en lote de los servidores de lenguaje
vim.lsp.enable({
	'lua_ls',
	'jdtls',
	'ts_ls',
	'eslint',
	'marksman',
	'yamlls',
})

-- Bufferline (tabs)
require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",

		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
	},
})

vim.keymap.set('n', '<leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>')
vim.keymap.set('n', '<leader>2', '<Cmd>BufferLineGoToBuffer 2<CR>')
vim.keymap.set('n', '<leader>3', '<Cmd>BufferLineGoToBuffer 3<CR>')
vim.keymap.set('n', '<leader>4', '<Cmd>BufferLineGoToBuffer 4<CR>')
vim.keymap.set('n', '<leader>5', '<Cmd>BufferLineGoToBuffer 5<CR>')
vim.keymap.set('n', '<leader>6', '<Cmd>BufferLineGoToBuffer 6<CR>')

vim.keymap.set('n', '<leader>x', '<Cmd>bdelete<CR>', {
	desc = 'Close current buffer',
})

vim.keymap.set('n', '<leader>r', '<Cmd>checktime<CR>', { desc = 'Reload buffer from disk' })
