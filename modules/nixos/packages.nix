{ pkgs, pkgs-unstable }:

with pkgs;
let shared-packages = import ../shared/headless/packages.nix { inherit pkgs; inherit pkgs-unstable; }; in
shared-packages ++ [
  pkg-config
  alsa-lib
  jack2

  # App and package management
  appimage-run
  gnumake
  cmake
  home-manager

  # Audio tools
  cava # Terminal audio visualizer
  pavucontrol # Pulse audio controls

  # Testing and development tools
  direnv
  rofi
  rofi-calc
  postgresql

  # Screenshot and recording tools
  flameshot

  # Text and terminal utilities
  feh # Manage wallpapers
  screenkey
  tree
  unixtools.ifconfig
  unixtools.netstat
  xorg.xwininfo # Provides a cursor to click and learn about windows
  xorg.xrandr

  # File and system utilities
  inotify-tools # inotifywait, inotifywatch - For file system events
  i3lock-fancy-rapid
  libnotify
  pcmanfm # File browser
  sqlite
  xdg-utils
]
