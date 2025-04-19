{pkgs-unstable, ...}: {
  imports = [
    ./python.nix
    ./eslint.nix
  ];
  config = {
    vim = {
      luaConfigPre =
        /*
        lua
        */
        ''
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { bufnr })
        '';
      treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
      };
      languages = {
        enableTreesitter = true;
        nix = {
          enable = true;
          extraDiagnostics.enable = true;
          format.enable = true;
          lsp.enable = true;
        };
        lua = {
          enable = true;
          lsp.enable = false;
        };
        ts = {
          enable = true;
          format.enable = true;
          extraDiagnostics.enable = false; # eslint_d is not available in none-ls anymore and I use eslint lsp
          lsp.enable = true;
        };
        tailwind = {
          enable = true;
          lsp.enable = true;
        };
        yaml = {
          enable = true;
          lsp.enable = true;
        };
        css = {
          enable = true;
          lsp.enable = true;
          format.enable = true;
        };
        rust = {
          enable = true;
          lsp.enable = true;
          format.enable = false;
          lsp = {
            opts =
              /*
              lua
              */
              ''
                ['rust-analyzer'] = {
                  -- cargo = {allFeature = true},
                  procMacro = {
                    enable = true,
                  },
                },
              '';
            package = pkgs-unstable.rust-analyzer;
          };
        };
      };
      visuals.fidget-nvim = {
        enable = true;
        setupOpts.notification.override_vim_notify = true;
      };
      luaConfigRC.ts-verstion-notificaion =
        /*
        lua
        */
        ''
          -- Custom handler for $/typescriptVersion
          local custom_typescript_version_handler = function(err, result, ctx)
            if err then
              vim.notify("LSP Error: " .. err.message, vim.log.levels.ERROR)
              return
            end

            vim.notify("TypeScript version: " .. result.version, vim.log.levels.INFO, {
              title = "TypeScript LSP",
            })
          end

          vim.lsp.handlers["$/typescriptVersion"] = custom_typescript_version_handler
        '';
    };
  };
}
