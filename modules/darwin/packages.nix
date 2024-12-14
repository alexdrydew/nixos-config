{ pkgs, pkgs-unstable }:

with pkgs;
let
  shared-packages = import ../shared/packages.nix { inherit pkgs; inherit pkgs-unstable; };
  tlk = ps: ps.callPackage ../shared/toloka/tlk.nix { fetchurl = pkgs.stdenv.fetchurlBoot; };
in
shared-packages ++ [
  dockutil
]
