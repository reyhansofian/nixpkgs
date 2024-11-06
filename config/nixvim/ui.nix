{
  programs.nixvim = {
    colorschemes.onedark.enable = true;
    plugins.bufferline.enable = true;
    plugins.notify.enable = true;

    plugins.lualine = {
      enable = true;
      settings.extensions = [ "fzf" ];
      settings.options.globalstatus = true;
      settings.options.theme = "onedark";
    };

    plugins.web-devicons.enable = true;
    plugins.mini.enable = true;
    plugins.indent-blankline = {
      enable = true;
      settings.indent.char = "┊";
      settings.exclude.buftypes = [ "terminal" "neorg" ];
      settings.exclude.filetypes = [
        "help"
        "terminal"
        "dashboard"
        "lspinfo"
        "TelescopePrompt"
        "TelescopeResults"
      ];
    };

    plugins.nvim-ufo = {
      enable = true;

      settings.preview.mappings = {
        scrollB = "<C-b>";
        scrollF = "<C-f>";
        scrollU = "<C-u>";
        scrollD = "<C-d>";
      };

      settings.providerSelector.__raw = ''
        function(_, filetype, buftype)
          local function handleFallbackException(bufnr, err, providerName)
            if type(err) == "string" and err:match "UfoFallbackException" then
              return require("ufo").getFolds(bufnr, providerName)
            else
              return require("promise").reject(err)
            end
          end

          return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
            or function(bufnr)
              return require("ufo")
                .getFolds(bufnr, "lsp")
                :catch(function(err) return handleFallbackException(bufnr, err, "treesitter") end)
                :catch(function(err) return handleFallbackException(bufnr, err, "indent") end)
            end
        end
      '';
    };
  };
}
