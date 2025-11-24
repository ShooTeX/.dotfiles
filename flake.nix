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
    opencode = {
      url = "github:sst/opencode";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      overlays = [
        inputs.neovim-overlay.overlays.default
        (final: prev: {
          opencode = inputs.opencode.packages.${prev.system}.default;
          http4k = final.callPackage ./pkgs/http4k.nix { };
        })
      ];
      mkDarwinSystem =
        hostname:
        inputs.darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
              nixpkgs.overlays = overlays;
            }
            inputs.home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                backupFileExtension = "nixbak";
              };
            }
            ./hosts/${hostname}
          ];
        };
    in
    {
      darwinConfigurations = {
        STX-MacBook-Pro = mkDarwinSystem "STX-MacBook-Pro";
        Erik-RWG6T57T93 = mkDarwinSystem "Erik-RWG6T57T93";
      };
    };
}
