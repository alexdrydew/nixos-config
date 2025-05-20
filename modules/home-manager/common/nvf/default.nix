{
  inputs,
  pkgs-stable,
  pkgs-unstable,
  lib,
  config,
  ...
}: let
  nvf-nvim = inputs.nvf.lib.neovimConfiguration {
    pkgs = pkgs-unstable;
    extraSpecialArgs = {
      inherit (inputs) neovim-nightly-overlay;
      inherit pkgs-unstable;
      rustaceanvim = inputs.rustaceanvim.packages.${pkgs-stable.system}.default;
      inherit (pkgs-stable) neovim-node-client;
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
      pkgs-unstable.stylua
      pkgs-unstable.neovim-node-client
      pkgs-unstable.basedpyright
      pkgs-unstable.ruff
    ];
  };
}
