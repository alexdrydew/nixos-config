{
  pkgs-stable,
  osConfig,
  ...
}: let
  homebrew-enabled = builtins.hasAttr "homebrew" osConfig && osConfig.homebrew.enable;
in {
  home.packages = with pkgs-stable; [
    # zsh
    zsh-autosuggestions
  ];
  programs.zsh = {
    enable = true;
    autocd = false;
    plugins = [];

    enableCompletion = true;
    autosuggestion.enable = true;

    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      if [[ -z "$IN_NIX_SHELL" ]]; then
        # Define variables for directories, only if not in nix-shell
        export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
        export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
        export PATH=$HOME/.local/share/bin:$PATH

        # Go
        export GO_PATH=$HOME/go
        export PATH=$PATH:$GO_PATH/bin

        export PATH="/Users/alexdrydew/.local/bin:$PATH"

        ${
          if homebrew-enabled
          then ''
            # Homebrew, only modify PATH if not in nix-shell
            if [[ $(uname -m) == 'arm64' ]]; then
              eval "$(/opt/homebrew/bin/brew shellenv)"
            fi
          ''
          else ""
        }
      fi

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      # editors
      export ALTERNATE_EDITOR=""
      export EDITOR="nvim"

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }

      # Use difftastic, syntax-aware diffing
      alias diff=difft

      # Always color ls and group directories
      alias ls='ls --color=auto'

      bindkey "\e[1;3D" backward-word
      bindkey "\e[1;3C" forward-word

      # Toloka
      alias tlk='$HOME/source/frontend/shared/infra/cli/bin/entrypoint'
    '';

    envExtra = ''
    '';
  };
  programs.starship = {
    enable = true;
  };
}
