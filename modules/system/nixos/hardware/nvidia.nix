{ ... }:
{
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
}
