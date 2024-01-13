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

      sources = [
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        { name = "path"; }
        { name = "buffer"; }
        { name = "codeium"; }
      ];

      snippet.expand = "luasnip";

      mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-e>" = "cmp.mapping.close()";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<CR>" = "cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert })";
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
