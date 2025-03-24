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

      # Define variables for directories
      export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
      export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
      export PATH=$HOME/.local/share/bin:$PATH

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

      # Go
      export GO_PATH=$HOME/go
      export PATH=$PATH:$GO_PATH/bin

      bindkey "\e[1;3D" backward-word
      bindkey "\e[1;3C" forward-word

      export PATH="/Users/alexdrydew/.local/bin:$PATH"

      # Toloka
      alias tlk='$HOME/source/frontend/shared/infra/cli/bin/entrypoint'
      ${
        if homebrew-enabled
        then ''
          # Homebrew
          if [[ $(uname -m) == 'arm64' ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
          fi
        ''
        else ""
      }
    '';

    envExtra = ''
    '';
  };
  programs.starship = {
    enable = true;
  };
}
