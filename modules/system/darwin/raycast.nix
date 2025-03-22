{
  config,
  pkgs,
  lib,
  ...
}:
with lib; {
  options = {
    raycast = {
      enable = mkEnableOption "Whether to enable Raycast application" // {default = true;};
    };
  };

  config = mkIf config.raycast.enable {
    environment.systemPackages = with pkgs; [
      raycast
    ];
  };
}
