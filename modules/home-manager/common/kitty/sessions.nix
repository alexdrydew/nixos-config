_: {
  home.file = {
    ".kitty-sessions/toloka-python.sh" = {
      text =
        /*
        bash
        */
        ''
          cd ~/source/toloka-python
          launch --title "nvim" zsh -ic "source ~/source/toloka-python/.venv/bin/activate; nvim .; exec zsh -i"

          new_tab shell
          cd ~/source/toloka-python
          launch zsh -ic "source ~/source/toloka-python/.venv/bin/activate; exec zsh -i"

          new_tab aider
          cd ~/source/toloka-python
          launch zsh -ic "source ~/source/toloka-python/.venv/bin/activate; aider --model openai/gemini-2-5-pro --subtree-only --no-auto-commits; exec zsh -i"

          new_tab aider watch
          cd ~/source/toloka-python
          launch zsh -ic "source ~/source/toloka-python/.venv/bin/activate; aider --model openai/gemini-2-5-pro --subtree-only --no-auto-commits --watch-files; exec zsh -i"
        '';
      executable = true;
    };

    ".kitty-sessions/kitty-python-agents.sh" = {
      text =
        /*
        bash
        */
        ''
          cd ~/source/agent-integrations
          launch --title "nvim" zsh -ic "source ~/source/agent-integrations/.venv/bin/activate; nvim .; exec zsh -i"

          new_tab shell
          cd ~/source/agent-integrations
          launch zsh -ic "source ~/source/agent-integrations/.venv/bin/activate; exec zsh -i"

          new_tab aider
          cd ~/source/agent-integrations
          launch zsh -ic "source ~/source/agent-integrations/.venv/bin/activate; aider --model openai/gemini-2-5-pro --subtree-only --no-auto-commits; exec zsh -i"

          new_tab aider watch
          cd ~/source/agent-integrations
          launch zsh -ic "source ~/source/agent-integrations/.venv/bin/activate; aider --model openai/gemini-2-5-pro --subtree-only --no-auto-commits --watch-files; exec zsh -i"
        '';
      executable = true;
    };

    ".kitty-sessions/bespoke-configurator-dev.sh" = {
      text =
        /*
        bash
        */
        ''
          cd ~/source/toloka-python/toloka/bespoke/configurator/backend
          launch --title "backend" zsh -ic "source ~/source/toloka-python/.venv/bin/activate; ./local-dev.sh; exec zsh -i"

          new_tab temporal
          launch zsh -ic "temporal server start-dev --namespace sft; exec zsh -i"

          new_tab kubectl techman
          launch zsh -ic "kubectl port-forward deployments/techman-deployment 8082:8080 --namespace dev-bespoke-techman; exec zsh -i"

          new_tab kubectl admin-ms
          launch zsh -ic "kubectl port-forward deployments/admin-ms-deployment 8081:80 --namespace prestable-apps; exec zsh -i"

          new_tab worker
          cd ~/source/toloka-python
          launch zsh -ic "source ~/source/toloka-python/.venv/bin/activate; python -m toloka.sft.workers.runtime.launcher.main -c local --watch; exec zsh -i"

          new_tab frontend
          cd ~/source/frontend
          launch zsh -ic "pnpm i; tlk dev -c; exec zsh -i"
        '';
      executable = true;
    };

    ".kitty-sessions/nixos-config-dev.sh" = {
      text =
        /*
        bash
        */
        ''
          cd ~/nixos-config
          launch --title "nvim" zsh -ic "nvim .; exec zsh -i"

          new_tab shell
          cd ~/nixos-config
          launch zsh -ic "exec zsh -i"

          new_tab aider
          cd ~/nixos-config
          launch zsh -ic "aider --model fireworks_ai/accounts/fireworks/models/deepseek-r1 --architect --editor-model openai/gemini-2-5-pro; exec zsh -i"
        '';
      executable = true;
    };

    ".kitty-sessions/nixos-config.sh" = {
      text =
        /*
        bash
        */
        ''
          cd ~/nixos-config
          launch --title "nvim" zsh -ic "nvim .; exec zsh -i"

          new_tab shell
          cd ~/nixos-config
          launch zsh -ic "exec zsh -i"

          new_tab aider
          launch zsh -ic "aider --model fireworks_ai/accounts/fireworks/models/deepseek-r1 --architect --editor-model fireworks_ai/accounts/fireworks/models/deepseek-v3 --subtree-only --map-tokens 1024; exec zsh -i"

          new_tab aider-watch
          launch zsh -ic "aider --model fireworks_ai/accounts/fireworks/models/deepseek-v3 --subtree-only --map-tokens 1024 --watch-files; exec zsh -i"
        '';
      executable = true;
    };

    ".kitty-sessions/tv-ui-dev.sh" = {
      text =
        /*
        bash
        */
        ''
          cd ~/source/tv-ui
          launch --title "nvim" zsh -ic "nix develop -c zsh -ic 'nvim .; exec zsh -i'"

          new_tab dev
          cd ~/source/tv-ui
          launch zsh -ic "nix develop -c zsh -ic 'cargo-tauri dev; exec zsh -i'"

          new_tab shell
          cd ~/source/tv-ui
          launch zsh -ic "nix develop -c zsh -ic 'exec zsh -i'"

          new_tab aider
          cd ~/source/tv-ui
          launch zsh -ic "nix develop -c zsh -ic 'aider --model fireworks_ai/accounts/fireworks/models/deepseek-r1 --architect --editor-model openai/gemini-2-5-pro; exec zsh -i'"
        '';
      executable = true;
    };
  };
}
