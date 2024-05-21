local options = {
  syntax = "on",
  number = true,
  relativenumber = false,
  showcmd = true,
  cursorline = true,
  numberwidth = 6,
  autoindent = true,
  hlsearch = true,
  wrapscan = true,
  ignorecase = true,
  smartcase = true,
  clipboard = "unnamedplus",
  backup = false,
  writebackup = false,
  swapfile = false,
  expandtab = true,
  shiftwidth = 4,
  tabstop = 4,
  backspace = "indent,eol,start",
  list = true,
  listchars = "tab:>.,trail:_,extends:>,precedes:<,nbsp:%,space:.",
  wildmenu = true,
  laststatus = 2,
  splitbelow = true,
  splitright = true,
  termguicolors = true,
  signcolumn = "yes:1",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
-- vim.cmd('let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"')
-- vim.cmd('let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"')
