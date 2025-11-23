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
      mkDarwinSystem =
        hostname:
        darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
              nixpkgs.overlays = overlays;
            }
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit nvim-config wezterm-config; };
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
