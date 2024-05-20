vim.scriptencoding = "utf-8"
vim.g.mapleader = " "

require('options')

-- プラグイン周り
vim.opt['compatible'] = false -- この設定で正しいか不明
local dein_dir = vim.fn['expand']('~/.config/nvim/dein')
local dein_repo_dir = dein_dir .. '/repos/github.com/Shougo/dein.vim'
if not vim.o.runtimepath:match('/dein.vim') then
    if vim.fn['isdirectory'](dein_repo_dir) == 0 then
        os.execute('git clone https://github.com/Shougo/dein.vim ' .. dein_repo_dir)
    end
    vim.o.runtimepath = vim.o.runtimepath .. ',' .. dein_repo_dir
end

if vim.fn['dein#load_state'](dein_dir) == 1 then
    vim.fn['dein#begin'](dein_dir)
    local plugin_path = vim.fn['expand']('~/.config/nvim/plugins/')

    vim.fn['dein#add']('morhetz/gruvbox')
    vim.fn['dein#load_toml'](plugin_path .. 'init.toml', {lazy = 0})
    vim.fn['dein#load_toml'](plugin_path .. 'lazy.toml', {lazy = 1})

    vim.fn['dein#end']()
    vim.fn['dein#save_state']()
end
if vim.fn['dein#check_install']() == 1 then
    vim.fn['dein#install']()
end
vim.cmd('filetype plugin indent on')
vim.cmd('syntax enable')


require('keymap')

require('colorscheme')
