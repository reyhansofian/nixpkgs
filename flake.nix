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

              # username = if pkgs.stdenv.isDarwin then "vicz" else "reyhan";
              # homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";  # Default path if system is not Linux or macOS
              # stateVersion = "23.05";
              # configuration = { config, pkgs, ... }:
              #   let
              #     overlay-unstable = final: prev: {
              #       unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
              #     };
              #   in {
              #     nixpkgs.overlays = [ overlay-unstable ];
              #     nixpkgs.config = {
              #       allowUnfree = true;
              #       allowBroken = true;
              #     };

              #     imports = [
              #       ./home.nix
              #     ];
              #   }
              modules = [
                ./home.nix
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
                    # home.packages = with pkgs;[
                    #   git
                    #   nodejs
                    #   go
                    #   python3
                    #   python3.pkgs.pip
                    # ];

                    nixpkgs.overlays = [ overlay-unstable ];
                    nixpkgs.config = {
                      allowUnfree = true;
                      allowBroken = true;
                    };

                    # home.shellAliases = {
                    #   flakeup = 
                    #     # example flakeup nixpkgs-unstable
                    #     "nix flake lock ${nixConfigDirectory} --update-input"; 
                    #   nxb =
                    #     "nix build ${nixConfigDirectory}/#homeConfigurations.${system}.${username}.activationPackage -o ${nixConfigDirectory}/result ";
                    #   nxa =
                    #     "${nixConfigDirectory}/result/activate switch --flake ${nixConfigDirectory}/#homeConfigurations.${system}.${username}";
                    # };
                  }
                )
              ];
            };
          };
        }
    );
}
