{
  description = "k9s with some opinionated tweaks";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/2e03f7f53b9e2e9a2485da72658cf5952bf384a8";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          k9s-overlay = final: prev: {
            k9s = prev.k9s.overrideAttrs (old: {
              src = ./.;
              vendorHash = "sha256-CQjxcneFdWswMLDIvjXxQO0zztsosg2MlJSheGwdhf0=";
            });
          };
          pkgs = import nixpkgs { inherit system; overlays = [ k9s-overlay ]; };
        in {
          packages.default = pkgs.k9s;
        }
      );
}
