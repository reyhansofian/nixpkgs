{
  # Import all your configuration modules here
  imports = [
    ./utils/init.nix
    ./utils/buffer.nix
    ./utils/ui.nix
    ./utils/autocmd.nix
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
