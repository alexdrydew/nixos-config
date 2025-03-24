{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./sessions.nix
  ];
  options = {
    kitty.enable = lib.mkEnableOption "Kitty Terminal" // {default = true;};
  };

  config = lib.mkIf config.kitty.enable {
    home.file."./.config/kitty/" = {
      source = ./config;
      recursive = true;
    };

    home.packages = with pkgs; [
      kitty
    ];
  };
}
