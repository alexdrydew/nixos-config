{pkgs, ...}: let
  local-highlight = pkgs.callPackage ./package.nix {};
in {
  config.vim.lazy.plugins = {
    "snacks.nvim" = {
      package = pkgs.vimPlugins.snacks-nvim;
      setupModule = "snacks.nvim";
      lazy = false;
      enabled = true;
      setupOpts = {
        words = {enabled = true;};
      };
    };
    "vimplugin-local-hightlight-nvim" = {
      package = local-highlight;
      setupModule = "local-highlight";
    };
  };
}
