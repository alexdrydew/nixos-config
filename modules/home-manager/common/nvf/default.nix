{
  inputs,
  pkgs-stable,
  pkgs-unstable,
  lib,
  config,
  ...
}: let
  nvf-nvim = inputs.nvf.lib.neovimConfiguration {
    pkgs = pkgs-stable;
    extraSpecialArgs = {
      inherit (inputs) neovim-nightly-overlay;
      inherit pkgs-unstable;
      rustaceanvim = inputs.rustaceanvim.packages.${pkgs-stable.system}.default;
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
      pkgs-stable.stylua
    ];
  };
}
