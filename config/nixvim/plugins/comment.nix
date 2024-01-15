{
  programs.nixvim = {
    extraConfigLuaPre = ''
      vim.keymap.set(
        "n", 
        "<leader>/", 
        "<esc><cmd>lua require('Comment.api').toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)<cr>", 
        { desc = "Comment" }
      )
      vim.keymap.set(
        "v", 
        "<leader>/", 
        "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", 
        { desc = "Comment" }
      )
    '';
  };
}
