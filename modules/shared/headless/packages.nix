{ pkgs, pkgs-unstable }:
with pkgs; [
  nil
  gh
  nixpkgs-fmt
  oh-my-zsh

  # Rust
  (rust-bin.stable.latest.default.override { extensions = [ "rust-src" ]; })
  gcc

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
