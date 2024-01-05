{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, utils, ... }:
    let
      # nixConfig = import ./config;
    in
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        sources = import ./nix/sources.nix;
        getHomeDir = username: if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
      in
      {
        homeConfigurations = {
          vicz = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            modules = [
              (import ./modules.nix { inherit inputs system home-manager sources; })
              ./home.nix
              ({ ... }: { home.username = "vicz"; home.homeDirectory = getHomeDir "vicz"; })
            ];
          };

          reyhan = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            modules = [
              (import ./modules.nix { inherit inputs system home-manager sources; })
              ./home.nix
              ({ ... }: { home.username = "reyhan"; home.homeDirectory = getHomeDir "reyhan"; })
            ];
          };
        };
      }
    );
}
