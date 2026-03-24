final: prev: {
  netbird = prev.netbird.overrideAttrs (old: rec {
    version = "0.67.0";
    src = final.fetchFromGitHub {
      owner = "netbirdio";
      repo = "netbird";
      tag = "v${version}";
      hash = "sha256-5Q90bEAXTnvkEHcsheohu9wdwZRFIoLnqBNzjotFz54=";
    };
    vendorHash = "sha256-6qYS2jXjfPczAfv+g79JsTcEJR9FniAVjW52Yi/g42M=";
  });
}
