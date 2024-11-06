{
  programs.nixvim = {
    plugins.comment = {
      enable = true;
    };

    plugins.nvim-autopairs.enable = true;
    plugins.treesitter = {
      enable = true;
    };
  };
}
