{ pkgs, pkgs-unstable }:
with pkgs; [
  vscode
  jetbrains.pycharm-professional
  jetbrains.webstorm
  jetbrains.idea-community
  jetbrains-mono
  xdot
  pkgs-unstable.dbeaver-bin

  dejavu_fonts
]
