{
  programs.nixvim = {
    plugins.comment-nvim = {
      enable = true;
    };

    plugins.nvim-autopairs.enable = true;
    plugins.treesitter = {
      enable = true;
    };
  };
}
