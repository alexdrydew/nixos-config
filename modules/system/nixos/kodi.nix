{ config, lib, pkgs, ... }:
{
  options = {
    kodi = {
      enable = lib.mkEnableOption "Kodi";
    };
  };
  config = lib.mkIf config.kodi.enable {
    services.xserver.enable = true;
    services.xserver.desktopManager = {
      kodi = {
        enable = true;
        package = (pkgs.kodi.withPackages (pkgs: with pkgs; [
          jellycon
          youtube 
        ]));
      };
    };
    services.xserver.displayManager.lightdm.greeter.enable = false;
    users.extraUsers.kodi.isNormalUser = true;
    services.displayManager.autoLogin = {
      user = "kodi";
      enable = true;
    };
  };
}
