{ lib, config, ... }:
{
  options = {
    hardware.nvidia.enable = lib.mkEnableOption "nvidia";
  };
   
  config = lib.mkIf config.hardware.nvidia.enable {
    hardware = {
      nvidia = {
        modesetting.enable = true;
        nvidiaSettings = false;
        open = false;
      };
      nvidia-container-toolkit.enable = true;
    };
    services = {
      xserver.videoDrivers = [ "nvidia" ];
    };
  };
}
