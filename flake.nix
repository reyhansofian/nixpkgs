{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, utils, ... }:
    utils.lib.eachDefaultSystem(
      system: 
        let 
          pkgs = import nixpkgs { inherit system; }; 
        in {
          homeConfigurations = {
            reyhan = home-manager.lib.homeManagerConfiguration {
              inherit pkgs;

              modules = [
                ({ config, pkgs, ... }: 
                  let
                    nixConfigDirectory = "~/.config/nixpkgs";
                    username = if pkgs.stdenv.isDarwin then "vicz" else "reyhan";
                    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";  # Default path if system is not Linux or macOS
                    overlay-unstable = final: prev: {
                      unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
                    };
                  in {
                    home.username = "reyhan";
                    home.homeDirectory = homeDirectory;
                    home.stateVersion = "23.05";

                    nixpkgs.overlays = [ overlay-unstable ];
                    nixpkgs.config = {
                      allowUnfree = true;
                      allowBroken = true;
                    };
                  }
                )
                ./home.nix
              ];
            };
          };
        }
    );
}
