{...}: {
  imports = [
    ../../modules/system/darwin
  ];

  local.dock.enable = true;

  home-manager.sharedModules = [
    {
      vscode.enable = true;
      aider.enable = true;
    }
  ];
  darwin.stateVersion = 4;
}
