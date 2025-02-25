{ ... }:
{
  config = {
    vim = {
      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };
      plugins = {

      };
      keymaps = [
        {
          key = "<Esc>";
          mode = ["n"];
          action = "<cmd>nohlsearch<CR>";
          silent = true;
        }
        {
          key = "]d";
          mode = ["n"];
          action = "<cmd>nohlsearch<CR>";
          silent = true;
        }
      ];
    };
  };
}
