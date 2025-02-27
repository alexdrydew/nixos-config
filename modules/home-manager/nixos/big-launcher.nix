{ lib, pkgs, config, ... }:
{
  options = {
    big-launcher.enable = lib.mkEnableOption "Big Launcher";
  };

  config = lib.mkIf config.big-launcher.enable {
    home.packages = with pkgs; [
      (pkgs.callPackage ./big-launcher {})
      # gcc
      # cmake
      # clang-tools
      # pkg-config
      # gnumake
      #
      # SDL2.dev
      # SDL2_image
      # SDL2_ttf
      # SDL2_mixer
      # libxml2
      # inih
      # fmt
      # spdlog
    ];
  };
}
