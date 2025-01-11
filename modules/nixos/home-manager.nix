{ config, pkgs, pkgs-unstable, lib, userConfig, nixvim, ... }:

let
  user = userConfig.userName;
  shared-programs = import ../shared/headless/home-manager-programs.nix { inherit config pkgs lib userConfig; };
  shared-files = import ../shared/headless/files.nix { inherit config pkgs; };
in
{
  imports = [ nixvim.homeManagerModules.nixvim ];
  home = {
    enableNixpkgsReleaseCheck = false;
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = pkgs.callPackage ./packages.nix { inherit pkgs; inherit pkgs-unstable; };
    file = shared-files // import ./files.nix { inherit user; };
    stateVersion = "24.05";
  };

  services = { };

  programs = shared-programs // {
    nixvim = {
      enable = true;
    };
  };
}
