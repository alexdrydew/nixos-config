{ pkgs, pkgs-unstable, userConfig, ... }:

let user = userConfig.userName; in

{
  imports = [
    ../../modules/system/common
    ../../modules/system/darwin
  ];

  services.nix-daemon.enable = true;
  local.dock.enable = true;

}
