return {
  -- Set colorscheme to use
  colorscheme = "onenord",

  vim.opt.clipboard:append "unnamedplus",

    options = {
    opt = {
      relativenumber = false,
      signcolumn = "auto",
      spell = true,
    },
  },

  plugins = {
    {
      "rmehri01/onenord.nvim",
      as = "onenord",
      config = function()
        require('onenord').setup({
          theme = "light", -- "dark" or "light".
        })
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
        require('marks').setup({
          mappings = {
            set_next = "m,",
            next = "m]",
            preview = "m:",
            set_bookmark0 = "m0",
            prev = false -- pass false to disable only this default mapping
          }
        })
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
      }
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


}
}
