local function fzf()
  vim.keymap.set('n', '<Leader>o', '<Cmd>call fzf#vim#files("", fzf#vim#with_preview(), 0)<CR>')
  vim.keymap.set('n', '<Leader>b', '<Cmd>call fzf#vim#buffers("", fzf#vim#with_preview({ "placeholder": "{1}" }), 0)<CR>')
  vim.keymap.set('n', '<Leader>F',
    'fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -- ".shellescape(""), 1, fzf#vim#with_preview(), 0)<CR>')
end

local function ddc()
  local capabilities = require("ddc_source_lsp").make_client_capabilities()
  require("lspconfig").denols.setup({
    capabilities = capabilities,
  })

  vim.fn["ddc#custom#patch_global"]('ui', 'native')
  vim.fn["ddc#custom#patch_global"]('sources', { 'lsp', 'around' })
  vim.fn["ddc#custom#patch_global"]('sourceOptions', {
    _ = {
      matchers = { 'matcher_fuzzy' },
      sorters = { 'sorter_rank' },
      converters = { 'converter_fuzzy' },
    },
    around = { mark = '[Around]', },
    lsp = { mark = '[LSP]', forceCompletionPattern = '.w*|:w*|->w*', },
  })
  vim.fn["ddc#custom#patch_global"]('sourceParams', {
    lsp = {
      enableResolveItem = true,
      enableAdditionalTextEdit = true,
    },
  })

  vim.fn["ddc#enable"]()
end

local function get_ddu_cr_action()
  local item = vim.fn['ddu#ui#get_item']()

  -- itemがnilでないことを確認
  if item ~= nil and item['isTree'] ~= nil then
    if item['isTree'] then
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<Cmd>call ddu#ui#do_action('expandItem', { 'mode': 'toggle' })<CR>", true, true,
          true), 'n', true)
      return ""
    end
  end

  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<Cmd>call ddu#ui#do_action('itemAction', { 'name': 'open' })<CR>", true, true, true),
    'n', true)
  return ""
end

local function ddu()
  vim.fn['ddu#custom#patch_global']({
    ui = 'filer',
    sources = {
      {
        name = 'file',
        params = {},
      }
    },
    sourceOptions = {
      _ = {
        columns = { 'rich_filename' },
      },
    },
    kindOptions = {
      file = {
        defaultAction = 'open',
        actions = {
          custom_create_file = function(items, params, helper)
            print("custom action")
          end,
        },
      }
    },
    uiParams = {
      filer = {
        winWidth = 40,
        split = 'vertical',
        splitDirection = 'topleft',
        sort = 'filename',
        sortTreesFirst = true,
      },
    },
    columnParams = {
      rich_filename = {
        sort = 'filename',
        sortTreesFirst = true,
      },
    },
  })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'ddu-filer',
    callback = function()
      vim.api.nvim_buf_set_keymap(0, 'n', '<CR>', "v:lua.require'plugin_settings'.get_ddu_cr_action()",
        { noremap = true, silent = true, expr = true })
      vim.keymap.set('n', '<Esc>', "<Cmd>call ddu#ui#do_action('quit')<CR>", { silent = true, buffer = true })
      vim.keymap.set('n', 'q', "<Cmd>call ddu#ui#do_action('quit')<CR>", { silent = true, buffer = true })
      vim.keymap.set('n', '..',
        "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'narrow', 'params': {'path': '..'}})<CR>",
        { silent = true, buffer = true })
      vim.keymap.set('n', 'o', "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'narrow', })<CR>",
        { silent = true, buffer = true })
      vim.keymap.set('n', 'l', "<Cmd>call ddu#ui#do_action('expandItem')<CR>", { silent = true, buffer = true })
      vim.keymap.set('n', 'h', "<Cmd>call ddu#ui#do_action('collapseItem')<CR>", { silent = true, buffer = true })
      vim.keymap.set('n', 'c', "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'copy'})<CR>",
        { silent = true, buffer = true })
      vim.keymap.set('n', 'p', "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'paste'})<CR>",
        { silent = true, buffer = true })
      vim.keymap.set('n', 'd', "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'delete'})<CR>",
        { silent = true, buffer = true })
      vim.keymap.set('n', 'r', "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'rename'})<CR>",
        { silent = true, buffer = true })
      vim.keymap.set('n', 'mv', "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'move'})<CR>",
        { silent = true, buffer = true })
      vim.keymap.set('n', 't', "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'newFile'})<CR>",
        { silent = true, buffer = true })
      -- vim.keymap.set('n', 'n', "<Cmd>call ddu#ui#do_action('custom_create_file', {'name': 'test'})<CR>", {silent = true, buffer = true})
      vim.keymap.set('n', 'mk', "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'newDirectory'})<CR>",
        { silent = true, buffer = true })
      vim.keymap.set('n', 'yy', "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'yank'})<CR>",
        { silent = true, buffer = true })
      vim.keymap.set('n', '<C-e>', "<Cmd>call ddu#ui#do_action('quit')<CR>", { silent = true, buffer = true })
    end
  })

  vim.keymap.set('n', '<C-e>', "<Cmd>call ddu#start({'name': 'filer','resume': v:true,})<CR>")
  vim.keymap.set('n', '<Leader>e',
    "<Cmd>call ddu#start({'name': 'filer','searchPath': expand('%:p'),'resume': v:true,})<CR>")
