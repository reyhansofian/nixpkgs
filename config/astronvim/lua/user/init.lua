return {
    -- colorscheme = "monokai-pro-nvim",
  
    options = {
      opt = {
        cmdheight = 1, -- Always display cmd line
        -- guicursor = "", -- Disable Nvim GUI cursor
        mouse = "a", -- Disable mouse support
        number = true, -- Hide numberline
        relativenumber = false, -- Hide relative numberline 
        signcolumn = "auto", -- Show sign column when used only
        spell = true, -- Enable spell checking
      },
      g = {
        cmp_enabled = true,
        lsp_signature_debug = true,
        icons_enabled = true,
      },
    },
  
    -- highlights = {
    --   -- Fix Gruvbox highlight groups
    --   -- https://github.com/ellisonleao/gruvbox.nvim/blob/main/lua/gruvbox/palette.lua
    --   gruvbox = {
    --     -- Hard-code reversed colors 
    --     -- https://github.com/AstroNvim/AstroNvim/issues/1147
    --     StatusLine = { fg = "#ebdbb2", bg = "#504945" }, -- colors.light1 / colors.dark2
    --   },
    -- },
  
    plugins = {
      heirline = function(config)
        config[1] = vim.tbl_deep_extend("force", config[1], {
          -- add mode component
          astronvim.status.component.mode { mode_text = { padding = { left = 1, right = 1 } } },
        })
        return config
      end,
      packer = {
        snapshot = "packer_snapshot",
        snapshot_path = vim.fn.stdpath("config"),
      },
      session_manager = {
        autosave_last_session = true,
      },
      {
        "lukas-reineke/indent-blankline.nvim",
      }
    },
  
    lsp = {
      servers = {
        "bashls",
        "cssls",
        "eslint",
        "gopls",
        "html",
        "jsonls",
        "jsonnet_ls",
        "python-lsp-server",
        "dockerfile-language-server-nodejs",
        -- "rnix",
        "rust_analyzer",
        "terraformls",
        "tsserver",
        "yamlls",
      },

      config = {
        ["dockerfile-language-server-nodejs"] = function()
          return {
            cmd = {
              "nix-shell",
              "-p",
              "nodePackages.dockerfile-language-server-nodejs",
              "--run",
              "'docker-langserver' '--stdio",
            },
            filetypes = { "dockerfile" },
            single_file_support = true,
            root_dir = require("lspconfig.util").root_pattern("Dockerfile", ".git");
          }
        end,
        ["python-lsp-server"] = function()
          return {
            cmd = {
              "nix-shell",
              "-p",
              "python310Packages.python-lsp-server",
              "--run",
              "'pylsp'",
            },
            filetypes = { "python" },
            single_file_support = true,
            root_dir = require("lspconfig.util").root_pattern(".envrc", ".git");
          }
        end,
        tsserver = function()
          return {
            cmd = {
              "nix-shell",
              "-p", 
              "nodePackages.typescript-language-server", 
              "--run",
              "'typescript-language-server' '--stdio'",
            }
          }
        end,
        gopls = function()
          return {
            cmd = {
              "nix-shell",
              "-p",
              "gopls",
              "go",
              "--run",
              "'gopls' 'serve'"
            };
            filetypes = {"go", "gomod"};
            root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git");
            settings = {
              gopls = {
                codelenses = {
                  usePlaceholders = true,
                },
              },
            };
          }
        end,
        -- rnix = function()
        --   return {
        --     cmd = {
        --       "nix-shell",
        --       "-p",
        --       "rnix-lsp",
        --       "--run",
        --       "'rnix-lsp'"
        --     }
        --   }
        -- end,
      },

      formatting = {
        disabled = {
          -- use null-ls' gofumpt/goimports instead 
          -- https://github.com/golang/tools/pull/410
          "gopls", 
          -- use null-ls' prettier instead
          "tsserver", 
        },
        format_on_save = {
          enabled = true,
          allow_filetypes = {
            "lua",
            "go",
            "jsonnet",
            "rust",
            "terraform",
            "typescript",
            "javascript",
            "nix",
            "python"
          },
        },
      },
      ["server-settings"] = {
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ["https://json.schemastore.org/github-action"] = "/action.{yml,yaml}",
                ["https://json.schemastore.org/github-workflow"] = "/.github/workflows/*.{yml,yaml}",
                ["https://json.schemastore.org/github-workflow-template-properties"] = "/.github/workflow-templates/*.{yml,yaml}",
                ["https://goreleaser.com/static/schema.json"] = "/.goreleaser.{yml,yaml}",
                ["https://json.schemastore.org/golangci-lint"] = "/.golangci.{yml,yaml}",
                ["https://json.schemastore.org/pre-commit-config"] = "/.pre-commit-config.{yml,yaml}",
                ["https://json.schemastore.org/pre-commit-hooks"] = "/.pre-commit-hooks.{yml,yaml}",
                ["https://json.schemastore.org/semantic-release"] = "/.releaserc.{yml,yaml}",
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/docker-compose*.{yml,yaml}",
              },
            },
          },
        },
      },
    },
  
    polish = function()
      vim.filetype.add({
        extension = {
          -- Map .libsonnet files to jsonnet filetype
          -- https://github.com/neovim/neovim/pull/20753
          libsonnet = "jsonnet",
        }
      })
  
      vim.api.nvim_create_autocmd("FileType", {
        desc = "Highlight lines over 80 characters long",
        callback = function()
          if vim.bo.filetype == "alpha" then
            return
          end
          vim.cmd([[
            highlight ColorColumn ctermbg=DarkRed guibg=DarkRed
            call matchadd('ColorColumn', '\%81v', 100)
          ]])
        end,
      })
  
      local dap_adapters = {
        "delve",
      }
      local dapconfig_ok, dapconfig = pcall(require, "mason-nvim-dap.automatic_setup")
      if dapconfig_ok then
        vim.tbl_map(dapconfig, dap_adapters)
      end
    end,
  }
