{pkgs, ...}: {
  vim = {
    extraPackages = [
      pkgs.vscode-langservers-extracted
    ];
    languages.ts = {
      enable = true;
      format.enable = true;
      extraDiagnostics.enable = false; #  to use eslint LSP from vscode-langservers-extracted over nvim-lint
      lsp.enable = false; # use typescript-tools.nvim instead
    };
    lsp.lspconfig.sources = {
      eslint =
        /*
        lua
        */
        ''
          lspconfig.eslint.setup{
            capabilities = capabilities;
            on_attach = default_on_attach;
            cmd = ${''{"${pkgs.vscode-langservers-extracted}/bin/vscode-eslint-language-server", "--stdio"}''}
          }
        '';
    };
    extraPlugins = {
      typescript-tools = {
        package = pkgs.vimPlugins.typescript-tools-nvim;
        setup =
          /*
          lua
          */
          ''
            require("typescript-tools").setup {
              settings = {
                expose_as_code_action = "all"
              }
            }
          '';
      };
    };
  };
}
