return {
  -- Set colorscheme to use
  colorscheme = "catppuccin",

  vim.opt.clipboard:append "unnamedplus",

  options = {
    opt = {
      relativenumber = false,
      signcolumn = "auto",
      spell = true,
      background = "light",
    },
  },

  plugins = {
    {
      "mg979/vim-visual-multi",
      lazy = true,
      event = "BufReadPost",
      setup = function() require "custom.configs.visual-multi" end,
    },

    -- colorscheme catppuccin
    {
      "catppuccin/nvim",
      priority = 1000,
      name = "catppuccin",
      opts = {
        integrations = {
          aerial = true,
          alpha = true,
          cmp = true,
          dashboard = true,
          flash = true,
          gitsigns = true,
          headlines = true,
          illuminate = true,
          indent_blankline = { enabled = true },
          leap = true,
          lsp_trouble = true,
          mason = true,
          markdown = true,
          mini = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          navic = { enabled = true, custom_bg = "lualine" },
          neotest = true,
          neotree = true,
          noice = true,
          notify = true,
          semantic_tokens = true,
          telescope = true,
          treesitter = true,
          treesitter_context = true,
          which_key = true,
        },
      },
    },

    -- colorscheme gruvbox
    {
      "sainnhe/gruvbox-material",
      priority = 1000,
      config = function()
        vim.o.background = "light"
        vim.g.gruvbox_material_background = "hard"
        vim.g.gruvbox_material_foreground = "original"
        vim.g.gruvbox_material_enable_bold = "1"
        vim.g.gruvbox_material_enable_italic = "0"

        vim.cmd.colorscheme "gruvbox-material"
      end,
    },

    {
      "mattn/emmet-vim",
      ft = { "html", "css", "javascript", "typescript", "php", "twig" },
    },

    {
      "chentoast/marks.nvim",
      as = "marks",
      config = function()
        require("marks").setup {
          mappings = {
            set_next = "m,",
            next = "m]",
            preview = "m:",
            set_bookmark0 = "m0",
            prev = false, -- pass false to disable only this default mapping
          },
        }
      end,
    },

    {
      "nvim-neo-tree/neo-tree.nvim",
      opts = {
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
          },
        },
      },
    },

    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = {
          "bash",
          "lua",
          "html",
          "css",
          "javascript",
          "typescript",
          "php",
          "python",
          "twig",
        },
      },
    },

    lsp = {
      servers = {
        "bashls",
        "cssls",
        "emmetls",
        "eslint",
        "html",
        "jsonls",
        "jsonnet_ls",
        "pylsp",
        "tsserver",
        "intelephense",
        "twig",
        "yamlls",
        "dockerls",
      },

      formatting = {
        disabled = {
          -- use null-ls' gofumpt/goimports instead
          -- https://github.com/golang/tools/pull/410
          -- use null-ls' prettier instead
          "tsserver",
        },
        format_on_save = {
          enabled = true,
          allow_filetypes = {
            "jsonnet",
            "lua",
          },
        },
      },
    },

    {
      "goolord/alpha-nvim",
      opts = function(_, opts) -- override the options using lazy.nvim
        opts.section.header.val = { -- change the header section value
          "                                                                       ",
          "                                                                     ",
          "       ████ ██████           █████      ██                     ",
          "      ███████████             █████                             ",
          "      █████████ ███████████████████ ███   ███████████   ",
          "     █████████  ███    █████████████ █████ ██████████████   ",
          "    █████████ ██████████ █████████ █████ █████ ████ █████   ",
          "  ███████████ ███    ███ █████████ █████ █████ ████ █████  ",
          " ██████  █████████████████████ ████ █████ █████ ████ ██████ ",
          "                                                                       ",
        }
      end,
    },
  },
}
