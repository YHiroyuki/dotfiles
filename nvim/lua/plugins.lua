return {
  { -- カラースキーマ
    'morhetz/gruvbox',
    config = function()
      vim.cmd("colorscheme gruvbox")
      local highlight = vim.api.nvim_set_hl
      highlight(0, "CursorLine", { underline = true })
      highlight(0, "SignColumn", { bg = "NONE" })
      highlight(0, "GitGutterAdd", { link = "GruvboxGreen" })
      highlight(0, "GitGutterChange", { link = "GruvboxAqua" })
      highlight(0, "GitGutterDelete", { link = "GruvboxRed" })
      highlight(0, "GitGutterChangeDelete", { link = "GruvboxAqua" })
      highlight(0, "FloatBorder", { link = "GruvboxAqua" })
      highlight(0, "Defx_git_Modified", { link = "GruvboxAqua" })
      highlight(0, "Defx_git_Untracked", { link = "GruvboxGreen" })
      highlight(0, "GitSignsAdd", { bg = "#204b2e" })
      highlight(0, "GitSignsChange", { bg = "#378246" })
      highlight(0, "GitSignsDelete", { bg = "#823746" })
    end
  },
  -- ステータスライン
  {
    'nvim-lualine/lualine.nvim',
    config = function()
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
  },
  -- indent
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
      local highlight = {
        -- "RainbowRed",
        -- "RainbowYellow",
        "RainbowBlue",
        -- "RainbowOrange",
        "RainbowGreen",
        -- "RainbowViolet",
        -- "RainbowCyan",
      }

      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#673d40" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#673d66" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#3d4167" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#3d6765" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#47673d" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#67653d" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#67503d" })
      end)

      require("ibl").setup { indent = { highlight = highlight } }
    end
  },
  -- nvimのwebアイコン
  'nvim-tree/nvim-web-devicons',
  {
    'github/copilot.vim',
    event = 'InsertEnter',
    config = function()
      -- Copilotのタブマッピングを無効にする
      vim.g.copilot_no_tab_map = true
      -- 挿入モードで<C-J>をcopilot#Accept()にマッピングする
      vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept()', { expr = true, silent = true, script = true })
    end
  },
  { -- file explorer
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local function my_on_attach(bufnr)
        local api = require "nvim-tree.api"

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        -- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
        vim.keymap.set('n', 't', api.fs.create, opts('Create File Or Directory'))
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

      vim.keymap.set('n', '<C-e>', "<Cmd>NvimTreeToggle<CR>")
      vim.keymap.set('n', '<Leader>e', "<Cmd>NvimTreeFindFile<CR>")
    end
  },
  -- fuzzy finder
  'junegunn/fzf',
  {
    'junegunn/fzf.vim',
    config = function()
      -- FZFのデフォルトオプションを設定
      vim.env.FZF_DEFAULT_OPTS = "--layout=reverse"
      -- FZFのデフォルトコマンドを設定
      vim.env.FZF_DEFAULT_COMMAND = "rg --files --hidden --sort path --glob '!.git/**'"
      -- FZFのレイアウトを設定
      vim.g.fzf_layout = {
        up = '~90%',
        window = {
          width = 0.8,
          height = 0.8,
          yoffset = 0.5,
          xoffset = 0.5,
          border = 'sharp'
        }
      }
      -- ランタイムパスにFZFのリポジトリを追加
      vim.cmd('set rtp+=$HOME/.local/share/nvim/lazy/fzf')
      -- FZFのカラースキームを設定
      vim.g.fzf_colors = {
        fg      = { 'fg', 'Normal' },
        bg      = { 'bg', 'Normal' },
        hl      = { 'fg', 'Define' },
        ['fg+'] = { 'fg', 'Type', 'CursorColumn', 'Normal' },
        ['bg+'] = { 'bg', 'CursorLine', 'CursorColumn' },
        ['hl+'] = { 'fg', 'Define' },
        info    = { 'fg', 'Identifier' },
        border  = { 'fg', 'Define' },
        prompt  = { 'fg', 'Identifier' },
        pointer = { 'fg', 'Type' },
        marker  = { 'fg', 'Keyword' },
        spinner = { 'fg', 'Label' },
        header  = { 'fg', 'Comment' }
      }

      vim.keymap.set('n', '<Leader>o', '<Cmd>call fzf#vim#files("", fzf#vim#with_preview(), 0)<CR>')
      vim.keymap.set('n', '<Leader>b',
        '<Cmd>call fzf#vim#buffers("", fzf#vim#with_preview({ "placeholder": "{1}" }), 0)<CR>')
      vim.keymap.set('n', '<Leader>F',
        'fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -- ".shellescape(""), 1, fzf#vim#with_preview(), 0)<CR>')
    end

  },
  'kannokanno/previm',
  'tyru/open-browser.vim',
  -- 整形
  'kg8m/vim-simple-align',
  -- 単語検索
  {
    'mileszs/ack.vim',
    config = function()
      -- wildignoreの設定を追加
      vim.opt.wildignore:append { "*.a", "vendor/**" }

      -- ackprgの設定
      vim.g.ackprg = 'ag --nogroup --nocolor --column'

      -- コマンドの作成
      vim.cmd [[
        command! Ack Ack!
        command! AckFromSearch AckFromSearch!
      ]]
    end
  },
  -- eidtorconfig
  'editorconfig/editorconfig-vim',
  -- lsp
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      -- client, bufnrを引数に取るon_attach関数を定義
      local on_attach = function(client, _)
        client.server_capabilities.documentFormattingProvider = false
        local set = vim.keymap.set
        set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
        set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
        set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
        set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
        set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
        set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
        set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
        set('n', 'gx', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
        set('n', 'g[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
        set('n', 'g]', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
        set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
      end
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })

      require("mason").setup()
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities, --cmpを連携⇐ココ！
          }
        end
      }
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signcolumn = false,
        numhl = true,
        linehl = false,
        word_diff = false,
      }
    end

  },
  -- 閉じカッコ
  {
    'cohama/lexima.vim',
    config = function()
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
  },
  -- コマンド
  'MunifTanjim/nui.nvim',
  {
    'folke/noice.nvim',
    config = function()
      local status, noice = pcall(require, "noice")
      if not status then
        return
      end

      noice.setup({
        -- lsp = {
        --   -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        --   override = {
        --     ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        --     ["vim.lsp.util.stylize_markdown"] = true,
        --     ["cmp.entry.get_documentation"] = true,
        --   },
        -- },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = false,        -- use a classic bottom cmdline for search
          command_palette = false,      -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
      })
    end
  },
  -- 補完
  {
    'hrsh7th/nvim-cmp',       --補完エンジン本体
    dependencies = {
      'hrsh7th/cmp-nvim-lsp', --LSPを補完ソースに
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-buffer',   --bufferを補完ソースに
      'hrsh7th/cmp-path',     --pathを補完ソースに
      'hrsh7th/vim-vsnip',    --スニペットエンジン
      'hrsh7th/cmp-vsnip',    --スニペットを補完ソースに
      'onsails/lspkind.nvim', --補完欄にアイコンを表示
    },
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = function()
      -- Lspkindのrequire
      local lspkind = require 'lspkind'
      --補完関係の設定
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        sources = {
          { name = "nvim_lsp" }, --ソース類を設定
          { name = 'vsnip' },    -- For vsnip users.
          { name = "buffer" },
          { name = "path" },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(), --Ctrl+pで補完欄を一つ上に移動
          ["<C-n>"] = cmp.mapping.select_next_item(), --Ctrl+nで補完欄を一つ下に移動
          ['<C-l>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }), --Ctrl+yで補完を選択確定
        }),
        experimental = {
          ghost_text = false,
        },
        -- Lspkind(アイコン)を設定
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol',       -- show only symbol annotations
            maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          })
        }
      })

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' } --ソース類を設定
        }
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "path" }, --ソース類を設定
          { name = 'cmdline' },
        },
      })
    end
  },
  {
    'brenoprata10/nvim-highlight-colors',
    config = function()
      vim.opt.termguicolors = true
      local nvim_highlight_colors = require('nvim-highlight-colors')

      nvim_highlight_colors.setup({
        render = 'virtual',
        virtual_symbol = '●',
      })
      nvim_highlight_colors.turnOff()
    end
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  }
}
