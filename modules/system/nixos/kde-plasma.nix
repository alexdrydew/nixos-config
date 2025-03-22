{
  lib,
  config,
  ...
}: {
  options = {
    kde-plasma.enable = lib.mkEnableOption "plasma";
  };
  config = lib.mkIf config.kde-plasma.enable {
    services = {
      displayManager = {
        sddm.enable = true;
        autoLogin.enable = true;
        autoLogin.user = config.userConfig.userName;
      };
      xserver.enable = true;
      desktopManager.plasma6 = {
        enable = true;
      };
    };
  };
}