end

local function lexima()
  vim.g.lexima_enable_space_rules = false
  vim.fn['lexima#add_rule']({
    char = '（',
    input_after = '）',
  })
  vim.fn['lexima#add_rule']({
    char = '<BS>',
    at = "（%#）",
    delete = 1,
  })
end

local function lualine()
  require('lualine').setup {
    options = {
      theme = 'gruvbox',
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        {
          'filename',
          file_status = true,     -- Displays file status (readonly status, modified status)
          newfile_status = false, -- Display new file status (new file means no write after created)
          path = 0,               -- 0: Just the filename
          -- 1: Relative path
          -- 2: Absolute path
          -- 3: Absolute path, with tilde as the home directory
          -- 4: Filename and parent dir, with tilde as the home directory
          shorting_target = 40, -- Shortens path to leave 40 spaces in the window
          -- for other components. (terrible name, any suggestions?)
          symbols = {
            modified = ' ', -- Text to show when the file is modified.
            readonly = ' ', -- Text to show when the file is non-modifiable or readonly.
            unnamed = '[No Name]', -- Text to show for unnamed buffers.
            newfile = '[New]', -- Text to show for newly created file before first write
          }
        }
      },
      lualine_c = {
        'branch',
        'diff',
        {
          'diagnostics',
          symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
        }
      },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    },
    -- inactive_sections = {
    --   lualine_a = {},
    --   lualine_b = {},
    --   lualine_c = {'filename'},
    --   lualine_x = {'location'},
    --   lualine_y = {},
    --   lualine_z = {}
    -- },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  }
end

local function tree()
  local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    -- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
    vim.keymap.set('n', 'n', api.fs.create, opts('Create File Or Directory'))
  end


  require("nvim-tree").setup({
    on_attach = my_on_attach,
    sort = {
      sorter = "name",
      folders_first = true,
    },
    view = {
      width = 30,
    },
    renderer = {
      highlight_git = true,
      highlight_opened_files = "none",
      group_empty = true,
      indent_markers = {
        enable = true,
        inline_arrows = false,
        icons = {
          corner = "└",
          edge = "│",
          item = "├",
          bottom = "─",
          none = " ",
        },
      },
      icons = {
        web_devicons = {
          file = {
            enable = true,
            color = true,
          },
          folder = {
            enable = false,
            color = true,
          },
        },
        show = {
          folder_arrow = false,
        },
        glyphs = {
          default = "",
          symlink = "",
          bookmark = "󰆤",
          modified = "●",
          folder = {
            arrow_closed = "",
            arrow_open = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
          git = {
            unstaged = "",
            staged = "",
            unmerged = "",
            renamed = "",
            untracked = "",
            deleted = "",
            ignored = "",
          },
        },

      },
    },
    filters = {
      dotfiles = true,
    },
  })

  require('keymap').tree()
end

M = {
  fzf = fzf,
  ddc = ddc,
  ddu = ddu,
  lexima = lexima,
  lualine = lualine,
  tree = tree,
  get_ddu_cr_action = get_ddu_cr_action,
}

return M
