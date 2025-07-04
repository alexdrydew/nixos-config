{
  pkgs-unstable,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
  inherit (lib.nvim.dag) entryAfter;
in {
  imports = [
    ./python.nix
    ./js.nix
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
      lsp = {
        enable = true;
        formatOnSave = true;
      };
      treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
        fold = false;
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
        tailwind = {
          enable = true;
          lsp.enable = true;
        };
        html = {
          enable = true;
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
    };
  };
}
