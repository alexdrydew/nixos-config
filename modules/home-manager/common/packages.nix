{ pkgs, pkgs-unstable, inputs, ... }:
let
  bazel-lsp = pkgs.callPackage ./bazel-lsp.nix { };
in
{
  home.packages = with pkgs; [
    nil
    nixpkgs-fmt
    nix-index
    azure-cli
    k9s
    bazel-watcher
    # bazel-lsp
    # teleport
    kubelogin
    postgresql
    temporal-cli
    fnm
    aider-chat
    rsync

    # Rust
    (rust-bin.stable.latest.default.override { extensions = [ "rust-src" ]; })
    gcc

    # Go
    go

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
    uv
    # (python310.withPackages (python_pkgs: [ (tlk python_pkgs) ]))

    jdk21

    # TODO: make desktop packages togglable
    vscode
    jetbrains.pycharm-professional
    jetbrains.webstorm
    jetbrains.idea-community
    jetbrains-mono
    xdot
    pkgs-unstable.dbeaver-bin
    obsidian
    dejavu_fonts
  ];
}
