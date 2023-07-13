{
  description = "STX darwin system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nur.url = "github:nix-community/NUR";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      /* inputs.nixpkgs.follows = "nixpkgs"; */
    };
    nvim-config = {
      url = "git+file:./nvim/";
      flake = false;
    };
  };

  outputs = { self, darwin, nixpkgs, home-manager, ... }@inputs:
    let
      overlays = [
        inputs.neovim-overlay.overlay
        (final: prev:
          if prev.stdenv.system == "aarch64-darwin" then {
            inherit (final.pkgs-x86) google-chrome;
          } else null
        )
      ];

      nixpkgsConfig = {
        config.allowUnfree = true;
        overlays = overlays;
      };
    in
    {
      darwinConfigurations = {
        STX-MacBook-Pro = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./configuration.nix
            ./darwin
            home-manager.darwinModules.home-manager
            {
              nixpkgs = nixpkgsConfig;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.stx = { ... }: { imports = [ ./home.nix ]; };
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
          ];
        };
        PYFRWN6V2V = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./configuration.nix
            ./darwin/work.nix
            home-manager.darwinModules.home-manager
            {
              nixpkgs = nixpkgsConfig;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."Erik.Simon" = { ... }: { imports = [ ./home.nix ]; };
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
          ];
        };
      };

      overlays = {
        apple-silicon = final: prev:
          if prev.stdenv.system == "aarch64-darwin" then {
            pkgs-x86 = import inputs.nixpkgs {
              system = "x86_64-darwin";
              inherit (nixpkgsConfig) config;
            };
          } else null;
      };
    };
}
