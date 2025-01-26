{ pkgs, pkgs-unstable }:

with pkgs;
let
  shared-headless-packages = import ../common/headless/packages.nix { inherit pkgs; inherit pkgs-unstable; };
  shared-desktop-packages = import ../common/desktop/packages.nix { inherit pkgs; inherit pkgs-unstable; };
  tlk = ps: ps.callPackage ../common/toloka/tlk.nix { fetchurl = pkgs.stdenv.fetchurlBoot; };
in
shared-headless-packages ++ shared-desktop-packages ++ [
  dockutil
  databricks-cli
  unnaturalscrollwheels
]
