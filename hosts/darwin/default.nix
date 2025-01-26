{ ... }:
{
  imports = [
    ../../modules/system/common
    ../../modules/system/darwin
  ];

  services.nix-daemon.enable = true;
  local.dock.enable = true;

  darwin.stateVersion = 4;
}
