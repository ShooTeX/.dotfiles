{ lib, ... }:
{
  imports = [
    ./go.nix
    ./nix.nix
    ./node.nix
    ./python.nix
    ./rust.nix
    ./tex.nix
  ];

  options.lab.dev.ecosystems = {
    enable = lib.mkEnableOption "Enable ecosystem configuration";

    active = lib.mkOption {
      type = lib.types.listOf (
        lib.types.enum [
          "go"
          "kotlin"
          "nix"
          "node"
          "python"
          "rust"
          "tex"
        ]
      );
      default = [
        "node"
        "nix"
      ];
    };
  };
}
