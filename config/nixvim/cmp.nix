{
  programs.nixvim = {
    keymaps = [
      {
        key = "<Up>";
        action.__raw = ''cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })'';
      }
      {
        key = "<Down>";
        action.__raw = ''cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })'';
      }
      {
        key = "<C-p>";
        action.__raw = ''cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })'';
      }
      {
        key = "<C-n>";
        action.__raw = ''cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })'';
      }
      {
        key = "<C-k>";
        action.__raw = ''cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })'';
      }
      {
        key = "<C-j>";
        action.__raw = ''cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })'';
      }
      {
        key = "<C-u>";
        action.__raw = ''cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })'';
        mode = [ "i" "c" ];
      }
      {
        key = "<C-d>";
        action.__raw = ''cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })'';
        mode = [ "i" "c" ];
      }
      {
        key = "<C-Space>";
        action.__raw = ''cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })'';
        mode = [ "i" "c" ];
      }
      {
        key = "<C-y>";
        action.__raw = ''cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })'';
      }
      {
        key = "<C-e>";
        action.__raw = ''cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })'';
      }
      {
        key = "<C-f>";
        action.__raw = ''cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })'';
      }
      {
        key = "<CR>";
        action.__raw = ''cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })'';
      }
      {
        key = "<S-Tab>";
        action.__raw = ''
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
        mode = [ "i" "s" ];
      }
      {
        key = "<Tab>";
        action.__raw = ''
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
        mode = [ "i" "s" ];
      }
    ];

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
      settings = {
        enable_autosnippets = true;
        store_selection_keys = "<Tab>";
      };
    };

    plugins.cmp_luasnip.enable = true;

    plugins.cmp = {
      enable = true;

      luaConfig = {
        pre = "

        ";
      };

      settings = {
        preselect = "None";
        sources = [
          { name = "nvim_lsp"; }
          { name = "nvim_lsp_signature_help"; }
          { name = "nvim_lsp_document_symbol"; }
          { name = "codeium"; }
          { name = "luasnip"; } #For luasnip users.
          { name = "luasnip-choice"; } #For luasnip users.
          { name = "path"; }
          { name = "buffer"; }
          # { name = "cmdline"; }
          # { name = "spell"; }
          # { name = "dictionary"; }
          # { name = "tmux"; }
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

      };
    };
  };
}
