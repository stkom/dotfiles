-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.foldlevelstart = 20
vim.opt.guicursor = ""
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.mouse = ""
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.updatetime = 1000
vim.opt.wildmode = "list:longest,full"

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 4

-- Key mappings
local opts = { noremap = true, silent = true }
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    if opts.desc then
      opts.desc = "keymaps.lua: " .. opts.desc
    end
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

map("i", "jj", "<esc>")
map("n", "<leader>pv", ":Ex<cr>")
map("n", "<leader>y", "\"+y")
map("v", "<leader>y", "\"+y")
map("n", "<leader>Y", "\"+Y")
map("v", "J", ":m '>+1<cr>gv=gv")
map("v", "K", ":m '>-2<cr>gv=gv")
map("n", "J", "mzJ`z")

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { "neovim/nvim-lspconfig" },
    { "rose-pine/neovim", name = "rose-pine" },
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },
  },
})

require("rose-pine").setup({
  styles = {
    --    transparency = true
  },
})

require("lualine").setup({
  --  options = { theme = "solarized_dark" },
})

vim.cmd.colorscheme("rose-pine")

-- LSP
vim.lsp.config("gopls", {})
vim.lsp.enable("gopls")
