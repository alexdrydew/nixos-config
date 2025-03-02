{pkgs, ...}: {
  config = {
    vim = {
      extraPackages = [
        pkgs.basedpyright
        pkgs.ruff
      ];
      languages = {
        python = {
          enable = true;
          format.type = "ruff";
          lsp.enable = false; # define custom
          treesitter.enable = true;
        };
      };
      lsp = {
        lspconfig = {
          enable = true;
          sources = {
            based-pyright =
              /*
              lua
              */
              ''
                lspconfig.basedpyright.setup{
                  capabilities = capabilities;
                  settings = {
                    basedpyright = {
                      analysis = {
                        -- ignore = { "*" },
                        disableOrganizeImports = true,
                        typeCheckingMode = "basic",
                        diagnosticMode = "openFilesOnly",
                        useLibraryCodeForTypes = true,
                        exclude = {
                          ".venv/**",
                          "bazel-*/**",
                        },
                        indexing = true,
                      },
                    },
                  };
                  cmd = ${''{"${pkgs.basedpyright}/bin/basedpyright-langserver", "--stdio"}''}
                }
              '';
            ruff =
              /*
              lua
              */
              ''
                lspconfig.ruff.setup{
                  capabilities = capabilities;
                  on_attach = default_on_attach;
                  cmd = ${''{"${pkgs.ruff}/bin/ruff", "server"}''}
                }
              '';
          };
        };
      };
    };
  };
}
