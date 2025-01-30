{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-24.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.home-manager.follows = "home-manager";
    };

    utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, nixvim, utils, nixos-wsl, ... }:
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
              (import ./modules.nix { inherit inputs system home-manager; })
              ./home.nix
              ({ ... }: { home.username = "reyhan"; home.homeDirectory = getHomeDir "reyhan"; })
              nixvim.homeManagerModules.nixvim
              ./config/nixvim/default.nix
            ];
          };
        };
      }
    ) // {
      nixosConfigurations = {
	      nixos = nixpkgs.lib.nixosSystem {
		    system = "x86_64-linux";
		    modules = [
		      nixos-wsl.nixosModules.default
		      ( 
		        { pkgs, ... }:
			      {
			        system.stateVersion = "24.05";
			        wsl.enable = true;
			        wsl.defaultUser = "reyhan";
			        wsl.docker-desktop.enable = true;
			        wsl.wslConf.network.generateHosts = false;
			        nix.settings = {
			          nix-path = [ "nixpkgs=${nixpkgs}" ];
			          experimental-features = [ "flakes" "nix-command" ];
			        };
			        nixpkgs.config = { allowUnfree = true; };
			        nixpkgs.overlays = [
			          (
					        final: prev: {
					            unstable = nixpkgs.legacyPackages."x86_64-linux";
					        }
				        )
			        ];
			        environment.systemPackages = with pkgs; [
			        ];
			        environment.shells = with pkgs; [
			          zsh
			        ];

			        networking.extraHosts = "192.168.0.157 ubuntu.local";
			        fonts.packages = with pkgs; [
                (nerdfonts.override {
                  fonts = [ "FiraCode" "DroidSansMono" "Hack" ];
                })
			        ];
			        fonts.fontDir.enable = true;
			      }
		      )
		      home-manager.nixosModules.home-manager
		      { 
		        home-manager.useGlobalPkgs = true;
		        home-manager.useUserPackages = true;
		        home-manager.users.reyhan = { ... }: {
		          home.stateVersion = "23.11";
		          imports = [
	      		    ./home.nix
		            nixvim.homeManagerModules.nixvim
		            ./config/nixvim/default.nix
		          ];
		        }; 
		      }
		    ];
	      };
	    };
    };
}
