vim.cmd("colorscheme gruvbox")

if vim.g.colors_name == "gruvbox" then
    vim.api.nvim_set_hl(0, "GitGutterAdd", {link = "GruvboxGreen"})
end
