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
        package = pkgs.vimUtils.buildVimPlugin {
          dependencies = [
            pkgs.vimPlugins.plenary-nvim
            pkgs.vimPlugins.nvim-lspconfig
          ];
          pname = "typescript-tools.nvim";
          version = "2025-04-19";
          src = pkgs.fetchFromGitHub {
            owner = "pmizio";
            repo = "typescript-tools.nvim";
            rev = "885f4cc150f996f5bff5804874f92ff3051c883d";
            hash = "sha256-PcLpn9c9BUAAhMfEzZIH4K4f+YDumvWZzQ0iGMR/NSw=";
          };
          meta.homepage = "https://github.com/pmizio/typescript-tools.nvim/";
        };
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
