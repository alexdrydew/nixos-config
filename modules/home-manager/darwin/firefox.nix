{ pkgs-unstable, lib, config, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs-unstable.firefox-unwrapped;
  };
}
