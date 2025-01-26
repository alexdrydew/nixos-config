{ pkgs, ... }:
{
  imports = [ ./git.nix ];

  home.packages = with pkgs; [
    gh
  ];

  programs.gh = {
    enable = true;
    extensions = [ ];
  };
}
