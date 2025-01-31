-- ✅ Настраиваем Lazy.nvim (менеджер плагинов)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
'navarasu/onedark.nvim',
"folke/tokyonight.nvim",

  -- 🚀 LSP (Language Server Protocol)
  "neovim/nvim-lspconfig",

  -- ⚡️ Автодополнение (nvim-cmp)
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",

  -- 🖌 Подсветка синтаксиса (Treesitter)
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- 📂 Дерево проекта (NvimTree)
  "nvim-tree/nvim-tree.lua",

  -- 💻 Терминал внутри Neovim
  "akinsho/toggleterm.nvim",

  -- 🔍 Поиск и навигация
  "nvim-telescope/telescope.nvim",

  -- 🧠 Нейросети (Copilot, Codeium)
{ 'codota/tabnine-nvim', build = "./dl_binaries.sh" },
"ray-x/telescope-ast-grep.nvim",
"xavierchow/nvim-sshfs",
"TimUntersberger/neogit",  -- Git UI как в LazyGit
  "nvim-lua/plenary.nvim",
})

-- ✅ Настраиваем LSP-серверы для Python, Go, JSON, YAML, HTML
local lspconfig = require("lspconfig")
local servers = { "pyright", "gopls", "jsonls", "yamlls", "html" }
for _, server in ipairs(servers) do
    lspconfig[server].setup({})
end

require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
})

-- ✅ Настраиваем автодополнение (nvim-cmp)
local cmp = require("cmp")
cmp.setup({
  completion = {
    autocomplete = false, -- ОТКЛЮЧАЕМ автоматическое появление
  },
  mapping = {
    ["<C-u>"] = cmp.mapping.complete(), -- Вручную вызвать автодополнение
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Принять подсказку
    ["<Tab>"] = cmp.mapping.select_next_item(), -- Вперёд по списку
    ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Назад по списку
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
})
-- ✅ Настраиваем NvimTree (дерево проекта)
require("nvim-tree").setup()
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true })

-- ✅ Настраиваем ToggleTerm (терминал)
require("toggleterm").setup({
  open_mapping = [[<C-t>]],
  direction = "float",
})



require('tabnine').setup({
  disable_auto_comment=true,
  accept_keymap="<Tab>",
  dismiss_keymap = "<C-]>",
  debounce_ms = 800,
  suggestion_color = {gui = "#808080", cterm = 244},
  exclude_filetypes = {"TelescopePrompt", "NvimTree"},
  log_file_path = nil, -- absolute path to Tabnine log file
  ignore_certificate_errors = false,
})

-- require("gruvbox").setup({
--   transparent_mode = false, -- Отключаем прозрачность (может влиять на цвета)
-- })
-- vim.cmd("colorscheme gruvbox")
require("telescope").load_extension("ast_grep")
-- ✅ Горячие клавиши
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", { noremap = true })
