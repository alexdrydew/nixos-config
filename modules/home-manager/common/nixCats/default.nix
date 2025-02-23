{ config, lib, inputs, ... }:
let
  utils = inputs.nixCats.utils;
in
{
  imports = [
    inputs.nixCats.homeModule
  ];
  config = {
    # this value, nixCats is the defaultPackageName you pass to mkNixosModules
    # it will be the namespace for your options.
    nvim = {
      enable = true;
      packageNames = [ "nvim" "nvim-vscode" ];
    };
  };

}
