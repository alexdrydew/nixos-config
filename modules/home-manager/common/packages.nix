{
  pkgs-stable,
  pkgs-unstable,
  lib,
  config,
  ...
}: {
  options = {
    home.packageSets = {
      graphical = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      devTools = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };

  config = {
    home.packages = with pkgs-stable;
      [
        azure-cli
        bazel-watcher
        # bazel-lsp
        # teleport
        kubelogin
        postgresql
        temporal-cli
        rsync
        graphviz
        cloc
        # av1 decoding
        mpv
        dav1d
        sshfs
        lsyncd
        cargo-tauri
        pipx
        difftastic
        nmap
        tokei
        etcd

        cmake
        ninja
        pkg-config
        arrow-cpp

        # General packages for development and system management
        bash-completion
        bat
        btop
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

        # Text and terminal utilities
        htop
        hunspell
        iftop
        jq
        ripgrep
        tree
        tmux
        unrar
        unzip
      ]
      ++ lib.optionals config.home.packageSets.devTools [
        coreutils
        fnm
        nil
        nixpkgs-fmt
        nix-index

        # Python packages
        jdk21

        # Rust
        # (rustbin.stable.latest.default.override { extensions = [ "rust-src" ]; })
        rustup
        gcc

        # Go
        go
      ]
      ++ lib.optionals config.home.packageSets.graphical [
        jetbrains.pycharm-professional
        jetbrains.webstorm
        jetbrains.idea-community
        jetbrains-mono
        # TODO: fix on macos
        # xdot
        pkgs-unstable.dbeaver-bin
        obsidian
        dejavu_fonts

        google-chrome
        brave
      ]
      ++ (with pkgs-unstable; [
        uv
        pnpm_8
        # Node.js development tools
        nodePackages.npm # globally install npm
        nodePackages.prettier
        nodePackages.node2nix

        codex
        gemini-cli
      ]);
  };
}
