{ userConfig, inputs, ... }:

let
  user = userConfig.userName;
in
{
  imports = [
    ../../modules/system/nixos
    inputs.nixos-wsl.nixosModules.default
    inputs.vscode-server.nixosModules.default
    # run `systemctl --user enable auto-fix-vscode-server.service`
    ({ ... }: {
      services.vscode-server.enable = true;
      services.vscode-server.enableFHS = true;
    })
  ];

  wsl.enable = true;
  wsl.defaultUser = user;
  networking.enableIPv6 = false;

  system.stateVersion = "21.05";
}
