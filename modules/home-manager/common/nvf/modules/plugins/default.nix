{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./none-ls.nix
    ./rustaceanvim.nix
  ];

  config = {
    vim.lazy.plugins = {
      telescope = {
        setupOpts = {
          extensions = {
            "ui-select" = [
              (lib.generators.mkLuaInline
                /*
                lua
                */
                "require('telescope.themes').get_dropdown()")
            ];
          };
          defaults = {
            vimgrep_arguments = lib.mkForce [
              "${pkgs.ripgrep}/bin/rg"
              "--color=never"
              "--no-heading"
              "--with-filename"
              "--line-number"
              "--column"
              "--smart-case"
              # "--hidden"
              # "--no-ignore"
            ];
          };
        };
        after =
          lib.mkAfter
          /*
          lua
          */
          ''
            telescope.load_extension('fzf')
            telescope.load_extension('ui-select')
          '';
      };
    };
  };
}
