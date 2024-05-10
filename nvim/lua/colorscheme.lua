vim.cmd("colorscheme gruvbox")

if vim.g.colors_name == "gruvbox" then
    vim.api.nvim_set_hl(0, "CursorLine", {underline = true})
    vim.api.nvim_set_hl(0, "SignColumn", {bg = "NONE"})
    vim.api.nvim_set_hl(0, "GitGutterAdd", {link = "GruvboxGreen"})
    vim.api.nvim_set_hl(0, "GitGutterChange", {link = "GruvboxAqua"})
    vim.api.nvim_set_hl(0, "GitGutterDelete", {link = "GruvboxRed"})
    vim.api.nvim_set_hl(0, "GitGutterChangeDelete", {link = "GruvboxAqua"})
    vim.api.nvim_set_hl(0, "FloatBorder", {link = "GruvboxAqua"})
    vim.api.nvim_set_hl(0, "Defx_git_Modified", {link = "GruvboxAqua"})
    vim.api.nvim_set_hl(0, "Defx_git_Untracked", {link = "GruvboxGreen"})
    vim.api.nvim_set_hl(0, "GitSignsAdd", {bg = "#204b2e"})
    vim.api.nvim_set_hl(0, "GitSignsChange", {bg = "#378246"})
    vim.api.nvim_set_hl(0, "GitSignsDelete", {bg = "#823746"})
end
