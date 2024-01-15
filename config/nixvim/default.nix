{
  # Import all your configuration modules here
  imports = [
    ./nvim.nix
    ./utils/buffer.nix
    ./utils/ui.nix
    ./plugins/comment.nix
    ./plugins/telescope.nix
    ./plugins/toggleterm.nix
    ./plugins/treesitter.nix
    ./lsp.nix
    ./keymap.nix
    ./ui.nix
    ./cmp.nix
    ./editor.nix
  ];
}
