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
  };

  outputs = { self, darwin, nixpkgs, home-manager, ... }@inputs: 
  let
    inherit (darwin.lib) darwinSystem;

    overlays = [
	inputs.neovim-overlay.overlay
    ];

    nixpkgsConfig = {
      config = { allowUnfree = true; };
      overlays = overlays;
    };
  in
  {
    darwinConfigurations = rec {
      STX-MacBook-Pro = darwinSystem {
        system = "aarch64-darwin";
	modules = [
	  ./configuration.nix
	  home-manager.darwinModules.home-manager
	  {
	    nixpkgs = nixpkgsConfig;
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.stx = import ./home.nix;
	  }
	];
      };
    };
  };
}
