{ pkgs, lib, config, ... }:
{
  options =
    {
      modules.neovim.enable = lib.mkEnableOption "Enable neovim" // { default = true; };
    };
  config = lib.mkIf config.modules.neovim.enable {
    home.packages = with pkgs;
      [
        neovim
      ];
  };
}
