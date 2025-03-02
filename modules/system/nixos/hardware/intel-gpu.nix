{ lib, config, pkgs, ... }:
{
  options = {
    hardware.intel-gpu.enable = lib.mkEnableOption "Intel Graphics";
  };

  config = lib.mkIf config.hardware.intel-gpu.enable {
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vpl-gpu-rt
        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
        mesa.drivers
      ];
    };
  };
}
