{ pkgs, pkgs-unstable }:

with pkgs;
let shared-packages = import ../common/headless/packages.nix { inherit pkgs; inherit pkgs-unstable; }; in
shared-packages ++ [
  pkg-config
  alsa-lib
  jack2

  libcap

  # App and package management
  appimage-run
  gnumake
  cmake
  home-manager

  # Testing and development tools
  direnv
  postgresql

  tree

  # File and system utilities
  sqlite
]
