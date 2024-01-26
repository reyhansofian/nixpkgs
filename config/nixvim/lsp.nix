{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;

      keymaps.lspBuf = {
        K = "hover";
        gD = "references";
        gd = "definition";
        gi = "implementation";
        gt = "type_definition";
        gh = "signature_help";
      };

      capabilities = ''
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities.textDocument.completion.completionItem.resolveSupport = {
          properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
          },
        }
        local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
        for _, ls in ipairs(language_servers) do
            require('lspconfig')[ls].setup({
                capabilities = capabilities
                -- you can add other fields for setting up lsp server in this table
            })
        end
      '';

      onAttach = ''
        local function on_attach(bufnr)
          require("lsp_signature").on_attach({
        		bind = true,
        		doc_lines = 0,
        		floating_window = true,
        		fix_pos = true,
        		hint_enable = true,
        		hint_prefix = " ",
        		hint_scheme = "String",
        		hi_parameter = "Search",
        		max_height = 22,
        		max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
        		handler_opts = {
        			border = "rounded", -- double, single, shadow, none
        		},
        		zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
        		padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
        	}, bufnr)
        end
      '';

      servers = {
        rnix-lsp = {
          enable = true;
          autostart = true;
        };

        gopls = {
          enable = true;
          rootDir = ''require("lspconfig.util").root_pattern("go.work", "go.mod", ".git")'';
          extraOptions = {
            settings = {
              gopls = {
                analyses = {
                  unusedparams = true;
                };
                staticcheck = true;
                gofumpt = true;
                codelenses = {
                  usePlaceholders = true;
                };
              };
            };
          };
        };

        graphql = {
          enable = true;
        };

        jsonls = {
          enable = true;
        };

        tsserver = {
          enable = true;
        };

        yamlls = {
          enable = true;
        };

        dockerls = {
          enable = true;
        };
      };
    };

    plugins.lsp-format = {
      enable = true;
      setup = {
        gopls = {
          exclude = [
            "gopls"
          ];
          force = true;
          order = [
            "gopls"
            "efm"
          ];
          sync = true;
        };
      };
    };
  };
}
