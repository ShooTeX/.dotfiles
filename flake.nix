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
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvchad = {
      url = "github:nvchad/nvchad";
      flake = false;
    };
    nvim-config = {
      url = "path:nvchad/.config/nvim/lua/custom/";
      flake = false;
    };
    ivar-nixpkgs-yabai-5_0_1.url =
      "github:IvarWithoutBones/nixpkgs?rev=27d6a8b410d9e5280d6e76692156dce5d9d6ef86";
  };

  outputs = { self, darwin, nixpkgs, home-manager, ivar-nixpkgs-yabai-5_0_1, ...
    }@inputs:
    let
      inherit (darwin.lib) darwinSystem;
      inherit (inputs.nixpkgs.lib)
        attrValues makeOverridable optionalAttrs singleton;

      overlays = attrValues self.overlays ++ [
        inputs.neovim-overlay.overlay
        (final: prev: {
          yabai-5_0_1 =
            (import ivar-nixpkgs-yabai-5_0_1 { inherit (final) system; }).yabai;
        })
        (final: prev:
          (optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
            inherit (final.pkgs-x86) google-chrome;
          }))
      ];

      nixpkgsConfig = {
        config = { allowUnfree = true; };
        overlays = overlays;
      };
    in {
      darwinConfigurations = rec {
        STX-MacBook-Pro = darwinSystem {
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
      };
      overlays = {
        apple-silicon = final: prev:
          optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
            pkgs-x86 = import inputs.nixpkgs {
              system = "x86_64-darwin";
              inherit (nixpkgsConfig) config;
            };
          };
      };
    };
}
