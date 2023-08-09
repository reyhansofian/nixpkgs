{ inputs, system, home-manager, sources }:
{ config, pkgs,  ... }:
let
  overlay-unstable = final: prev: {
    unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
  };
in
{
  home.stateVersion = "23.05";
  home.activation = {
    change-ssh-permission = home-manager.lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD chmod $VERBOSE_ARG 600 ~/.ssh/id_ed.pub
      $DRY_RUN_CMD chmod $VERBOSE_ARG 600 ~/.ssh/efish_ed.pub
    '';
  };

  nixpkgs.overlays = [ overlay-unstable ];
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  xdg.configFile = {
    astronvim = {
      # onChange = "nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'";
      onChange = "nvim --headless -c 'if exists(\":LuaCacheClear\") | :LuaCacheClear' +quitall";
      source = ./config/astronvim;
    };
    nvim = {
      # onChange = "nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'";
      # onChange = "nvim --headless -c 'if exists(\":LuaCacheClear\") | :LuaCacheClear' +quitall";
      source = sources.AstroNvim;
    };
  };
}
