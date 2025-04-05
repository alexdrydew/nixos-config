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
      };
    };
  };
}
