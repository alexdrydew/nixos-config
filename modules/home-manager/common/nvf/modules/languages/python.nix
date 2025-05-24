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
          format = {
            enable = true;
            type = "ruff";
          };
          lsp.enable = false; # define custom
          treesitter.enable = true;
        };
      };
      lsp = {
        enable = true;
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
                          "bazel-*/**",
                          "**/node_modules",
                          "**/__pycache__",
                          "**/.*"
                        },
                        indexing = true,
                      },
                    },
                  };
                  cmd = {"basedpyright-langserver", "--stdio"};
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
                  cmd = ${''{"ruff", "server"}''}
                }
              '';
          };
        };
      };
    };
  };
}
