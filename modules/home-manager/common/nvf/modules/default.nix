{ pkgs, ... }:
{
  imports = [
    ./languages
  ];

  config = {
    vim = {
      startPlugins = with pkgs.vimPlugins; [
        vim-sleuth
      ];
      vimAlias = true;
      filetree.neo-tree = {
        enable = true;
      };
      theme = {
        enable = true;
        name = "tokyonight";
        style = "night";
      };
    };
  };
}
