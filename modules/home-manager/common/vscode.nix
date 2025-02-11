{ config, pkgs, lib, ... }:
{
  options.vscode = {
    enable = lib.mkEnableOption {
      default = true;
      description = "Enable installing VSCode";
    };
  };

  config = lib.mkIf config.vscode.enable {
    home.packages = with pkgs; [
      vscode
    ];
  };
}

