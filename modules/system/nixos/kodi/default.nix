{ config, lib, ... }:
{
  options = {
    kodi = {
      enable = lib.mkEnableOption "Kodi";
    };
  };
  config = lib.mkIf config.kodi.enable {
    services.xserver.enable = true;
    services.xserver.desktopManager.kodi.enable = true;
    services.xserver.displayManager.autoLogin.enable = true;
    services.xserver.displayManager.autoLogin.user = "kodi";
    services.xserver.displayManager.lightdm.greeter.enable = false;
    users.extraUsers.kodi.isNormalUser = true;
    kodi.enableAdvancedLauncher = true;
  };
}
