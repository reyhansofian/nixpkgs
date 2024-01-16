{
  # Import all your configuration modules here
  imports = [
    ./utils/init.nix
    ./utils/buffer.nix
    ./utils/ui.nix
    ./utils/git.nix
    ./utils/autocmd.nix
    ./plugins/comment.nix
    ./plugins/telescope.nix
    ./plugins/toggleterm.nix
    ./plugins/treesitter.nix
    ./plugins/neo-tree.nix
    ./plugins/git.nix
    ./lsp.nix
    ./keymap.nix
    ./ui.nix
    ./cmp.nix
    ./editor.nix
  ];
}
