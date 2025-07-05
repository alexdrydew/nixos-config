{pkgs, ...}: {
  config = {
    vim = {
      debugger.nvim-dap.enable = true;
      debugger.nvim-dap.ui.enable = true;

      languages.python.dap.enable = true;

      lazy.plugins = {
        nvim-dap-python = {
          package = pkgs.vimPlugins.nvim-dap-python;
          event = [
            {
              event = "BufEnter";
              pattern = "*.py";
            }
          ];
          after =
            /*
            lua
            */
            ''
              require("dap-python").setup("uv")
            '';
        };
      };
    };
  };
}
