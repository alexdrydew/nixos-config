{lib, ...}: {
  imports = [
    ./local-highlight
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
