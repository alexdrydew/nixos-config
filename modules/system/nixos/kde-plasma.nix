{ lib, config, inputs, ... }:
{
  options = {
    kde-plasma.enable = lib.mkEnableOption "plasma";
  };
  config = lib.mkIf config.kde-plasma.enable {
    services.xserver.enable = true;
    services.displayManager = {
      sddm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = config.userConfig.userName;
      # defaultSession = "plasma-bigscreen-x11";
    };
    services.xserver.desktopManager.plasma5 = {
      enable = true;
      # bigscreen.enable = true;
    };
  };
}
