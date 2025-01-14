{ pkgs, pkgs-unstable }:

with pkgs;
let
  shared-headless-packages = import ../shared/headless/packages.nix { inherit pkgs; inherit pkgs-unstable; };
  shared-desktop-packages = import ../shared/desktop/packages.nix { inherit pkgs; inherit pkgs-unstable; };
  tlk = ps: ps.callPackage ../shared/toloka/tlk.nix { fetchurl = pkgs.stdenv.fetchurlBoot; };
in
shared-headless-packages ++ shared-desktop-packages ++ [
  dockutil
  databricks-cli
]
