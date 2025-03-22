{
  lib,
  osConfig,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  config = lib.mkIf osConfig.kde-plasma.enable {
    home.packages = with pkgs; [
    ];

    programs.plasma = {
      enable = true;
      configFile = {
        "kwinrc"."Xwayland"."Scale" = 2;
      };
    };
  };
}
