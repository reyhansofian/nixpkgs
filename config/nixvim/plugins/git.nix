{
  programs.nixvim = {
    plugins.gitsigns = {
      enable = true;

      signs = {
        add = {
          hl = "GitSignsAdd";
          text = "┃ ";
          numhl = "GitSignsAddNr";
          linehl = "GitSignsAddLn";
        };
        change = {
          hl = "GitSignsChange";
          text = "┃ ";
          numhl = "GitSignsChangeNr";
          linehl = "GitSignsChangeLn";
        };
        delete = {
          hl = "GitSignsDelete";
          text = "┃ ";
          numhl = "GitSignsDeleteNr";
          linehl = "GitSignsDeleteLn";
        };
        topdelete = {
          hl = "GitSignsDelete";
          text = "┃ ";
          numhl = "GitSignsDeleteNr";
          linehl = "GitSignsDeleteLn";
        };
        changedelete = {
          text = "┃ ";
          numhl = "GitSignsChangeNr";
          linehl = "GitSignsChangeLn";
        };
        untracked = {
          hl = "GitSignsAdd";
          text = "┃ ";
          numhl = "GitSignsAddNr";
          linehl = "GitSignsAddLn";
        };
      };

      worktrees = [
        {
          gitdir = "vim.g.git_worktress.gitdir";
          toplevel = "vim.g.git_worktress.toplevel";
        }
      ];
    };
  };
}
