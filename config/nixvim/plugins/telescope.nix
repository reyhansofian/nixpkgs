{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      extensions = {
        fzf-native.enable = true;
        file-browser.enable = true;
      };

      settings.defaults = {
        git_worktrees = "vim.g.git_worktrees";
        path_display = [ "truncate" ];
        sorting_strategy = "ascending";
        layout_config = {
          horizontal = {
            prompt_position = "top";
            preview_width = 0.55;
          };
          vertical = { mirror = false; };
          width = 0.87;
          height = 0.80;
          preview_cutoff = 120;
        };
      };
    };

  };
}
