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
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
