{
  description = "STX darwin system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
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
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvim-config = {
      url = "github:shootex/init.lua";
      flake = false;
    };
    wezterm-config = {
      url = "github:shootex/wezterm.lua";
      flake = false;
    };
  };

  outputs =
    {
      darwin,
      home-manager,
      neovim-overlay,
      nvim-config,
      wezterm-config,
      ...
    }:
    let
      overlays = [
        neovim-overlay.overlays.default
        (final: prev: {
          http4k = final.callPackage ./pkgs/http4k.nix { };
        })
      ];

      nixpkgsConfig = {
        config.allowUnfree = true;
        overlays = overlays;
      };

      homeManagerConfig = {
        nixpkgs = nixpkgsConfig;
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit nvim-config wezterm-config; };

      };
    in
    {
      darwinConfigurations = {
        STX-MacBook-Pro = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./configuration.nix
            {
              system.primaryUser = "stx";
            }
            ./darwin
            home-manager.darwinModules.home-manager
            homeManagerConfig
            {
              home-manager.users.stx.imports = [ ./home ];
            }
          ];
        };
        Erik-RWG6T57T93 = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./configuration.nix
            {
              system.primaryUser = "eriksimon";
            }
            ./darwin/work.nix
            home-manager.darwinModules.home-manager
            homeManagerConfig
            {
              home-manager.users.eriksimon.imports = [ ./home ];
            }
          ];
        };
      };
    };
}
