{ lib, config, pkgs, ... }:
{
  options = {
    docker.enable = lib.mkEnableOption "Docker" // { default = true; };
  };
   
  config = lib.mkIf config.docker.enable {
    environment.systemPackages = with pkgs; [
      nvidia-docker
    ];

    virtualisation.docker = {
      enable = true;
      logDriver = "json-file";
      daemon.settings = {
        default-runtime = "nvidia";
        runtimes.nvidia.path = "${pkgs.nvidia-docker}/bin/nvidia-container-runtime";
      };
    };
  };
}
