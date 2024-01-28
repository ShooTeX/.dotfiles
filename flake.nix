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
      url = "flake:nvim-config";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, neovim-overlay, nvim-config }:
    let
      overlays = [
        neovim-overlay.overlay
        (final: prev:
          {
            http4k = final.callPackage ./pkgs/http4k.nix { };
            # use until co-authors is officially released
            lazygit = final.callPackage ./pkgs/lazygit.nix { };

            extraNodePackages = final.callPackage ./pkgs/node/default.nix { };
            inherit (prev.stdenv.system == "aarch64-darwin") google-chrome;
          }
        )
      ];

      nixpkgsConfig = {
        config.allowUnfree = true;
        overlays = overlays;
      };

      homeManagerConfig = {
        nixpkgs = nixpkgsConfig;
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit nvim-config; };
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
            homeManagerConfig
            { home-manager.users."stx" = { ... }: { imports = [ ./home.nix ]; }; }
          ];
        };
        Eriks-MacBook-Pro = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./configuration.nix
            ./darwin/work.nix
            home-manager.darwinModules.home-manager
            homeManagerConfig
            { home-manager.users."eriksimon" = { ... }: { imports = [ ./home.nix ]; }; }
          ];
        };
      };
    };
}
