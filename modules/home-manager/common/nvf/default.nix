{
  inputs,
  pkgs,
  pkgs-unstable,
  lib,
  config,
  ...
}: let
  nvf-nvim = inputs.nvf.lib.neovimConfiguration {
    inherit pkgs;
    extraSpecialArgs = {
      inherit (inputs) neovim-nightly-overlay;
      inherit pkgs-unstable;
    };
    modules = [
      ./modules/default.nix
    ];
  };
in {
  options = {
    nvf = {
      enable = lib.mkEnableOption "nvf" // {default = true;};
    };
  };
  config = lib.mkIf config.nvf.enable {
    home.packages = [
      nvf-nvim.neovim
      pkgs.stylua
    ];
  };
}
