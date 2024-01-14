{
  programs.nixvim = {
    plugins.cmp-nvim-lsp.enable = true;
    plugins.cmp-nvim-lsp-signature-help.enable = true;
    plugins.cmp-nvim-lsp-document-symbol.enable = true;
    plugins.codeium-nvim = {
      enable = true;
    };

    plugins.luasnip.enable = true;
    plugins.cmp_luasnip.enable = true;

    plugins.nvim-cmp = {
      enable = true;
      preselect = "None";

      sources = [
        { name = "codeium"; priority = 1000; }
        { name = "nvim_lsp"; priority = 750; }
        { name = "luasnip"; priority = 550; }
        { name = "buffer"; priority = 300; }
        { name = "path"; priority = 250; }
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
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-e>" = "cmp.mapping.close()";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<CR>" = "cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace })";
        "<S-Tab>" = {
          action = "cmp.mapping.select_prev_item()";
          modes = [
            "i"
            "s"
          ];
        };
        "<Tab>" = {
          action = ''
            	  function(fallback)
            			if cmp.visible() then
            				cmp.select_next_item()
            			elseif require("luasnip").expand_or_jumpable() then
            				require("luasnip").expand_or_jump()
            			else
            				fallback()
            			end
            		end
            	  '';
          #"cmp.mapping.select_next_item()";
          modes = [
            "i"
            "s"
          ];
        };
      };
    };
  };
}
