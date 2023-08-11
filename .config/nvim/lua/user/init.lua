return {
  -- Set colorscheme to use
  colorscheme = "onenord",

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
