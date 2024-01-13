{
  programs.nixvim = {
    enable = true;
    globals.mapleader = " ";

    extraConfigLuaPre = ''
      vim.g.mapleader = " "
    '';

    options = {
      number = true;
      #  relativenumber = true;
      shiftwidth = 2;
      foldcolumn = "0";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;
      foldnestmax = 2;
      fillchars = {
        eob = " ";
        fold = " ";
        foldopen = "";
        foldsep = " ";
        foldclose = "";
        vert = "▕";
        diff = "╱";
        msgsep = "‾";
      };
    };

    clipboard.providers.wl-copy.enable = true;
  };
}
