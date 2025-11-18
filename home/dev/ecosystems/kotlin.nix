{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (gradle.override { java = graalvmPackages.graalvm-ce; })
    graalvmPackages.graalvm-ce
    http4k
    kotlin
  ];

  home.sessionPath = [
    "${pkgs.graalvmPackages.graalvm-ce}/bin"
  ];

  home.sessionVariables = {
    GRAALVM_HOME = "${pkgs.graalvmPackages.graalvm-ce}";
    JAVA_HOME = "${pkgs.graalvmPackages.graalvm-ce}";
  };
}
