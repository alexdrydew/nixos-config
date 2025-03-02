{
  lib,
  pkgs,
  config,
  ...
}: let
  yaml = pkgs.formats.yaml {};
in {
  options.aider = {
    enable = lib.mkEnableOption "Enable aider" // {default = true;};
    settings = lib.mkOption {
      type = lib.types.attrs;
      default = {
        "read" = [
          "${config.home.homeDirectory}/CONVENTIONS.md"
        ];
        "dark-mode" = true;
        "model-settings-file" = "${config.home.homeDirectory}/.aider.model.settings.yml";
        "auto-commits" = false;
        "auto-lint" = false;
        "check-update" = false;
        "vim" = true;
      };
      description = "Aider configuration attributes";
    };
    modelSettings = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [
        {
          name = "fireworks_ai/accounts/fireworks/models/deepseek-v3";
          edit_format = "diff";
          weak_model_name = null;
          use_repo_map = true;
          send_undo_reply = false;
          lazy = false;
          reminder = "sys";
          examples_as_sys_msg = true;
          extra_params = {max_tokens = 16384;};
          cache_control = false;
          caches_by_default = true;
          use_system_prompt = true;
          use_temperature = true;
          streaming = true;
        }
        {
          name = "fireworks_ai/accounts/fireworks/models/deepseek-r1";
          edit_format = "diff";
          weak_model_name = null;
          use_repo_map = true;
          send_undo_reply = false;
          lazy = false;
          reminder = "sys";
          examples_as_sys_msg = true;
          extra_params = {max_tokens = 16384;};
          cache_control = false;
          caches_by_default = true;
          use_system_prompt = true;
          use_temperature = true;
          streaming = true;
        }
      ];
      description = "Aider model configuration";
    };
  };

  config = lib.mkIf config.aider.enable {
    home = {
      packages = [pkgs.aider-chat];
      file.".aider.conf.yml" = {
        source = yaml.generate "aider-conf" config.aider.settings;
      };
      file.".aider.model.settings.yml" = {
        source = yaml.generate "aider-model-settings" config.aider.modelSettings;
      };
    };
  };
}
