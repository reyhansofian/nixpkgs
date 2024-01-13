{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, nixvim, utils, ... }:
    let
      # nixConfig = import ./config;
    in
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        # sources = import ./nix/sources.nix;
        getHomeDir = username: if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
      in
      {
        homeConfigurations = {
          vicz = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            modules = [
              # (import ./modules.nix { inherit inputs system home-manager sources; })
              (import ./modules.nix { inherit inputs system home-manager; })
              ./home.nix
              ({ ... }: { home.username = "vicz"; home.homeDirectory = getHomeDir "vicz"; })
              nixvim.homeManagerModules.nixvim
              ./config/nixvim/default.nix
            ];
          };

          reyhan = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            modules = [
              # (import ./modules.nix { inherit inputs system home-manager sources; })
              (import ./modules.nix { inherit inputs system home-manager; })
              ./home.nix
              ({ ... }: { home.username = "reyhan"; home.homeDirectory = getHomeDir "reyhan"; })
              nixvim.homeManagerModules.nixvim
              ./config/nixvim/default.nix
            ];
          };
        };
      }
    );
}
