{
  programs.nixvim = {
    plugins.cmp-nvim-lsp.enable = true;
    plugins.cmp-nvim-lsp-signature-help.enable = true;
    plugins.cmp-nvim-lsp-document-symbol.enable = true;
    plugins.cmp-treesitter.enable = true;
    plugins.cmp-path.enable = true;
    plugins.cmp-buffer.enable = true;
    plugins.cmp-cmdline.enable = true;
    plugins.cmp-spell.enable = true;
    plugins.cmp-dictionary.enable = true;
    plugins.codeium-nvim = {
      enable = true;
    };

    plugins.luasnip = {
      enable = true;
      extraConfig = {
        enable_autosnippets = true;
        store_selection_keys = "<Tab>";
      };
    };

    plugins.cmp_luasnip.enable = true;

    plugins.nvim-cmp = {
      enable = true;
      preselect = "None";

      sources = [
        { name = "nvim_lsp"; }
        { name = "nvim_lsp_signature_help"; }
        { name = "nvim_lsp_document_symbol"; }
        { name = "codeium"; }
        { name = "luasnip"; } #For luasnip users.
        { name = "path"; }
        { name = "buffer"; }
        { name = "cmdline"; }
        { name = "spell"; }
        { name = "dictionary"; }
        { name = "tmux"; }
        { name = "treesitter"; }
      ];

      window = {
        completion = {
          border = "rounded";
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None";
        };

        documentation = {
          border = "rounded";
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None";
        };
      };

      snippet.expand = "luasnip";

      mapping = {
        "<Up>" = "cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })";
        "<Down>" = "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })";
        "<C-p>" = "cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })";
        "<C-n>" = "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })";
        "<C-k>" = "cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })";
        "<C-j>" = "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })";
        "<C-u>" = {
          action = "cmp.mapping.scroll_docs(-4)";
          modes = [ "i" "c" ];
        };
        "<C-d>" = {
          action = "cmp.mapping.scroll_docs(4)";
          modes = [ "i" "c" ];
        };
        "<C-Space>" = {
          action = "cmp.mapping.complete()";
          modes = [ "i" "c" ];
        };
        "<C-y>" = "cmp.config.disable";
        "<C-e>" = "cmp.mapping.close()";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<CR>" = "cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace })";
        "<S-Tab>" = {
          action = ''
            function(fallback)
              local snip_status_ok, luasnip = pcall(require, "luasnip")
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end
          '';
          modes = [ "i" "s" ];
        };
        "<Tab>" = {
          action = ''
            function(fallback)
              local snip_status_ok, luasnip = pcall(require, "luasnip")
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              elseif has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end
          '';
          modes = [ "i" "s" ];
        };
      };
    };
  };
}
