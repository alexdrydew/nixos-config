{pkgs, ...}: let
  none-ls = pkgs.vimUtils.buildVimPlugin {
    pname = "none-ls.nvim";
    version = "2025-03-04";
    src = pkgs.fetchFromGitHub {
      owner = "nvimtools";
      repo = "none-ls.nvim";
      rev = "a117163db44c256d53c3be8717f3e1a2a28e6299";
      sha256 = "sha256-KP/mS6HfVbPA5javQdj/x8qnYYk0G6oT0RZaPTAPseM=";
    };
    meta.homepage = "https://github.com/nvimtools/none-ls.nvim/";
  };
in {
  vim.pluginOverrides = {
    none-ls-nvim = none-ls;
  };
}
