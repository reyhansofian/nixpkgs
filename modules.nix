{ inputs, system, home-manager, ... }:
{ config, pkgs, ... }:
let
  overlay-unstable = final: prev: {
    unstable = inputs.nixpkgs.legacyPackages.${system};
    # nix = inputs.nixpkgs-stable.legacyPackages.${system}.nix;
  };
in
{
  home.stateVersion = "23.11";
  home.activation = {
    change-ssh-permission = home-manager.lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD chmod $VERBOSE_ARG 600 ~/.ssh/id_ed.pub
      $DRY_RUN_CMD chmod $VERBOSE_ARG 600 ~/.ssh/efish_ed.pub
    '';
  };

  nix.package = inputs.nixpkgs-stable.legacyPackages.${system}.nix;
  nixpkgs.overlays = [ overlay-unstable ];
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };
}
