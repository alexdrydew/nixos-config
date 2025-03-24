_: {
  home.file.".kitty-sessions/toloka-python.sh" = {
    text = ''
      cd ~/source/toloka-python
      launch --title "nvim" zsh -ic "source ~/source/toloka-python/.venv/bin/activate && nvim . && exec zsh -i"

      new_tab shell
      cd ~/source/toloka-python
      launch zsh -ic "source ~/source/toloka-python/.venv/bin/activate && exec zsh -i"

      new_tab aider
      cd ~/source/toloka-python
      launch zsh -ic "source ~/source/toloka-python/.venv/bin/activate && aider --model openai/deepseek-r1 --architect --editor-model openai/claude-3-7-sonnet-20250219 --subtree-only --no-auto-commits && exec zsh -i"

      new_tab aider watch
      cd ~/source/toloka-python
      launch zsh -ic "source ~/source/toloka-python/.venv/bin/activate && aider --model openai/claude-3-7-sonnet-20250219 --subtree-only --no-auto-commits --watch-files && exec zsh -i"
    '';
    executable = true;
  };

  home.file.".kitty-sessions/bespoke-configurator-dev.sh" = {
    text = ''
      cd ~/source/toloka-python/toloka/bespoke/configurator/backend
      launch --title "backend" zsh -ic "source ~/source/toloka-python/.venv/bin/activate && ./local-dev.sh && exec zsh -i"

      new_tab temporal
      launch zsh -ic "temporal server start-dev --namespace sft && exec zsh -i"

      new_tab kubectl techman
      launch zsh -ic "kubectl port-forward deployments/techman-deployment 8082:8080 --namespace dev-bespoke-techman && exec zsh -i"

      new_tab kubectl admin-ms
      launch zsh -ic "kubectl port-forward deployments/admin-ms-deployment 8081:80 --namespace prestable-apps && exec zsh -i"

      new_tab worker
      cd ~/source/toloka-python
      launch zsh -ic "source ~/source/toloka-python/.venv/bin/activate && python -m toloka.sft.workers.runtime.launcher.main -c local --watch && exec zsh -i"

      new_tab frontend
      cd ~/source/frontend
      launch zsh -ic "pnpm i && tlk dev -c && exec zsh -i"
    '';
    executable = true;
  };
}
