{ pkgs, pkgs-unstable }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; inherit pkgs-unstable; }; in
shared-packages ++ [
  dockutil
]
