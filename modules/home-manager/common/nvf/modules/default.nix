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
      options = {
        mouse = "a";
        signcolumn = "yes";
        splitright = true;
        splitbelow = true;
      };
      scrollOffset = 10;
      lineNumberMode = "number";
      undoFile.enable = true;
    };
  };
}
