{
  programs.nixvim = {
    colorschemes.onedark.enable = true;
    plugins.bufferline.enable = true;
    plugins.neo-tree = {
      enable = true;
      enableDiagnostics = true;
      enableGitStatus = true;
      enableModifiedMarkers = true;
      enableRefreshOnWrite = true;
    };

    plugins.notify.enable = true;

    plugins.telescope = {
      enable = true;
      extensions = {
        fzf-native.enable = true;
        file_browser.enable = true;
      };
    };

    plugins.lualine = {
      enable = true;
      extensions = [ "fzf" ];
      globalstatus = true;
      theme = "onedark";
    };

    plugins.toggleterm = {
      enable = true;
    };

    plugins.indent-blankline.enable = true;

    plugins.nvim-ufo = {
      enable = true;
      preview.mappings = {
        scrollB = "<C-b>";
        scrollF = "<C-f>";
        scrollU = "<C-u>";
        scrollD = "<C-d>";
      };
      providerSelector = ''
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
