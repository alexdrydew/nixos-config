{ ... }:
{
  home.file."./.config/alacritty/" = {
    source = ./config;
    recursive = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      keyboard.bindings = [
        {
          key = "N";
          mods = "Command";
          action = "SpawnNewInstance";
        }
      ];
    };
  };

}
