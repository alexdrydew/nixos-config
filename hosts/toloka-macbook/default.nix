{...}: {
  imports = [
    ../../modules/system/darwin
  ];

  services.nix-daemon.enable = true;
  local.dock.enable = true;

  home-manager.sharedModules = [
    {
      vscode.enable = true;
    }
  ];
  darwin.stateVersion = 4;
}
