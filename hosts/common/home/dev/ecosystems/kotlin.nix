{ inputs, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      (gradle.override { java = graalvmPackages.graalvm-ce; })
      graalvmPackages.graalvm-ce
      (callPackage "${inputs.self}/pkgs/http4k.nix" { })
      kotlin
    ];

    sessionPath = [
      "${pkgs.graalvmPackages.graalvm-ce}/bin"
    ];

    sessionVariables = {
      GRAALVM_HOME = "${pkgs.graalvmPackages.graalvm-ce}";
      JAVA_HOME = "${pkgs.graalvmPackages.graalvm-ce}";
    };
  };

}
