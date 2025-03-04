{pkgs, ...}: {
  vim.extraPackages = [
    pkgs.vscode-langservers-extracted
  ];
  vim.lsp.lspconfig.sources = {
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
}
