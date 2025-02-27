{ lib, osConfig, inputs, pkgs, ... }:
{
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ]; 

  config = lib.mkIf osConfig.kde-plasma.enable {
    home.packages = with pkgs; [
      libsForQt5.plasma-bigscreen
    ];

    programs.plasma = {
      enable = true;
    };
  };
}
