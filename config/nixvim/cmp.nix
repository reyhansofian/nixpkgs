{
  programs.nixvim = {
    plugins.cmp-nvim-lsp.enable = true;
    plugins.cmp-nvim-lsp-signature-help.enable = true;
    plugins.cmp-nvim-lsp-document-symbol.enable = true;
    plugins.cmp-path.enable = true;
    plugins.cmp-buffer.enable = true;
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
        { name = "luasnip"; priority = 500; }
        { name = "buffer"; priority = 250; }
        { name = "path"; priority = 100; }
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
