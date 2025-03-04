{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./local-highlight
  ];

  config.vim.lazy.plugins = {
    telescope = {
      setupOpts = {
        extensions = {
          # "ui-select" = [
          #   (lib.generators.mkLuaInline
          #     /*
          #     lua
          #     */
          #     "require('telescope.themes').get_dropdown()")
          # ];
        };
      };
      after =
        lib.mkAfter
        # telescope.load_extension('ui-select')
        /*
        lua
        */
        ''
          telescope.load_extension('fzf')
        '';
    };
    # "telescope-ui-select.nvim" = {
    #   package = pkgs.vimPlugins.telescope-ui-select-nvim;
    #   setupModule = "telescope-ui-select.nvim";
    #   after =
    #     /*
    #     lua
    #     */
    #     ''
    #       require("telescope").load_extension("ui-select")
    #     '';
    # };
  };
}
