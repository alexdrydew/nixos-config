{ config, pkgs, pkgs-unstable, lib, userConfig, nixvim, ... }:

let
  user = userConfig.userName;
  shared-files = import ../shared/headless/files.nix { inherit config pkgs; };
in
{
  imports = [ nixvim.homeManagerModules.nixvim ../shared/headless/home-manager.nix ];
  home = {
    enableNixpkgsReleaseCheck = false;
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = pkgs.callPackage ./packages.nix { inherit pkgs; inherit pkgs-unstable; };
    file = shared-files // import ./files.nix { inherit user; };
    stateVersion = "24.05";
  };

  services = { };

  programs = {
    nixvim = {
      enable = true;
    };
  };
}
