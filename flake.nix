{
  description = "STX/DOTTEX systems";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

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
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim = {
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
    deploy-rs.url = "github:serokell/deploy-rs";
    dawarich-pr = {
      url = "github:diogotcorreia/nixpkgs/dawarich-init";
      flake = false;
    };
  };

  outputs =
    inputs:
    let
      mkDarwinSystem =
        hostname:
        inputs.darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
            }
            inputs.sops-nix.darwinModules.sops
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
        Eriks-MacBook-Pro = mkDarwinSystem "Eriks-MacBook-Pro";
      };
      # Slightly experimental: Like generic, but with nixos-facter (https://github.com/numtide/nixos-facter)
      # nixos-anywhere --flake .#heisenberg --generate-hardware-config nixos-facter facter.json <hostname>
      nixosConfigurations.heisenberg = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          "${inputs.dawarich-pr}/nixos/modules/services/web-apps/dawarich.nix"
          {
            nixpkgs.overlays = [
              (final: prev: {
                dawarich = prev.callPackage "${inputs.dawarich-pr}/pkgs/by-name/da/dawarich/package.nix" { };
              })
            ];
          }
          inputs.disko.nixosModules.disko
          ./hosts/heisenberg/configuration.nix
          inputs.nixos-facter-modules.nixosModules.facter
          {
            config.facter.reportPath =
              if builtins.pathExists ./hosts/heisenberg/facter.json then
                ./hosts/heisenberg/facter.json
              else
                throw "Have you forgotten to run nixos-anywhere with `--generate-hardware-config nixos-facter ./facter.json`?";
          }
          inputs.sops-nix.nixosModules.sops
        ];
      };
      deploy.nodes.heisenberg = {
        hostname = "heisenberg";
        remoteBuild = true;
        profiles.system = {
          user = "root";
          path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos inputs.self.nixosConfigurations.heisenberg;
        };
      };
    };
}
