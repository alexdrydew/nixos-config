{ pkgs, ... }:
{
  home.packages = with pkgs; [
    oh-my-zsh
    zsh
  ];
  programs.zsh = {
    enable = true;
    autocd = false;
    plugins = [ ];
    oh-my-zsh = {
      enable = true;
      theme = "af-magic";

      plugins = [
        "git"
        "docker"
      ];
    };

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
      export EDITOR="vim"
      export VISUAL="code"

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }

      # Use difftastic, syntax-aware diffing
      alias diff=difft

      # Always color ls and group directories
      alias ls='ls --color=auto'

      # pyenv
      export PYENV_ROOT="$HOME/.pyenv"
      [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
      eval "$(pyenv init -)"

      # Go
      export GO_PATH=$HOME/go
      export PATH=$PATH:$GO_PATH/bin

      # Toloka
      alias tlk='$HOME/source/frontend/common/infra/cli/bin/entrypoint'
    '';

    envExtra = ''
    '';
  };
}
