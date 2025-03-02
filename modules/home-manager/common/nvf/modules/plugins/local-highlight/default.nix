{pkgs, ...}: let
  local-highlight = pkgs.callPackage ./package.nix {};
  # use more recent version of snacks
  snacks = pkgs.callPackage ./snacks.nix {};
in {
  config.vim = {
    lazy.plugins = {
      # TODO: why do we need to trigger load in after?
      "snacks.nvim" = {
        package = snacks;
        setupModule = "snacks";
        lazy = false;
        after =
          /*
          lua
          */
          ''
            require('snacks.animate')
            require("lz.n").trigger_load("vimplugin-local-hightlight-nvim")
          '';
      };
      "vimplugin-local-hightlight-nvim" = {
        # before =
        #   /*
        #   lua
        #   */
        #   ''
        #     require("lz.n").trigger_load("snacks.nvim")
        #     require('snacks.animate')
        #   '';
        package = local-highlight;
        setupModule = "local-highlight";
        lazy = true;
      };
    };
  };
}
