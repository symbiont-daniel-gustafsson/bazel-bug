{ sources ? import ./nix/sources.nix
, pkgs ? import sources.nixpkgs {} }:
with pkgs;

pkgs.mkShell {
  buildInputs = [
    bazel_4
    nix
  ];
}
