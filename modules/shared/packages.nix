{ pkgs, pkgs-unstable }:
with pkgs; [
  # vscode
  nil
  gh
  jetbrains.pycharm-professional
  jetbrains.webstorm
  jetbrains.idea-community
  nixpkgs-fmt
  oh-my-zsh
  jetbrains-mono

  pkgs-unstable.dbeaver-bin

  # General packages for development and system management
  bash-completion
  bat
  btop
  coreutils
  killall
  neofetch
  openssh
  sqlite
  wget
  zip

  # Encryption and security tools
  age
  gnupg
  libfido2

  # Cloud-related tools and SDKs
  docker
  docker-compose

  # Media-related packages
  dejavu_fonts
  ffmpeg
  fd

  # Node.js development tools
  nodePackages.npm # globally install npm
  nodePackages.prettier
  nodePackages.node2nix
  nodejs-slim
  pnpm_8

  # Text and terminal utilities
  htop
  hunspell
  iftop
  jetbrains-mono
  jq
  ripgrep
  tree
  tmux
  unrar
  unzip

  # Python packages
  pyenv
  # (python310.withPackages (python_pkgs: [ (tlk python_pkgs) ]))
]
