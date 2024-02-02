{
  programs.nixvim = {
    plugins.toggleterm = {
      enable = false;

      openMapping = "<F7>";
      direction = "float";
      shadingFactor = 2;

      floatOpts = {
        border = "rounded";
      };

      onCreate = ''
        function()
          vim.opt.foldcolumn = "0"
          vim.opt.signcolumn = "no"
        end
      '';

      highlights = {
        Normal = { link = "Normal"; };
        NormalNC = { link = "NormalNC"; };
        NormalFloat = { link = "NormalFloat"; };
        FloatBorder = { link = "FloatBorder"; };
        StatusLine = { link = "StatusLine"; };
        StatusLineNC = { link = "StatusLineNC"; };
        WinBar = { link = "WinBar"; };
        WinBarNC = { link = "WinBarNC"; };
      };
    };
  };
}
