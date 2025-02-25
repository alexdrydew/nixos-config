{ inputs, pkgs, ... }:
let 
  nvf-nvim = inputs.nvf.lib.neovimConfiguration {
    inherit pkgs;
    modules = [
      ./modules/default.nix
    ];
  };
in {
  home.packages = with pkgs; [
    nvf-nvim.neovim
  ];
}
