{...}: {
  imports = [
    ./python.nix
  ];
  config = {
    vim = {
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
          lsp.enable = true;
        };
        ts = {
          enable = true;
          format.enable = true;
          extraDiagnostics.enable = true;
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
      };
      visuals.fidget-nvim = {
        enable = true;
      };
    };
  };
}
