local options = {
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
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
