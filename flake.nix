{
  description = "A react frontend for my training database";

  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    poetry2nix.url = "github:nix-community/poetry2nix";
  };

  outputs = { self, nixpkgs, flake-utils, poetry2nix }:
    let
    in
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
        overlay = (final: prev: {
          final.callPackage ./default.nix {
            poetry2nix = prev.poetry2nix;
          };
        });
      in rec {
        inherit overlay;

        packages = {
          app = pkgs.app
        };
        defaultPackage = packages.app;
        checks = packages;

        devShells = {
          app = pkgs.app.shell;
        };
        devShell = devShells.app;
      });
}
